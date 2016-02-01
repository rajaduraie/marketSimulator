use utf8;
package Market::Schema::Result::OrderBook;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Market::Schema::Result::OrderBook

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<ORDER_BOOK>

=cut

__PACKAGE__->table("ORDER_BOOK");

=head1 ACCESSORS

=head2 customerid

  data_type: 'varchar'
  is_nullable: 0
  size: 32

=head2 tickersymbol

  data_type: 'varchar'
  is_nullable: 0
  size: 32

=head2 ordertype

  data_type: 'varchar'
  is_nullable: 0
  size: 6

=head2 numberofunits

  data_type: 'integer'
  is_nullable: 0

=head2 action

  data_type: 'varchar'
  is_nullable: 0
  size: 4

=head2 unitprice

  data_type: 'float'
  is_nullable: 0

=head2 timeofaction

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "customerid",
  { data_type => "varchar", is_nullable => 0, size => 32 },
  "tickersymbol",
  { data_type => "varchar", is_nullable => 0, size => 32 },
  "ordertype",
  { data_type => "varchar", is_nullable => 0, size => 6 },
  "numberofunits",
  { data_type => "integer", is_nullable => 0 },
  "action",
  { data_type => "varchar", is_nullable => 0, size => 4 },
  "unitprice",
  { data_type => "float", is_nullable => 0 },
  "timeofaction",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => \"current_timestamp",
    is_nullable => 0,
  },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-01-28 16:12:39
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:CDlqNCQR0RmLVhJ/Ya+kcA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
