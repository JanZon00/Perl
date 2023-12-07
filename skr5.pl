#! /usr/bin/perl
#JanZon PJS1

use FindBin qw($RealBin);
use lib $RealBin;
use lib "$RealBin/Counter";
use Counter;


if (@ARGV < 1) {
	die "provide at least 1 file \n";
}

my $total_lines = 0;
my $total_words = 0;
my $total_bytes = 0;
my $total_integers = 0;
my $total_numbers = 0;
my $invalid_file = 0;
my $exclude_lines = 0;
my $count_integers = 0;
my $count_numbers = 0;
my $file_counter = 0;

while (@ARGV && $ARGV[0] =~ /^-/) {
	my $option = shift @ARGV;
	if ($option eq "-i") {
		$count_integers = 1;
	}elsif ($option eq "-e") {
		$exclude_lines = 1;
	}elsif ($option eq "-d") {
		$count_numbers = 1;
	}else{
		die "Unknown option: $option\n";
	}
}

#sub countIntegers{
#	return (scalar(grep { $_ !~ /\D/ } split(/\s+/, $_)));
#}

#sub countNumbers {
#	return (scalar(grep { $_ =~ /^[-+]?(\d+(\.\d*)?|\.\d+)([eEdDqQ^][-+]?\d+)?$/ } split(/\s+/, $_)));
#}

sub countWords{
	return (scalar(split(/\s+/, $_)));
}

foreach my $i (0..$#ARGV) {
	$invalid_file = 0;
	my $filename = $ARGV[$i];
	open my $file, '<', $filename or $invalid_file = 1;
	
	if($invalid_file){
		next;
	}else{
		my $lines = 0;
		my $words = 0;
		my $bytes = 0;
		my $integers = 0;
		my $numbers = 0;

		while (<$file>) {

			if($exclude_lines && /^\s*#/) {
				next;
			}
			
			$lines++;
			$words += countWords();
			$bytes += length;
			
			if($count_integers) {
				$integers += Counter::countIntegers();
			}
			if($count_numbers) {
				$numbers += Counter::countNumbers();
			}
		
		}
		
		print "File : $filename\n";
		if ($count_integers == 1){
			print "Number of integers: $integers\n";
		}
		if($count_numbers == 1){
			print "Number of numbers: $numbers\n";
		}
		if($count_integers == 0 && $count_numbers == 0){
			print "Number of lines: $lines\n";
			print "Number of words: $words\n";
			print "Number of bytes: $bytes\n";
		}
		
		print "\n";

		$total_lines += $lines;
		$total_words += $words;
		$total_bytes += $bytes;
		$total_integers += $integers;
		$total_numbers += $numbers;
		close $file;
		$file_counter += 1;
	}
}

if($file_counter > 1){

	print "SUM : \n";

	if($count_integers == 1){
		print "Total number of integers: $total_integers\n";
	}
	if($count_numbers == 1){
		print "Total number of numbers: $total_numbers\n";
	}
	if($count_integers == 0 && $count_numbers == 0){
		print "Total number of lines: $total_lines\n";
		print "Total number of words: $total_words\n";
		print "Total number of bytes: $total_bytes\n";
	}
}
