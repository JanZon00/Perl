#! /usr/bin/perl
#JanZon PJS1

if ($#ARGV < 0) {
	die "provide at least one argument\n";
}

foreach my $filename (@ARGV) {
	
	my $line_number = 1;
	open my $file, '<', $filename or die "cannot open file\n";

	while (my $line = <$file>) {
		if ($line !~ /^\s*#/) {
			print "$line_number. $line";
			$line_number++;
		}
	}

	close $file;
}
