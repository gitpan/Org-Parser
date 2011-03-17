package Org::Document;
BEGIN {
  $Org::Document::VERSION = '0.02';
}
# ABSTRACT: Represent an Org document

use 5.010;
use strict;
use warnings;

use Moo;
extends 'Org::Element::Base';


has todo_states             => (is => 'rw', default => sub{[qw/TODO/]});


has done_states             => (is => 'rw', default => sub{[qw/DONE/]});


has priorities              => (is => 'rw', default => sub{[qw/A B C/]});


has drawers                 => (is => 'rw', default => sub{[
    qw/CLOCK LOGBOOK PROPERTIES/]});

has _parser => (is => 'rw');

1;


=pod

=head1 NAME

Org::Document - Represent an Org document

=head1 VERSION

version 0.02

=head1 DESCRIPTION

Derived from Org::Element::Base.

=head1 ATTRIBUTES

=head2 todo_states => ARRAY

List of known (action-requiring) todo states. Default is ['TODO'].

=head2 done_states => ARRAY

List of known done (non-action-requiring) states. Default is ['DONE'].

=head2 priorities => ARRAY

List of known priorities. Default is ['A', 'B', 'C'].

=head2 drawers => ARRAY

List of known drawer names. Default is [qw/CLOCK LOGBOOK PROPERTIES/].

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

