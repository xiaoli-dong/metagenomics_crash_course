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
>fastaContig2Gff.pl  -c path_to_your_bin_id.fa -g path_to_your_metaerg_output_from_last_section/data/all.gff > your_bin_id.gff
# Secondly, generate metaerg output and reports for the MAG
>output_reports.pl  -g your_bin_id.gff -f path_to_your_bin_id.fa -o your_bin_id_metaerg_out
#check MAG annotation
>ls your_bin_id_metaerg
```
## Extract MetaErg annotations for multiple MAGs
Assume your interested MAGs are in a dirctory called "MAGs"
```
>mkdir MAGs
>cp your_interested_fasta_bin_files MAGs
>cd MAGs
```
Assume you are using bash shell, you can use the following for loop to extract MetaErg annotations for all your interested MAGs  
```bash 
for var in *.fa  
do  
fastaContig2Gff.pl  -c $var -g path_to_your_metaerg_output/data/all.gff > $var.gff  
output_reports.pl  -g $var.gff -f $var -o $var_metaerg_out  
done
```

After finishing the extractions, the MetaErg annotations for each MAG will be in "your_bin_id.fa_metaerg_out"
