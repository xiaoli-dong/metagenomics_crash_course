# Assembly Comparison
There are many assemblers available. Some assemblers work better for some datasets, and others work better for others. Choosing the “best” assembly is not straightforward and it can depend on what you’re doing. You can try several well-known assemblers (metaSPAdes, Megahit, idba-ud et.al.) and compare them with QUAST (for individual genome assembly) or MetaQUAST (for metagenome assemblies). 
```
>path_to_your_quast_program/metaquast.py --mgm -o metaquast --bam read_to_first_assemby.bam,read_to_second_assemby.bam,read_to_third_assemby.bam first_assembly.fasta second_assembly.fasta third_assembly.fasta
```
