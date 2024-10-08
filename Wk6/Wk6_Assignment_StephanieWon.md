### Week 6 BMMB 852 Assignment: FASTQ Quality Control ###

Identify a bad sequencing dataset. You may need to evaluate multiple SRR numbers to find one with poor quality.

Q. Evaluate the quality of the downloaded data.
The file is whole genome sequence of Limulus polyphemus in skeletal leg muscle (SRA Accession:`SRR4181534`). The sample was sequenced using Illumina HiSeq 2000. The file is paired end reads. There are 62.7Gbp with 310.4M spots/reads. Link to script is [here](https://github.com/stephwon/Applied_Bioinformatics_BMMB852/blob/main/Wk6/fastq_qual.sh).

Commands to run the script:
```
chmod +x fastq_qual.sh
./fastq_qual.sh
```

The sequence quality of both read files is very bad. `Per base sequence quality` and `Per sequence quality scores` are in the lowest quality score (0-10).
FASTQ Quality (before trim):
![Before Trim](image/Before.png):

Q. Improve the quality of the reads in the dataset. Evaluate the quality again and document the improvements.
After trimming the adapter, the quality of the reads did not improve (image); doesn't even have any score. 

After trim:
![After trimming](image/After.png) 


This could mean several things:
1. The sequence itself is really bad which would require re-sequencing of the sample
2. The file could be corrupt which means the publisher needs to re-upload the file into NCBI sequence read archive database.


I investigated this further by going to the `Data Access` looking at the original data submission [(BAM files)](https://trace.ncbi.nlm.nih.gov/Traces/?view=run_browser&page_size=10&acc=SRR4181534&display=reads).
Looking at couple of random readm the Q scores are all 30 at SRA site.
![SRA site](image/SRA_site.png)

If I were the publisher I would re-examine the FASTQ file to either re-upload or re-sequence it to verify and validate that they have sequenced it correctly and provided the correct data.

The FASTQC and MultiQC `.html` format reports are located [here](https://github.com/stephwon/Applied_Bioinformatics_BMMB852/tree/main/Wk6/data).
