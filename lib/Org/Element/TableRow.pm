package Org::Element::TableRow;
BEGIN {
  $Org::Element::TableRow::VERSION = '0.16';
}
# ABSTRACT: Represent Org table row

use 5.010;
use locale;
use Moo;
extends 'Org::Element::Base';


sub as_string {
    my ($self) = @_;
    return $self->_str if defined $self->_str;

    join("",
         "|",
         join("|", map {$_->as_string} @{$self->children}),
         "\n");
}


sub cells {
    my ($self) = @_;
    return [] unless $self->children;

    my $cells = [];
    for my $el (@{$self->children}) {
        push @$cells, $el if $el->isa('Org::Element::TableCell');
    }
    $cells;
}

1;


=pod

=head1 NAME

Org::Element::TableRow - Represent Org table row

=head1 VERSION

version 0.16

=head1 DESCRIPTION

Derived from L<Org::Element::Base>.

=head1 DESCRIPTION

Must have L<Org::Element::TableCell> instances as its children.

=head1 ATTRIBUTES

=head1 METHODS

=for Pod::Coverage as_string

=head2 $table->cells() => ELEMENTS

Return the cells of the row.

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

