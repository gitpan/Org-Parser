package Org::Element::TableRow;
BEGIN {
  $Org::Element::TableRow::VERSION = '0.02';
}
# ABSTRACT: Represent Org table row

use 5.010;
use Moo;
extends 'Org::Element::Base';


sub children_as_string {
    my ($self) = @_;
    my @res;
    push @res, map { ("|", $_->as_string) } @{ $self->children };
    push @res, "\n";
    join "", @res;
}


__END__
=pod

=head1 NAME

Org::Element::TableRow - Represent Org table row

=head1 VERSION

version 0.02

=head1 DESCRIPTION

Derived from Org::Element::Base.

=head1 DESCRIPTION

Must have L<Org::Element::TableCell> instances as its children.

=head1 ATTRIBUTES

=head1 METHODS

=for Pod::Coverage children_as_string

1;
__END__

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

