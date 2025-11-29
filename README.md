# BIOF_501-Nextflow-Pipeline
## **By Steven Chen**
--- 
## Pipeline Overview
--- 
This pipeline takes raw methylation .IDAT files from Illumina EPIC/EPICv2 array data using a comprehensive Nextflow workflow. Preprocessing, differential methylation probe (DMP) identification, and gene ontology (GO) enrichment analysis steps are performed using R packages to create an end-to-end analysis pipeline. 

## Background
---
Analyzing the human epigenome can reveal key factors and drivers of human health and disease. One integral component of epigenetic analysis is the investigation of methylation data. DNA methylation is the addition of methyl groups to nucleotides (most often cysteine), leading to downstream regulatory effects on gene expression. Increased methylation (hypermethylation) has been associated with many diseases

An automated workflow/pipeline such as this one is necessary for the development of the field. Given the prevalence of bioinformatics packages across various languages, there are a plethora of different ways that raw methylation data could be analyzed. However, many individuals may not be well-versed or trained in bioinformatics, highlighting a need for an easily accessible, reproducible pipeline such as this. Moreover, reproducibility is a huge issue in scientific research, leading to many false and inflated results being published [1]. Thus, new pipelines such as this one must be created to ensure reproducibility and accessibility within the bioinformatics community, promoting best-practice for future research and fostering collaboration between members across scientific disciplines.


## Workflow Summary
---
1. **Preprocessing** \
a. *Filtering reads* - removing any poor quality reads (p < 0.05) \
b. *Normalization* - using quantile normalization \
c. *Failed probe removal* - some probes may have failed during sequencing, detect and remove these probes \
d. *SNP probe removals* - remove any probes with single nucleotide polymorphisms (SNPs) at the respective CpG site \
e. *Generate beta values* - generate methylation beta-values, which quantify the degree of hyper-methylation (>0) or hypo-methylation (<0) \


## References
---
[1] Ioannidis, J. P. A. (2022). Correction: Why Most Published Research Findings Are False. PLoS Med, 19(8), e1004085. https://doi.org/10.1371/journal.pmed.1004085
