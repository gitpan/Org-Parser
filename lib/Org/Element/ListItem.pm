package Org::Element::ListItem;

use 5.010;
use locale;
use Moo;
extends 'Org::Element';

our $VERSION = '0.35'; # VERSION

has bullet => (is => 'rw');
has check_state => (is => 'rw');
has desc_term => (is => 'rw');

sub header_as_string {
    my ($self) = @_;
    join("",
         $self->parent->indent,
         $self->bullet, " ",
         defined($self->check_state) ? "[".$self->check_state."]" : "",
         defined($self->desc_term) ? $self->desc_term->as_string . " ::" : "",
     );
}

sub as_string {
    my ($self) = @_;
    $self->header_as_string . $self->children_as_string;
}

1;
#ABSTRACT: Represent Org list item

__END__

=pod

=head1 NAME

Org::Element::ListItem - Represent Org list item

=head1 VERSION

version 0.35

=head1 DESCRIPTION

Must have L<Org::Element::List> as parent.

Derived from L<Org::Element>.

=head1 ATTRIBUTES

=head2 bullet

=head2 check_state

undef, " ", "X" or "-".

=head2 desc_term

Description term (for description list).

=head1 METHODS

=for Pod::Coverage header_as_string as_string

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
