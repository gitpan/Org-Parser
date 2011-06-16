package Org::Element::Target;
BEGIN {
  $Org::Element::Target::VERSION = '0.16';
}
# ABSTRACT: Represent Org target

use 5.010;
use locale;
use Moo;
extends 'Org::Element::Base';


has target => (is => 'rw');



sub as_string {
    my ($self) = @_;
    join("",
         "<<", ($self->target // ""), ">>");
}

1;


=pod

=head1 NAME

Org::Element::Target - Represent Org target

=head1 VERSION

version 0.16

=head1 DESCRIPTION

Derived from L<Org::Element::Base>.

=head1 ATTRIBUTES

=head2 target

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

