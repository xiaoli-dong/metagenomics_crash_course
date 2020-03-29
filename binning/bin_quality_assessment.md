# Metagenome bin quality assessment
In this tutorial, the goodness of the metagenome bins or Metagenome Assembled Genomes (MAGs) is estimated using the fully automated [CheckM software] (https://github.com/Ecogenomics/CheckM). In short,  it provides robust estimates of MAG's completeness, contamination, and strain heterogeneity by using collocated sets of genes that are ubiquitous and single-copy within a phylogenetic lineage. 

## Create checkm directory
```
#assume you are in the "binning" directory
#make "checkm_out" directory inside the "binning" directory  
>mkdir checkm_out
#move into the "checkm_out" directory
>cd checkm_out
```
## Metagenome bin inspection

```
#print CheckM usage message
>checkm -h
#print CheckM lineage_wf command usage message
>checkm lineage_wf -h

#excute checkm workflow 
>checkm lineage_wf -f checkm.txt -t 8 -x fa . checkm_out
```
The above "checkm lineage_wf" workflow will produce a MAGs quality evaluation summary report and a [Newick format](https://en.wikipedia.org/wiki/Newick_format) phylogentic tree based on a set of 43 genes with largely congruent phylogenetic histories.
```
#View the MAGs's quality evaluaiton summary report 
>less checkm_out/checkm.txt

#View the phylogenetric tree containing reference genomes and MAGs
>less checkm_out/checkm/storage/tree/concatenated.tre
```
The checkm produced tree can be visualized using [Dendroscope program](http://dendroscope.org/)
