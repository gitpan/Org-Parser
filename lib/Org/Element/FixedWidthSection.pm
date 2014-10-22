package Org::Element::FixedWidthSection;

use 5.010;
use locale;
use Moo;
extends 'Org::Element';

our $VERSION = '0.39'; # VERSION

sub text {
    my ($self) = @_;
    my $res = $self->_str;
    $res =~ s/^[ \t]*: ?//mg;
    $res;
}

1;
# ABSTRACT: Represent Org fixed-width section

__END__

=pod

=encoding UTF-8

=head1 NAME

Org::Element::FixedWidthSection - Represent Org fixed-width section

=head1 VERSION

This document describes version 0.39 of Org::Element::FixedWidthSection (from Perl distribution Org-Parser), released on 2014-07-17.

=head1 SYNOPSIS

 use Org::Element::FixedWidthSection;
 my $el = Org::Element::FixedWidthSection->new(_str => ": line1\n: line2\n");

=head1 DESCRIPTION

Fixed width section is a block of text where each line is prefixed by colon +
space (or just a colon + space or a colon). Example:

 Here is an example:
   : some example from a text file.
   :   second line.
   :
   : fourth line, after the empty above.

which is functionally equivalent to:

 Here is an example:
   #+BEGIN_EXAMPLE
   some example from a text file.
     another example.

   fourth line, after the empty above.
   #+END_EXAMPLE

Derived from L<Org::Element>.

=head1 ATTRIBUTES

=head1 METHODS

=head2 $el->text => STR

The text (without colon prefix).

=for Pod::Coverage as_string BUILD

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
