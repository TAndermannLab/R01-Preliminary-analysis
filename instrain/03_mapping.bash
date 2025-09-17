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

reference=$1 #unique prefix to identify reference
reads_dir=$2 #directory containing sequencing reads (isolates or extracted MAG reads)
mapping_dir=$3 #outputs


for file in $reads_dir/*_R1.fastq.gz;
do
	sample=$(basename $file | sed 's/_R1.fastq.gz//')
	R1=$(ls $file)
	R2=${R1//R1.fastq.gz/R2.fastq.gz}
	single=${R1//R1.fastq.gz/singleton.fastq.gz} 
	#only extracted MAG reads have singletons

	echo Mapping $sample with $R1 $R2
	bowtie2 -p 10 -x $mapping_dir/index/$reference -1 $R1 -2 $R2 -U $single -S $mapping_dir/$sample.sam

	samtools sort -m 5G -@ 2 -o $mapping_dir/$sample.sorted.bam $mapping_dir/$sample.sam
	samtools index $mapping_dir/$sample.sorted.bam

	#rm $mapping_dir/$sample.sam 
done

