# Short read quality assesment
In this tutorial, you will use [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) to evaluate your sequence quality and get a quick impression of whether your data has any problems of which you should be aware before doing any furthur analysis.  

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
