package Org::Element::Link;
BEGIN {
  $Org::Element::Link::VERSION = '0.13';
}
# ABSTRACT: Represent Org hyperlink

use 5.010;
use locale;
use Moo;
extends 'Org::Element::Base';


has link => (is => 'rw');


has description => (is => 'rw');


has from_radio_target => (is => 'rw');



sub as_string {
    my ($self) = @_;
    return $self->_str if defined $self->_str;
    join("",
         "[",
         "[", $self->link, "]",
         (defined($self->description) && length($self->description) ?
              ("[", $self->description, "]") : ()),
         "]");
}

1;


=pod

=head1 NAME

Org::Element::Link - Represent Org hyperlink

=head1 VERSION

version 0.13

=head1 DESCRIPTION

Derived from L<Org::Element::Base>.

=head1 ATTRIBUTES

=head2 link => STR

=head2 description => STR

=head2 from_radio_target => BOOL

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

