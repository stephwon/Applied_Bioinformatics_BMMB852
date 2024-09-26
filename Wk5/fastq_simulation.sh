### BMMB 852 Week 5 Assignment: FASTQ Simulation
#!/bin/bash

# Set the error handling and trace
set -uex

CONDA_DIR=~/micromamba/etc/profile.d/micromamba.sh
BIOINFO_PATH=/Users/sj_won/micromamba/envs/bioinfo

GENE_DIR=~/Desktop/BMMB-852_Applied-Bioinformatics/Wk5/FASTQ_Sim

GENOME_ID=GCF_000307795.1 # H.pylori Genome Acession ID
FNA=GCF_000307795.1_ASM30779v1_genomic.fna
GENOME_PATH="ncbi_dataset/data/${GENOME_ID}/${FNA}"
GENOME=Helicobacteria.fa

# --- Simulation actions below ---

# Activate conda environment and create directories
source "${CONDA_DIR}"
micromamba activate "${BIOINFO_PATH}"

mkdir -p "${GENE_DIR}" && cd "${GENE_DIR}"

# Download FASTA file
datasets download genome accession ${GENOME_ID}

# Decompress the file
unzip ncbi_dataset.zip

# Change the file name to simpler name
ln -sf "${GENOME_PATH}" "${GENOME}"

# Number of reads to achieve 10x coverage
N=80000

# Length of the read
L=100

# The files to write the reads to
R1=reads/wgsim_read1.fq
R2=reads/wgsim_read2.fq

# Make directory to hold the reads
mkdir -p "$(dirname ${R1})"

# Simulate with no errors and no mutations
wgsim -N ${N} -1 ${L} -2 ${L} -r 0 -R 0 -X 0 \
      ${GENOME} ${R1} ${R2}

# Run read statistics
seqkit stats ${R1} ${R2}

# Print the size of the FASTQ files before compression
echo "Size of FASTQ files before compression:"
ls -lh "${R1}" "${R2}"

###
# Capture the original size before compression
ORIGINAL_SIZE=$(du -k "${R1}" "${R2}" | awk '{sum += $1} END {print sum}')

# Compress the FASTQ files
gzip "${R1}" "${R2}"

# Print the size of the FASTQ files after compression
echo "Size of FASTQ files after compression:"
ls -lh "${R1}.gz" "${R2}.gz"

# Capture the compressed size
COMPRESSED_SIZE=$(du -k "${R1}.gz" "${R2}.gz" | awk '{sum += $1} END {print sum}')

# Calculate the space saved
SPACE_SAVED=$((ORIGINAL_SIZE - COMPRESSED_SIZE))

# Calculate the percentage of space saved
PERCENT_SAVED=$(echo "scale=2; ($SPACE_SAVED/$ORIGINAL_SIZE)*100" | bc)

# Print space saved and percentage
echo "Space saved after compression: ${SPACE_SAVED} KB"
echo "Percentage of space saved: ${PERCENT_SAVED}%"