package Org::Element::Base;
BEGIN {
  $Org::Element::Base::VERSION = '0.02';
}
# ABSTRACT: Base class for element of Org document

use 5.010;
use Moo;


has document => (is => 'rw');


has parent => (is => 'rw');


has children => (is => 'rw');

# normally only leaf nodes will store _raw values, to avoid duplication
has _raw => (is => 'rw');



sub element_as_string {
    my ($self) = @_;
    return $self->_raw if defined $self->_raw;
    "";
}


sub children_as_string {
    my ($self) = @_;
    return "" unless $self->children;
    join "", map { $_->as_string } @{ $self->children };
}


sub as_string {
    my ($self) = @_;
    ($self->element_as_string // "") . ($self->children_as_string // "");
}

1;

__END__
=pod

=head1 NAME

Org::Element::Base - Base class for element of Org document

=head1 VERSION

version 0.02

=head1 ATTRIBUTES

=head2 document => DOCUMENT

Link to document object. Elements need this e.g. to access file-wide settings,
properties, etc.

=head2 parent => undef | ELEMENT

Link to parent element.

=head2 children => undef | ARRAY[ELEMENTS]

=head1 METHODS

=head2 $el->element_as_string() => STR

Return the string representation of element. The default implementation will
just try to return _raw or empty string. Subclasses might want to override for
more appropriate representation.

=head2 $el->children_as_string() => STR

Return the string representation of children elements. The default
implementation will just try to concatenate as_string() for each child.

=head2 $el->as_string() => STR

Return the string representation of element. The default implementation will
just concatenate element_as_string() and children_as_string(). Subclasses might
want to override for more appropriate representation.

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

