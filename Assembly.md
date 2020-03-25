# Metagenome assembly
Assembly is one of the key steps for the genome-centric metagenome analysis. It is the process that reconstructs genomes using your quality controlled sequences. The assemblers can be different depending on the sequence platforms used to generate the sequences. In this tutoria, we assume that your sequences are short reads generated using Illumina platforms. There are many tools available to assembly the Illumina short reads. There are a number of metagenome assemblers widely used for Illumina sequences such as [IDBA-UD](https://academic.oup.com/bioinformatics/article/28/11/1420/266973), [MEGAHIT](https://github.com/voutcn/megahit), and [metaSPAdes](http://cab.spbu.ru/software/spades/). In this tutoria, we are using MEGAHIT and metaSPAdes.

### Assembly of qc reads with Megahit
```
#make an assembly directory in your project directory  
>mkdir assembly  
#cd into assembly directory  
>cd assembly/  
#print megahit version  
>megahit -v
#print megahit usage message   
>megahit -h  
#do the assembly using quality controlled reads  
>nohup megahit -1 your_qc_R1_file -2 your_qc_R2_file -t 8 -m 0.5 -o megahit_assembly  >& megahit.log.txt &
```
After finishing the assembly, we first check the "megahit.log.txt" file to make sure no errors has occurred during assembly and also to look at some of the simple stats such as min length of the contigs, max length of the contigs, N50  
```
#check log file to make sure there are no errors occurred during the assembly
>more megahit.log.txt
#check the simple stats for the assembly
>tail megahit.log.txt
```
After the successful assembly, your contig file is "final.contigs.fa".

### Assembly of qc reads with SPades
While Megahit is a fast assembler, metaSPAdes can provide longer contigs, but is much slower. Regardless of assembly method, the produced contig file (.fasta or .fa) can be used in the rest of the metagenomics pipeline.  Here is an optional assembly with metaspades
```  
#access metaspades parameters  
metaspades.py -h  
#do the assembly using quality controlled reads  
metaspades.py -1 ../qc/coassembly.R1.fastq -2 ../qc/coassembly.R2.fastq -t 8 -o metaspades_out  
#filter out contigs shorter than 500 bp  
filterContigByLength.pl contigs.fasta 500 > contigs.500.fasta  
```  
### Coassembly
If you have multiple samples that you would like to co-assemble, concatenate the qc read files into one file for forward (R1) and one for reverse (R2).
```
#go to the directory  
cd ~/mgworkshop2019/tutorials/qc  

#concatenate qc read files  
cat *.qc.R1.fastq > coassembly.R1.fastq  
cat *.qc.R2.fastq > coassembly.R2.fastq  
#check that the number of sequences in the concatenated files is equal to the sum of the input files (quotes don’t always copy and paste well onto the command line, you may need to type it out)  
grep -c ‘+’ S*.qc.R1.fastq  
grep -c ‘+’ S*.qc.R2.fastq  

grep -c ‘+’ coassembly.R1.fastq  
grep -c ‘+’ coassembly.R2.fastq
```
### Assembly statistics  
To assess the assembly, a tool from bbmap is used to generate summary statistics.
```
#go into directory  
cd megahit_assembly  

#run assembly statistics using BBmap stats tool  
stats.sh final.contigs.fa > assembly_stats.txt
```
