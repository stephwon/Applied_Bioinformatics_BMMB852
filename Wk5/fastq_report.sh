### BMMB 852 Week 5 Assignment: FASTQ file ###
#!/bin/bash

# Set the error handling and trace
set -uex

# Define working directories
CONDA_DIR=~/anaconda3/bin/activate
WORK_DIR=~/Desktop/BMMB-852_Applied-Bioinformatics/Wk5
FASTQ_DIR=${WORK_DIR}/fastq_report

# SRA ID for H. pylori
SRA_ID="SRR8278185"

# ------ ALL THE ACTIONS FOLLOW ------

# Activate conda environment and create directories
source "${CONDA_DIR}" bioinfo

# Create directories or locate the FASTQ directory
mkdir -p "${FASTQ_DIR}" && cd "${FASTQ_DIR}"

# Extract FASTQ files from the SRA file
fastq-dump --split-files ${SRA_ID}

# Get basic statistics of the genome
sra-stat --xml --statistics ${SRA_ID}









