package Org::Element::Text;

use 5.010;
use locale;
use Moo;
extends 'Org::Element';

our $VERSION = '0.40'; # VERSION

has text => (is => 'rw');
has style => (is => 'rw');

our %mu2style = (''=>'', '*'=>'B', '_'=>'U', '/'=>'I',
                 '+'=>'S', '='=>'C', '~'=>'V');
our %style2mu = reverse(%mu2style);

sub as_string {
    my ($self) = @_;
    my $muchar = $style2mu{$self->style // ''} // '';

    join("",
         $muchar,
         $self->text // '', $self->children_as_string,
         $muchar);
}

1;
# ABSTRACT: Represent text

__END__

=pod

=encoding UTF-8

=head1 NAME

Org::Element::Text - Represent text

=head1 VERSION

This document describes version 0.40 of Org::Element::Text (from Perl distribution Org-Parser), released on 2014-08-28.

=head1 DESCRIPTION

Derived from L<Org::Element>.

=head1 ATTRIBUTES

=head2 text

=head2 style

''=normal, I=italic, B=bold, U=underline, S=strikethrough, V=verbatim,
C=code

=head1 METHODS

=for Pod::Coverage as_string

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
