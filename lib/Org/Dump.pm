package Org::Dump;
BEGIN {
  $Org::Dump::VERSION = '0.11';
}
#ABSTRACT: Show Org document/element object in a human-friendly format

use 5.010;
use strict;
use warnings;
use Log::Any qw($log);

use String::Escape qw(elide printable);


sub dump_element {
    my ($el, $indent_level) = @_;
    $indent_level //= 0;
    my @res;

    my $line = "  " x $indent_level;
    my $type = ref($el);
    $type =~ s/^Org::(?:Element::)?//;
    $line .= "$type:";
    # per-element important info
    if ($type eq 'Headline') {
        $line .= " l=".$el->level;
        $line .= " tags ".join(",", @{$el->tags}) if $el->tags;
        $line .= " todo=".$el->todo_state if $el->todo_state;
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
        $line .= " A" if $el->is_active;
        $line .= " dt=".$el->datetime;
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
        push @res, dump_element($el->title, $indent_level+1);
        push @res, "  " x ($indent_level+1), "(children)\n" if $el->children;
    } elsif ($type eq 'Footnote') {
        if ($el->def) {
            push @res, "  " x ($indent_level+1), "(definition)\n";
            push @res, dump_element($el->def, $indent_level+1);
        }
        push @res, "  " x ($indent_level+1), "(children)\n" if $el->children;
    } elsif ($type eq 'ListItem') {
        if ($el->desc_term) {
            push @res, "  " x ($indent_level+1), "(description term)\n";
            push @res, dump_element($el->desc_term, $indent_level+1);
        }
        push @res, "  " x ($indent_level+1), "(children)\n" if $el->children;
    }

    if ($el->children) {
        push @res, dump_element($_, $indent_level+1) for @{ $el->children };
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

__END__
=pod

=head1 NAME

Org::Dump - Show Org document/element object in a human-friendly format

=head1 VERSION

version 0.11

=head1 FUNCTIONS

None are exported.

=head2 dump_element($elem) => STR

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

