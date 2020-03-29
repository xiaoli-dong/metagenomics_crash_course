# MAGs taxonomy assignment
The MAGs can be classified using [GTDB-Tk software toolkit](https://github.com/Ecogenomics/GTDBTk) based on the [GTDB Genome Taxonomy Database](https://gtdb.ecogenomic.org/) 

## Execute the GTDB-TK classify workflow
```
#move into "binning" directory
#classify taxonomy of genome bins generated in the binning process
gtdbtk classify_wf --genome_dir . -x fa --out_dir gtdbtk_out --prefix your_sample_id.bin --cpus 8
```
## GTDBTK program outputs
The primary outputs of the GTDBTk program contain the taxonomic classification it recommends plus additional information regarding the criteria used to assign taxonomy. The two files below include classification of query genomes based on their placement in the reference tree, relative evolutionary divergence, and Average Nucleotide Identity (ANI) to reference genomes.
```
#
>less gtdbtk_out/your_sample_id.bin.bac120.summary.tsv
>less gtdbtk_out/your_sample_id.bin.ar122.summary.tsv
```
The following two files contains the reference tree in Newick format containing query genomes placed with [pplacer program](https://github.com/matsen/pplacer).
```
>less gtdbtk_out/your_sample_id.bin.bac120.classify.tree
>less gtdbtk_out/your_sample_id.bin.ar122.classify.tree
```
The Newick format trees can be visualized in [Dendroscope program](http://dendroscope.org/). To learn more how to interpret the primary output files, please refer to [GTDBTK documentation](https://github.com/Ecogenomics/GTDBTk#classification-summary-file)
