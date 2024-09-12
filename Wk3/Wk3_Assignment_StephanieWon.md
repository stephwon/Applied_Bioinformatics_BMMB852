# Week 3 BMMB 852 Assignment

## 1. Reformat your previous assignment
Here is the link to the previous homework as Markdown file:
[https://github.com/stephwon/Applied_Bioinformatics_BMMB852/blob/main/Wk2/Wk2_Assignment_StephanieWon.md](https://github.com/stephwon/Applied_Bioinformatics_BMMB852/blob/main/Wk2/Wk2_Assignment_StephanieWon.md)

## 2. Visualize the GFF file of your choice.
Using a resource of your choice, download the genome and annotation files for an organism of your choice.

Below is the command I used to download the genome and create files:

```
# Activate bioinfo environment
conda activate bioinfo

# Change to working directory
cd BMMB_852

# Create a new directory for lec04
mkdir Wk3
cd Wk3

# Download genome data for the specified accession, including GFF3, CDS, protein, RNA, and genome
datasets download genome accession GCF_001577835.2 --include gff3,cds,protein,rna,genome

# Get some stats on the genome
seqkit stats ncbi_dataset/data/GCF_001577835.2/GCF_001577835.2_Coturnix_japonica_2.1_genomic.fna

# Build a FASTA index for the genome
samtools faidx ncbi_dataset/data/GCF_001577835.2/GCF_001577835.2_Coturnix_japonica_2.1_genomic.fna

```

### Use IGV to visualize your genome
![genome](https://github.com/stephwon/Applied_Bioinformatics_BMMB852/blob/main/Wk3/image/IGV_genome_viz.png)


### Separate intervals of type "gene" into a different file. If you don't have genes pick another feature.

Commands used to generate `gene.gff` and `CDS.gff`

```
# Create directory for GFF files
mkdir gff_files

# From genomic.gff, extract features of type gene using awk
cat ncbi_dataset/data/GCF_001577835.2/genomic.gff | awk '$3 == "gene"' > genes.gff

# From genomic.gff, extract features of type CDS using awk
cat ncbi_dataset/data/GCF_001577835.2/genomic.gff | awk '$3 == "CDS"' > CDS.gff

# Move the GFF files to the gff_files directory
mv -v *.gff
```

![gene-cds vis](https://github.com/stephwon/Applied_Bioinformatics_BMMB852/blob/main/Wk3/image/IGV_gene_cds_viz.png)


### Using your editor create a GFF that represents a intervals in your genome. Load that GFF as a separate track in IGV.
Command used to create demo gene GFF:
```
cd gff_files

code demo_gene.gff

# I extracted USP25 gene. Chromosome NC_029516.1 position 88,686kb to 8877324bp. Below is what I put in the demo_gene.gff

NC_029516.1	.	.	88686000	88773240	.	.	.	.
```

![demo gene](https://github.com/stephwon/Applied_Bioinformatics_BMMB852/blob/main/Wk3/image/IGV_demo-gene_viz.png)

### Report findings and provide relevant screenshots.

The annotation is consistent with the genome because the CDS and genes are well-reflected in the reference genome. Using the *USP25* gene as an example, I was able to find the start and stop codons.

### Start codon
![start codon](https://github.com/stephwon/Applied_Bioinformatics_BMMB852/blob/main/Wk3/image/IGV_findings_start-codon.jpg)

### Stop codon
![stop codon](https://github.com/stephwon/Applied_Bioinformatics_BMMB852/blob/main/Wk3/image/IGV_findings_stop-codon.jpg)

In that same gene, I was able to find the frame where the protein P (protline) was split in the middle of the codon. You can see that because P is not aligned with the frame.

![findings](https://github.com/stephwon/Applied_Bioinformatics_BMMB852/blob/main/Wk3/image/IGV_findings.png)

### Note:###
`CDS.gff` (150 MB) was compressed to `CDS.gff.zip` due to GitHub file size limit.
