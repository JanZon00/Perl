#! /usr/bin/perl
#JanZon PJS1

if ($#ARGV < 0) {
	die "provide at least one argument\n";
}

foreach my $filename (@ARGV) {
	open my $file, '<', $filename or die "cannot open file\n";

	while (my $line = <$file>) {
		print $line;
	}

	close $file;
}
