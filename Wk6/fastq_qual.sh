### Week 6 BMMB 852 Assignment: FASTQ Quality Control with fastp###
#!/bin/bash

set -uex

CONDA_DIR=~/micromamba/etc/profile.d/micromamba.sh
BIOINFO_PATH=/Users/sj_won/micromamba/envs/bioinfo

WORK_DIR=~/Desktop/BMMB-852_Applied-Bioinformatics/Wk6

# SRR number 
SRR=SRR4181534

# Number of reads to sample
N=10000

# The output read names
R1=reads/${SRR}_1.fastq
R2=reads/${SRR}_2.fastq

# Trimmed read names
T1=reads/${SRR}_1.trimmed.fastq
T2=reads/${SRR}_2.trimmed.fastq

# The adapter sequence
ADAPTER=AGATCGGAAGAGCACACGTCTGAACTCCAGTCA

# The reads directory
RDIR=reads

# The reports directory
PDIR=reports

# ----- actions below ----

source "${CONDA_DIR}"
micromamba activate "${BIOINFO_PATH}"

cd "${WORK_DIR}"

# Make the necessary directories
mkdir -p ${RDIR} ${PDIR}

# Download the FASTQ file
fastq-dump -X ${N} --split-files -O ${RDIR} ${SRR} 

# Run fastqc
fastqc -q -o ${PDIR} ${R1} ${R2}

# Run fastp and trim for quality
# There is a substantial difference between --cut_tail vs --cut_right
# both trim in a window but one goes from the right and the other from the left

fastp --adapter_sequence=${ADAPTER} --cut_tail \
      -i ${R1} -I ${R2} -o ${T1} -O ${T2} 

# Run fastqc
fastqc -q -o ${PDIR} ${T1} ${T2}

# Assumes that you have installed multiqc like so
# conda create -y -n menv multiqc 

# Run the multiqc from the menv environment on the reports directory
# The output of the tool is in the multiqc_report.html
micromamba run -n menv multiqc -o ${PDIR} ${PDIR}



