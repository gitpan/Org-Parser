package Org::Element::List;

use 5.010;
use locale;
use Moo;
extends 'Org::Element';

our $VERSION = '0.36'; # VERSION

has indent => (is => 'rw');
has type => (is => 'rw');
has bullet_style => (is => 'rw');

sub items {
    my $self = shift;
    my @items;
    for (@{ $self->children }) {
        push @items, $_ if $_->isa('Org::Element::ListItem');
    }
    \@items;
}

1;
# ABSTRACT: Represent Org list

__END__

=pod

=head1 NAME

Org::Element::List - Represent Org list

=head1 VERSION

version 0.36

=head1 DESCRIPTION

Must have L<Org::Element::ListItem> (or another ::List) as children.

Derived from L<Org::Element>.

=begin Pod::Coverage




=end Pod::Coverage

=head1 ATTRIBUTES

=head2 indent

Indent (e.g. " " x 2).

=head2 type

'U' for unordered list (-, +, * for bullets), 'D' for description list, 'O' for
ordered list (1., 2., 3., and so on).

=head2 bullet_style

E.g. '-', '*', '+'. For ordered list, currently just use '<N>.'

=head1 METHODS

=head2 $list->items() => ARRAY OF OBJECTS

Return the items, which are array of L<Org::Element::ListItem> objects.

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
