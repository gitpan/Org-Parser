package Org::Element::TableVLine;

use 5.010;
use locale;
use Moo;
extends 'Org::Element';

our $VERSION = '0.20'; # VERSION

sub as_string {
    my ($self) = @_;
    return $self->_str if $self->_str;
    "|---\n";
}

1;


=pod

=head1 NAME

Org::Element::TableVLine - Represent Org table vertical line

=head1 VERSION

version 0.20

=head1 DESCRIPTION

Derived from L<Org::Element>.

=head1 ATTRIBUTES

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
# ABSTRACT: Represent Org table vertical line

