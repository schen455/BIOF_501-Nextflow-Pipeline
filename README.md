# BIOF_501-Nextflow-Pipeline
## **By Steven Chen**
--- 
## Pipeline Overview
--- 
This pipeline takes raw methylation .IDAT files from Illumina EPIC/EPICv2 array data using a comprehensive Nextflow workflow. Preprocessing, differential methylation probe (DMP) identification, and gene ontology (GO) enrichment analysis steps are performed using R packages to create an end-to-end analysis pipeline. 



## Workflow Summary
---
1. **Preprocessing** \
a. *Filtering reads* - removing any poor quality reads (p < 0.05) \
b. *Normalization* - using quantile normalization \
c. *Failed probe removal* - some probes may have failed during sequencing, detect and remove these probes \
d. *SNP probe removals* - remove any probes with single nucleotide polymorphisms (SNPs) at the respective CpG site \
e. *Generate beta values* - generate methylation beta-values, which quantify the degree of hyper-methylation (>0) or hypo-methylation (<0) \
