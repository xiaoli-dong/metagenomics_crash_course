# Short read quality assesment
Raw read quality control is the first step of metagenomic data analysis. Quality control is a multistep process. First, raw sequence quality assessment should be performed. This quality assessment should be proactive and comprehensive. This is an opportunity for you to know your data, which will enable you to perform downstream analyses with (more) appropriate assumptions and parameters. Second, the bioinformatics tools will be used to detect any problems, correct errors, and improve the sequence quality.  After the quality control process, the quality assessment procedure should be applied to the quality controlled reads again to make sure the remaining reads have sufficient quality for the downstream analysis.

### Create raw directory
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
## Do the quality assessment using the [FastQC program](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/)
```
#make fastqc output directory
>mkdir fastqc
#print fastqc program usage message
>fastqc -h
#run fastqc program
>fastqc -t 2 -f fastq -o fastqc *.fastq.gz
```
FastQC program will produce html quality assement reports to each fastq.gz file in the "raw" directory. To learn how to interpret the FastQC outputs, please refer to [FastQC tutorial](http://www.bioinformatics.babraham.ac.uk/projects/fastqc/Help/3%20Analysis%20Modules/)
