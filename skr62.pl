#! /usr/bin/perl
#JanZon PJS1

if ($#ARGV < 0) {
	die "provide at least one argument\n";
}

my $line_number = 1;

foreach my $filename (@ARGV) {
	open my $file, '<', $filename or die "cannot open file\n";

	while (my $line = <$file>) {
		print "$line_number: $line";
		$line_number++;
	}

	close $file;
}
