use strict;
use warnings;
use v5.10;
use Data::Dumper;
use Carp;
use Cwd;

our $cwd = ''; 

BEGIN {
  $cwd = getcwd;
}

use lib "$cwd/lib";
use Base;

# You can pass the conf fie if you want
my $conf_file = $ARGV[0] // "feed.conf";

# Get configurations values in this hash

my %conf = ();

open (CONF,'<',$conf_file) or die "Unable to open $conf_file file: $!";

while(my $line = <CONF>) {
  chomp($line);
  my($key, $value) = split("=",$line);
  $conf{$key} = $value;
}

my $count                     = 0;
my $average_elements          = $conf{averageElementCount} // 10;
my $allowed_percent_deviation = $conf{allowedPercentageDeviation} // 1;
my $log_level                 = $conf{logLevel} // 4;
my $threshold_percentage      = $conf{thresholdPercentage} // 0.1;

my $feeder = Base->new( log_level => $log_level );

my $ua  = $feeder->user_agent();
my $db  = $feeder->db();
my $log = $feeder->log();

unless($ua && $db && $log) {
  croak "Unable to initialize one or more of UserAgent, database handler or log";
}

## This is for the zero mq

use ZMQ::FFI;
use ZMQ::FFI::Constants qw(ZMQ_PUB);

my $context   = ZMQ::FFI->new();
my $publisher = $context->socket(ZMQ_PUB);
$publisher->bind("tcp://*:5556");


# Get the ticker table object 

my $ticker_table         = $db->get_table_object('Ticker');

my @tickers = $ticker_table->search(undef, {columns => [qw/tickersymbol/]});

my @symbols = ();
foreach(@tickers) {
  push @symbols, $_->tickersymbol();
}

unless (@symbols) {
  croak "No tickers in table ";
}

my %tickers_info  = ();
my %alerts        = ();

my %tick_data = ();
$ua->websocket('wss://ws.binaryws.com/websockets/v3' => sub {
  my ($ua, $tx) = @_;
  unless($tx->is_websocket) {
    say "Websocket handshake failed";
    return;
  }

  $tx->on(json=> sub {
    my($tx, $data) = @_;
    if (exists $data->{error}) {
      say "Error code: $data->{error}{code}";
      say "Error: $data->{error}{code} : $data->{error}{message}";
      if ($data->{error}{code} =~ /invalid/i ) {
        say "This will not be checked";
        #Comment out the stop statement if you want
        #this to continue for valid ticks
        #Mojo::IOLoop->stop();
      } 
    } else {
      no strict;
      no warnings;
      my $tick  = $data->{tick}{symbol};
      my $quote = $data->{tick}{quote};

      push @{$tick}, $quote;
      $tick_data{$tick}{sum} += $quote;

      say "Tick is $tick and quote is $quote";
      # Calculate average of configured number of values

      if ( scalar(@{$tick}) > $average_elements ) {
        $tick_data{$tick}{first} = shift @{$tick};
        $tick_data{$tick}{sum} -= $tick_data{$tick}{first};
        $tick_data{$tick}{average} = $tick_data{$tick}{sum}/$average_elements;
        $tick_date{$tick}{first_last_diff} = $tick_data{$tick}{first} - $quote;
      }

      # Calculate deviation of tick from average

      if ( defined ($tick_data{$tick}{average})) {
        if (abs(1 - ($quote/$tick_data{$tick}{average})) * 100 > $allowed_percent_deviation) {
          my $update = "STRAY ".$tick." ".$quote;
          $publisher->send($update);
        }

        if (abs(($tick_date{$tick}{first_last_diff}/$tick_data{$tick}{first})*100) >= $threshold_percentage) {
          my $rise_or_fall = ($tick_date{$tick}{first_last_diff} > 0) ? 'RISING' : 'FALLING';
          my $update = "ALERT $tick $rise_or_fall $quote";
          $publisher->send($update);
        }
      }
      use strict;  

    }
  });

  $tx->send({json=> { ticks=> [@symbols]}});
});

Mojo::IOLoop->start();
