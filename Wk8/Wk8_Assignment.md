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
align:
	mkdir -p bam
	bwa mem ${GENOME} ${t1} > bam/${SAM}
	cat bam/${SAM} | samtools sort > bam/${BAM}
	samtools index bam/${BAM}
```
When we put it all together into IGV, the result looks like this


The reson for terrible alingment is because the SRA is horrific file from the start.

Even with QC and trimming, the file reads were unsalvageable.

To obtain statistics of the alignment use the following command:
```
samtools flagstats bam/align.bam
```
