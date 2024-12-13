## Week 14: RNA-seq Differential Expression Analysis

Used a simulated count matrix for this assignment. To generate a simulated count matrix, I used the following command:
```
# Configure conda environment
conda activate stats

# Generate simulated RNA-seq count matrix
Rscript src/r/simulate_counts.r
```

To execute RNA-seq differential expression analysis, create PCA and heatmap, I used the following command:
```
make -f Makefile.mk diff pca heatmap clean
```

### Result

There are:
* 419 genes (8.60%) were considered significant passing the PValue of `0.05` threshold 
* 149 genes (3.10%) end up significant when `FDR` adjustment was applied
* Out of the `259` changes, edgeR found `143` that matched
* `116` that were false negative,genes that were differentially expressed but `edger` did not find.
* `6` were found false positive genes that `edger` found to be differentially expressed but were not.

### PCA
* Sample A1 and A2 were closely correlated with another but A3 much less so. 
* However, B samples did not look like they are correlated much given that they are all spread far apart.
* Between sample A and B they are not closely correlated.

[pca](result_viz/pca.pdf)
### Heatmap
* Sample A and sample B had do not share same genes expressing, which supports the PCA results that the two sample groups are not correlated.
* When looking at sample A's, all the samples had varying degree of 

* Some genes exhibit strong "upregulation" (red) or "downregulation" (blue). For example the top genes (e.g., `GENE-7996`, `GENE-14387`) are highly expressed in sample B but not in sample A. 
* Even within the same sample group, the expression level for the same gene differ. For example when looking at `GENE-13442` it's highly expressed in sample A3 but not much in A1 and A2.

[heatmap](result_viz/heatmap.pdf)



