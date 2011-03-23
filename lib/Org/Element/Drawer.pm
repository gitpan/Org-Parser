package Org::Element::Drawer;
BEGIN {
  $Org::Element::Drawer::VERSION = '0.07';
}
# ABSTRACT: Represent Org drawer

use 5.010;
use Moo;
extends 'Org::Element::Base';


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
         ":END:\n");
}

1;


=pod

=head1 NAME

Org::Element::Drawer - Represent Org drawer

=head1 VERSION

version 0.07

=head1 DESCRIPTION

Derived from Org::Element::Base.

=head1 ATTRIBUTES

=head2 name => STR

Drawer name.

=head2 properties => HASH

Collected properties in the drawer.

=head1 METHODS

=for Pod::Coverage BUILD as_string

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

