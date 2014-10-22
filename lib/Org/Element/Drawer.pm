package Org::Element::Drawer;

use 5.010;
use locale;
use Moo;
use experimental 'smartmatch';
extends 'Org::Element';

our $VERSION = '0.39'; # VERSION

has name => (is => 'rw');
has properties => (is => 'rw');

sub BUILD {
    my ($self, $args) = @_;
    my $doc = $self->document;
    my $pass = $args->{pass} // 1;

    if ($pass == 2) {
        die "Unknown drawer name: ".$self->name
            unless $self->name ~~ @{$doc->drawer_names};
    }
}

sub _parse_properties {
    my ($self, $raw_content) = @_;
    $self->properties({}) unless $self->properties;
    while ($raw_content =~ /^[ \t]*:(\w+):[ \t]+
                            ($Org::Document::args_re)[ \t]*(?:\R|\z)/mxg) {
        my $args = Org::Document::__parse_args($2);
        $self->properties->{$1} = @$args == 1 ? $args->[0] : $args;
    }
}

sub as_string {
    my ($self) = @_;
    join("",
         ":", $self->name, ":\n",
         $self->children_as_string,
         ":END:");
}

1;
# ABSTRACT: Represent Org drawer

__END__

=pod

=encoding UTF-8

=head1 NAME

Org::Element::Drawer - Represent Org drawer

=head1 VERSION

This document describes version 0.39 of Org::Element::Drawer (from Perl distribution Org-Parser), released on 2014-07-17.

=head1 DESCRIPTION

Derived from L<Org::Element>.

=head1 ATTRIBUTES

=head2 name => STR

Drawer name.

=head2 properties => HASH

Collected properties in the drawer.

=head1 METHODS

=for Pod::Coverage BUILD as_string

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
