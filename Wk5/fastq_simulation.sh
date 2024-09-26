### BMMB 852 Week 5 Assignment: FASTQ Simulation
#!/bin/bash

# Set the error handling and trace
set -uex

CONDA_DIR=~/micromamba/etc/profile.d/micromamba.sh
BIOINFO_PATH=/Users/sj_won/micromamba/envs/bioinfo

GENE_DIR=~/Desktop/BMMB-852_Applied-Bioinformatics/Wk5/FASTQ_Sim

GENOME_ID=GCF_000307795.1 # H.pylori Genome Acession ID
FNA=GCF_000307795.1_ASM30779v1_genomic.fna
GENOME_PATH="fastq_report/ncbi_dataset/data/${GENOME_ID}/${FNA}"
GENOME=Helicobacteria.fa

# --- Using ART simulation actions below ---

# Activate conda environment and create directories
source "${CONDA_DIR}"
micromamba activate "${BIOINFO_PATH}"

# Change the file name to simpler name
ln -sf "${GENOME_PATH}" "${GENOME}"

# The location of the genome file
GENOME=Helicobacteria.fa

# Targt Coverage (x10)
C=10

# The genome size (85 base pairs)
G=85

# Length of the read
L=100

# Calculate the number of reads based on the target coverage
# Formula: DEPTH = (C * G) / L
DEPTH=$(echo "($C * $G) / $L" | bc)

# The prefix for the reads
PREFIX=reads/art_reads_

# Valid modes are: HS10, HS25, NS50 (see art_illumina -help)
MODEL=HS25

# --- Simulation actions below ---

# The read names are created automatically by art
R1=${PREFIX}1.fq
R2=${PREFIX}2.fq

# Make the reads directory
mkdir -p $(dirname ${PREFIX})

# Simulate reads with art
art_illumina -ss ${MODEL} -i ${GENOME} \
             -p -l ${L} -f ${DEPTH} -m 200 -s 10 -o ${PREFIX}

# Run read statistics
seqkit stats ${R1} ${R2}
echo

# Show the size of each FASTQ file and the total size (macOS version)
echo "Each FASTQ file size:"
stat -f "%z bytes" "${R1}" "${R2}"

# Calculate the total size
TOTAL_SIZE=$(stat -f "%z" "${R1}" "${R2}" | awk '{sum += $1} END {print sum}')
echo

# Display the total size
echo "Total FASTQ file size: ${TOTAL_SIZE} bytes"

# Capture the original size before compression
ORIGINAL_SIZE=$(du -k "${R1}" "${R2}" | awk '{sum += $1} END {print sum}')

# Compress the FASTQ files
gzip "${R1}" "${R2}"

# Capture the compressed size
COMPRESSED_SIZE=$(du -k "${R1}.gz" "${R2}.gz" | awk '{sum += $1} END {print sum}')

# Calculate the space saved
SPACE_SAVED=$((ORIGINAL_SIZE - COMPRESSED_SIZE))

# Calculate the percentage of space saved
PERCENT_SAVED=$(echo "scale=2; ($SPACE_SAVED/$ORIGINAL_SIZE)*100" | bc)

# Output only the required information
echo
echo "${SPACE_SAVED} KB space saved"
echo "${PERCENT_SAVED}% of space saved"