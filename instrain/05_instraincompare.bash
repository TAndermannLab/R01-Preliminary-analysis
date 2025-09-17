#!/bin/bash

#SBATCH -p general
#SBATCH --job-name=instraincompare
#SBATCH -N 1
#SBATCH --mem 80g
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

results_dir=$1 #directory for instrain results
ref_id=$2 #unique reference prefix

inStrain compare -i $results_dir/*_profile -o $results_dir/${ref_id}_instrain_compare -p 16

inStrain genome_wide -i $results_dir/${ref_id}_instrain_compare -p 16
