package Org::Element::RadioTarget;
BEGIN {
  $Org::Element::RadioTarget::VERSION = '0.11';
}
# ABSTRACT: Represent Org radio target

use 5.010;
use Moo;
extends 'Org::Element::Base';


has target => (is => 'rw');



sub BUILD {
    my ($self, $args) = @_;
    my $pass = $args->{pass} // 1;
    my $doc  = $self->document;
    if ($pass == 1) {
        push @{ $doc->radio_targets },
            $self->target;
    }
}

sub as_string {
    my ($self) = @_;
    join("",
         "<<<", $self->target, ">>>");
}

1;


=pod

=head1 NAME

Org::Element::RadioTarget - Represent Org radio target

=head1 VERSION

version 0.11

=head1 DESCRIPTION

Derived from L<Org::Element::Base>.

=head1 ATTRIBUTES

=head2 target

=head1 METHODS

=for Pod::Coverage as_string BUILD

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__
