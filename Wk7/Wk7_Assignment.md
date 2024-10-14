### Week 7 BMMB 852 Assignment: Makefile
The organism I am using is `Helicobacter pylori (H.pylori)`.

The variables used to make the `Makefile`
```
# Genome Accession number (Organism: H.pylori)
ACC=GCF_000307795.1

FNA=GCF_000307795.1_ASM30779v1_genomic.fna
GENOME_PATH="fastq_report/ncbi_dataset/data/${GENOME_ID}/${FNA}"
GENOME=Helicobacteria.fa

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

# Set read directory
RDIR=reads

# Set report directory (quality control)
PDIR=reports
```
The following commands were used to execute Makefile:

The `usage` commands show the `Makefile` contents.
```
usage:
	@echo "make genome    # Download the genome"
	@echo "make simulate  # Simulate reads for the genome"
	@echo "make download  # Download reads from SRA"
	@echo "make trim      # Trim reads"
	@echo "make fastqc    # Run fastqc on the reads"
```


The genome command downloads H.pylori genome file using the `${ACC}` (accession number).
Once download is complete it will designate the file to `${GENOME}` variable.
```
genome:
	datasets download genome accession ${GENOME_ACC}
	unzip -n ncbi_dataset.zip
	ln -sf "${GENOME_PATH}" "${GENOME}"
```


The simulate command simulates read sequencing using the above outputs. 
The command uses read length of 100 and number of reads, `${N}`, set as 10,000 and genome file as input (`${GENOME}`).
The number of reads variable can be changed by adjusting the `N` value.
It will also provide some statistic of the simulation result.  
```
simulate:
	wgsim -e 0 -r 0 -R 0 -1 100 -2 100 -N ${N} ${GENOME} ${R1} ${R2}
	echo $(seqkit stats ${R1} ${R2})
```


The download command downloads reads using the SRA accession number (`${SRR}`) and creates raw (un-trimmed) fastqc files. 
```
download:
	mkdir -p ${RDIR} ${PDIR}
	fastq-dump -X ${N} -F --outdir reads --split-files ${SRR}
	echo $(seqkit stats ${R1} ${R2})
	fastqc -q ${R1} ${R2} -o ${PDIR}
```

The trim command conducts quality control of the reads by removing adapter sequences to create better fastq files.
```
trim:
	cutadapt -a ${ADAPTER} -o ${T1} -p ${T2} ${R1} ${R2}
	fastqc -q -o ${PDIR} ${T1} ${T2}
```

Final line of the command in this script is to ensure the commands are executed properly.
```
.PHONY: usage
```
