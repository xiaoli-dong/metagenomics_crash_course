# Rapidly reconstruct the SSU rRNAs
[phyloFlash](https://github.com/HRGV/phyloFlash) is a complete workflow for SSU rRNA-targeted profiling of metagenomes that integrates database preparation, read extraction, taxonomic classification, targeted assembly and SSU rRNA targeted binning. It has been designed to provide a quick and user-friendly overview of the composition of metagenomic sequence libraries based on all domains of life, and can be used for the rapid screening and comparison of multiple samples, and for retrieving complete SSU rRNA genes and the associated genomic bins. This section, we are going to run phyloFlash program over our quality controlled sequences.

## Create phyloflash directory
```
#assume you are inside the project directory
>mkdir phyloflash
>cd phyloflash
```
## Execute phyloFlash
```
#show program usage message
>perl path_to_your_phyloFlash/phyloFlash.pl -help
#run phyloFlash over your quality controlled sequences for each of your samples
>perl path_to_your_phyloFlash/phyloFlash.pl -lib your_short_sample_id -read1 your_quality_controlled_read1.fastq -read2 your_quality_controlled_read2.fastq -CPUs 8 -everything

#list output from phyloFlash program
>ls
your_sample_id.phyloFlash.html
your_sample_id.phyloFlash.log
your_sample_id.phyloFlash.tar.gz

#Show detailed list of phyloFlash output and temporary files
>perl path_to_your_phyloFlash/phyloFlash.pl -outfiles
```
On how to intepret the phyloFlash output, please refer to [phyloFlash website](https://github.com/HRGV/phyloFlash)
