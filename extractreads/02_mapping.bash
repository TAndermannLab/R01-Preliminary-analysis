#!/bin/bash

#SBATCH -p general
#SBATCH -N 1
#SBATCH --mem 64g
#SBATCH -n 24
#SBATCH -t 1-
#SBATCH --mail-type=fail
#SBATCH --mail-user=prisca@live.unc.edu

module purge #removes any loaded modules
module load bowtie2
module load samtools

sample=$1
reads_dir=$2 #directory containing hostremoved reads per sample
mapping_dir=. #directory containing Instrain inputs

mkdir -p $mapping_dir/indexes

#All bins from a sample are concatenated into one file ${sample}.fasta
bowtie2-build $mapping_dir/concatbins/${sample}.fasta $mapping_dir/indexes/$sample.fasta.bt2 --threads 20 --quiet

mkdir -p $mapping_dir/mapping

for file in $reads_dir/"$sample"*R1.fastq.gz;
do
	R1=$(ls $file)
	R2=${R1//R1.fastq.gz/R2.fastq.gz}

	echo Mapping $sample with $R1 $R2
	bowtie2 -p 10 -x $mapping_dir/indexes/$sample.fasta.bt2 -1 $R1 -2 $R2 -S $mapping_dir/mapping/$sample.sam

	#samtools sort -m 5G -@ 2 -o $mapping_dir/mapping/$sample.sorted.bam $mapping_dir/mapping/$sample.sam
	#samtools index $mapping_dir/mapping/$sample.sorted.bam

	#rm $mapping_dir/mapping/$sample.sam 

done

