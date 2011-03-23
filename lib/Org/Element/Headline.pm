package Org::Element::Headline;
BEGIN {
  $Org::Element::Headline::VERSION = '0.05';
}
# ABSTRACT: Represent Org headline

use 5.010;
use Moo;
extends 'Org::Element::Base';


has level => (is => 'rw');


has title => (is => 'rw');


has todo_priority => (is => 'rw');


has tags => (is => 'rw');


has is_todo => (is => 'rw');


has is_done => (is => 'rw');


has todo_state => (is => 'rw');


has progress => (is => 'rw');



sub header_as_string {
    my ($self) = @_;
    return $self->_str if defined $self->_str;
    join("",
         "*" x $self->level,
         " ",
         $self->is_todo ? $self->todo_state." " : "",
         $self->todo_priority ? "[#".$self->todo_priority."] " : "",
         $self->title->as_string,
         $self->tags && @{$self->tags} ?
             "  :".join(":", @{$self->tags}).":" : "",
         "\n");
}

sub as_string {
    my ($self) = @_;
    $self->header_as_string . $self->children_as_string;
}

1;


=pod

=head1 NAME

Org::Element::Headline - Represent Org headline

=head1 VERSION

version 0.05

=head1 DESCRIPTION

Derived from Org::Element::Base.

=head1 ATTRIBUTES

=head2 level => INT

Level of headline (e.g. 1, 2, 3). Corresponds to the number of bullet stars.

=head2 title => OBJ

L<Org::Element::Text> representing the headline title

=head2 todo_priority => STR

String (optional) representing priority.

=head2 tags => ARRAY

Arrayref (optional) containing list of defined tags.

=head2 is_todo => BOOL

Whether this headline is a TODO item.

=head2 is_done => BOOL

Whether this TODO item is in a done state (state which requires no more action,
e.g. DONE). Only meaningful if headline is a TODO item.

=head2 todo_state => STR

TODO state.

=head2 progress => STR

Progress.

=head1 METHODS

=for Pod::Coverage header_as_string as_string

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

