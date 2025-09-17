#!/bin/bash

#SBATCH -p general
#SBATCH --job-name=instrainprofile
#SBATCH -N 1
#SBATCH --mem 32g
#SBATCH -n 16
#SBATCH -t 1-
#SBATCH -o %x.%j.out
#SBATCH --mail-type=fail,end
#SBATCH --mail-user=prisca@live.unc.edu

# This script utilizes InStrain to profile and compare strain-level microdiversity between samples

module purge
module load anaconda
module load samtools 

conda_envs=/users/p/r/prisca/miniconda3/envs
conda activate "$conda_envs"/instrain

ref_dir=$1 #directory containing reference fasta, predicted genes file and Bakta output
ref_id=$2 #unique reference prefix
fasta=$ref_dir/${ref_id}.fasta
genes=$ref_dir/${ref_id}.genes.fna  
mapping=$ref_dir/mapping #directory containing .bam files from 03_mapping
results=$ref_dir/results

mkdir -p $results

for file in $mapping/*.sorted.bam 
do
	sample=$(basename $file | sed 's/.sorted.bam//')
	if [[ -e "$results/"$sample"_profile" ]]; then
		echo inStrain profile on $sample already ran
	else
		echo running inStrain profile on $sample 

		inStrain profile $file $fasta -g $genes -o $results/"$sample"_profile \
			-p 16 --skip_mm_profiling --pairing_filter non_discordant 
	fi
done
