***************************************************************
*                 This is doMreps verion 0.2                  *
*                                                             *
* released under GNU General Public Licence (see LICENCE.md)  *
*                                                             *
*                                                             *
*      This program is a wrapper to the mreps program         *
*                (http://mreps.univ-mlv.fr/)                  *
*                                                             *
***************************************************************

 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
 * WARNING: doMreps use a slightly modified version of mreps. 
 * The original version should be downloaded from 
 *  http://mreps.univ-mlv.fr/.
 * the aim of the modification is to have a lesser verbose output to 
 * accelerate the processing (or a more specific output)
 * 
 * mreps is released by the author under the GNU GPL licence 
 *  (see LICENCE.md)

 * This programm runs under linux 64 bits 
 *  and requires perl to be installed

Usage:
	perl doMreps.pl <list of fastq file>
count occurrences of internal tandem duplication

Examples:
perl doMreps sample1/*.fastq


doMreps$ ./doMreps-0.2.pl sample1/*.fastq
opening file sample1/sample1_S4._L001_peared_001.fastq
 ADD : FRFFRFRFFRFFRFRFRRFFRRRFFRFFRFFFFRFFFFRFFFFFFFRFRFFFFFRFRRRFRRRFRFRRFFRRRFRFRFRFFFRFFRFFRRFFRRFRFFRFFRRFFRRFRFRRRRFRFFRFFFFRFRFRFFFFFFRFRFFRFFFRRFFFFFRFFFRFRFFFFFFFFRFFRRRRRRFFFRFRFFRRRRRRFFFRFRFRRRFFRRRFRRFRFFRRFRFFFRRFFRFRFRFFRRFFRRRRRRFRRFRRRRRFRRFFFFRFFFRRFRFRRRRRRRRRFRRFFFFFRRFRFRRFFRFRRRRFFRRRRFFRRRFFRRRRFFRRRRFFFFRRFFFFFRFFRFRRRFFFFFFRRFRRFFFFFFRFRRFFFRFFRFRFFFRRFFFFFFFRFFFFRFFFFFFRFFFFRFRRFFRFRRFRRRFRRRRRFRFFRFFFRFRRFFRRRFFFFRFRFFRFRRFFFRFRRFRFFFFRRFFFFRFRRFRRFRFFRRRRRRFRFRFFRRRRFRRRRFRFFFRFRFRFFFRFRFRFFFRRFRFFFFRRFRRFRRFRRFFRFR

ITD  SEED ITD	SEED WT+ITD	MREPS	sample1/sample1_S4._L001_peared_001.fastq ITD	sample1/sample1_S4._L001_peared_001.fastq WT+ITD
     	  	#reads		517974	517974
AGATAATGAGTACTTCTACGTTGA	TTCTACGTTGAAGATAATGAG	ATAATGAGTACTTCTACGTTGA	6899	0	185181
AGCCAATGAGTACTTCTACGTTGA	TTCTACGTTGAAGCCAATGAG	CCAATGAGTACTTCTACGTTGA	6245	41379	39335
CCCCTCCCATCCCTGAGGCTTCCCCAGCAGGTGGGACACAGCACACAGGC	AGCACACAGGCCCCCTCCCAT	AGGTGGGACACAGCACACAGGC	114	1021	2723
CACAGCACACAGGACCCCTCCCATCCCTGAGGCTTTCCCAGCAGGTGGGA	AGCAGGTGGGACACAGCACAC	GAGGCTTTCCCAGCAGGTGGGA	61	2832	1238
AAGCCTGTGTGCTGTGTCCCACCTGCTGGGGAAGCCTCAGGGATGGGAGGGG	GATGGGAGGGGAAGCCTGTGT	GAAGCCTCAGGGATGGGAGGGG	35	414	1310
GGGGAAGCCTGTGTGCTGTGTCCCACCTGCTGGGGAAGCCTCGGGGATGGGA	CGGGGATGGGAGGGGAAGCCT	TGGGGAAGCCTCGGGGATGGGA	28	384	451


Output description: Each time mreps find a new Internal Tandem Duplication (ITD), it display an 'F' (for forward read) or an 'R' (for Reverse read). 
Then it display a tabular view of ITDs. 
  First line is the column header. 
  Second line is the total number of reads. 
  Then we have for each ITD sequence, 
    the seed used for counting ITD reads, 
    the seed used for counting WT and ITD reads, 
    the number of ITD found by mreps for all samples
    then for each fastq file: 
      the number of reads with the ITD seed, 
      the number of reads with the WT or ITD seed.
