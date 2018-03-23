#!/usr/bin/perl -w

### A Perl script to pull out the section "Inferred ancestry of individuals:" from a STRUCTURE _f output. 
### It takes as input a _f file. 
### It outputs a text file containing only the "Inferred ancestry of individuals:" section of the _f file. 

use strict; 
our $_;

if( @ARGV != 2 )
{ 
	print "Usage: pull_STRUCTURE_cluster_prop.pl StructureOutfile_f output.txt\n";
	exit;
}

my $infile = $ARGV[0];
# print "\tThis is your input: ",$infile,"\n";
my $outfile = $ARGV[1];
# print "\tThis is yout output: ",$outfile,"\n";

open (IN, "<$infile") or die "Can't open $infile: $!\n"; 
open (OUT, ">$outfile") or die "Can't open $outfile: $!\n"; 
my $done=0;
my $keep=0;
while( defined($_ = <IN>) && !$done ) 
{
	if( !$keep ) {
		if (/Inferred ancestry of individuals:/) { $keep=1; }
	} else {
		if (/Estimated Allele Frequencies in each cluster/) { $done=1; } else { print OUT $_; }
	}
}

close IN;
close OUT;

