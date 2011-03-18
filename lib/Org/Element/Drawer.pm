package Org::Element::Drawer;
BEGIN {
  $Org::Element::Drawer::VERSION = '0.03';
}
# ABSTRACT: Represent Org drawer

use 5.010;
use Moo;
extends 'Org::Element::Base';


has name => (is => 'rw');


has raw_content => (is => 'rw');



sub BUILD {
    my ($self, $args) = @_;
    my $raw = $args->{raw};
    if (defined $raw) {
        my $doc = $self->document
            or die "Please specify document when specifying raw";
        state $re = qr/\A\s*:(\w+):\s*\R
                       ((?:.|\R)*?)    # content
                       [ \t]*:END:\z   # closing
                      /xi;
        $raw =~ $re or die "Invalid syntax in drawer: $raw";
        my ($d, $rc) = (uc($1), $2);
        $d ~~ @{ $doc->drawers } or die "Unknown drawer name $d: $raw";
        $self->name($d);
        $self->raw_content($rc);
    }
}

sub element_as_string {
    my ($self) = @_;
    return $self->_raw if $self->_raw;
    join("",
         ":", uc($self->name), ":", "\n",
         $self->children ? $self->children_as_string : $self->raw_content,
         ":END:\n");
}

sub as_string {
    my ($self) = @_;
    $self->element_as_string;
}

1;


=pod

=head1 NAME

Org::Element::Drawer - Represent Org drawer

=head1 VERSION

version 0.03

=head1 DESCRIPTION

Derived from Org::Element::Base.

=head1 ATTRIBUTES

=head2 name => STR

Drawer name.

=head2 raw_content => STR

=head1 METHODS

=for Pod::Coverage as_string element_as_string BUILD

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

