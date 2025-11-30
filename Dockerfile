FROM bioconductor/bioconductor_docker:RELEASE_3_22

RUN R -e "BiocManager::install(c( \
    'limma', \
    'minfi', \
    'missMethyl', \
    'IlluminaHumanMethylationEPICanno.ilm10b4.hg19', \
    'IlluminaHumanMethylationEPICv2anno.20a1.hg38', \
    'IlluminaHumanMethylationEPICmanifest', \
    'org.Hs.eg.db', \
    'FlowSorted.Blood.EPIC', \
    'GO.db' \
))"

RUN R -e "install.packages(c('tidyverse','data.table','ggplot2','stringr','optparse'))"