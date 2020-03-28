# Sequence quality assesment
In this tutorial, you will use [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) to evaluate your sequence quality and get a quick impression of whether your data has any problems of which you should be aware before doing any furthur analysis. FastQC exports a html summary report containing the data summay graphs and tables.

### Create raw directory
```
# go to project directory
#make a directory for raw sequence files and move into the directory
>mkdir raw
>cd raw
#copy all your assigned raw sequence files into this directory
>cp the_path_to_your_sequence_file/your_file .
```
### Inspect the raw sequence file  
The following commands will guide you to see what a [fastq file](https://en.wikipedia.org/wiki/FASTQ_format) looks like:
```
#fastq file is a text file and you can view the file on linux using: more, cat, less, head, tail et al. Each fastq item has four lines ( header line, sequence line, spacer starts with +, and a quality line)
>less your_read_file_name.fastq

#check the compressed paired-end fastq sequence file content  
>zcat your_read1.fastq.gz | head -20
>zcat your_read2.fastq.gz | head -20

#download the "seqStats.pl" from the "bin" directory in this project and generate basic sequence stats

#print the script usage message
>perl seqStats.pl
#the script can accept compressed or uncompressed fastq or fasta format sequence files as input 
>perl seqStats.pl  -f fastq -s your_reads.fastaq.gz > your_read1.stats.txt
```
## Do the quality assessment using FastQC
Now, we are ready to excute the fastqc program on our sequence files
```
#prepare the fastqc output directory
>mkdir fastqc
#print fastqc program usage message
>fastqc -h
#FastQC program can accept both compressed or uncompressed sequence file.
# excute fastqc program
>fastqc -t 2 -f fastq -o fastqc your_sequence_file.fastq 
#or
>fastqc -t 2 -f fastq -o fastqc your_sequence_file.fastq.gz
```
After FastQC program finishing, it will produce a html format sequence evaluation report in "fastqc/your_sequence_file.fastq.html". To learn how to interpret the FastQC report, please check  [FastQC Help](http://www.bioinformatics.babraham.ac.uk/projects/fastqc/Help/) 
