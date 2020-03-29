# MAGs annotation
There are two ways to annotate MAGs using MetaErg. One is to run MetaErg pipline over the fasta format MAG files one by one following the procedures in the last section. The other method is to use MetaErg's utiliy script to extract individual MAG annotations and to generate html reports from the [total metagenome annotation](https://github.com/xiaoli-dong/metagenomics_crash_course/blob/master/annotation/README.md) results we generated in the last section. The following is an example on how to extract a MetaErg annotaiton for a specific MAG

## Prepare the work directory
```
#assume you are inside the "binning" directory
>mkdir metaerg_annot
>cd metaerg_annot
```
## Extarct MetaErg annotation for a single MAG
```
#Firstly, extract the gff subset belonging to a MAG from the metaerg output
fastaContig2Gff.pl  -c path_to_your_bin_id.fa -g path_to_your_metaerg_output/data/all.gff > your_bin_id.gff
# Secondly, generate metaerg output and reports for the MAG
output_reports.pl  -g your_bin_id.gff -f path_to_your_bin_id.fa -o your_bin_id_metaerg
```
## Extract MetaErg annotations for all MAGs
