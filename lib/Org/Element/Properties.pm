package Org::Element::Properties;
BEGIN {
  $Org::Element::Properties::VERSION = '0.02';
}
# ABSTRACT: Represent Org properties

use 5.010;
use Moo;
extends 'Org::Element::Drawer';


# XXX use Tie::OrdHash?
has properties => (is => 'rw');



sub BUILD {
    my ($self, $args) = @_;
    $self->SUPER::BUILD($args);
    uc($self->name) eq 'PROPERTIES' or die "Drawer name must be PROPERTIES";
    $self->properties({});
    for (split /\R/, $self->raw_content) {
        next unless /\S/;
        die "Invalid line in PROPERTIES drawer: $_"
            unless /^\s*:(\w+):\s+(.+?)\s*$/;
        $self->properties->{uc $1} = $2;
    }
}

sub element_as_string {
    my ($self) = @_;
    return $self->_raw if $self->_raw;
    join("",
         ":", uc($self->name), ":", "\n",
         map({(" :", uc($_), ": ", $self->properties->{$_}, "\n")}
             sort keys %{ $self->properties }),
         ":END:\n");
}

1;


=pod

=head1 NAME

Org::Element::Properties - Represent Org properties

=head1 VERSION

version 0.02

=head1 DESCRIPTION

Derived from Org::Element::Drawer.

=head1 ATTRIBUTES

=head2 properties => HASHREF

A hashref containing property name and values.

=head1 METHODS

=for Pod::Coverage element_as_string BUILD

=head2 new(attr => val, ...)

=head2 new(raw => STR, document => OBJ)

Create a new headline item from parsing raw string. (You can also create
directly by filling out priority, title, etc).

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

