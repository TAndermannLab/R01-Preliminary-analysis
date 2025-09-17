#!/bin/bash

#This script adds gene annotations to combined snv output based on Bakta results 

BAKTA_FILE=$1 #Bakta .tsv output
SNV_FILE=$2 #combined SNVs.tsv file
OUTPUT_FILE=$3

awk -v bakta_file="$BAKTA_FILE" '
    BEGIN { FS=OFS="\t" }

    # Load Bakta file
    FILENAME == bakta_file {
        if ($1 == "#Sequence Id") {
            for (i=1; i<=NF; i++) {
                if ($i == "#Sequence Id") seqid_col = i
                if ($i == "Gene") gene_col = i
            }
            next
        }
        bakta[$seqid_col] = $gene_col
        next
    }

    # Process SNV file
    FNR==1 {
        for (i=1; i<=NF; i++) {
            if ($i == "gene") gene_col_snv = i
        }
        print $0, "gene_name"
        next
    }

    {
        gene_id = $gene_col_snv
        gene_name = (gene_id in bakta) ? bakta[gene_id] : ""
        print $0, gene_name
    }

' "$BAKTA_FILE" "$SNV_FILE" > "$OUTPUT_FILE"
