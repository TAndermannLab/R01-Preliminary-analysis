#!/bin/bash

#SBATCH -p general
#SBATCH -N 1
#SBATCH --mem 16g
#SBATCH -n 8
#SBATCH -t 1:00:00
#SBATCH --mail-type=fail
#SBATCH --mail-user=prisca@live.unc.edu

module purge
module load anaconda
conda_envs=/users/p/r/prisca/miniconda3/envs
conda activate "$conda_envs"/bakta

input=$1 
directory=$(dirname $input)
sample=$(basename $input | sed 's/.genes.fna//')

bakta  --db "$conda_envs"/bakta/db --output $directory/"$sample"_bakta -f \
	--prefix $sample --keep-contig-headers --threads 8 $input
