package Org::Element::TodoItem;
BEGIN {
  $Org::Element::TodoItem::VERSION = '0.03';
}
# ABSTRACT: Represent an Org TODO item

use 5.010;
use strict;
use warnings;

use Moo;
extends 'Org::Element::Headline';

1;


=pod

=head1 NAME

Org::Element::TodoItem - Represent an Org TODO item

=head1 VERSION

version 0.03

=head1 DESCRIPTION

Derived from Org::Element::Headline.

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

