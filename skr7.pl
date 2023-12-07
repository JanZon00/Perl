#! /usr/bin/perl
#JanZon PJS1

use List::Util qw(sum);

if (@ARGV < 1) {
	die "provide at least 1 file \n";
}

my $invalid_file = 0;

sub countIntegers{
	my $word = shift;
	return $word =~ /^-?\d+(\.\d+)?$/ ? 1 : 0;
}

sub calculateAverage {
	my @numbers = @_;
	return @numbers ? sum(@numbers) / @numbers : 0;
}

foreach my $i (0..$#ARGV) {
	$invalid_file = 0;
	my $filename = $ARGV[$i];
	open my $file, '<', $filename or $invalid_file = 1;
	my $hash = {};
	
	if($invalid_file){
		next;
	}else{
		while (my $line = <$file>) {			
			my @words = split /\s+/, $line;
			my $name = ucfirst lc @words[0]; 
			my $separator = " "; 
			my $surname = ucfirst lc @words[1];
			my $full_name = $name.$separator.$surname;
			my $ocena = @words[2];
			my $first_char = substr($ocena, 0, 1);
			my $last_char = substr($ocena, -1, 1);
			
			if (defined $words[3]){
				warn "Too many words in : $line";
				next;
			}
		
			if ($first_char eq '+'){
				$ocena = substr($ocena, 1);
				my $isNumber = countIntegers($ocena);
				if($isNumber eq 0){
					warn "Invalid grades in file $filename in line : $line";
					next;
				}
				$ocena += 0.25;

			}elsif($first_char eq '-'){
				$ocena = substr($ocena, 1);
				my $isNumber = countIntegers($ocena);
				if($isNumber eq 0){
					warn "Invalid grades in file $filename in line : $line";
					next;
				}
				$ocena -= 0.25;
			}elsif($last_char eq '+'){
				$ocena = substr($ocena, 0, length($ocena) -1);
				my $isNumber = countIntegers($ocena);
				if($isNumber eq 0){
					warn "Invalid grades in file $filename in line : $line";
					next;
				}
				$ocena += 0.25;
			}elsif($last_char eq '-'){
				$ocena = substr($ocena, 0, length($ocena) -1);
				my $isNumber = countIntegers($ocena);
				if($isNumber eq 0){
					warn "Invalid grades in file $filename in line : $line";
					next;
				}
				$ocena -= 0.25;
			}
			
			my $isNumber = countIntegers($ocena);
			if($isNumber eq 0){
				warn "Invalid grades in file $filename in line : $line";
				next;
			}
			push ( @{$hash{$full_name}}, $ocena );
		}
		print "File : $filename\n";
		while ( ($k,$v) = each %hash ) {
			my $average = calculateAverage(@$v);
			my $average = sprintf("%.2f", $average);
			print "$k : " . join(", ", @$v) . " Average: $average \n";
		}
			
		%hash = ();
		close $file;
		print "\n";
	}
}
