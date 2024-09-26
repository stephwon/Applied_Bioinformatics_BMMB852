# Week 5 BMMB 852 Assignment

### Question 1. Select a genome, then download the corresponding FASTA file.

I chose `SRR8278185` which is H.pylori, a bacteria strain known to cause stomach and/or colon cancer.

File size: 230,071,007 bytes (approx. 230.07 MB)
Total genome size: 1.6Mb
Total sequenced base: 339,362,847 base (approx 3.4Mb)
Number of chromosomes: 1 (bacteria has circular DNA)
Name and length of each chromosome: None, E.coli has only one chromsome (circular) instead it gave me base composition.

Output:
```
<Bases cs_native="false" count="339362847">
    <Base value="A" count="100632494"/>
    <Base value="C" count="65646876"/>
    <Base value="G" count="64446409"/>
    <Base value="T" count="101091520"/>
    <Base value="N" count="7545548"/>
```
* A (Adenine): 100,632,494

* C (Cytosine): 65,646,876

* G (Guanine): 64,446,409

* T (Thymine): 101,091,520

* N (Unknown/ambiguous base): 7,545,548

### Question 2. Generate a simulated FASTQ output for a sequencing instrument of your choice.  Set the parameters so that your target coverage is 10x.

* Reads generated: 80,000 reads

* Average read length: 100 bases long

* Size of FASTQ file: 39900KB (39.9MB)

* Space saved: Approximately 77.5% space saved. The FASTQ files after compression were 8960KB (8.96MB).

  Therefore, (39900-8960)KB/39900KB *100 = 77.5% saved.

### Question 3. How much data would be generated when covering the Yeast,  the Drosophila or the Human genome at 30x?

At 30x reads coverage:
* Yeast will need 3.63 million reads, yield approximately 726 MB (217.8 MB compressed) FASTQ file size. FASTA size is ~12.1 MB.
* Drosophila will need 41.85 million reads, yield approximately 8.37GB (2.51 GB compressed) FASTQ file size. FASTA size is ~139.5 MB.
* Human will need 960 million reads, yield approximately 192 GB (57.6 GB compressed) FASTQ file size. FASTA size is ~3.2 GB.
