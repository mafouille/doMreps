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
