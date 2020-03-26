# Read Mapping.
Mapping is the process of aligning short reads back to references genomes, genes, or contigs. The mapping results can be used to compute contig coverages, quantify genes, infer taxonomic diversities, functional and pathway profiles, and improve binning results. There are many mappers publicly available. In this practice session, you will:

* Learn how to perform mapping using BBMap and bowtie2
* Understand file formats for aligned reads: sam file
* Learn how to use SAMTools to manipulate SAM and BAM files
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
Perform mapping
```
#BBMap will produce sorted and indexed bam file
>bbmap.sh ref=your_contigs_longer_than_500bp in=your_qc_R1_file in2=your_qc_R2_file out=your_sample_id.bam bs=bs.sh; sh bs.sh covstats=your_sample_id.bbmap_covstats.txt scafstats=your_sample_id.bbmap_scafstats.txt threads=8

#to look at the content of the bam file
>samtools view sorted_your_sample_id.bam | less
```
You will repeat the BBMap mapping process for all your sequenced libraries that you want to map.

## Short reads mapping using Bowtie2
Create output dirctory
```
#assume you are in "mapping" directory, make and move into the directory
>mkdir mapping_bowtie2
>cd mapping_bowtie2
```
Perform mapping
```
#step 1: build index
bowtie2-build -f your_contigs_longer_than_500bp contigs

#step 2: mapping quality controlled reads back to contigs and index sorted bam file
(bowtie2 --threads 8 --local -x contigs -q -1 your_qc_R1_file -2 your_qc_R2_file  | samtools view -@ 8 -Sb1 - | samtools sort -m 10G -@ 8 -o your_sample_id.sorted.bam -) 3>&1 1>&2 2>&3 | tee your_sample_id.log.txt

#step 3: build index
samtools index -@ 8 your_sample_id.sorted.bam
```
You will repeat the step-by-step bowtie2 mapping procedures (from step 2 to step 3) for all your sequeced libraries that you want to map.

## Make contig depth profiles
The contig depth profiles will be used in the downstream metagenome binning and annotation process.
```
#assume we are in "mapping" directory

#generate contig depth profile using BBMap produced sorted and indexed bam files.
jgi_summarize_bam_contig_depths --outputDepth  depth_bbmap.txt mapping_bbmap/*.bam
#generate contig depth profile using Bowtie2 produced sorted and indexed bam files.
jgi_summarize_bam_contig_depths --outputDepth  depth_bbmap.txt mapping_bowtie2/*.bam
```
