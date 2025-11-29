# BIOF_501-Nextflow-Pipeline
Nextflow pipeline to analyze ASV count data from microbial samples. This is for the term project for the BIOF_501 course.



# Workflow Summary
---
1. **Preprocessing** \
a. **Filtering reads** - removing any poor quality reads (p < 0.05)
b. **Normalization** - using quantile normalization
c. **Failed probe removal** - some probes may have failed during sequencing, detect and remove these probes
d. **SNP probe removals** - remove any probes with single nucleotide polymorphisms (SNPs) at the respective CpG site 
e. **Generate beta values** - generate methylation beta-values, which quantify the degree of hyper-methylation (>0) or hypo-methylation (<0)
