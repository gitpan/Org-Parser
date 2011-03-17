package Org::Element::ScheduleTimestamp;
BEGIN {
  $Org::Element::ScheduleTimestamp::VERSION = '0.02';
}
# ABSTRACT: Represent Org schedule timestamp

use 5.010;
use Moo;
extends 'Org::Element::Base';


has datetime => (is => 'rw');



sub BUILD {
    require Org::Parser;
    my ($self, $args) = @_;
    my $raw = $args->{raw};
    my $doc = $self->document;
    if (defined $raw) {
        state $re = qr/^<(.+)>$/;
        $raw =~ $re or die "Invalid syntax in timestamp: $raw";
        my $ts = Org::Parser::__parse_timestamp($1)
            or die "Can't parse timestamp $1";
        $self->datetime($ts);
    }
}

sub element_as_string {
    my ($self) = @_;
    return $self->_raw if $self->_raw;
    join("",
         "<", $self->datetime->ymd, " ",
         # XXX Thu 11:59
         ">");
}

1;


=pod

=head1 NAME

Org::Element::ScheduleTimestamp - Represent Org schedule timestamp

=head1 VERSION

version 0.02

=head1 DESCRIPTION

Derived from Org::Element::Base.

=head1 ATTRIBUTES

=head2 datetime

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

