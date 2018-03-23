#!/usr/bin/perl -w
use strict; 

## Script to process results from getFTPlist.sh.
## It essentially converts all ls listings into a single list of pathnames.  
## 


if( @ARGV != 2 ) {
	die "Usage: $0 <INFILE> <OUTFILE>\n";
}

my $infile = $ARGV[0];
my $outfile = $ARGV[1]; 

open( INFILE, $infile ) or die "Can't open $infile for reading: $!\n"; 
open (OUTFILE, ">$outfile" ) or die "Can't open $outfile for writing: $!\n"; 

my $path = "";
while( <INFILE> ) { 
	my $line = $_; 
	chomp $line; 
	if( $line =~ /^(.*):$/ ) { 
		$path = $1;
		# print OUTFILE $path, "\n"; 
	} else {
		$line =~ s/\S+\s+//g;
		print OUTFILE "$path/$line\n"; 
	}
}

close INFILE; 
close OUTFILE; 
