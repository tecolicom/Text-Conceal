use strict;
use warnings;
use utf8;
use open IO => ':utf8', ':std';
use lib 't/lib'; use Text::VPrintf;

use Test::More;

is( Text::VPrintf::sprintf( '%4s',  "\N{WORD JOINER}"), "   \N{WORD JOINER}", 'zero-width char' );
is( Text::VPrintf::sprintf( '%-4s', "\N{WORD JOINER}"), "\N{WORD JOINER}   ", 'zero-width char' );

Text::VPrintf::configure(zerowidth => "");

is( Text::VPrintf::sprintf( '%4s',  "\N{WORD JOINER}"), "    ", 'zero-width char w/zero=""' );
is( Text::VPrintf::sprintf( '%-4s', "\N{WORD JOINER}"), "    ", 'zero-width char w/zero=""' );

Text::VPrintf::configure(zerowidth => "\0");

is( Text::VPrintf::sprintf( '%4s',  "\N{WORD JOINER}"), "   \0", 'zero-width char w/zero="\\0"' );
is( Text::VPrintf::sprintf( '%-4s', "\N{WORD JOINER}"), "\0   ", 'zero-width char w/zero="\\0"' );

done_testing;
