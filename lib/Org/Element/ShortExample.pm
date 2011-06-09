package Org::Element::ShortExample;
BEGIN {
  $Org::Element::ShortExample::VERSION = '0.15';
}
# ABSTRACT: Represent Org in-buffer settings

use 5.010;
use locale;
use Moo;
extends 'Org::Element::Base';


has example => (is => 'rw');


has indent => (is => 'rw');



sub as_string {
    my ($self) = @_;
    join("",
         $self->indent // "",
         ": ",
         $self->example,
         "\n"
     );
}

1;


=pod

=head1 NAME

Org::Element::ShortExample - Represent Org in-buffer settings

=head1 VERSION

version 0.15

=head1 DESCRIPTION

Short example is one-line literal example which is preceded by colon + space.
Example:

 Here is an example:
   : some example from a text file.
   :   another example.

which is functionally equivalent to:

 Here is an example:
   #+BEGIN_EXAMPLE
   some example from a text file.
   #+END_EXAMPLE
   #+BEGIN_EXAMPLE
     another example.
   #+END_EXAMPLE

Derived from L<Org::Element::Base>.

=head1 ATTRIBUTES

=head2 example => STR

Example content.

=head2 indent => STR

Indentation (whitespaces before C<#+>), or empty string if none.

=head1 METHODS

=for Pod::Coverage as_string BUILD

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

