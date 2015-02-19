#!/usr/bin/perl

###
### doMreps.pl version 0.2.0
###
### arguments : fastq files to analyze together (fastq file from same patient)
### example : perl doMreps2.pl ./sample1/fastq/*.fastq
###
### doMreps is looking for duplication in fastq reads
###
### author : jebibault@gmail.com, martin.figeac@univ-lille2.fr

### doMreps is a script invoking the GPL mreps program [1] (http://mreps.univ-mlv.fr/index.html)
### do accelerate the running time, mreps has been modified to be less verbose
### ** all the intelligence is in mreps. The scipt is just an automatic way to call mreps. **
### [1] R. Kolpakov, G. Bana, and G. Kucherov, mreps: efficient and flexible detection 
###  of tandem repeats in DNA, Nucleic Acid Research, 31 (13), July 1 2003, pp 3672-3678.
### This is still a work in progress !
### use at you own risk

### This program is released under the GNU Genreal Public Licence:
### This program is free software: you can redistribute it and/or modify
### it under the terms of the GNU General Public License as published by
### the Free Software Foundation, either version 3 of the License, or
### (at your option) any later version.
### 
### This program is distributed in the hope that it will be useful,
### but WITHOUT ANY WARRANTY; without even the implied warranty of
### MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
### GNU General Public License for more details.
### 
### You should have received a copy of the GNU General Public License
### along with this program.  If not, see <http://www.gnu.org/licenses/>.


## MIN_READ_LENGTH to be processed
## small reads doesn't have full ITD and are spurious
## WARNING: 200 for PGM 400bp ; 130 for illumina 2x150bp
my $MIN_READ_LENGTH=130

## MREPS_BIN is the path to the mreps binary
## mreps has been very slighlty modified in order to have a less verbose output 
## and and easier output to parse.
my $MREPS_BIN="./mreps"

## mreps_period is the minimal size of duplicated fragment in bp
## Smaller size give more "false positives" (germline duplicated DNA or random effect)
## WARNING: default is 20
my $mreps_period=20

## display the first '10 x number_of_fastq_file' repeats (ITD)
## WARNING: low count ITD will not be displayed if below this threshold
my $max = @ARGV*10;


use strict;
use warnings;

use Scalar::Util qw(looks_like_number);

my %repeats;
my %count;

################################################
## first part : execute mreps on each fastq read
##  store mreps repeats (if exists) in hash
foreach my $file (@ARGV) {

    print "opening file $file\n";
    open (INFILE, $file) or die ("Error opening fastq file: $file");

    my $line;
    my $seq;
    my $output;

    print " ADD : ";
    $count{$file} = 0;

    while ($line=<INFILE>) {
	$seq=<INFILE>; ## sequence in fastq format
	chomp($seq);
	$line=<INFILE>; ## skip "+" separator in fastq format
	$line=<INFILE>; ## skip quality values in fastq format
	$count{$file}++;

	## analysis is only done on long read. 
	if (length($seq) > $MIN_READ_LENGTH) {   

	    ## run MREPS
	    my $output=`$MREPS_BIN -minperiod $mreps_period -res 2 -s $seq`; 
	    if (length ($output) > 0) {
		#print $output;
		my @res;
		chomp ($output);
		## transform string output to tabular array
		@res = split (/\s+/, $output);  
		my $nb=$res[7];
		## check exposant (length/periods) : "number of repeats"
		if (! looks_like_number ($nb)) {
		    print "\n--> ".$output."\n"."-->".$res[4]."--".$res[5]."\n";
		}
		if ($nb >= 1.5 && $nb <= 2.5) {   ## WARNING : we only want duplication (2 copies)
		    ## store repeated word ITD in hashtable
		    ## test if forwar or reverse already exist. 
		    ## if yes, set +1 to counter
		    ## if not, add new repeat (ITD) but choose the first 
		    ##  from Forward and Reverse in lexicographic order
		    my $k=9;  # first repeat in mreps output is at id=9
		    while ($k > 0 && $k < 11) {
			if (exists $repeats{$res[$k]}) {
			    $repeats{$res[$k]}+=1;
			    $k=-5;
			} else {
			    my $rev = reverse($res[$k]);
			    $rev =~ tr/ACGTacgt/TGCAtgca/;
			    if (exists $repeats{$rev}) {
				$repeats{$rev}+=1;
				$k=-5;
			    }
			}
			$k++;
		    }
		    if ($k > 0) { ## word not already in hash, add it !
			my $rev = reverse($res[9]); 
                        ## WARNING : always insert in hash first in lexicographic order
			$rev =~ tr/ACGTacgt/TGCAtgca/;
			if ($rev gt $res[9]) {
			    $repeats{$res[9]}+=1;
			    print "F";
			} else {
			    $repeats{$rev}+=1;
			    print "R";
			}
		    }
		}
	    }
	}
	
    }
    
    close (INFILE);
    print "\n";
}


#############################################
## Second Part : display array of occurrences

## sort Hash on occurrences
my @tri = sort { $repeats{$a} <=> $repeats{$b} } keys(%repeats);


my %seeds;  ## will need a seed associated to each ITD (breakpoint sequence)

## print column header
print "\n";
print "ITD\tSEED ITD\tSEED WT+ITD\tMREPS";
foreach my $file (@ARGV) {
    print "\t$file ITD\t$file WT+ITD";
}

## print number of reads for each file
print"\n";
print "\t\t\t#reads";
foreach my $file (@ARGV) {
    my $nb=`wc -l $file`;
    print "\t$count{$file}\t$count{$file}";
}
print"\n";

## create a seed for each repeats (breakpoint sequence)
##  count occurrences of each seed in each fastq
##  display result
for (my $k=(@tri-1); $k >= 0 && $k >=(@tri-1-$max); $k--) {  ## $max repeats to display

    my $seq=$tri[$k];

    print "$seq";
    ## determine seed for "greping" (Last 10 character and First 10)
    my $seed = substr $seq, -11;
    $seed .= substr $seq, 0, 10;    ## repeats (ITD) seed
    my $seedWT = substr $seq, -22;  ## WT seed
    ## sensibility and specificity is linked to seed size.
    ## WARNING: change at your own risk !!!
    #  seed de 2x7
    #    my $seed = substr $seq, -8;
    #    $seed .= substr $seq, 0, 7;
    print "\t$seed\t$seedWT";
   	print "\t".$repeats{$seq};

    foreach my $file (@ARGV) {
		my $nb=`grep -c $seed $file`;
		my $revseed = reverse($seed);
		$revseed =~ tr/ACGTacgt/TGCAtgca/;
		$nb+=`grep -c $revseed $file`;
		print "\t$nb";
		
		## "WT"
		$nb=`grep -c $seedWT $file`;
		$revseed = reverse($seedWT);
		$revseed =~ tr/ACGTacgt/TGCAtgca/;
		$nb+=`grep -c $revseed $file`;
		print "\t$nb";
    }
    foreach my $file (@ARGV) {
		my $nb=`grep -c $seed $file`;
		my $revseed = reverse($seed);
		$revseed =~ tr/ACGTacgt/TGCAtgca/;
		$nb+=`grep -c $revseed $file`;
		$nb/=$count{$file};
		print "\t$nb";
   }
    print "\n";

}
