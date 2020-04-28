# Metagenome annotation
Metagenome annotation is the process of labeling sequences as genes or genomic elements and also determining what those genes do. In this session, we will use [MetaErg](https://doi.org/10.3389/fgene.2019.00999) to annotate our metagenome contigs. 
## Create annotation directories
```
#assume you are inside the project direcotry
#make directory and move into the directory
>mkdir annotation
>cd annotation
```
## Execute MetaErg program
```
#print metaerg usage message
>metaerg.pl -h
#running metaerg. The depth file in the command was generated in the mapping section of the tutorial
>metaerg.pl --sp --tm --prefix your_shorten_sample_id --outdir your_shorten_sample_id_metaerg_out --locustag your_shorten_sample_id --depth your_depth_file your_contig_file_longer_than_500bp.fasta >& your_sample_id.metaerg.log.txt
```
## Check MetaErg output reports
To facilitate the exploration of complex metagenome annotation results and make sense of the data, MetaErg’s annotation reports are presented in various formats. The HTML result page visually brings together text summaries, output data files, and accompanying visualizations. The interactive sortable and searchable gene, function, and profile tables, collapsible trees, sunburst hierarchical views of taxonomy and functional ontology, and other graphical representations, enable the effective interactive exploration, analysis, filtering, and intuitive navigation of complex metagenomic data 
```
#check MetaErg ouput
>ls your_shorten_sample_id_metaerg_out
#the "index.html" page inside the directory links all data and reports together and we can open it using a browser
```
You can also transfer the MetaErg output "your_shorten_sample_id_metaerg_out" to you local computers for better and faster rendering. When you do the transferring, you can ignore "your_shorten_sample_id_metaerg_out/tmp", which has big data size and is not needed for the data visualization. To speed up the data transfering, you can compress the MetaErg analysis results before transferring:   
```
#compresse the analysis results for faster data transferring to the local computer
tar -cvzf  your_shorten_sample_id_metaerg_out.tar.gz your_shorten_sample_id_metaerg_out --exclude='your_shorten_sample_id_metaerg_out/tmp'
```
