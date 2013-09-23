use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::Compile 2.030

use Test::More  tests => 23 + ($ENV{AUTHOR_TESTING} ? 1 : 0);



my @module_files = (
    'Org/Document.pm',
    'Org/Dump.pm',
    'Org/Element.pm',
    'Org/Element/Block.pm',
    'Org/Element/Comment.pm',
    'Org/Element/Drawer.pm',
    'Org/Element/FixedWidthSection.pm',
    'Org/Element/Footnote.pm',
    'Org/Element/Headline.pm',
    'Org/Element/Link.pm',
    'Org/Element/List.pm',
    'Org/Element/ListItem.pm',
    'Org/Element/RadioTarget.pm',
    'Org/Element/Setting.pm',
    'Org/Element/Table.pm',
    'Org/Element/TableCell.pm',
    'Org/Element/TableRow.pm',
    'Org/Element/TableVLine.pm',
    'Org/Element/Target.pm',
    'Org/Element/Text.pm',
    'Org/Element/TimeRange.pm',
    'Org/Element/Timestamp.pm',
    'Org/Parser.pm'
);



# no fake home requested

use IPC::Open3;
use IO::Handle;

my @warnings;
for my $lib (@module_files)
{
    # see L<perlfaq8/How can I capture STDERR from an external command?>
    my $stdin = '';     # converted to a gensym by open3
    my $stderr = IO::Handle->new;

    my $pid = open3($stdin, '>&STDERR', $stderr, qq{$^X -Mblib -e"require q[$lib]"});
    binmode $stderr, ':crlf' if $^O; # eq 'MSWin32';
    waitpid($pid, 0);
    is($? >> 8, 0, "$lib loaded ok");

    if (my @_warnings = <$stderr>)
    {
        warn @_warnings;
        push @warnings, @_warnings;
    }
}



is(scalar(@warnings), 0, 'no warnings found') if $ENV{AUTHOR_TESTING};


