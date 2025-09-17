#!/bin/bash

#SBATCH -p general
#SBATCH -N 1
#SBATCH --mem 8g
#SBATCH -n 2
#SBATCH -t 1:00:00
#SBATCH --mail-type=fail
#SBATCH --mail-user=prisca@live.unc.edu

module purge
module load anaconda
conda_envs=/users/p/r/prisca/miniforge3/envs
conda activate "$conda_envs"/prodigal

input=$1
directory=$2
#directory=$(dirname $input)
sample=$(basename $input | sed 's/.fasta//')

prodigal -q -i $input -d $directory/$sample.genes.fna
