## Week 9: Filter BAM file

The goal is to use the BAM file created from previous assignment via Makefile and extract statistical and other relevant information.

Since Istvan requested I use a different SRA and genome after winning `"Find the worst data"` championship from previous assigntmets. 

For the sake of assignment I chose Tuberculosis. I have modified the `Makefile` accordingly and the script is in the repository as `Makefile.mk`. 

To execut the makefile I used the following command 
```
make -f Makefile.mk all
```
`samtools flagstat` Output:
```
samtools flagstat bam/tuberculosis.bam
20072 + 0 in total (QC-passed reads + QC-failed reads)
20000 + 0 primary
0 + 0 secondary
72 + 0 supplementary
0 + 0 duplicates
0 + 0 primary duplicates
20038 + 0 mapped (99.83% : N/A)
19966 + 0 primary mapped (99.83% : N/A)
20000 + 0 paired in sequencing
10000 + 0 read1
10000 + 0 read2
19664 + 0 properly paired (98.32% : N/A)
19932 + 0 with itself and mate mapped
34 + 0 singletons (0.17% : N/A)
90 + 0 with mate mapped to a different chr
89 + 0 with mate mapped to a different chr (mapQ>=5)
```

#### Question 1: How many reads did not align with the reference genome?
Given that the `total reads` was `20,072` and the `mapped reads` was `20,038` the number of reads that did not align is:
$$
20072 - 20038 = 34
$$
Thus, **34 reads did not align** to the reference genome.

#### Question 2: How many primary, secondary, and supplementary alignments are in the BAM file?

Based on the `samtools flagstat` output:
* Primary: 20,000 alignments as indicated by `20000 + 0 primary`
* Secondary: 0 alignments, shown as `0 + 0 secondary`
* Supplementary: 72 supplementary alignments, given as `72 + 0 supplementary`

#### Question 3: How many properly-paired alignments on the reverse strand are formed by reads contained in the first pair?
To obtain paired alignmetns on the reverse strand, I used the following command 
```
samtools view -f 0x2 -f 0x40 -F 0x10 bam/tuberculosis.bam | wc -l
```
The prameters (flags) used in the command are:

* `-f 0x2` filters for properly paired reads
* `-f 0x40` filters for reads in the first pair (Read 1).
* `-f 0x10` excludes reads on the forward strand so it will only give reverse strand.

Hence the Output:
```
4909
```

#### Question 4: Make a new BAM file that contains only the properly paired primary alignments with a mapping quality of over 10.

To create new BAM file with paired primary alingments with quality > 10, I ran the following command:
```
samtools view -h -b -q 10 -f 0x2 -F 0x100 bam/tuberculosis.bam > bam/tuberculosis_filtered.bam
```
The parameters used in the command are:
* `-h`: Includes the header in the output BAM file.
* `-b`: Specifies BAM output format.
* `-q 10`: Filters alignments with a mapping quality greater than 10.
* `-f 0x2`: Filters for properly paired reads.
* `-F 0x100`: Excludes secondary alignments (retaining only primary alignments).

The paired primary alignments with mapping quality >10 BAM file is stored in `/bam` and file name is `tuberculosis_filtered.bam`

#### Question 5: Compare the flagstats between orginal and filtered BAM file.
I used the following commands to generate the flagstats for original and filtered BAM file:
```
# Flagstat report for original BAM file
samtools flagstat bam/tuberculosis.bam > original_bam_flagstat.txt

# Flagstat report for filtered BAM file 
samtools flagstat bam/tuberculosis_filtered.bam > filtered_bam_flagstat.txt
```
The `filtered_bam_flagstat.txt` report:
```
19701 + 0 in total (QC-passed reads + QC-failed reads)
19659 + 0 primary
0 + 0 secondary
42 + 0 supplementary
0 + 0 duplicates
0 + 0 primary duplicates
19701 + 0 mapped (100.00% : N/A)
19659 + 0 primary mapped (100.00% : N/A)
19659 + 0 paired in sequencing
9829 + 0 read1
9830 + 0 read2
19659 + 0 properly paired (100.00% : N/A)
19659 + 0 with itself and mate mapped
0 + 0 singletons (0.00% : N/A)
0 + 0 with mate mapped to a different chr
0 + 0 with mate mapped to a different chr (mapQ>=5)
```
The `original_bam_flagstat.txt` report:
```
20072 + 0 in total (QC-passed reads + QC-failed reads)
20000 + 0 primary
0 + 0 secondary
72 + 0 supplementary
0 + 0 duplicates
0 + 0 primary duplicates
20038 + 0 mapped (99.83% : N/A)
19966 + 0 primary mapped (99.83% : N/A)
20000 + 0 paired in sequencing
10000 + 0 read1
10000 + 0 read2
19664 + 0 properly paired (98.32% : N/A)
19932 + 0 with itself and mate mapped
34 + 0 singletons (0.17% : N/A)
90 + 0 with mate mapped to a different chr
89 + 0 with mate mapped to a different chr (mapQ>=5)
```

### Comparison summary:
* `Total reads`: Filtered BAM has fewere reads (19,701) due to filtering for quality > 10.
* `Mapping quality`: The filtered file ahcieved 100% mapping rate whereas original was at 99.83%
* `Properly paired reads`: The filtered BAM has 100% properly paired reads, compared to 98.32% in the original.
* `Supplementary Alignments`: Reduced from 72 in the original to 42 in the filtered BAM
* `Singletons and Cross-Chromosome Mappings`: Filtered BAM has no singletons or cross-chromosome mate mappings, indicating strict filtering. The original BAM has mate mapping of 90.

The flagstat reports for filtered and original is in the repository. 
