# Read Mapping.
Mapping is the process of aligning short reads back to references genomes, genes, or contigs. The mapping results can be used to compute contig coverages, quantify genes, infer taxonomic diversities, functional and pathway profiles, and improve binning results. There are many different mappers available to map your quality controlled reads back to the assemblies. In this tutorial, we will be using [BBMap](https://jgi.doe.gov/data-and-tools/bbtools/) and [Bowtie2](http://bowtie-bio.sourceforge.net/bowtie2/index.shtml). In this practice session, you will:

* Learn how to perform mapping using BBMap and Bowtie2
* Understand mapping tool produced [SAM or BAM](https://genome.sph.umich.edu/wiki/SAM) file
* Learn how to use [SAMTools](http://www.htslib.org/) to manipulate SAM and BAM files
* Calculate the contig depth profile based on the short reads mapping results

## Create mapping directory
```
#make an "mapping" directory in your project directory
>mkdir mapping
#go into mapping directory
>cd mapping
```
## Short reads mapping using BBMap
Create output dirctory
```
#assume you are in "mapping" directory, create directory and move into the directory
>mkdir mapping_bbmap
>cd mapping_bbmap
```
Map the quality controlled reads back to your assembly
```
#BBMap will produce sorted and indexed bam file 
>bbmap.sh -Xmx50g ref=your_contigs_longer_than_500bp in=your_qc_R1_file in2=your_qc_R2_file minid=0.90 covstats=your_sample_id.bbmap_covstats.txt scafstats=your_sample_id.bbmap_scafstats.txt statsfile=your_sample_id.bbmap_stats.txt threads=8 out=your_sample_id.bbmap.bam bs=bs.sh; sh bs.sh >& your_sample_id.bbmap.log.txt
```
The above command will result sorted and indexed BAM file: "your_sample_id.bbmap_sorted.bam" and "your_sample_id.bbmap_sorted.bam.bai"  

You need to repeat the BBMap mapping process for all your sequenced libraries that you want to map to your assembly.
## Short reads mapping using Bowtie2
Create output dirctory
```
#assume you are in "mapping" directory, make and move into the directory
>mkdir mapping_bowtie2
>cd mapping_bowtie2
```
Map the quality controlled reads back to your assembly
```
#step 1: build index
>bowtie2-build -f your_contigs_longer_than_500bp bowtie2_contigs
#step 2: mapping quality controlled reads back to contigs and index sorted bam file
>(bowtie2 --threads 8 --local -x bowtie2_contigs -q -1 your_qc_R1_file -2 your_qc_R2_file  | samtools view -@ 8 -Sb1 - | samtools sort -m 10G -@ 8 -o your_sample_id.bowtie2_sorted.bam -) 3>&1 1>&2 2>&3 | tee your_sample_id.bowtie2_map.log.txt
#step 3: build index
>samtools index -@ 8 your_sample_id.bowtie2_sorted.bam
```
The above commands will result sorted and indexed BAM file: "your_sample_id.bowtie2_sorted.bam" and "your_sample_id.bowtie2_sorted.bam.bai"  
You need repeat the step-by-step bowtie2 mapping procedures (from step 2 to step 3) for all your sequenced libraries that you want to map to your assembly.
## Make contig depth profiles
The contig depth profiles will be used in the downstream metagenome binning and annotation process. "jgi_summarize_bam_contig_depths" is from [MetaBAT program](https://bitbucket.org/berkeleylab/metabat/src/master/)
```
#assume we are in "mapping" directory
#generate contig depth profile using BBMap produced sorted and indexed bam files.
jgi_summarize_bam_contig_depths --outputDepth  depth_bbmap.txt mapping_bbmap/*.bam

#generate contig depth profile using Bowtie2 produced sorted and indexed bam files.
jgi_summarize_bam_contig_depths --outputDepth  depth_bowtie2.txt mapping_bowtie2/*.bam
```
## Manipulate SAM and BAM file using SAMTools  
The mapping tools produced alignment infromation is contained in a SAM or BAM file. SAM stands for Sequence Alignment/Map format and BAM is the binary version of the plain text SAM format. Samtools is a set of utilities that manipulate alignments in the BAM format. In the following section, we explain how to manipulate SAM or BAM files with samtools 
```
#sam file is a text file and can be veiwed by cat, more, less, head, tail
>head your_file.sam

#print samtools usage message
>samtools
#or 
>samtools --help

#convert a sam file to a bam file
>samtools view -bS your_file.sam > your_file.bam
#to look at the content of a bam file
>samtools view your_file.bam | less
#convert a sam file to a sorted bam file
>samtools view -bS your_file.sam | samtools sort - -o your_file.sorted.bam
#create a bam index file
>samtools index your_file.sorted.bam
```
