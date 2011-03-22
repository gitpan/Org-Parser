package Org::Element::TimeRange;
BEGIN {
  $Org::Element::TimeRange::VERSION = '0.04';
}
# ABSTRACT: Represent Org time range (TS1--TS2)

use 5.010;
use Moo;
extends 'Org::Element::Base';


has datetime1 => (is => 'rw');


has datetime2 => (is => 'rw');


has is_active => (is => 'rw');



sub as_string {
    my ($self) = @_;
    return $self->_str if $self->_str;
    join("",
         $self->is_active ? "<" : "[",
         $self->datetime1->ymd, " ",
         # XXX Thu 11:59
         $self->is_active ? ">--<" : "]--[",
         $self->datetime2->ymd, " ",
         # XXX Thu 11:59
         $self->is_active ? ">" : "]",
     );
}

1;


=pod

=head1 NAME

Org::Element::TimeRange - Represent Org time range (TS1--TS2)

=head1 VERSION

version 0.04

=head1 DESCRIPTION

Derived from Org::Element::Base.

=head1 ATTRIBUTES

=head2 datetime1 => DATETIME_OBJ

=head2 datetime2 => DATETIME_OBJ

=head2 is_active => BOOL

=head1 METHODS

=for Pod::Coverage as_string

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

