### BMMB 852 Week 5 Assignment: FASTQ file ###
#!/bin/bash

# Set the error handling and trace
set -uex

# Define working directories
CONDA_DIR=~/micromamba/etc/profile.d/micromamba.sh
BIOINFO_PATH=/Users/sj_won/micromamba/envs/bioinfo

WORK_DIR=~/Desktop/BMMB-852_Applied-Bioinformatics/Wk5
FASTQ_DIR=${WORK_DIR}/fastq_report

GENOME_ID=GCF_000307795.1 # H.pylori Genome Acession ID
FNA=GCF_000307795.1_ASM30779v1_genomic.fna
GENOME_PATH="ncbi_dataset/data/${GENOME_ID}/${FNA}"

# ------ ALL THE ACTIONS FOLLOW ------

# Activate conda environment and create directories
source "${CONDA_DIR}" 
micromamba activate bioinfo

# Create directories or locate the FASTQ directory
mkdir -p "${FASTQ_DIR}" && cd "${FASTQ_DIR}"

# Extract FASTQ files 
datasets download genome accession ${GENOME_ID}

# Decompress the file
unzip ncbi_dataset.zip

# Get basic statistics of the genome
seqkit stats "${GENOME_PATH}"
echo

# Get file size
echo "The size of the file:"
ls -lh $GENOME_PATH | awk '{print $5}'
echo

# Use seqkit to get statistics about the genome and store it in a variable
stats=$(seqkit stats $GENOME_PATH)

# Extract relevant information from the seqkit stats report
genome_info=$(echo "$stats" | awk 'NR==2')

# Extract total size of the genome (sum_len), number of chromosomes (num_seqs), and max length
total_size=$(echo "$genome_info" | awk '{print $5}')  # sum_len
num_chromosomes=$(echo "$genome_info" | awk '{print $4}')  # num_seqs
chromosome_id=$(grep ">" $GENOME_PATH | sed 's/>//g')  # Extract the chromosome ID from the FASTA header
chromosome_length=$(echo "$genome_info" | awk '{print $5}')  # sum_len again because it's a single chromosome

# Print the results
echo "Total size of the genome (in base pairs): $total_size"
echo "Number of chromosomes in the genome: $num_chromosomes"
echo
echo "Chromosome ID: $chromosome_id"
echo "Chromosome Length: $chromosome_length bp"




