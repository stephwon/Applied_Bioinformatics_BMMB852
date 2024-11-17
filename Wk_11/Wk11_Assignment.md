## Week 11: Variant Effect Predition (VEP)

To execute the `Makefile.mk` run the following command:
```
make -f Makefile.mk all
```
### VEP Result
17 variants were processed in the genome *Mycobacterium tuberculosis (TB RSA126)*.
![stats](image/gen_stat.png)



100% of the variants were SNV (single nucleotide variation) or SNP. ![SNV](image/variant_class.png)

The SNP is due to intergenic variant meaning change in the nucelotide sequence in the region between gene loci. This mutation most likely have not affected translation and the resulting protein integreity. 
![intergenic variant](image/consequence_mostsevere.png)

### Visualization
Given that the genome size of TB is small, I had to manuver the zoom a lot to capture the data.

Here is the IVG view with coding region
![coding region](image/ivg_view_1.png)

one example where the mutation is
![with GFF](image/ivg_view_3_with_refgenome.png)

Coverage
![coverage with .bw file](image/igv_view_2.png)