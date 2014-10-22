package Org::Element::Base;
BEGIN {
  $Org::Element::Base::VERSION = '0.12';
}
# ABSTRACT: Base class for element of Org document

use 5.010;
use locale;
use Log::Any '$log';
use Moo;
use Scalar::Util qw(refaddr);


has document => (is => 'rw');


has parent => (is => 'rw');


has children => (is => 'rw');

# store the raw string (to preserve original formatting), not all elements use
# this, usually only more complex elements
has _str => (is => 'rw');
has _str_include_children => (is => 'rw');



sub children_as_string {
    my ($self) = @_;
    return "" unless $self->children;
    join "", map {$_->as_string} @{$self->children};
}


sub as_string {
    my ($self) = @_;

    if (defined $self->_str) {
        return $self->_str .
            ($self->_str_include_children ? "" : $self->children_as_string);
    } else {
        return "" . $self->children_as_string;
    }
}


sub seniority {
    my ($self) = @_;
    my $c;
    return -4 unless $self->parent && ($c = $self->parent->children);
    my $addr = refaddr($self);
    for (my $i=0; $i < @$c; $i++) {
        return $i if refaddr($c->[$i]) == $addr;
    }
    return undef;
}


sub prev_sibling {
    my ($self) = @_;

    my $sen = $self->seniority;
    return undef unless defined($sen) && $sen > 0;
    my $c = $self->parent->children;
    $c->[$sen-1];
}


sub next_sibling {
    my ($self) = @_;

    my $sen = $self->seniority;
    return undef unless defined($sen);
    my $c = $self->parent->children;
    return undef unless $sen < @$c-1;
    $c->[$sen+1];
}


sub get_property {
    my ($self, $name, $search_parent) = @_;
    #$log->tracef("-> get_property(%s, search_par=%s)", $name, $search_parent);
    my $p = $self->parent;
    my $s = $p->children if $p;

    if ($s) {
        for my $d (@$s) {
        #$log->tracef("searching in sibling: %s (%s)", $d->as_string, ref($d));
            next unless $d->isa('Org::Element::Drawer')
                && $d->name eq 'PROPERTIES' && $d->properties;
            return $d->properties->{$name} if defined $d->properties->{$name};
        }
    }

    if ($p && $search_parent) {
        my $res = $p->get_property($name, 1);
        return $res if defined $res;
    }

    $log->tracef("Getting property from document's .properties");
    $self->document->properties->{$name};
}


sub walk {
    my ($self, $code) = @_;
    $code->($self);
    if ($self->children) {
        $_->walk($code) for @{$self->children};
    }
}


sub find {
    my ($self, $criteria) = @_;
    return unless $self->children;
    my @res;
    $self->walk(
        sub {
            my $el = shift;
            if (ref($criteria) eq 'CODE') {
                push @res, $el if $criteria->($el);
            } elsif ($criteria =~ /^\w+$/) {
                push @res, $el if $el->isa("Org::Element::$criteria");
            } else {
                push @res, $el if $el->isa($criteria);
            }
        });
    @res;
}


sub walk_parents {
    my ($self, $code) = @_;
    my $parent = $self->parent;
    while ($parent) {
        return $parent unless $code->($self, $parent);
        $parent = $parent->parent;
    }
    return;
}


sub headline {
    my ($self) = @_;
    my $h;
    $self->walk_parents(
        sub {
            my ($el, $p) = @_;
            if ($p->isa('Org::Element::Headline')) {
                $h = $p;
                return;
            }
            1;
        });
    $h;
}

1;

__END__
=pod

=head1 NAME

Org::Element::Base - Base class for element of Org document

=head1 VERSION

version 0.12

=head1 ATTRIBUTES

=head2 document => DOCUMENT

Link to document object. Elements need this e.g. to access file-wide settings,
properties, etc.

=head2 parent => undef | ELEMENT

Link to parent element.

=head2 children => undef | ARRAY_OF_ELEMENTS

=head1 METHODS

=head2 $el->children_as_string() => STR

Return a concatenation of children's as_string(), or "" if there are no
children.

=head2 $el->as_string() => STR

Return the string representation of element. The default implementation will
just use _str (if defined) concatenated with children_as_string().

=head2 $el->seniority => INT

Find out the ranking of brothers/sisters of all sibling. If we are the first
child of parent, return 0. If we are the second child, return 1, and so on.

=head2 $el->prev_sibling() => ELEMENT | undef

=head2 $el->next_sibling() => ELEMENT | undef

=head2 $el->get_property($name, $search_parent) => VALUE

Search for property named $name in the nearest properties drawer. If
$search_parent is set to true (default is false), will also search in
upper-level properties (useful for searching for inherited property, like
foo_ALL). Return undef if property cannot be found in all drawers.

Regardless of $search_parent setting, file-wide properties will be consulted if
property is not found in nearest properties drawer.

=head2 walk(CODEREF)

Call CODEREF for node and all descendent nodes, depth-first. Code will be given
the element object as argument.

=head2 find(CRITERIA) -> ELEMENTS

Find subelements. CRITERIA can be a word (e.g. 'Headline' meaning of class
'Org::Element::Headline') or a class name ('Org::Element::ListItem') or a
coderef (which will be given the element to test). Will return matched elements.

=head2 $el->walk_parents(CODE)

Run CODEREF for parent, and its parent, and so on until the root element (the
document), or until CODEREF returns a false value. CODEREF will be supplied
($el, $parent). Will return the last parent walked.

=head2 $el->headline()

Get current headline.

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

