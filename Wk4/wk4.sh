#!/bin/bash

# Set the trace in the script
set -uex

# Set working directory path
WORK_DIR=~/Desktop/BMMB-852_Applied-Bioinformatics/Wk3
GFF_DIR="$WORK_DIR/gff_files"

# Create and move to the working directory
mkdir -p "$WORK_DIR"
cd "$WORK_DIR"

# Set file names
FNA="GCF_001577835.2_Coturnix_japonica_2.1_genomic.fna"
GENOME_PATH="ncbi_dataset/data/GCF_001577835.2/$FNA"
GFF_FILE="ncbi_dataset/data/GCF_001577835.2/genomic.gff"
GENES_FILE="$GFF_DIR/genes.gff"
CDS_FILE="$GFF_DIR/CDS.gff"
DEMO_GFF="$GFF_DIR/demo_gene.gff"

# Genome accession ID
GENOME_ACC="GCF_001577835.2"

# ------ NO CHANGES NECESSARY BELOW THIS LINE ------

# Download genome data for the specified accession, including GFF3, CDS, protein, RNA, and genome
datasets download genome accession "$GENOME_ACC" --include gff3,cds,protein,rna,genome

# Unzip the genome data
unzip ncbi_dataset.zip

# Get some stats on the genome
seqkit stats "$GENOME_PATH"

# Build a FASTA index for the genome
samtools faidx "$GENOME_PATH"

# Create directory for GFF files
mkdir -p "$GFF_DIR"

# From genomic.gff, extract features of type "gene" using awk
awk '$3 == "gene"' "$GFF_FILE" > "$GENES_FILE"

# Print the number of genes
cat "$GENES_FILE" | wc -l

# From genomic.gff, extract features of type "CDS" using awk
awk '$3 == "CDS"' "$GFF_FILE" > "$CDS_FILE"

# Output a message to inform the user that the GFF files have been created
echo "GFF files for 'gene' and 'CDS' have been created in the $GFF_DIR directory."

# Create a demo GFF file for a specific gene (USP25)
echo -e "NC_029516.1\t.\t.\t88686000\t88773240\t.\t.\t.\t." > "$DEMO_GFF"

# Output a message to inform the user that the demo GFF file has been created
echo "Demo gene GFF file has been created as $DEMO_GFF."

### Additional Functions ###
# Count the number of genes
NUM=$(cat "$GENES_FILE" | wc -l)

# Print the number of genes
echo "The number of genes is ${NUM}"

# Count the number of CDS features
NUM_CDS=$(cat "$CDS_FILE" | wc -l)

# Print the number of CDS features
echo "The number of CDS features is ${NUM_CDS}"

# Count all feature types in the GFF file
awk '{print $3}' "$GFF_FILE" | sort | uniq -c | sort -nr