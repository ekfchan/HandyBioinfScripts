#!/usr/bin/perl -w

#
# Eva KF Chan, 29 May 2014
# Script to pull sequences from a multiple fasta file where header matches PATTERN
#

# Usage:  pullSeqWithHeaderPattern multi.fa PATTERN 

use strict;

if( scalar(@ARGV) != 2 ) { die( "Usage:  ./pullSeqWithHeaderPattern.pl multi.fa PATTERN\n" ) }
my $multifa = $ARGV[0]; 
my $pattern = qr/$ARGV[1]/;

open( IN, $multifa ) or die "Cannot opern $multifa: $!\n"; 

my $copy = 0; 
while(<IN>) {
	my $line = $_;
	#chomp $line; 
	if( $line =~ /^>/ ) {	#found header line
		# if coverage is >=100, then indicate for copy, else signal no copy
		if( $line =~ /$pattern/ ) { $copy = 1; print $line; } else { $copy = 0; }
	} else {
		if( $copy ) { print $line; } 
	}
}
