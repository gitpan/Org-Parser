package Org::Dump;

use 5.010;
use strict;
use warnings;
use Log::Any qw($log);

use String::Escape qw(elide printable);

our $VERSION = '0.43'; # VERSION

sub _dump_ts {
    my ($self, $ts) = @_;
    my $dump = "";
    $dump .= "A " if $ts->is_active;
    my $dt = $ts->datetime;
    my $tz = $dt->time_zone;
    $dump .= $dt.
        ($tz->is_floating ? "F" : $tz->short_name_for_datetime($dt));
    $dump;
}

sub dump_element {
    my ($el, $indent_level) = @_;
    __PACKAGE__->new->_dump($el, $indent_level);
}

sub new {
    my ($class) = @_;
    bless {}, $class;
}

sub _dump {
    my ($self, $el, $indent_level) = @_;
    $indent_level //= 0;
    my @res;

    my $line = "  " x $indent_level;
    my $type = ref($el);
    $type =~ s/^Org::(?:Element::)?//;
    $line .= "$type:";
    # per-element important info
    if ($type eq 'Headline') {
        $line .= " l=".$el->level;
        $line .= " tags=[".join(",", @{$el->tags})."]" if $el->tags;
        $line .= " todo=".$el->todo_state if $el->todo_state;
        $line .= " prio=".$el->priority if $el->priority;
        $line .= " prog=".$el->progress if $el->progress;
    } elsif ($type eq 'Footnote') {
        $line .= " name=".($el->name // "");
    } elsif ($type eq 'Block') {
        $line .= " name=".($el->name // "");
    } elsif ($type eq 'List') {
        $line .= " ".$el->type;
        $line .= "(".$el->bullet_style.")";
        $line .= " indent=".length($el->indent);
    } elsif ($type eq 'ListItem') {
        $line .= " ".$el->bullet;
        $line .= " [".$el->check_state."]" if $el->check_state;
    } elsif ($type eq 'Text') {
        #$line .= " mu_start" if $el->{_mu_start}; #TMP
        #$line .= " mu_end" if $el->{_mu_end}; #TMP
        $line .= " ".$el->style if $el->style;
    } elsif ($type eq 'Timestamp') {
        $line .= " ".$self->_dump_ts($el);
    } elsif ($type eq 'TimeRange') {
    } elsif ($type eq 'Drawer') {
        $line .= " ".$el->name;
        $line .= " "._format_properties($el->properties)
            if $el->name eq 'PROPERTIES' && $el->properties;
    }
    unless ($el->children) {
        $line .= " \"".
            printable(elide(($el->_str // $el->as_string), 50))."\"";
    }
    push @res, $line, "\n";

    if ($type eq 'Headline') {
        push @res, "  " x ($indent_level+1), "(title)\n";
        push @res, $self->_dump($el->title, $indent_level+1);
        push @res, "  " x ($indent_level+1), "(children)\n" if $el->children;
    } elsif ($type eq 'Footnote') {
        if ($el->def) {
            push @res, "  " x ($indent_level+1), "(definition)\n";
            push @res, $self->_dump($el->def, $indent_level+1);
        }
        push @res, "  " x ($indent_level+1), "(children)\n" if $el->children;
    } elsif ($type eq 'ListItem') {
        if ($el->desc_term) {
            push @res, "  " x ($indent_level+1), "(description term)\n";
            push @res, $self->_dump($el->desc_term, $indent_level+1);
        }
        push @res, "  " x ($indent_level+1), "(children)\n" if $el->children;
    }

    if ($el->children) {
        push @res, $self->_dump($_, $indent_level+1) for @{ $el->children };
    }

    join "", @res;
}

sub _format_properties {
    my ($props) = @_;
    #use Data::Dump::OneLine qw(dump1); return dump1($props);
    my @s;
    for my $k (sort keys %$props) {
        my $v = $props->{$k};
        if (ref($v) eq 'ARRAY') {
            $v = "[" . join(",", map {printable($_)} @$v). "]";
        } else {
            $v = printable($v);
        }
        push @s, "$k=$v";
    }
    "{" . join(", ", @s) . "}";
}

1;
#ABSTRACT: Show Org document/element object in a human-friendly format

__END__

=pod

=encoding UTF-8

=head1 NAME

Org::Dump - Show Org document/element object in a human-friendly format

=head1 VERSION

This document describes version 0.43 of Org::Dump (from Perl distribution Org-Parser), released on 2014-12-01.

=head1 FUNCTIONS

None are exported.

=for Pod::Coverage new

=head2 dump_element($elem) => STR

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/Org-Parser>.

=head1 SOURCE

Source repository is at L<https://github.com/sharyanto/perl-Org-Parser>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=Org-Parser>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
