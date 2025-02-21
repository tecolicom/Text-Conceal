use strict;
use warnings;
use utf8;
use open IO => ':utf8', ':std';
use lib 't/lib'; use Text::VPrintf;

use Test::More;

is( Text::VPrintf::sprintf( '%4s',  "\N{WORD JOINER}"), "   \N{WORD JOINER}", 'zero-width char' );
is( Text::VPrintf::sprintf( '%-4s', "\N{WORD JOINER}"), "\N{WORD JOINER}   ", 'zero-width char' );

Text::VPrintf::configure(emptyzero => 1);

is( Text::VPrintf::sprintf( '%4s',  "\N{WORD JOINER}"), "    ", 'zero-width char w/emptyzero' );
is( Text::VPrintf::sprintf( '%-4s', "\N{WORD JOINER}"), "    ", 'zero-width char w/emptyzero' );

done_testing;
