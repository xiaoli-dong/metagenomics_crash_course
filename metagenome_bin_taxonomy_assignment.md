# MAGs taxonomy assignment
The MAGs can be classified using [GTDB-Tk software toolkit](https://github.com/Ecogenomics/GTDBTk) based on the [GTDB Genome Taxonomy Database](https://gtdb.ecogenomic.org/) 


```
#move into "binning" directory
#classify taxonomy of genome bins generated in the binning process
gtdbtk classify_wf --genome_dir . -x fa --out_dir gtdbtk_out --prefix your_sample_id.bin --cpus 8
```
The above program will produce “gtdbtk_out/your_sample_id.bin.bac120.summary.tsv” and “gtdbtk_out/your_sample_id.bin.ar122.summary.tsv”. The resulting Newick tree files “*.bac120.classify.tree” and “*.ar122.classify.tree” can be opened in a tree viewer software such as Dendroscope for visualization.
