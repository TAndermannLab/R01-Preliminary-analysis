# R01-Preliminary-analysis
From Tolerance to Resistance: Adaptive Pathways of Enterobacterales Persistence in the gut Under Antibiotic Pressure

## Sample overview
16 stool samples spanning 6 patients were selected based on the relative abundance of E.coli observed through metagenomic sequencing.
E.coli strains were isolated from the stool by streaking them on selective media. These strains were tested for tolerance against meropenem using a time-kill curve and sequenced.
From these samples, 18 isolates are included in this analyses.

Stool sequences were assembled and binned to obtained metagenome assemblies (MAGs), which were annotated with GTDBtk. E.coli MAGs were retrieved from 13 of the stool sequencing, ranging from 23.11-99.97% completeness and 0.09-40.12% contamination

Summary of samples, isolates and MAGs:
| Sample	    | # Isolates	| E.coli MAG obtained? |	Completeness (%)	| Contamination (%) |
| ----------| ----------- | ------------- | ------------- | ------------- |
| 1801.21 PCON| 2  | No	 |  -  |   -   |
| 1801.21 D56	| 1	 |  No	 |  -  |   -   |
| 1801.21 D70	| 1	| Yes|	99.7|	3.83 |
|1801.21 D98	| 1|	Yes|	98.78|	0.09 |
|1801.21 D180|	2	|Yes	|91.48	|1.45|
|1801.21 D270|	1	|Yes|	99.93|	0.12|
| BMT116 D-3	|2  |  No	 |  -  |   -   |
|BMT116 D1	|2	|Yes|	99.97	|0.71|
|BMT119 D-7	|2	|Yes	|23.11|	0.16|
|BMT119 D1	|2	|Yes	|93.04	|3.28|
|BMT126 D-12	|2	|Yes	|99.93	|9.43|
|BMT126 D1|	2	| Yes	|97.89|	1.34|
|BMT127 D-13|	2	|Yes	|52.37|	1.68|
|BMT127 D1	|2	|Yes	|99.97	|1.87|
|BMT108 D-33|	2	|Yes|	94.5	|13.54|
|BMT108 D0	| 2	|Yes	|90.46	|40.12|

## Extracting E.coli reads from stool seqeunces
Processed reads were mapped to their respective binned MAGs. Reads that mapped to bins annotated as E.coli were extracted
> Insert relevant script link/description

## Instrain profile
[Instrain](https://instrain.readthedocs.io/en/latest/) was utilized to profile samples and identify SNVs in genes of interest.
For all samples, an isolate obtained from BMT116 D-3 was selected as the reference as it exhibited low tolerance and had the best assembly quality.
-  Isolate reads and extracted stool reads were mapped to this reference
-  Reference genes were predicted using Prodigal and annotated using Bakta
-  Mapping files, reference assembly and gene files were profiled using Instrain
-  Instrain SNVs.tsv output file for each profile annotated using the Bakta results. Only non-synonymous SNVs were considered.

The exact analysis was performed on the 1801.21 subset to identify if similar trends could be observed within a single patient. For this subset, an isolate from 1801.21 D56 was used as the reference as it exhibited low tolerance and had the best assembly quality.

## Instrain compare
All Instrain profiles (using BMT116 D-3 as reference) were compared using Instrain compare. This calculates popANI between samples and allows us to determine if the MAGs represent the isolates well. For isolate-MAG pairs from the same sample, popANI was summarized at both the [25% and 50% percent_genome_compared thresholds](https://instrain.readthedocs.io/en/latest/important_concepts.html#thresholds-for-determining-same-vs-different-strains)

