# MAGs quality assessment
In this tutorial, the goodness of the metagenome bins or Metagenome Assembled Genomes (MAGs) is estimated using the fully automated [CheckM software] (https://github.com/Ecogenomics/CheckM). In short,  it provides robust estimates of MAG's completeness, contamination, and strain heterogeneity by using collocated sets of genes that are ubiquitous and single-copy within a phylogenetic lineage. 

## Create checkm directory
```
#assume you are in the "binning" directory
#make "checkm_out" directory inside the "binning" directory  
>mkdir checkm_out
#move into the "checkm_out" directory
>cd checkm_out
```
## Inspection MAGs
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
## CheckM utility commands  
CheckM also provides a number of additional commands useful for exploring genome bins.
```
#move into "checkm_out" direcotry
>cd checkm_out

# print the "checkm coverage" usage message. This command needs the sorted and indexed bam files
>checkm coverage -h
#produces coverage profiles for all all the MAGs inside the "binning" directory
>checkm coverage -x fa ../ your_sample_id.checkm_coverage.bins.tsv the_path_to_your_mapping_dir_generated_in_mapping_section/*.bam

# print the "checkm profile" usage message
>checkm profile -h
# determine the percentage of each bin relative to all genome bins under consideration.
>checkm profile your_sample_id.checkm_coverage.bins.tsv > your_sample_id.checkm_profile.bins.txt

# print the "checkm unbinned" usage message
>checkm unbinned -h
# extract unbinned sequences and get unbinned sequence statistics
>checkm unbinned -x fa ../ your_contig_file_longer_than_500bp.fasta your_sample_id.unbinned.fna your_sample_id.unbinned_stats.txt
```
