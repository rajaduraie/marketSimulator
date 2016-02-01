use utf8;
package Market::Schema::Result::CustomerPortfolio;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Market::Schema::Result::CustomerPortfolio

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<CUSTOMER_PORTFOLIO>

=cut

__PACKAGE__->table("CUSTOMER_PORTFOLIO");

=head1 ACCESSORS

=head2 customerid

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 tickersymbol

  data_type: 'varchar'
  is_foreign_key: 1
  is_nullable: 0
  size: 32

=head2 lowertrigger

  data_type: 'float'
  is_nullable: 1

=head2 highertrigger

  data_type: 'float'
  is_nullable: 1

=head2 orderstatus

  data_type: 'varchar'
  is_nullable: 0
  size: 8

=cut

__PACKAGE__->add_columns(
  "customerid",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "tickersymbol",
  { data_type => "varchar", is_foreign_key => 1, is_nullable => 0, size => 32 },
  "lowertrigger",
  { data_type => "float", is_nullable => 1 },
  "highertrigger",
  { data_type => "float", is_nullable => 1 },
  "orderstatus",
  { data_type => "varchar", is_nullable => 0, size => 8 },
);

=head1 RELATIONS

=head2 customerid

Type: belongs_to

Related object: L<Market::Schema::Result::Customer>

=cut

__PACKAGE__->belongs_to(
  "customerid",
  "Market::Schema::Result::Customer",
  { customerid => "customerid" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);

=head2 tickersymbol

Type: belongs_to

Related object: L<Market::Schema::Result::Ticker>

=cut

__PACKAGE__->belongs_to(
  "tickersymbol",
  "Market::Schema::Result::Ticker",
  { tickersymbol => "tickersymbol" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-01-28 16:12:39
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:k9bxEb3QgX+LzhfwcDsLOQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
