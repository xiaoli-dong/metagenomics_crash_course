# Metagenome assembly
Genome assembly is the process that reconstructs genomes from short reads. There are a number of metagenome assemblers widely used for Illumina sequences such as IDBA, SOAPDenovo2, MegaHit, and metaSPAdes. The following are examples on how to use MegaHit and metaSPAdes to do the assembly. Detailed tutorials are available from their website:

If you have multiple samples that you would like to co-assemble, concatenate the qc read files into one file for forward (R1) and one for reverse (R2).

'''

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

'''
## Assembly of qc reads with Megahit
'''
#move up a directory  
cd ..  
#make an assembly directory  
mkdir assembly  
#cd into assembly directory  
cd assembly/  
#access megahit parameters  
megahit -h  
#do the assembly using quality controlled reads  
megahit -1 ../qc/coassembly.R1.fastq -2 ../qc/coassembly.R2.fastq -t 8 -m 0.5 -o megahit_assembly  
#filter out contigs shorter than 500 bp  
filterContigByLength.pl contigs.fasta 500 > contigs.500.fasta
'''  
While Megahit is a fast assembler, metaSPAdes can provide longer contigs, but is much slower. Regardless of assembly method, the produced contig file (.fasta or .fa) can be used in the rest of the metagenomics pipeline.  
Here is an optional assembly with metaspades
'''  
#access metaspades parameters  
metaspades.py -h  
#do the assembly using quality controlled reads  
metaspades.py -1 ../qc/coassembly.R1.fastq -2 ../qc/coassembly.R2.fastq -t 8 -o metaspades_out  
#filter out contigs shorter than 500 bp  
filterContigByLength.pl contigs.fasta 500 > contigs.500.fasta  
'''  
To assess the assembly, a tool from bbmap is used to generate summary statistics.
'''
#go into directory  
cd megahit_assembly  

#run assembly statistics using BBmap stats tool  
stats.sh final.contigs.fa > assembly_stats.txt
'''
