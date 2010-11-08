#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

use B::Compiling;

my $sub = eval <<EOF;
BEGIN {
    B::Compiling::PL_compiling->file('blah');
    B::Compiling::PL_compiling->line(23);
}
sub {
    warn "foo";
    warn "bar";
BEGIN {
    B::Compiling::PL_compiling->file('hlab');
    B::Compiling::PL_compiling->line(256);
}
    warn "baz";
    warn "quux";
}
EOF
die $@ if $@;

{
    my @warnings;
    local $SIG{__WARN__} = sub { push @warnings, @_ };
    $sub->();
    is_deeply(
        \@warnings,
        [
            'foo at blah line 24',
            'bar at blah line 25',
            'baz at hlab line 256',
            'quux at hlab line 257',
        ],
        "got the right file and line numbers"
    );
}

{
    BEGIN { PL_compiling->file('blarg') }
    is(__FILE__, 'blarg', "changed file");
}

done_testing;
