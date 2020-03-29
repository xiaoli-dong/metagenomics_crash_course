# Metagenome bin taxonomy classification
Genome classification can be obtained using the protein phylogeny in the Genome Taxonomy Database, which seeks to provide standardized microbial taxonomy inferred from a concatenated set of 120 single copy marker proteins for bacterial and 122 marker proteins for Archaea, with the “gtdbtk classify_wf ” command of the GTDB-Tk program. The classifications provided by the program are in the files “*.bac120.summary.tsv” and “*.ar122.summary.tsv”. The resulting Newick tree files “*.bac120.classify.tree” and “*.ar122.classify.tree” can be opened in a tree viewer software such as Dendroscope for visualization.

## Create gtdbtk directory
```
#make gtdbtk directory inside the "binning" directory and move into the directory
>mkdir gtdbtk
>cd gtdbtk
#classify taxonomy of genome bins generated in the binning process
gtdbtk classify_wf --genome_dir ../ -x fa --out_dir gtdbtk_out --prefix your_sample_id.bin --cpus 8


```
