#!/bin/bash
#$ -N rename
#$ -q bio
#$ -m beas


## Taking all the data in the Bioinformatics_Course/ and reorganizing it 
## Making the directories for the samples

cd /dfs3/pub/rhoadesn/Bioinformatics_Course
for sample in {4,5,6,7};do
mkdir -p sample_A"$sample"/{DNA,ATAC}
done

cd ATACseq/
## Rename in the ATAC folder
## Read 1
for i in $(ls *R1.fq.gz); do 
mv $i $(grep $(echo $i | cut -d'_' -f5) README.ATACseq.txt | awk '{print $2"_"$4"_"$3"_""R1"".fq.gz"}'); 
done

## Read 2
for i in $(ls *R2.fq.gz); do 
mv $i $(grep $(echo $i | cut -d'_' -f5) README.ATACseq.txt | awk '{print $2"_"$4"_"$3"_""R2"".fq.gz"}'); 
done

## move ATAC samples to their sample specific folder
for i in $(ls A*_*_*_*.fq.gz); do 
g=$(echo $i | cut -d'_' -f1); 
mv $i /dfs3/pub/rhoadesn/Bioinformatics_Course/sample_"$g"/ATAC/"$i"; 
done

## DNAseq
cd /dfs3/pub/rhoadesn/Bioinformatics_Course/DNAseq


## subsample reads tp 50,000...to play around with

for f in *.fq.gz; do
j=$(basename "$f" .fq.gz);
gunzip -c "$f" | head -200000 | gzip -c > "$j".sub.fq.gz
done

## move the DNA samples to their sample specific folder
mv ADL06*.gz /dfs3/pub/rhoadesn/Bioinformatics_Course/sample_A4/DNA/
mv ADL09*.gz /dfs3/pub/rhoadesn/Bioinformatics_Course/sample_A5/DNA/
mv ADL10*.gz /dfs3/pub/rhoadesn/Bioinformatics_Course/sample_A6/DNA/
mv ADL14*.gz /dfs3/pub/rhoadesn/Bioinformatics_Course/sample_A7/DNA/
