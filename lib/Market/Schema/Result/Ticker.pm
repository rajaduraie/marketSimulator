use utf8;
package Market::Schema::Result::Ticker;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Market::Schema::Result::Ticker

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<TICKER>

=cut

__PACKAGE__->table("TICKER");

=head1 ACCESSORS

=head2 tickersymbol

  data_type: 'varchar'
  is_nullable: 0
  size: 32

=head2 tickerdescription

  data_type: 'varchar'
  is_nullable: 0
  size: 128

=head2 tickergroupid

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "tickersymbol",
  { data_type => "varchar", is_nullable => 0, size => 32 },
  "tickerdescription",
  { data_type => "varchar", is_nullable => 0, size => 128 },
  "tickergroupid",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</tickersymbol>

=back

=cut

__PACKAGE__->set_primary_key("tickersymbol");

=head1 RELATIONS

=head2 customer_portfolios

Type: has_many

Related object: L<Market::Schema::Result::CustomerPortfolio>

=cut

__PACKAGE__->has_many(
  "customer_portfolios",
  "Market::Schema::Result::CustomerPortfolio",
  { "foreign.tickersymbol" => "self.tickersymbol" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 tickergroupid

Type: belongs_to

Related object: L<Market::Schema::Result::TickerGroup>

=cut

__PACKAGE__->belongs_to(
  "tickergroupid",
  "Market::Schema::Result::TickerGroup",
  { tickergroupid => "tickergroupid" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-01-28 16:12:39
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:oTeBS/AV+lURHM5+2vE5ew


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
