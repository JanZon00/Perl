#! /usr/bin/perl
#JanZon PJS1

if ($#ARGV < 0) {
	die "provide at least one argument\n";
}

my $show_line_numbers;
my $skip_comment_lines;
my $numerate_skip_comment_lines;
my $numerate_separate_files;
my $iterator = 0;

foreach my $arg (@ARGV) {
	if ($arg eq "-c") {
		$show_line_numbers = 1;
	}elsif ($arg eq "-N") {
		$skip_comment_lines = 1
	}elsif ($arg eq "-n") {
		$numerate_skip_comment_lines = 1
	}elsif ($arg eq "-p") {
		$numerate_separate_files = 1
	}else{
		last;
	}
	$iterator++;
}

my $line_number = 1;
my $current_file = "";

foreach my $i ($iterator..$#ARGV) {

	my $filename = $ARGV[$i];

	if ($numerate_separate_files) {
		$line_number = 1;
	}

	open my $file, '<', $filename or die "cannot open file\n";

	while (my $line = <$file>) {
		if (($numerate_skip_comment_lines || $skip_comment_lines) && $line =~ /^\s*#/) {
			next;
		}
		
		if ($show_line_numbers || $numerate_skip_comment_lines || $numerate_separate_files) {
			print "$line_number. $line";
			$line_number++;
		}else {
			print $line;
		}
	}
	close $file;
}
