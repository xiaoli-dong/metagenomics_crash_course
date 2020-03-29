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
#running metaerg
>metaerg.pl --sp --tm --prefix your_shorten_sample_id --outdir your_shorten_sample_id_metaerg_out --locustag your_shorten_sample_id  --depth path_to_your_depth_file_generted_in_mapping_section your_contig_file_longer_than_500bp.fasta >& your_sample_id.metaerg.log.txt
```
