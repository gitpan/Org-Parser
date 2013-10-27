package Org::Element::TimeRange;

use 5.010;
use locale;
use Moo;
extends 'Org::Element';

our $VERSION = '0.37'; # VERSION

has ts1 => (is => 'rw');
has ts2 => (is => 'rw');

sub as_string {
    my ($self) = @_;
    return $self->_str if $self->_str;
    join("",
         $self->ts1->as_string,
         "--",
         $self->ts2->as_string
     );
}

1;
# ABSTRACT: Represent Org time range (TS1--TS2)

__END__

=pod

=encoding utf-8

=head1 NAME

Org::Element::TimeRange - Represent Org time range (TS1--TS2)

=head1 DESCRIPTION

Derived from L<Org::Element>.

=head1 ATTRIBUTES

=head2 ts1 => TIMESTAMP ELEMENT

Starting timestamp.

=head2 ts2 => TIMESTAMP ELEMENT

Ending timestamp.

=head1 METHODS

=for Pod::Coverage as_string

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/Org-Parser>.

=head1 SOURCE

Source repository is at L<https://github.com/sharyanto/perl-Org-Parser>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website
http://rt.cpan.org/Public/Dist/Display.html?Name=Org-Parser

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
