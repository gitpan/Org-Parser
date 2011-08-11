package Org::Element::Text;

use 5.010;
use locale;
use Moo;
extends 'Org::Element';

our $VERSION = '0.18'; # VERSION

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


=pod

=head1 NAME

Org::Element::Text - Represent text

=head1 VERSION

version 0.18

=head1 DESCRIPTION

Derived from L<Org::Element>.

=head1 ATTRIBUTES

=head2 text

=head2 style

''=normal, I=italic, B=bold, U=underline, S=strikethrough, V=verbatim,
C=code

=head1 METHODS

=for Pod::Coverage as_string

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__


