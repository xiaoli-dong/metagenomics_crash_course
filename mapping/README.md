# Read Mapping. 
Mapping is the process of aligning short reads back to references genomes, genes, or contigs. The mapping results can be used to compute contig coverages, quantify genes, infer taxonomic diversities, functional and pathway profiles, and improve binning results. There are many mappers publicly available. In this practice session, you will:

* Learn how to perform mapping using BBMap and bowtie2
* Understand file formats for aligned reads: sam file 
* Learn how to use SAMTools to manipulate SAM and BAM files
* Calculate the contig depth profile based on the short reads mapping results

### Create mapping directory  
```
#make an "mapping" directory in your project directory  
>mkdir mapping  
#go into mapping directory  
>cd mapping
```

### Mapping short reads using BBMap

Create BBMap output dirctory
```
#assume you are in "mapping" directory, create directory and move into the directory
>mkdir mapping_bbmap
>cd mapping_bbmap
```
Perform the step by step procedures for each of your assembled contigs
```
>bbmap.sh ref=your_contigs_longer_than_500bp in=your_qc_R1_file in2=your_qc_R2_file out=your_sample_id.bam bs=bs.sh; sh bs.sh covstats=your_sample_id.bbmap_covstats.txt scafstats=your_sample_id.bbmap_scafstats.txt threads=8
```
To look at the produced bam file use:
```
samtools view sorted_your_sample_id.bam | less
```
