# Week 5 BMMB 852 Assignment

### Question 1. Select a genome, then download the corresponding FASTA file.

Link to the script [here](https://github.com/stephwon/Applied_Bioinformatics_BMMB852/blob/main/Wk5/fastq_report.sh).

I chose `GCF_000307795.1 ` which is H.pylori, a bacteria strain known to cause stomach and/or colon cancer.
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
1.6MB

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
* Name (ID) chromosome in the genome is `NC_018939.1 Helicobacter pylori 26,695` and Length is `1,667,892 bp`.

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
* Number of reads: 66,661

* Average read length: 100 bp

* The size of the FASTQ files is 15,009,876 bytes (approx. 14.3MB) each. Total file size is 30,019,752 bytes (approx. 28.63MB).

* Approximately 21304KB (~20.8MB) of space was saved after compression. That's 71.00% of space saved. 

* Yes I can get the same coverage by increaisng the read length (longer) and decreasing the read number (lower).

NOTE: The math is included in the script. 

### Question 3. How much data would be generated when covering the Yeast,  the Drosophila or the Human genome at 30x?


Assuming the Genome size of the organisms are: 

| **Organism**       | **Genome Size** | 
|--------------------|-----------------|
| **Yeast**          | 12.1 million bp |
| **Drosophila**     | 139.5 million bp| 
| **Human**          | 3.1 billion bp  |

As the H.pylori genome is 1.67 million bp and has a FASTA file size of 1.6MB, and assuming the read length is the same (100 bp), I can estimate the following:

Size of FASTA file for:
```
Yeast: 12.1 Mb
Drosophila: 139.5 Mb
Human: 3.1 Gb
```
Number of reads needed for 30x:
```
Yeast: 1,815,000 reads
Drosophila: 20,925,000 reads
Human: 465,000,000 reads
```
### Reads Calculation
#### 1. Yeast
Number of Reads:

$$
\begin{aligned}
\text{Number of Reads} &= \frac{30 \times 12,100,000\, \text{bp}}{200\, \text{bp/read}} \\[10pt]
&= \frac{363,000,000\, \text{bp}}{200\, \text{bp/read}} \\[10pt]
&= 1,815,000\, \text{reads}
\end{aligned}
$$

##### 2. Drosophila

Number of Reads:

$$
\begin{aligned}
\text{Number of Reads} &= \frac{30 \times 139,500,000\, \text{bp}}{200\, \text{bp/read}} \\[10pt]
&= \frac{4,185,000,000\, \text{bp}}{200\, \text{bp/read}} \\[10pt]
&= 20,925,000\, \text{reads}
\end{aligned}
$$

##### 3. Human

Number of Reads:

$$
\begin{aligned}
\text{Number of Reads} &= \frac{30 \times 3,100,000,000\, \text{bp}}{200\, \text{bp/read}} \\[10pt]
&= \frac{93,000,000,000\, \text{bp}}{200\, \text{bp/read}} \\[10pt]
&= 465,000,000\, \text{reads}
\end{aligned}
$$

Assuming that the read length is 100 bp (200bp for paired end). H.pylori genome is 1.67 million bp and has a FASTA file size of 1.6MB, `art_reads_1.fq` and `art_reads_2.fq` at 10x coverage is 28.63MB. So, if they were 30x they should be 3 times bigger at 85.89MB. Then the ratio should be:

$$
\begin{aligned}
\frac{85.89\text{ MB}}{1.67\text{ MB}} 
&\approx 51.43
\end{aligned}
$$

Which means that the read files for yeast, drosophila, and human should be 51 times bigger than the original FASTA file size. Therefore:
```
Yeast: 617.1 Mb
Drosophila: 7.11 Gb
Human: 158.1 Gb
```
Compression rate was 71% so the file size after compression is:
```
Yeast: 178.96 Mb
Drosophila: 2.06 Gb
Human: 45.85 Gb
```