### Week 4 Assigment Part 2 Sequence Ontology Script

#!/bin/bash

# Set variables
WORK_DIR=/Users/sj_won/Desktop/BMMB-852_Applied-Bioinformatics/Wk4
URL=https://raw.githubusercontent.com/The-Sequence-Ontology/SO-Ontologies/master/so-edit.obo
OUTPUT_FILE=pseudogene_report.txt

# ------ NO CHANGES NECESSARY BELOW THIS LINE ------

# Activate Bioinfo conda environment
source activate bioinfo

cd $WORK_DIR
mkdir sequence_ontology
cd sequence_ontology

# Get pseudogene definition, parent and children terms
bio explain pseudogene

# Download SO data
wget $URL

# Get pseudogene information from SO data and save the report as a text file
cat so-edit.obo | grep 'name: pseudogene$' -B 1 -A 6 > $OUTPUT_FILE

# Optional: Print a message to confirm the report was saved
echo "Pseudogene report saved to $OUTPUT_FILE"
