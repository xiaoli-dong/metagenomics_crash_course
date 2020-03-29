# Metagenome binning
During the binning process, contigs originating from the same genome are grouped into bins. Each bin represents an individual population from a mixed microbial community. [MetaBat2](https://bitbucket.org/berkeleylab/metabat/src/master/) is an automated metagenome binning software, which integrates empirical probabilistic distances of genome abundance and tetranucleotide frequency.  

## Create binning directory
```
#make binning directory in your project directory
>mkdir binning
#move into binning directory
>cd binning
```
## Metagenome binning using MetaBAT
```
#print metabat2  metabat’s parameters
>metabat -h
#excute metabat program, for each input sample, please give a short unique id
>metabat -i your_contig_file_longer_than_500bp.fasta -a path_to_your_depth_file_generted_for_you_assemby_in_mapping_section/depth.txt -o your_sample_id.bin -t 8 -v >& your_sample_id.metabat.log.txt

#metabat will produce fasta format bin files in the "binning" directory and each bin file name will start with "your_sample_id.bin."
#list all the bin files
ls 
```
