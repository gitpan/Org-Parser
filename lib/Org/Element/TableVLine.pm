package Org::Element::TableVLine;

use 5.010;
use locale;
use Moo;
extends 'Org::Element';

our $VERSION = '0.38'; # VERSION

sub as_string {
    my ($self) = @_;
    return $self->_str if $self->_str;
    "|---\n";
}

1;
#ABSTRACT: Represent Org table vertical line

__END__

=pod

=encoding UTF-8

=head1 NAME

Org::Element::TableVLine - Represent Org table vertical line

=head1 VERSION

This document describes version 0.38 of Org::Element::TableVLine (from Perl distribution Org-Parser), released on 2014-05-17.

=head1 DESCRIPTION

Derived from L<Org::Element>.

=head1 ATTRIBUTES

=head1 METHODS

=for Pod::Coverage as_string

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

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
