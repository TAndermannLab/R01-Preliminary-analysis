#!/bin/bash

#SBATCH -p general
#SBATCH -N 1
#SBATCH --mem 2g
#SBATCH -n 8
#SBATCH -t 1-
#SBATCH --mail-type=fail
#SBATCH --mail-user=prisca@live.unc.edu

# First, check the GTDB-tk output to ID genomes classified as E.coli. Currently, I am doing this manually, but the aim is to automate this process in the future.  

# parse_stb.py script comes from dRep, so let's load our conda environment
module load anaconda

conda_envs=/users/p/r/prisca/miniconda3/envs
conda activate "$conda_envs"/drep

sample=$1
allbins=$2 #directory containing all bins for sample 
mags=$3 #directory to output concatenated bin  & stb files 

# Generate scaffolds to bin file
echo Generating scaffold to bin for $sample
parse_stb.py --reverse -f $allbins/${sample}_*.fa -o $mags/$sample.stb

# Concatenate all bins into one .fasta file
echo Concatenating bins for $sample
cat $allbins/${sample}_*.fa > $mags/$sample.fasta
