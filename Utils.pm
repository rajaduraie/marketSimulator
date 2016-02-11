package Utils;

use strict;
use v5.10;

sub read_config {
  my ($class, $file) = @_;
  my %conf = ();
  unless ( -e $file) {
    say "Config file does not exist";
    return undef;
  }
  open (CONF,'<',$file) or return undef;

  while(my $line = <CONF>) {
    chomp($line);
    my($key, $value) = split("=",$line);
    $conf{$key} = $value;
  }
  return \%conf;
}
1;
