package Org::Element::TableRow;

use 5.010;
use locale;
use Moo;
extends 'Org::Element';

our $VERSION = '0.41'; # VERSION

sub as_string {
    my ($self) = @_;
    return $self->_str if defined $self->_str;

    join("",
         "|",
         join("|", map {$_->as_string} @{$self->children}),
         "\n");
}

sub as_array {
    my ($self) = @_;

    [map {$_->as_string} @{$self->children}];
}

sub cells {
    my ($self) = @_;
    return [] unless $self->children;

    my $cells = [];
    for my $el (@{$self->children}) {
        push @$cells, $el if $el->isa('Org::Element::TableCell');
    }
    $cells;
}

1;
# ABSTRACT: Represent Org table row

__END__

=pod

=encoding UTF-8

=head1 NAME

Org::Element::TableRow - Represent Org table row

=head1 VERSION

This document describes version 0.41 of Org::Element::TableRow (from Perl distribution Org-Parser), released on 2014-11-18.

=head1 DESCRIPTION

Derived from L<Org::Element>. Must have L<Org::Element::TableCell>
instances as its children.

=head1 ATTRIBUTES

=head1 METHODS

=for Pod::Coverage as_string

=head2 $table->cells() => ELEMENTS

Return the cells of the row.

=head2 $table->as_array() => ARRAY

Return an arrayref containing the cells of the row, each cells already
stringified with as_string().

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/Org-Parser>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-Org-Parser>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=Org-Parser>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
