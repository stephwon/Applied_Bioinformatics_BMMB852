# Week 8: Generate BAM alignment files

The following variables are used for BAM alignment:
```
GENOME=Helicobacteria.fa

# Set reference genome
REF=refs/${GENOME}

# Set SAM file name
SAM=align.sam

# Set BAM file name
BAM=align.bam
```
Added more commands to `usage` to execute alignment and indexing:

```
@echo "make index     # Index the reference genome"
@echo "make align     # Align the reads to the reference genome"
```

The command for indexing reference genome:
```
# Index the reference genome
index:
	bwa index ${GENOME}
```

The following command is to execute alignment of sequence reads to the reference genome:
```
#Align the reads to the reference genome
align:
	mkdir -p bam
	bwa mem ${GENOME} ${t1} > bam/${SAM}
	cat bam/${SAM} | samtools sort > bam/${BAM}
	samtools index bam/${BAM}
```
When we put it all together into IGV, the result looks like this:
![IGV](https://github.com/stephwon/Applied_Bioinformatics_BMMB852/blob/main/Wk8/image/IGV_bam_align_result.png)


The reson for terrible alingment is because the SRA is horrific file from the start. 

Note: This file earned the `Who can find the worst data` from previous (Week 6 assignment) challenge.

Even with QC and trimming, the file reads were unsalvageable.

To obtain statistics of the alignment use the following command:
```samtools flagstats bam/align.bam```

Output:
```
0 + 0 in total (QC-passed reads + QC-failed reads)
0 + 0 primary
0 + 0 secondary
0 + 0 supplementary
0 + 0 duplicates
0 + 0 primary duplicates
0 + 0 mapped (N/A : N/A)
0 + 0 primary mapped (N/A : N/A)
0 + 0 paired in sequencing
0 + 0 read1
0 + 0 read2
0 + 0 properly paired (N/A : N/A)
0 + 0 with itself and mate mapped
0 + 0 singletons (N/A : N/A)
0 + 0 with mate mapped to a different chr
0 + 0 with mate mapped to a different chr (mapQ>=5)
```
Since the data itself is in the worst state, there is not a result to be produced, hence why it came out all ZERO reads, alignments, etc.
