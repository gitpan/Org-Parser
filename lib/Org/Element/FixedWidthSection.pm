package Org::Element::FixedWidthSection;

use 5.010;
use locale;
use Moo;
extends 'Org::Element';

our $VERSION = '0.27'; # VERSION

sub text {
    my ($self) = @_;
    my $res = $self->_str;
    $res =~ s/^[ \t]*: ?//mg;
    $res;
}

1;
# ABSTRACT: Represent Org fixed-width section


=pod

=head1 NAME

Org::Element::FixedWidthSection - Represent Org fixed-width section

=head1 VERSION

version 0.27

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

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

