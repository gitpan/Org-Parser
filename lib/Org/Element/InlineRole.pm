package Org::Element::InlineRole;

our $DATE = '2014-12-01'; # DATE
our $VERSION = '0.43'; # VERSION

use 5.010;
use Moo::Role;

requires 'as_text';

sub children_as_text {
    my ($self) = @_;
    return "" unless $self->children;
    join "", map {$_->as_text} @{$self->children};
}

1;
# ABSTRACT: Inline elements

__END__

=pod

=encoding UTF-8

=head1 NAME

Org::Element::InlineRole - Inline elements

=head1 VERSION

This document describes version 0.43 of Org::Element::InlineRole (from Perl distribution Org-Parser), released on 2014-12-01.

=head1 DESCRIPTION

This role is applied to elements that are "inline": elements that can occur
inside text and put as a child of L<Org::Element::Text>.

=head1 REQUIRES

=head2 as_text => str

Get the "rendered plaintext" representation of element. Most elements would
return the same result as C<as_string>, except for elements like
L<Org::Element::Link> which will return link description instead of the link
itself.

=head1 METHODS

=head2 children_as_text => str

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/Org-Parser>.

=head1 SOURCE

Source repository is at L<https://github.com/sharyanto/perl-Org-Parser>.

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
