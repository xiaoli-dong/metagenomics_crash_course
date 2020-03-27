# Short read quality control  
## Short reads quality assessment

Raw read quality control is the first step of metagenomic data analysis. Quality control is a multistep process. First, raw sequence quality assessment should be performed. This quality assessment should be proactive and comprehensive. This is an opportunity for you to know your data, which will enable you to perform downstream analyses with (more) appropriate assumptions and parameters. Second, the bioinformatics tools will be used to detect any problems, correct errors, and improve the sequence quality.  After the quality control process, the quality assessment procedure should be applied to the quality controlled reads again to make sure the remaining reads have sufficient quality for the downstream analysis.

#### Create raw directory
```
# go to project directory
#make a directory for raw sequence files and move into the directory
>mkdir raw
>cd raw
#copy all your assigned raw sequence files into this directory

#check the paired-end sequence file content  
>zcat your_read1.fastq.gz | head -20
>zcat your_read2.fastq.gz | head -20

#generate sequence stats
>nohup perl seqStats.pl  -f fastq -s your_read1.fastaq.gz > your_read1.stats.txt&
```
#### Do the quality assessment using the [FastQC program](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/)
```
#make fastqc output directory
>mkdir fastqc
#print fastqc program usage message
>fastqc -h
#run fastqc program
>fastqc -t 2 -f fastq -o fastqc *.fastq.gz
```
FastQC program will produce html quality assement reports to each fastq.gz file in the "raw" directory. To learn how to interpret the FastQC outputs, please refer to [FastQC tutorial](http://www.bioinformatics.babraham.ac.uk/projects/fastqc/Help/3%20Analysis%20Modules/)

# Short reads quality control

The effectiveness of the raw sequence quality control could significantly impact the downstream analysis. The QC procedures usually include clipping off the technical sequences (primer, adapter), filtering out artifacts, low-quality reads, short reads, and contamination reads, and trimming 3’ low quality bases. In this hands-on session, you will learn how to implement  the  step-by-step quality control procedures with the Illumina paired-end dataset using the BBduk program from the BBTools software suite. To better understand the input parameters, please refer to [BBTools User Guide](https://jgi.doe.gov/data-and-tools/bbtools/bb-tools-user-guide/). At the end, we will be running the fastqc program again with the quality controlled reads. In this session, you will learn:

* The raw sequence quality control workflow  
* How to perform data quality control using bbduk.sh  
* How to merge overlapped paired-end reads using bbmerge.sh

#### Create qc directory  
```
#assume you are in the project directory
#create qc directory and move into the directory
mkdir qc
# go to the directory
cd qc
```
#### The QC can be run step-by-step for each sample as shown below:
```

#reference: https://jgi.doe.gov/data-and-tools/bbtools/bb-tools-user-guide/bbduk-guide/
#The order of the QC commands can affect the quality control results. 

#Sample 1

#Step 1: trims the last base off of 151bp reads; that base is very low quality. Specifically, ftm=5 will trim reads so that their length is equal to zero modulo 5, and ignore reads that are already 100bp or 150bp, etc
bbduk.sh -Xmx10g in=../raw/sampleID/your_read1.fastq.gz in2=../raw/sampleID/your_read2.fastq.gz  out=your_sample_id_trimLastBase_R1.fastq out2=your_sample_id_trimLastBase_R2.fastq ftm=5 >& your_sample_id.trimLastbase.log.txt &

#Step 2: trim off the partial adapter
nohup bbduk.sh -Xmx10g in=your_sample_id_trimLastBase_R1.fastq in2=your_sample_id_trimLastBase_R2.fastq out=your_sample_id_trimAdapter_R1.fastq out2=your_sample_id_trimAdapter_R2.fastq ref=/gpfs/ebg_data/programs/BBMap/bbmap/resources/adapters.fa tbo tpe k=23 mink=11 hdist=1 ktrim=r >& your_sample_id.trimAdapter.log.txt&

#Step 3: filter out contaminants
nohup bbduk.sh in=your_sample_id_trimAdapter_R1.fastq in2=your_sample_id_trimAdapter_R2.fastq out=your_sample_id_filterPhix_R1.fastq out2=your_sample_id_filterPhix_R2.fastq outm=your_sample_id_matched_Phix.fastq ref=/gpfs/ebg_data/programs/BBMap/bbmap/resources/phix_adapters.fa.gz k=31 hdist=1 stats=your_sample_id_stats.txt >& your_sample_id.filtercontamin.log.txt &

#Step 4: clipping off the low quality ends
nohup bbduk.sh -Xmx10g in=your_sample_id_filterPhix_R1.fastq in2=your_sample_id_filterPhix_R2.fastq out=your_sample_id.qc.R1.fastq out2=your_sample_id.qc.R2.fastq qtrim=rl trimq=15 minlength=30 >& your_sample_id.lowquality.log.txt&


#you will need to run the above steps for all your samples

```
