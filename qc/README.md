# Short reads quality control
The effectiveness of the raw sequence quality control could significantly impact the downstream analysis. The QC procedures usually include clipping off the technical sequences (primer, adapter), filtering out artifacts, low-quality reads, short reads, and contamination reads, and trimming 3’ low quality bases.  

In this hands-on session, we will implement  the  step-by-step quality control procedures with the Illumina paired-end dataset using the [BBDuk program](https://jgi.doe.gov/data-and-tools/bbtools/bb-tools-user-guide/bbduk-guide/) from the [BBTools software suite](https://jgi.doe.gov/data-and-tools/bbtools/). To better understand the BBduk program input parameters, please refer to [BBTools User Guide](https://jgi.doe.gov/data-and-tools/bbtools/bb-tools-user-guide/).

After finishing the quality control procedures, we need to run the [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) program again over the quality controlled reads to check whether our quality control procedures are effective or not. In this session, we will learn:

* The metagenomic short read sequence quality control workflow  
* How to perform data quality control using BBDuk program  
* How to merge overlapped paired-end reads using BBMerge
## Create qc directory  
```
#assume you are in the project directory
#create qc directory and move into the directory
>mkdir qc
# go to the directory
>cd qc
```
## Step-by-step quality control
We will use using [BBDuk program](https://jgi.doe.gov/data-and-tools/bbtools/bb-tools-user-guide/bbduk-guide/) to do the metagenomic illumina reads quality control and the order of the QC commands below can affect the quality control outcomes. 
```
#print bbduk usage message
>bbudk.sh

#Step 1: trims the last base off of 151bp reads; that base is very low quality. Specifically, ftm=5 will trim reads so that their length is equal to zero modulo 5, and ignore reads that are already 100bp or 150bp, etc
>bbduk.sh -Xmx10g in=../raw/sampleID/your_read1.fastq.gz in2=../raw/sampleID/your_read2.fastq.gz  out=your_sample_id_trimLastBase_R1.fastq out2=your_sample_id_trimLastBase_R2.fastq ftm=5 threads=8 >& your_sample_id.trimLastbase.log.txt

#Step 2: trim off the partial adapter
>bbduk.sh -Xmx10g in=your_sample_id_trimLastBase_R1.fastq in2=your_sample_id_trimLastBase_R2.fastq out=your_sample_id_trimAdapter_R1.fastq out2=your_sample_id_trimAdapter_R2.fastq ref=/gpfs/ebg_data/programs/BBMap/bbmap/resources/adapters.fa tbo tpe k=23 mink=11 hdist=1 ktrim=r threads=8 >& your_sample_id.trimAdapter.log.txt

#Step 3: filter out contaminants
>bbduk.sh in=your_sample_id_trimAdapter_R1.fastq in2=your_sample_id_trimAdapter_R2.fastq out=your_sample_id_filterPhix_R1.fastq out2=your_sample_id_filterPhix_R2.fastq outm=your_sample_id_matched_Phix.fastq ref=/gpfs/ebg_data/programs/BBMap/bbmap/resources/phix_adapters.fa.gz k=31 hdist=1 stats=your_sample_id_stats.txt threads=8 >& your_sample_id.filtercontamin.log.txt

#Step 4: clipping off the low quality ends
>bbduk.sh -Xmx10g in=your_sample_id_filterPhix_R1.fastq in2=your_sample_id_filterPhix_R2.fastq out=your_sample_id.qc.R1.fastq out2=your_sample_id.qc.R2.fastq qtrim=rl trimq=15 minlength=30 threads=8 >& your_sample_id.lowquality.log.txt
```
you need to repeat the step-by-step steps for all your samples
