# Week 2 BMMB 852 Assignment
*This text file contains the unix command used to download the GFF file and generate results.*

Go to the directory where I want the file to be downloaded

```
cd /Users/sj_won/Desktop/BMMB-852_Applied-Bioinformatics
```
Download the GFF 
```
wget https://ftp.ensembl.org/pub/current_gff3/coturnix_japonica/Coturnix_japonica.Coturnix_japonica_2.0.112.gff3.gz
```
Decompress the GFF file
```
gunzip Coturnix_japonica.Coturnix_japonica_2.0.112.gff3.gz
```
* Question 1:
I just googled the organism. Coturnix japonica is a Japanese quail.

* Question 2: Count features in the GFF file
```
grep -v '^#' Coturnix_japonica.Coturnix_japonica_2.0.112.abinitio.gff3 | wc -l
```
Answer: The file has 921141 features.

* Question 3: Finding and counting sequence regions (chromosomes)
```
grep '##sequence-region' Coturnix_japonica.Coturnix_japonica_2.0.112.abinitio.gff3 | wc -l
```
Answer: The file has 2012 sequence regions

* Question 4: Count how many genes listed in the file 
```
awk '$3 == "gene"' Coturnix_japonica.Coturnix_japonica_2.0.112.gff3 | wc -l
```
Answer: There are 15,732 genes (third column)

* Question 5: top-ten most annotated feature types (column 3) across the genome
```
cut -f 3 Coturnix_japonica.Coturnix_japonica_2.0.112.gff3 | grep -v '^#' | sort | uniq -c | sort -nr | head -10
```
Answer: The top most annotated feature types are exon, CDS, biological_region, mRNA, gene, five-prime UTR, long non-coding RNA, three-prime UTR, ncRNA_gene, region. 

* Question 6: Having analyzed this GFF file, does it seem like a complete and well-annotated organism? Share any other insights you might note.

I think the organism is some what well annotated. It has annotation regarding protein-coding genes and other key genomic features. It could do a bit more annotation on the `region` feature type since it doesn't specify the type of genomic region it is referring to.

For more insight I used the command:

```
cat Coturnix_japonica.Coturnix_japonica_2.0.112.gff3 | cut -f 3 | grep -v '^###' | sort | uniq -c | sort -nr | head
```

Which gave me the top 10 most annotated feature types and their counts:
```
403,038 exon
369,663 CDS
67,526 biological_region
27,883 mRNA
15,732 gene
11,640 five_prime_UTR
8,982 lnc_RNA
8,097 three_prime_UTR
5,689 ncRNA_gene
2012 region
```
