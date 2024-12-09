## Week 13: Generating RNA-seq Count Matrix
The following RNA-seq data was obtained from [here](https://www.ncbi.nlm.nih.gov/bioproject/PRJNA1185652).

The script will automate downloading reference genome to indexing with HiSat2

Use the following command to automate the process for all SRR accession numbers:

```
cat design.csv | parallel --lb -j 10 --colsep , --header : make -f Makefile.mk all SRR={SRR}
```

To individually process use the command below as example but change the target to specify the task:
```
cat design.csv | parallel --lb -j 10 --colsep , --header : make -f Makefile.mk reads SRR={SRR}
```
Another example:
```
cat design.csv | parallel --lb -j 10 --colsep , --header : make -f Makefile.mk align SRR={SRR}
```
### Create RNA-seq Count Matrix
To create the count matrix run the following command:
```
cd bam
featureCounts -a TB.gff -o TB_matrix.txt *.bam
```
### Result

Visualizing the aligned RAN-seq files in IGV:

![rna_seq](image/rna_seq.png)

### Count
Some interesting thing I found from RNA-seq count:

* SRR31326196 had 186 reads were assigned 
* SRR31326196 had 657 reads that were unmapped
* SRR31326196 had 18,265 reads that had no features

For each SRR, the counts are following:

| SRR           | Assigned Counts |
|---------------|-----------------|
| SRR31326196   | 186             |
| SRR31326197   | 153             |
| SRR31326198   | 130             |
| SRR31326199   | 123             |
| SRR31326200   | 113             |
| SRR31326201   | 146             |
| SRR31326202   | 216             |
| SRR31326203   | 479             |
| SRR31326204   | 458             |

Number of `Assigned` reads is relatively low compared to `Unassigned_NoFeatures` suggesting that most reads mapped to the regions were not annotated in the `TB.gff`.

Makes sense because these RNA-seq reads were from an experiment that were treated with some chemicals and the researchers wanted to see the its effects. 

