package Org::Element::Footnote;

use 5.010;
use locale;
use Log::Any '$log';
use Moo;
extends 'Org::Element';

our $VERSION = '0.28'; # VERSION

has name => (is => 'rw');
has is_ref => (is => 'rw');
has def => (is => 'rw');

sub BUILD {
    my ($self, $args) = @_;
    $log->tracef("name = %s", $self->name);
}

sub as_string {
    my ($self) = @_;

    join("",
         "[fn:", ($self->name // ""),
         defined($self->def) ? ":".$self->def->as_string : "",
         "]");
}

1;
# ABSTRACT: Represent Org footnote reference and/or definition


__END__
=pod

=head1 NAME

Org::Element::Footnote - Represent Org footnote reference and/or definition

=head1 VERSION

version 0.28

=head1 DESCRIPTION

Derived from L<Org::Element>.

=head1 ATTRIBUTES

=head2 name => STR|undef

Can be undef, for anonymous footnote (but in case of undef, is_ref must be
true and def must also be set).

=head2 is_ref => BOOL

Set to true to make this a footnote reference.

=head2 def => TEXT ELEMENT

Set to make this a footnote definition.

=head1 METHODS

=for Pod::Coverage as_string BUILD

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

