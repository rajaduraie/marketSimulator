use strict;
use warnings;
use v5.10;

use ZMQ::FFI;
use ZMQ::FFI::Constants qw(ZMQ_SUB);

use constant FILTER => "STRAY";

my $port = $ARGV[0];

unless($port) {
  die "Port number has to be passed as parameter";
}

# Socket to talk to server
say "Collecting STRAYS from stock feed...";

my $context    = ZMQ::FFI->new();
my $subscriber = $context->socket(ZMQ_SUB);
$subscriber->connect("tcp://localhost:$port");


$subscriber->subscribe(FILTER);
my $update;
while(1){
  $update = $subscriber->recv();
  say $update;
}

