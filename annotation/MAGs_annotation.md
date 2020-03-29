# MAGs annotation
There are two ways to get the annotation for MAGs. One is to run MetaErg pipline over the fasta format MAG files one by one following the procedures in the [total metagenome annotation](https://github.com/xiaoli-dong/metagenomics_crash_course/blob/master/annotation/README.md) section, the other is 
 to extract the annotation and to generate html reports for each MAG from the total annotation above. The following is an example on how to extract a MetaErg annotaiton for a specific MAG

## Prepare the work directory
```
#assume you are inside the "binning" directory
>mkdir metaerg_annot
>cd metaerg_annot
```
## Extarct MetaErg annotation for a single MAG
```
#Firstly, extract the gff subset belonging to a bin from the metaerg output
fastaContig2Gff.pl  -c path_to_your_bin_id.fa -g path_to_your_metaerg_output/data/all.gff > your_bin_id.gff
# Secondly, generate metaerg output and report
output_reports.pl  -g your_bin_id.gff -f path_to_your_bin_id.fa -o your_bin_id_metaerg
```
