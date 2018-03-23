#!/usr/bin/perl -w

use strict; 

## Pull out specified information (e.g. isolate, haplogroup, pop_variant, country, note) for each accession (LOCUS) from a multi-genbank file. Writes to STDOUT, a table with 1+N columns, where N is the number of specified features. 

if( @ARGV < 1 ) {
	die "Usage: $0 <infile.gb> <space-separated list of features to extract>\n";
}

my ($infile, @features) = @ARGV;

# Dont' attempt to print header as order of features encountered may be different to supplied. 
# $,="\t";
# print "Locus", "\t", @features, "\n";

open( INFILE, $infile ) or die "Can't open $infile for reading: $!\n"; 
LINE: while(<INFILE>) {
	my $line = $_;
	#chomp $line; 
	if( $line =~ /^LOCUS\s+([\w]+)\s+.+$/ ) { print $1; next; }	#accession
	for ( my $i=0; $i<=$#features; $i++ ) {
		if( $line =~ /\/$features[$i]=\"(.+)\"/ ) { 
			print "\t", $1;
			if( $i==$#features ) { print "\n"; }
			next LINE;
		}
	}
}
close INFILE;
