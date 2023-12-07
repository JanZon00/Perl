#! /usr/bin/perl
#JanZon PJS1

if (@ARGV < 3) {
	die "provide at least 3 argument (eg: 1 8 file.txt)\n";
}

my $iterator = 1;
my $delimiter = $ARGV[0];
my $num1 = $ARGV[1];
my $num2 = $ARGV[2];
my $invalid_file = 0;

if ($num1 > $num2) { 
	$num1 = $ARGV[$1];
	$num2 = $ARGV[$0];
}	

foreach my $i (3..$#ARGV) {
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
				if($iterator >= $num1 - 1 && $iterator <= $num2 - 1){
					$word =~ s/^\s+|\s+$//g;
					$word =~ s/$delimiter/ /;
					print "$word ";
				}
				$iterator+=1;
			}
			if($iterator < $num2 - 1){
				print "\n";
			}
		}
		print "\n";
		close $file;
	}
}
