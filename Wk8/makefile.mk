# Genome Accession number (Organism: H.pylori)
ACC=GCF_000307795.1

FNA=GCF_000307795.1_ASM30779v1_genomic.fna
GENOME_PATH="fastq_report/ncbi_dataset/data/${ACC}/${FNA}"
GENOME=Helicobacteria.fa

# SRR number 
SRR=SRR4181534

# Number of reads
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

# Set reference genome
REF=refs/${GENOME}

# Set SAM file name
SAM=align.sam

# Set BAM file name
BAM=align.bam

# Print the help
usage:
	@echo "make genome    # Download the genome"
	@echo "make simulate  # Simulate reads for the genome"
	@echo "make download  # Download reads from SRA"
	@echo "make trim      # Trim reads"
	@echo "make fastqc    # Run fastqc on the reads"
	@echo "make index     # Index the reference genome"
	@echo "make align     # Align the reads to the reference genome"


# Download the genome
genome:
	datasets download genome accession ${ACC}
	unzip -n ncbi_dataset.zip
	ln -sf "${GENOME_PATH}" "${GENOME}"

# Simulate sequencing
simulate:
	wgsim -e 0 -r 0 -R 0 -1 100 -2 100 -N ${N} ${GENOME} ${R1} ${R2}
	echo $(seqkit stats ${R1} ${R2})

# Download reads from SRA
download:
	mkdir -p ${RDIR} ${PDIR}
	fastq-dump -X ${N} -F --outdir reads --split-files ${SRR}
	echo $(seqkit stats ${R1} ${R2})
	fastqc -q ${R1} ${R2} -o ${PDIR}

# QC Trimming
trim:
	cutadapt -a ${ADAPTER} -o ${T1} -p ${T2} ${R1} ${R2}
	fastqc -q -o ${PDIR} ${T1} ${T2}

# Index the reference genome
index:
	bwa index ${GENOME}

#Align the reads to the reference genome
align:
	mkdir -p bam
	bwa mem ${GENOME} ${T1} > bam/${SAM}
	cat bam/${SAM} | samtools sort > bam/${BAM}
	samtools index bam/${BAM}

.PHONY: usage genome simulate download trim index align
