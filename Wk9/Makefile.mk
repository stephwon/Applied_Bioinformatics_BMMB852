
# NCBI Genome accession number (Organism: Mycobacterium tuberculosis)
ACC=GCF_000675775.1

# Reference genome
REF=refs/tuberculosis.fa

# SRR number
SRR=SRR1169147

# Reads
R1=reads/${SRR}_1.fastq

# Reads
R2=reads/${SRR}_2.fastq

# BAM file
BAM=bam/tuberculosis.bam

# How many reads to download
N=10000

# Setting useful defaults.
SHELL = bash
.ONESHELL:
.SHELLFLAGS = -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

usage:
	@echo "# Usage: make [all|refs|fastq|index|align|clean]"    

# Obtain the reference genome
refs:
	# Create the reference directory
	mkdir -p $(dir ${REF})

	# Use datasets to download the genome.
	datasets download genome accession ${ACC}

	# Unzip the genome, skip the README and md5sum files.
	unzip -n ncbi_dataset.zip -x README.md md5sum.txt 

	# Copy the genome to the reference file.
	cp -f ncbi_dataset/data/${ACC}*/${ACC}*_genomic.fna ${REF}
	rm -rf ncbi_dataset.zip ncbi_dataset

# Download a subset of reads from SRA
# Remove the -X flag to get all data.
fastq:
	# Create the reads directory
	mkdir -p $(dir ${R1})

	# Download the reads
	fastq-dump -X ${N} --outdir reads --split-files ${SRR}

# Index the reference genome
index:
	bwa index ${REF}

# Align the reads and convert to BAM. Use 4 threads
# Works for paired-end reads. Modify for single-end reads.
align:
	# Make the BAM directory
	mkdir -p $(dir ${BAM})

	# Align the reads
	bwa mem -t 4 ${REF} ${R1} ${R2} | samtools sort -o ${BAM}

	# Index the BAM file
	samtools index ${BAM}

# Generate alignment statistics
stats:
	samtools flagstat ${BAM}

# Clean up generated files
clean:
	rm -rf ${REF} ${R1} ${R2} ${BAM} ${BAM}.bai

# Create necessary directories
all: refs fastq index align stats

# Create necessary directories
.PHONY: all refs fastq index align clean stats
