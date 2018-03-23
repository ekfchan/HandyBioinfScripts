#!/usr/bin/perl -w

#
# Eva KF Chan, 23 June 2014
# Script to pull from a multiple fasta file only those matching given list of names. 
# Modified:  30 June 2014
#	Note that there are two uses: 
#	(1) Pulling genomes from GenBank's complete mitochondrial genomes, in which case, we'd match the identifier in the header line provided by GenBank
#	(2) Pulling genomes matching the list of names.txt EXACTLY
#

# Usage:  getMultiFastaSubset.pl multi.fa names.txt 

use strict;
use List::MoreUtils 'any';

if( scalar(@ARGV) != 2 ) { die( "Usage:  ./getMultiFastaSubset.pl multi.fa names.txt\n" ) }
my $multifa = $ARGV[0];

open( NAMES, $ARGV[1] ) or die "Cannot open $ARGV[1]: $!\n"; 
my @names = <NAMES>; 
close NAMES;
chomp @names;
# print @names; 

open( IN, $multifa ) or die "Cannot open $multifa: $!\n"; 

my $printit = 0; 
while(<IN>) {
	my $line = $_;
	chomp $line; 
	if( $line =~ /^>/ ) {
		my $id = $line;
		chomp $id;
		# $id =~ s/>//;
		$printit = any { $id =~ /(\b|\W)$_(\b|\W)/i } @names;
	}
	if( $printit ) { print $line, "\n"; }
}

close IN; 
