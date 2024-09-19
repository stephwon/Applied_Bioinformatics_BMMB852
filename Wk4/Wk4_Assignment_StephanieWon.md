# Week 4 BMMB 852 Assignment

## Part 1: Write a script

##### Q: Write bash scrip based on the code from previous assignment. Run your script on your original data and verify that it works.

 Ran the commands:
  ```
  cd ~/Desktop/BMMB-852_Applied-Bioinformatics/Wk4
  chmod +x wk4.sh
  bash wk4.sh
  ```

 It created the GFF files and gave me stats on the genome and gene count (second to the last) and GFF file creation completion statement output:

```
  file                                                                                 format  type  num_seqs      sum_len  min_len    avg_len      max_len
ncbi_dataset/data/GCF_001577835.2/GCF_001577835.2_Coturnix_japonica_2.1_genomic.fna  FASTA   DNA      2,012  927,656,957      237  461,062.1  175,656,249


20802

Demo gene GFF file has been created as /Users/sj_won/Desktop/BMMB-852_Applied-Bioinformatics/Wk3/gff_files/demo_gene.gff.
```
Note: Removed tracer statement outputs for better readability; only showing three major outputs that I encoded in the script to verify that my script works.

##### Q: Now, run your script on their data. If the script is reusable, you can replace your variables with theirs and run the script.
##### Add more functions to the script that also print some of their results. Were you able to reproduce their results? Make a note in the report.

I was able to reproduce their results. Used my script on [this](https://github.com/nakinscherf/BMMB852/blob/main/week3/Kinscherf_wk3.md) person's organism.  
Additional fuctions are in the `wk4.sh` script to print some results. Output from the additional functions:
```
The number of genes is     5544

The number of CDS features is      190

5544 gene
5365 Homology
 190 CDS
  84 pseudogene
  75 exon
  56 tRNA
  15 rRNA
  13 riboswitch
  11 
   6 region
   6 1
   1 tmRNA
   1 sequence_feature
   1 ncRNA
   1 annotwriter
   1 SRP_RNA
   1 RefSeq
   1 RNase_P_RNA
   1 23:39:44

```
Link to Part 1 script is [here]()

### Part 2: Make use of ontologies

#### Sequence Ontology
1. Choose a feature type from the GFF file and look up its definition in the sequence ontology.

Chose `pseudogene` as the feature type from my GFF file and ran the following commands:

```
conda activate bioinfo
cd BMMB-852_Applied-Bioinformatics/Wk4
mkdir sequence_ontology

# Get pseudogene definition
bio explain pseudogene
```

Output:
```
## pseudogene (SO:0000336)

A sequence that closely resembles a known functional gene,
at another locus within a genome, that is non-functional as
a consequence of (usually several) mutations that prevent
either its transcription or translation (or both). In
general, pseudogenes result from either reverse
transcription of a transcript of their \

Parents:
- biological_region 
- gene (non_functional_homolog_of)

Children:
- processed_pseudogene 
- pseudogenic_transcript (part_of)
- non_processed_pseudogene 
- polymorphic_pseudogene 
- transposable_element_pseudogene 
- vertebrate_immune_system_pseudogene 
```

2. Find both the parent terms and children nodes of the term.

The command  `bio explain pseudogene` gave me the Parent and the Children nodes and the definition of the `pseudogene`. Note: Output is same as question 1. I just copied the Parent and Chilren portion to answer the question.

```
Parents:
- biological_region 
- gene (non_functional_homolog_of)

Children:
- processed_pseudogene 
- pseudogenic_transcript (part_of)
- non_processed_pseudogene 
- polymorphic_pseudogene 
- transposable_element_pseudogene 
- vertebrate_immune_system_pseudogene 
```

3. Provide a short discussion of what you found.

Pseudogene belongs to the Alliance Genome Resources subset and part of the SOFA (Seqeuence Ontology Feature Annotation). The term `"gene"` is broad synonym and the term `"pseudo"` is an exact synonym in the INSDC. 

Command:
`cat so-edit.obo | grep 'name: pseudogene$' -B 1 -A 6`

Output:
```
id: SO:0000336
name: pseudogene
def: "A sequence that closely resembles a known functional gene, at another locus within a genome, that is non-functional as a consequence of (usually several) mutations that prevent either its transcription or translation (or both). In general, pseudogenes result from either reverse transcription of a transcript of their \"normal\" paralog (SO:0000043) (in which case the pseudogene typically lacks introns and includes a poly(A) tail) or from recombination (SO:0000044) (in which case the pseudogene is typically a tandem duplication of its \"normal\" paralog)." [http://www.ucl.ac.uk/~ucbhjow/b241/glossary.html]
subset: Alliance_of_Genome_Resources
subset: SOFA
synonym: "INSDC_feature:gene" BROAD []
synonym: "INSDC_qualifier:pseudo" EXACT []
synonym: "INSDC_qualifier:unknown" EXACT []
```
Link to the sequence ontology [script]().