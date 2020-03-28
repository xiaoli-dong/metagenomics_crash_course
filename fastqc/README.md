# Sequence quality assesment
In this tutorial, you will use [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) to evaluate your sequence quality and get a quick impression of whether your data has any problems of which you should be aware before doing any furthur analysis. FastQC exports a html summary report containing the data summay graphs and tables. To learn how to interpret the FastQC report, please check  [FastQC Help](http://www.bioinformatics.babraham.ac.uk/projects/fastqc/Help/)


### Create raw directory
```
# go to project directory
#make a directory for raw sequence files and move into the directory
>mkdir raw
>cd raw
#copy all your assigned raw sequence files into this directory
```
### Inspect the raw data file to see what a fastq file looks like
```
#fastq file is a text file and you can view the file on linux using: more, cat, less, head, tail et al.
>less your_read_file_name.fastq

#check the compressed paired-end fastq sequence file content  
>zcat your_read1.fastq.gz | head -20
>zcat your_read2.fastq.gz | head -20

#download the "seqStats.pl" from the "bin" directory in this project and generate basic sequence stats

#print the script usage message
>perl seqStats.pl
#the script can accept compressed or uncompressed fastq or fasta format sequence files as input 
>perl seqStats.pl  -f fastq -s your_read1.fastaq.gz > your_read1.stats.txt
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

