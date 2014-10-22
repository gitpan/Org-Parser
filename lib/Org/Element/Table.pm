package Org::Element::Table;
BEGIN {
  $Org::Element::Table::VERSION = '0.02';
}
# ABSTRACT: Represent Org table

use 5.010;
use Log::Any '$log';
use Moo;
extends 'Org::Element::Base';


has _dummy => (is => 'rw'); # workaround Moo bug



sub BUILD {
    require Org::Element::TableRow;
    require Org::Element::TableVLine;
    require Org::Element::TableCell;
    require Org::Parser;
    my ($self, $args) = @_;
    my $raw = $args->{raw};
    if (defined $raw) {
        my $doc = $self->document
            or die "Please specify document when specifying raw";
        my $orgp = $self->document->_parser // Org::Parser->new;
        $self->_raw($raw);
        my @rows0 = split /\R/, $raw;
        $self->children([]);
        for my $row0 (@rows0) {
            $log->tracef("table line: %s", $row0);
            next unless $row0 =~ /\S/;
            my $row;
            if ($row0 =~ /^\s*\|--+(?:\+--+)*\|?\s*$/) {
                $row = Org::Element::TableVLine->new(parent => $self);
            } elsif ($row0 =~ /^\s*\|\s*(.+?)\s*\|?\s*$/) {
                my $s = $1;
                $row = Org::Element::TableRow->new(
                    parent => $self, children=>[]);
                for my $cell0 (split /\s*\|\s*/, $s) {
                    my $cell = Org::Element::TableCell->new(
                        parent => $row, children=>[]);
                    $orgp->parse_inline($cell0, $doc, $cell);
                    push @{ $row->children }, $cell;
                }
            } else {
                die "Invalid line in table: $row0";
            }
            push @{$self->children}, $row;
        }
    }
}

sub as_string {
    my ($self) = @_;
    $self->element_as_string;
}

1;


=pod

=head1 NAME

Org::Element::Table - Represent Org table

=head1 VERSION

version 0.02

=head1 DESCRIPTION

Derived from Org::Element::Base.

=head1 DESCRIPTION

Must have L<Org::Element::TableRow> instances as its children.

=head1 ATTRIBUTES

# caption

# label

=head1 METHODS

=for Pod::Coverage as_string BUILD

=head2 new(attr => val, ...)

=head2 new(raw => STR, document => OBJ)

Create a new table from parsing raw string. (You can also create manually
directly by filling out attributes).

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

