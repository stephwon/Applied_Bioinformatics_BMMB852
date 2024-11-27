# NCBI Genome accession number (Organism: Mycobacterium tuberculosis)
ACC=GCF_000675775.1

# Reference genome 
REF=refs/tuberculosis.fa

# GFF file
GFF=refs/tuberculosis.gff

# GTF file
GTF=refs/tuberculosis.gtf

# SRI number
SRR=SRR1169147

# The name of the sample
SAMPLE=tuberculosis

# Read number
N=100000

# Reads
R1=reads/${SRR}_1.fastq
R2=reads/${SRR}_2.fastq

# BAM and VCF files
BAM=bam/${SAMPLE}.bam
VCF=vcf/${SAMPLE}.vcf.gz

# Setting useful defaults
SHELL = bash
.ONESHELL:
.SHELLFLAGS = -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

# Usage message
usage:
	@echo "# Usage: make [all|refs|fastq|index|align|stats|bam|vcf|clean]"
	@echo "# SNP call demonstration"

# Check that the bio toolbox is installed.
CHECK_FILE = src/run/genbank.mk
${CHECK_FILE}:
	@echo "#"
	@echo "# Please install toolbox with: bio code"
	@echo "#"
	@exit 1

# Obtain the reference genome
refs:
	mkdir -p $(dir ${REF})
	datasets download genome accession ${ACC}
	unzip -n ncbi_dataset.zip -x README.md md5sum.txt 
	cp -f ncbi_dataset/data/${ACC}/${ACC}*_genomic.fna ${REF}
	rm -rf ncbi_dataset.zip ncbi_dataset

# Download a subset of reads from SRA
fastq: 
	mkdir -p $(dir ${R1})
	fastq-dump -X ${N} --outdir reads --split-files ${SRR}

# Index the reference genome
index: refs
	bwa index ${REF}

# Align the reads and convert to BAM, using 4 threads
align: index fastq
	mkdir -p $(dir ${BAM})
	bwa mem -t 4 ${REF} ${R1} ${R2} | samtools sort -o ${BAM}
	samtools index ${BAM}

# Generate alignment statistics
stats: stats
	samtools flagstat ${BAM}

# Create the BAM alignment file (final step)
bam: 
	# Get the reference genome and the annotations
	make -f src/run/datasets.mk ACC=${ACC} REF=${REF} GFF=${GFF} GTF=${GTF} run

	# Index the reference genome
	make -f src/run/bwa.mk REF=${REF} index

	# Download the sequence data
	make -f src/run/sra.mk SRR=${SRR} R1=${R1} R2=${R2} N=${N} run

	# Align the reads to the reference genome
	make -f src/run/bwa.mk REF=${REF} R1=${R1} R2=${R2} BAM=${BAM} run stats

# Call the SNPs in the resulting BAM file (final step)
vcf: bam
	mkdir -p vcf
	make -f src/run/bcftools.mk REF=${REF} BAM=${BAM} VCF=${VCF} run

# Run all steps in the correct sequence, ending with bam and vcf
all: refs fastq index align stats bam vcf
	@echo "Running pipeline for SRR=${SRR}, SAMPLE=${SAMPLE}"

# Clean up generated files
clean:
	rm -rf bam reads refs vcf ncbi_dataset
	rm -rf ${REF} ${GFF} ${R1} ${R2} ${BAM} ${VCF} ${BAM}.bai

# PHONY targets
.PHONY: usage refs fastq index align stats bam vcf all clean
