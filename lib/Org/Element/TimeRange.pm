package Org::Element::TimeRange;
BEGIN {
  $Org::Element::TimeRange::VERSION = '0.15';
}
# ABSTRACT: Represent Org time range (TS1--TS2)

use 5.010;
use locale;
use Moo;
extends 'Org::Element::Base';


has ts1 => (is => 'rw');


has ts2 => (is => 'rw');



sub as_string {
    my ($self) = @_;
    return $self->_str if $self->_str;
    join("",
         $self->ts1->as_string,
         "--",
         $self->ts2->as_string
     );
}

1;


=pod

=head1 NAME

Org::Element::TimeRange - Represent Org time range (TS1--TS2)

=head1 VERSION

version 0.15

=head1 DESCRIPTION

Derived from L<Org::Element::Base>.

=head1 ATTRIBUTES

=head2 ts1 => TIMESTAMP ELEMENT

=head2 ts2 => TIMESTAMP ELEMENT

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

