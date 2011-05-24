package Org::Element::Table;
BEGIN {
  $Org::Element::Table::VERSION = '0.11';
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
    my ($self, $args) = @_;
    my $pass = $args->{pass} // 1;

    # parse _str into rows & cells
    my $_str = $args->{_str};
    if (defined $_str && !defined($self->children)) {

        if (!defined($self->_str_include_children)) {
            $self->_str_include_children(1);
        }

        my $doc = $self->document;
        my @rows0 = split /\R/, $_str;
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
                    $doc->_add_text($cell0, $cell, $pass);
                    push @{ $row->children }, $cell;
                }
            } else {
                die "Invalid line in table: $row0";
            }
            push @{$self->children}, $row;
        }
    }
}

1;


=pod

=head1 NAME

Org::Element::Table - Represent Org table

=head1 VERSION

version 0.11

=head1 DESCRIPTION

Derived from L<Org::Element::Base>.

=head1 DESCRIPTION

Must have L<Org::Element::TableRow> or L<Org::Element::TableVLine> instances as
its children.

=head1 ATTRIBUTES

=head1 METHODS

=for Pod::Coverage BUILD

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

