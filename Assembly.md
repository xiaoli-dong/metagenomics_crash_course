# Metagenome assembly
Assembly is one of the key steps for the genome-centric metagenome analysis. It is the process that reconstructs genomes using your quality controlled sequences. The assemblers can be different depending on the sequence platforms used to generate the sequences. In this tutoria, we assume that your sequences are short reads generated using Illumina platforms. There are many tools available to assembly the Illumina short reads. There are a number of metagenome assemblers widely used for Illumina sequences such as [IDBA-UD](https://academic.oup.com/bioinformatics/article/28/11/1420/266973), [MEGAHIT](https://github.com/voutcn/megahit), and [metaSPAdes](http://cab.spbu.ru/software/spades/). In this tutoria, we are using MEGAHIT and metaSPAdes.

### Assembly of qc reads with Megahit
```
#make an "assembly" directory in your project directory  
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
After the successful assembly, your contig file is "megahit_assembly/final.contigs.fa".

### Assembly of qc reads with metaSPAdes
While Megahit is a fast assembler, metaSPAdes can provide longer contigs, but is much slower. Regardless of assembly method, the produced contig file (.fasta or .fa) can be used in the rest of the metagenomics pipeline.  Here is a metaSPAdes assembly example:  
```  
#assume you are in "assembly" directory  
#print metaspades version  
>metaspades.py -h  
#print metaspades usage message  
>metaspades.py -h  
#do the assembly using quality controlled reads  
>nohup metaspades.py -1 your_qc_R1_file -2 your_qc_R2_file -t 8 -m 100 -o metaspades_assembly  >& metaspades.log.txt&
```  
After finishing the assembly, we first check the "metaspades.log.txt" file to make sure no errors occurred during assembly
```
#check log file to make sure there are no errors occurred during the assembly
>more metaspades.log.txt  
```
After the successful assembly, your contig file is "metaspades_assembly/contigs.fasta". To know more about metaSPAdes output, please check its website. 

### Co-assembly
The process of assembling the quality controlled sequences from multiple samples togehter is called co-assembly
```
#assume you are in "assembly" directory
#megahit coassembly using quality controlled reads  
>nohup megahit -1 your_qc_R1_file1,your_qc_R1_file2,your_qc_R1_file3 -2 your_qc_R2_file,your_qc_R2_file2,your_qc_R3_file3 -t 8 -m 0.5 -o megahit_coassembly  >& megahit_coassembly.log.txt &
#do the assembly using quality controlled reads  
>nohup metaspades.py --pe1-1 your_qc_R1_file --pe2-1 your_qc_R1_file2 --pe3-1 your_qc_R1_file3  --pe1-2 your_qc_R1_file --pe2-2 your_qc_R1_file2 --pe3-2 your_qc_R1_file3  -t 8 -m 100 -o metaspades_coassembly  >& metaspades_coassembly.log.txt&
```
### Assembly statistics  
To assess the assembly, a tool from bbmap is used to generate summary statistics.
```
#go into directory  
cd megahit_assembly  

#run assembly statistics using BBmap stats tool  
stats.sh final.contigs.fa > assembly_stats.txt
```
