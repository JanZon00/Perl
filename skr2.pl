#! /usr/bin/perl
#JanZon PJS1

if (@ARGV < 3) {
	die "provide at least 3 argument (eg: 1 8 file.txt)\n";
}

my $iterator = 1;
my $num1 = $ARGV[0];
my $num2 = $ARGV[1];	
my $word1 = "";
my $word2 = "";
my $invalid_file = 0;

foreach my $i (2..$#ARGV) {
	$iterator = 0;
	$invalid_file = 0;
	my $filename = $ARGV[$i];
	open my $file, '<', $filename or $invalid_file = 1;

	if($invalid_file){
		print "cannot open file $filename\n";
	}else{
		while (my $line = <$file>) {
			my @words = split /\s+/, $line;
		
			foreach my $word (@words){
				if($iterator == $num1 - 1){
					$word1 = $word;
				}
				if($iterator == $num2 - 1){
					$word2 = $word;
				}
				$iterator+=1;
			}
		}
		print "$word1 $word2\n";
		close $file;
	}
}
