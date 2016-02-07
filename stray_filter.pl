use strict;
use warnings;
use v5.10;

use ZMQ::FFI;
use ZMQ::FFI::Constants qw(ZMQ_SUB);

use constant FILTER => "STRAY";

# Socket to talk to server
say "Collecting STRAYS from stock feed...";

my $context    = ZMQ::FFI->new();
my $subscriber = $context->socket(ZMQ_SUB);
$subscriber->connect("tcp://localhost:5556");


$subscriber->subscribe(FILTER);
my $update;
while(1){
  $update = $subscriber->recv();
  say $update;
}

