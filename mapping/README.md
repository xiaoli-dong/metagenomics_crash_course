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
mkdir mapping_bbmap
cd mapping_bbmap
```
Perform the step by step procedures for each of your assembled contigs
```
#step 1: only keep the contigs longer than 500bp
perl /gpfs/ebg_data/programs/metaerg/bin/filterContigByLength.pl  ../assembly/megahit_assembly/final.contigs.fa 500 > contigs.fasta

#mapping sample1
bbmap.sh ref=contigs.fasta in=../qc/S1.qc.R1.fastq in2=../qc/S1.qc.R2.fastq out=S1.sam covstats=S1_bbmap_covstats.txt scafstats=S1_bbmap_scafstats.txt threads=8

#converting sam file to bam file and sort the bam file
samtools view -b S1.sam | samtools sort -o S1.sorted.bam

#index sorted bam file
samtools index S1.sorted.bam

```
