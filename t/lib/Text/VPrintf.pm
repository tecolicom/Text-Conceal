package Text::VPrintf;

use v5.14;
use warnings;
use Carp;

use Exporter 'import';
our @EXPORT_OK = qw(&vprintf &vsprintf);

use Data::Dumper;
use Text::Conceal;

sub vprintf  { &printf (@_) }
sub vsprintf { &sprintf(@_) }

my %default = (
    test      => qr/[\e\b\P{ASCII}]/,
    length    => \&vwidth,
    ordered   => 0,
    duplicate => 1,
);

sub configure {
    %default = (%default, @_);
}

sub sprintf {
    my($format, @args) = @_;
    my $conceal = Text::Conceal->new(
	%default,
	except    => $format,
	max       => int @args,
    );
    $conceal->encode(@args) if $conceal;
    my $s = CORE::sprintf $format, @args;
    $conceal->decode($s)    if $conceal;
    $s;
}

sub printf {
    my $fh = ref($_[0]) =~ /^(?:GLOB|IO::)/ ? shift : select;
    $fh->print(&sprintf(@_));
}

{
    no strict 'refs';
    *{"Is_Emoji_Modifier"} = sub { "1F3FB\t1F3FF\n" };
};

sub IsZeroWidth {
    return <<"END";
+utf8::Nonspacing_Mark
+utf8::Default_Ignorable_Code_Point
+Is_Emoji_Modifier
END
}

sub IsWideSpacing {
    return <<"END";
+utf8::East_Asian_Width=Wide
+utf8::East_Asian_Width=FullWidth
-IsZeroWidth
END
}

sub vwidth {
    local $_ = shift;
    my $w;
    while (m{\G  (?:
		 (?<zero> \p{IsZeroWidth} )
	     |   (?<two>  \p{IsWideSpacing} )
	     |   \X
	     )
	}xg) {
	$w += $+{zero} ? 0 : $+{two} ? 2 : 1;
    }
    $w;
}

1;

__END__
