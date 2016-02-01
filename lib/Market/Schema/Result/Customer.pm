use utf8;
package Market::Schema::Result::Customer;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Market::Schema::Result::Customer

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<CUSTOMER>

=cut

__PACKAGE__->table("CUSTOMER");

=head1 ACCESSORS

=head2 customerid

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 customername

  data_type: 'varchar'
  is_nullable: 0
  size: 62

=head2 customeraddress

  data_type: 'varchar'
  is_nullable: 1
  size: 128

=head2 customertype

  data_type: 'varchar'
  is_nullable: 0
  size: 10

=cut

__PACKAGE__->add_columns(
  "customerid",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "customername",
  { data_type => "varchar", is_nullable => 0, size => 62 },
  "customeraddress",
  { data_type => "varchar", is_nullable => 1, size => 128 },
  "customertype",
  { data_type => "varchar", is_nullable => 0, size => 10 },
);

=head1 PRIMARY KEY

=over 4

=item * L</customerid>

=back

=cut

__PACKAGE__->set_primary_key("customerid");

=head1 RELATIONS

=head2 customer_portfolios

Type: has_many

Related object: L<Market::Schema::Result::CustomerPortfolio>

=cut

__PACKAGE__->has_many(
  "customer_portfolios",
  "Market::Schema::Result::CustomerPortfolio",
  { "foreign.customerid" => "self.customerid" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-01-28 16:12:39
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:+te90kA1/4HUBw0WRTIlQQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
