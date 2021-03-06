package Org::Element::Block;

use 5.010;
use locale;
use Moo;
use experimental 'smartmatch';
extends 'Org::Element';

our $VERSION = '0.43'; # VERSION

has name => (is => 'rw');
has args => (is => 'rw');
has raw_content => (is => 'rw');
has begin_indent => (is => 'rw');
has end_indent => (is => 'rw');

my @known_blocks = qw(
                         ASCII CENTER COMMENT EXAMPLE HTML
                         LATEX QUOTE SRC VERSE
                 );

sub BUILD {
    my ($self, $args) = @_;
    $self->name(uc $self->name);
    $self->name ~~ @known_blocks or die "Unknown block name: ".$self->name;
}

sub element_as_string {
    my ($self) = @_;
    return $self->_str if defined $self->_str;
    join("",
         $self->begin_indent // "",
         "#+BEGIN_".uc($self->name),
         $self->args && @{$self->args} ?
             " ".Org::Document::__format_args($self->args) : "",
         "\n",
         $self->raw_content,
         $self->end_indent // "",
         "#+END_".uc($self->name)."\n");
}

1;
# ABSTRACT: Represent Org block

__END__

=pod

=encoding UTF-8

=head1 NAME

Org::Element::Block - Represent Org block

=head1 VERSION

This document describes version 0.43 of Org::Element::Block (from Perl distribution Org-Parser), released on 2014-12-01.

=head1 DESCRIPTION

Derived from L<Org::Element>.

=head1 ATTRIBUTES

=head2 name => STR

Block name. For example, #+begin_src ... #+end_src is an 'SRC' block.

=head2 args => ARRAY

=head2 raw_content => STR

=head2 begin_indent => STR

Indentation on begin line (before C<#+BEGIN>), or empty string if none.

=head2 end_indent => STR

Indentation on end line (before C<#+END>), or empty string if none.

=head1 METHODS

=for Pod::Coverage element_as_string BUILD

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
