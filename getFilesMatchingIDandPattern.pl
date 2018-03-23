#!/usr/bin/perl -w

use strict; 

## Originally written to pull, from a list of files, those matching a list of SAMPLE IDs and matching files with "summary-" in their names; essentially pulling full file paths of summary-[ASM-ID]-ASM.tsv (from ftp://ftp.1000genomes.ebi.ac.uk). 
## But script is actually quite generic. It can pull from a list of matching a list of IDs and a specific "keyword" or "pattern". 

## PATHLIST is from convert2fullpathList.pl
## IDlist is a single column list of (Coriell) sample ID 
## OUTFILE is the name of the file to output the results
if( @ARGV != 4 ) {
	die "Usage: $0 <PATHLIST> <IDlist> <pattern> <OUTFILE>\n";
}

my $pathlist = $ARGV[0];
my $ids = $ARGV[1];
my $pattern = $ARGV[2];
my $outfile = $ARGV[3]; 

# Slurp in list of sample IDs
open( IDLIST, $ids ) or die "Can't open $ids for reading: $!\n"; 
my @ids = <IDLIST>;
close IDLIST;
chomp @ids; 

# Slurp in the list of FTP files with pathnames
open( PATHLIST, $pathlist ) or die "Can't open $pathlist for reading: $!\n"; 
my @paths = <PATHLIST>;
close PATHLIST; 
chomp @paths; 

open (OUTFILE, ">$outfile" ) or die "Can't open $outfile for writing: $!\n"; 
foreach (@ids) {
	my $id = $_;
	my @tmpouts = grep(/$id/, @paths); 
	@tmpouts = grep(/$pattern/, @tmpouts);
	if( @tmpouts >0 ) { 
		foreach (@tmpouts) {
			print OUTFILE $_, "\n";
		}
	}
}
close OUTFILE; 

