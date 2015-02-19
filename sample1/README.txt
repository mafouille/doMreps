paired-end reads from Illumina might be transformed to single-end reads if pair overlap each others.
We did it with pear [1]

pear -f paired-end/sampl1_S4_L001_R1_001.fastq -r paired-end/sampl1_S4_L001_R2_001.fastq -o sample1_S4._L001_peared_001


[1] PEAR: A fast and accurate Illumina Paired-End reAd mergeR. J. Zhang, K. Kobert, T. Flouri, and A. Stamatakis. Bioinformatics 2013 doi: 10.1093/bioinformatics/btt593


