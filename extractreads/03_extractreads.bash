#!/bin/bash

#SBATCH -p general
#SBATCH -N 1
#SBATCH --mem 48g
#SBATCH -n 16
#SBATCH -t 1-
#SBATCH --mail-type=fail
#SBATCH --mail-user=prisca@live.unc.edu

#This script extracts reads mapping to E.coli contigs and converts to FASTQ files

module load bowtie2
module load samtools 

sample=$1

input=mapping/$sample.sam
contigs=${sample}_Ecoli_Contigs.txt #file containing all the contig headers from the bin annotated as E.coli
output=${sample}_Ecoli.bam

echo Converting .sam file to .bam
samtools view -@ 16 -bS $input -o mapping/$sample.bam

echo Sort and index .bam file
samtools sort mapping/$sample.bam -o mapping/${sample}_sorted.bam
samtools index mapping/${sample}_sorted.bam

echo Filtering for Ecoli reads in $sample
samtools view -@ 16 -b mapping/${sample}_sorted.bam $(cat $contigs) -o $output

#writing reads to respective .fastq.gz files and discarding supplementary and secondary reads.
echo Converting to FASTQ
samtools fastq -@ 16 -n $output \
	-1 ${sample}_EcoliMAG_R1.fastq.gz -2 ${sample}_EcoliMAG_R2.fastq.gz \
	-s ${sample}_EcoliMAG_singleton.fastq.gz

#rm intermediate files once complete particularly .sam file
echo All done!
