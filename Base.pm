package Base;

use Mojo::IOLoop;
use Mojo::UserAgent;
use Market::Schema;
use MarketDB;
use DBI;
use Carp;
use Log;

use Moose;

has   'log_level' => (
      is      =>'ro',
      isa     => 'Int',
      default => 3
      );
          
has   'log_location' => (
      is => 'ro',
      default => $ENV{HOME}.'/logs/'
      );

has   'user_agent' => (
      is => 'ro',
      default => sub {
        return Mojo::UserAgent->new();
      }
      );      

has   'log' => (
      is => 'ro',
      builder => 'new_log_object',
      lazy_build => 1
      );

has   'db' => (
       is => 'ro',
       builder => 'new_database_object',
       lazy_build => 1,
      );

sub new_log_object {
  my $self = shift; 
  my $log_object = Log->new($self->log_level(), $self->log_location());
  unless($log_object) {
    croak "Unable to create a log object";
  }
  return $log_object;
}

sub new_database_object {
  my $self = shift;
  my $database_object = MarketDB->connect('dbi:mysql:dbname=Market', 'mojo', 'xxxx');
  unless ($database_object) {
    croak "Unable to create a new database object";
  }
  return $database_object;
}

1;
