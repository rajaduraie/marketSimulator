use utf8;
package Market::Schema::Result::TickerGroup;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Market::Schema::Result::TickerGroup

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<TICKER_GROUP>

=cut

__PACKAGE__->table("TICKER_GROUP");

=head1 ACCESSORS

=head2 tickergroupid

  data_type: 'integer'
  is_nullable: 0

=head2 tickergroupname

  data_type: 'varchar'
  is_nullable: 1
  size: 32

=cut

__PACKAGE__->add_columns(
  "tickergroupid",
  { data_type => "integer", is_nullable => 0 },
  "tickergroupname",
  { data_type => "varchar", is_nullable => 1, size => 32 },
);

=head1 PRIMARY KEY

=over 4

=item * L</tickergroupid>

=back

=cut

__PACKAGE__->set_primary_key("tickergroupid");

=head1 RELATIONS

=head2 tickers

Type: has_many

Related object: L<Market::Schema::Result::Ticker>

=cut

__PACKAGE__->has_many(
  "tickers",
  "Market::Schema::Result::Ticker",
  { "foreign.tickergroupid" => "self.tickergroupid" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-01-28 16:12:39
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:sP6rupvWXTgFi68Tc9hgkg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
