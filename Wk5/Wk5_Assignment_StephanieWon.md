# Week 5 BMMB 852 Assignment

### Question 1. Select a genome, then download the corresponding FASTA file.

Link to the script [here](https://github.com/stephwon/Applied_Bioinformatics_BMMB852/blob/main/Wk5/fastq_report.sh).

I chose `GCF_000307795.1` which is H.pylori, a bacteria strain known to cause stomach and/or colon cancer.
I ran the following command to get executet the script:
```
chmod +x fastq_report.sh
./fastq_report.sh
```
Ouput:
```
file                                                                      format  type  num_seqs    sum_len    min_len    avg_len    max_len
ncbi_dataset/data/GCF_000307795.1/GCF_000307795.1_ASM30779v1_genomic.fna  FASTA   DNA          1  1,667,892  1,667,892  1,667,892  1,667,892

The size of the file:
1.6M

Total size of the genome (in base pairs): 1,667,892
Number of chromosomes in the genome: 1

Chromosome ID and Length:
ID: NC_018939.1 Helicobacter pylori 26695, complete sequence
Length: 1,667,892 bp
```
Answer:
* The File size is 1.6MB
* Total size of genome is 1,667,892 base pairs (approximately 1.67Mbp)
* Number of chromosomes in the genome is 1, which makes sense given this is a bacteria. 
* Name (ID) chromosome in the genome is NC_018939.1 Helicobacter pylori 26695 and Length is 1667892 bp.

### Question 2. Generate a simulated FASTQ output for a sequencing instrument of your choice.  Set the parameters so that your target coverage is 10x.

Link to the script [here](https://github.com/stephwon/Applied_Bioinformatics_BMMB852/blob/main/Wk5/fastq_simulation.sh).

For simulating FASTQ reads, I used ART simulator using `HS25` model.
I used the following command to run the script:
```
chmod +x fastq_simulation.sh
./fastq_simulation.sh
```

Output:
```
file                  format  type  num_seqs    sum_len  min_len  avg_len  max_len
reads/art_reads_1.fq  FASTQ   DNA     66,661  6,666,100      100      100      100
reads/art_reads_2.fq  FASTQ   DNA     66,661  6,666,100      100      100      100

Each FASTQ file size:
15009876 bytes
15009876 bytes

Total FASTQ file size: 30019752 bytes

21372 KB space saved
71.00% of space saved

```

Answer:
* Approximately 8 reads were generated. $C = \frac{L \times N}{G}$ which means $N = \frac{G \times C}{L}$.

  $N = \frac{85 \times 10}{100}$ = 8.5 which is approximately 8 reads

* Average read length is 100 base pairs long

* The size of the FASTQ files is 15,009,876 bytes (approx. 14.3MB) each. Total file size is 30,019,752 bytes (approx. 28.63MB).

* Approximately 21304KB (~20.8MB) of space was saved after compression. That's 71.00% of space saved. 

NOTE: The math is included in the script. 

### Question 3. How much data would be generated when covering the Yeast,  the Drosophila or the Human genome at 30x?


For each organism (Yeast, Drosophila, and Human), the estimates for the size of the FASTA file that holds the genome, the number of FASTQ reads needed for 30x coverage, and the size of the FASTQ files before and after compression are as follows:

| **Organism**       | **Genome Size** | **Number of Reads** | **FASTQ Size (Before Compression)** | **FASTQ Size (After Compression)** |
|--------------------|-----------------|---------------------|-------------------------------------|------------------------------------|
| **Yeast**          | 12.1 Mb         | 3,630,000           | 692.37 MB                           | 242.33 MB                         |
| **Drosophila**     | 139.5 Mb        | 41,850,000          | 7.80 GB                             | 2.73 GB                           |
| **Human**          | 3.1 Gb          | 930,000,000         | 173.61 GB                           | 60.76 GB                          |

NOTE: Assuming the read length is 100bp and a read (with 100 base pairs) will consume around 200 bytes of storage.

### **Yeast Genome**
- **Genome Size**: 12,100,000 base pairs (12.1 Mb).
- **Number of FASTQ reads needed**: 
    $\frac{30 \times 12,100,000}{100} = 3,630,000 \text{ reads}$
- **Size of FASTQ file before compression**: 
    $3,630,000 \text{ reads} \times 200 \text{ bytes} = 726,000,000 \text{ bytes} = 692.37 \text{ MB}$
- **After compression (assuming 60-70% compression)**: 
    $692.37 \text{ MB} \times 0.35 = 242.33 \text{ MB}$

### **Drosophila Genome**
- **Genome Size**: 139,500,000 base pairs (139.5 Mb).
- **Number of FASTQ reads needed**: 
    $\frac{30 \times 139,500,000}{100} = 41,850,000 \text{ reads}$
- **Size of FASTQ file before compression**: 
    $41,850,000 \text{ reads} \times 200 \text{ bytes} = 8,370,000,000 \text{ bytes} = 7.80 \text{ GB}$
- **After compression**: 
    $7.80 \text{ GB} \times 0.35 = 2.73 \text{ GB}$

### **Human Genome**
- **Genome Size**: 3,100,000,000 base pairs (3.1 Gb).
- **Number of FASTQ reads needed**: 
    $\frac{30 \times 3,100,000,000}{100} = 930,000,000 \text{ reads}$
- **Size of FASTQ file before compression**: 
    $930,000,000 \text{ reads} \times 200 \text{ bytes} = 186,000,000,000 \text{ bytes} = 173.61 \text{ GB}$
- **After compression**: 
    $173.61 \text{ GB} \times 0.35 = 60.76 \text{ GB}$
