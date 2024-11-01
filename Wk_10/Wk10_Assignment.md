## Week 10: Variant Calling

To execute the `Makefile.mk` ran the following command:
```
make -f Makefile.mk all
```
### Verify Variant Caller's result
To identify variants of interest in the VCF file, I ran the following command to show the first 5 variants:
```
gunzip -c vcf/tuberculosis.vcf.gz | grep -v '^##' | head -n 5
```
Output:
```
#CHROM	POS	ID	REF	ALT	QUAL	FILTER	INFO	FORMAT	sample1
NZ_KK354750.1	117231	.	C	T	11.7172	.	DP=1;AD=0,1;SGB=-0.379885;MQ0F=0;AC=2;AN=2;DP4=0,0,0,1;MQ=60	GT:PL:DP:SP:ADF:ADR:AD:GQ	1/1:41,3,0:1:0:0,0:0,1:0,1:127
NZ_KK354750.1	744769	.	A	T	11.7172	.	DP=1;AD=0,1;SGB=-0.379885;MQ0F=0;AC=2;AN=2;DP4=0,0,0,1;MQ=59	GT:PL:DP:SP:ADF:ADR:AD:GQ	1/1:41,3,0:1:0:0,0:0,1:0,1:127
NZ_KK354750.1	745337	.	T	A	10.7923	.	DP=1;AD=0,1;SGB=-0.379885;MQ0F=0;AC=2;AN=2;DP4=0,0,1,0;MQ=60	GT:PL:DP:SP:ADF:ADR:AD:GQ	1/1:40,3,0:1:0:0,1:0,0:0,1:127
NZ_KK354750.1	850824	.	T	C	10.7923	.	DP=1;AD=0,1;SGB=-0.379885;MQ0F=0;AC=2;AN=2;DP4=0,0,1,0;MQ=60	GT:PL:DP:SP:ADF:ADR:AD:GQ	1/1:40,3,0:1:0:0,1:0,0:0,1:127
```
To view the alignments at specific postion, I used `samtools` to view the BAM file alignment at the variant position using the following command:
```
samtools view bam/tuberculosis.bam NZ_KK354750.1:10000-20000
```
Output:
```
22138	129	NZ_KK354750.1	16518	60	76M25S	NZ_KK354752.1	226015	0	CGATGTCGAACTTCCTGCGCTCGGCGGCAACCGCCATTCGCGGCGAGCCGCCGAAACTGCGGCACTGGGTCAAAGATCTAGATGACAAGGAGTCCTACCGC	CC@FFFFFDFHHHIHJIGBHIJJJIIIIJJJJHFFDDEFEDDDDD8BBDDBDDDDDDDDDDDDDDDDDDCDDDDDCDDDDDDCCDDCDDDBBCCDDDDAD@	NM:i:0	MD:Z:76	MC:Z:101M	MQ:i:60	AS:i:76	XS:i:0	RG:Z:run1
```
It mapped `NZ_KK354750.1` between position `10000` and `20000`

### Find examples where the variant caller did not work as expected: false positives, false negatives, etc.

To identify **False positives** in VCF file, I used the following command:
```
bcftools filter -e 'QUAL < 20 || DP < 10' vcf/tuberculosis.vcf.gz > potential_false_positives.vcf
```
creating a VCF file which contains variants with low quality (`QUAL < 20`) or low read depth (`FORMAT/DP < 10`).

when examining the output file `potential_false_positives.vcf` it came empty, which means there were no false positive based on the threshold criteria. 


To extract **False negative** in VCF file, I used the following commands:
```
# Identify high-coverage regions in the BAM file 
samtools depth -r NZ_KK354750.1 bam/tuberculosis.bam | awk '$3 > 20' > high_coverage_positions.txt

# Filter out knonw variants
awk '{print $1 "\t" $2-1 "\t" $2}' high_coverage_positions.txt > high_coverage_regions.bed

# Filter out regions in VCF file that overlap with BED file
bcftools view -T ^high_coverage_regions.bed vcf/tuberculosis.vcf.gz > potential_false_negatives.vcf
```
creating a VCF file which contains variants with false negative cases.
To verify these false negatives I ran the following commands:
```
samtools view bam/tuberculosis.bam NZ_KK354750.1:117221-117241
```
Output:
```
81525	2227	NZ_KK354750.1	117226	60	60H41M	=	1939367	1822202	TGTTGTCGGAGTTGAAGTAGCCGGTGTTCACGTTGCCCGAG	JJJJJJJJJIJIEGJJJJJJJJIJJIIJHHHHHFFFFFCCC	NM:i:1	MD:Z:5C35	MC:Z:101M	MQ:i:60	AS:i:36	XS:i:0	RG:Z:run1	SA:Z:NZ_KK354750.1,1939281,+,33S68M,60,0;
```
It's saying that:
* Read Name: `81525`
* FLAG: `2227` (indicating it is part of a supplementary alignment in a paired-end read)
* Chromosome: `NZ_KK354750.1`
* Position: `117226` (start of the alignment)
* Mapping Quality (MAPQ): `60` (indicating high confidence in the alignment)
* CIGAR String: `60H41M` (60 bases hard-clipped, with 41 matching bases)
* Sequence: `TGTTGTCGGAGTTGAAGTAGCCGGTGTTCACGTTGCCCGAG`
* Quality Scores: `High-quality bases`, indicated by J, I, H, and F characters.
* Mismatch: The tag `MD:Z:5C35` indicates a single mismatch (C instead of reference) at the 6th base of the aligned portion.

The presence of the `SA` tag indicates that the read aligns to multiple locations which lowers the confidence in the variant calling. The report of `potential_false_positive.vcf` and `potential_false_negative.vcf` are located [here](https://github.com/stephwon/Applied_Bioinformatics_BMMB852/tree/main/Wk_10/vcf_report).