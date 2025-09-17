#!/usr/bin/env python3

#This script combines Instrain profile outputs and adds sample information as an identifier!

import pandas as pd
import os
import argparse
import glob

# Set up argument parsing
parser = argparse.ArgumentParser(description="Combine multiple TSV files and add identifier column.")
parser.add_argument('files', metavar='F', type=str, nargs='+', help="List of input files to combine")
parser.add_argument('output', type=str, help="Output file name")

args = parser.parse_args()

# Expand wildcards in file paths using glob
input_files = []
for pattern in args.files:
    input_files.extend(glob.glob(pattern))  # Use glob to expand the pattern

print("Combining the following files:")
for f in input_files:
    print(f)

# Empty list to store DataFrames
dfs = []

# Loop through each file and process it
for file in input_files:
	# Read the current file into a DataFrame
	df = pd.read_csv(file, sep='\t')  # Specify '\t' for TSV format

	# Extract identifier before the first underscore in the filename
	filename = os.path.basename(file)  # e.g. "sample_profile_SNVs.tsv"
	sample = filename.replace('_profile_SNVs.tsv', '')	

	# Add a new column for the identifier
	df['sample'] = sample

	# Reorder columns to make 'timepoint' the first column
	df = df[['sample'] + [col for col in df.columns if col != 'sample']]

	# Append the DataFrame to the list
	dfs.append(df)

# Concatenate all the DataFrames in the list
combined_df = pd.concat(dfs, ignore_index=True)

# Write the combined DataFrame to a new file
combined_df.to_csv(args.output, sep='\t', index=False)
