package Org::Element::Timestamp;
BEGIN {
  $Org::Element::Timestamp::VERSION = '0.11';
}
# ABSTRACT: Represent Org timestamp

use 5.010;
use Moo;
extends 'Org::Element::Base';


has datetime => (is => 'rw');


has has_time => (is => 'rw');


has event_duration => (is => 'rw');


has recurrence => (is => 'rw');
has _repeater => (is => 'rw'); # stores the raw repeater spec


has is_active => (is => 'rw');



our @dow = (undef, qw(Mon Tue Wed Thu Fri Sat Sun));

sub as_string {
    my ($self) = @_;
    return $self->_str if $self->_str;
    my $dt = $self->datetime;
    my ($hour2, $min2);
    if ($self->event_duration) {
        my $hour = $dt->hour;
        my $min = $dt->minute;
        my $mins = $self->event_duration / 60;
        $min2 = $min + $mins;
        my $hours = int ($min2 / 60);
        $hour2 = $hour + $hours;
        $min2  = $min2 % 60;
    }
    join("",
         $self->is_active ? "<" : "[",
         $dt->ymd, " ",
         $dow[$dt->day_of_week],
         $self->has_time ? (
             " ",
             sprintf("%02d:%02d", $dt->hour, $dt->minute),
             defined($hour2) ? (
                 "-",
                 sprintf("%02d:%02d", $hour2, $min2),
             ) : (),
             $self->_repeater ? (
                 " +",
                 $self->_repeater,
             ) : (),
         ) : (),
         $self->is_active ? ">" : "]",
     );
}

sub _parse_timestamp {
    require DateTime;
    require DateTime::Event::Recurrence;
    my ($self, $str, $opts) = @_;
    $opts //= {};
    $opts->{allow_event_duration} //= 1;
    $opts->{allow_repeater} //= 1;

    $str =~ /^(?<open_bracket> \[|<)
             (?<year> \d{4})-(?<mon> \d{2})-(?<day> \d{2}) \s
             (?:
                 (?<dow> \w{2,3})
                 (?:\s
                     (?<hour> \d{2}):(?<min> \d{2})
                     (?:-
                         (?<event_duration>
                             (?<hour2> \d{2}):(?<min2> \d{2}))
                     )?
                 )?
                 (?:\s\+
                     (?<repeater>
                         (?<repeater_interval> \d+)
                         (?<repeater_unit> [dwmy])
                     )
                 )?
             )?
             (?<close_bracket> \]|>)
             $/x
                 or die "Can't parse timestamp string: $str";
    die "Duration not allowed in timestamp: $str"
        if !$opts->{allow_event_duration} && $+{event_duration};
    die "Repeater ($+{repeater}) not allowed in timestamp: $str"
        if !$opts->{allow_repeater} && $+{repeater};

    $self->is_active($+{open_bracket} eq '<' ? 1:0)
        unless defined $self->is_active;

    if ($+{event_duration} && !defined($self->event_duration)) {
        $self->event_duration(
            ($+{hour2}-$+{hour})*3600 +
            ($+{min2} -$+{min} )*60
        );
    }

    if ($+{repeater} && !$self->recurrence) {
        my $r;
        my $i = $+{repeater_interval};
        my $u = $+{repeater_unit};
        if ($u eq 'd') {
            $r = DateTime::Event::Recurrence->daily(interval=>$i);
        } elsif ($u eq 'w') {
            $r = DateTime::Event::Recurrence->weekly(interval=>$i);
        } elsif ($u eq 'm') {
            $r = DateTime::Event::Recurrence->monthly(interval=>$i);
        } elsif ($u eq 'y') {
            $r = DateTime::Event::Recurrence->yearly(interval=>$i);
        } else {
            die "BUG: Unknown repeater unit $u in timestamp $str";
        }
        $self->recurrence($r);
        $self->_repeater($+{repeater});
    }

    my %dt_args = (year => $+{year}, month=>$+{mon}, day=>$+{day});
    if (defined($+{hour})) {
        $dt_args{hour}   = $+{hour};
        $dt_args{minute} = $+{min};
        $self->has_time(1);
    } else {
        $self->has_time(0);
    }
    $self->datetime(DateTime->new(%dt_args));
}

1;


=pod

=head1 NAME

Org::Element::Timestamp - Represent Org timestamp

=head1 VERSION

version 0.11

=head1 DESCRIPTION

Derived from L<Org::Element::Base>.

=head1 ATTRIBUTES

=head2 datetime => DATETIME_OBJ

=head2 has_time => BOOL

=head2 event_duration => INT

Event duration in seconds, e.g. for event timestamp like this:

 <2011-03-23 10:15-13:25>

event_duration is 7200+600=7800 (2 hours 10 minutes).

=head2 recurrence => DateTime::Event::Recurrence object

=head2 is_active => BOOL

=head1 METHODS

=for Pod::Coverage as_string

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

