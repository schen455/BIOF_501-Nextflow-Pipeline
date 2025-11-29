library(limma)
library(minfi)
library(IlluminaHumanMethylationEPICanno.ilm10b4.hg19)
library(IlluminaHumanMethylationEPICmanifest)
library(QCEWAS)

args <- commandArgs(TRUE)
sample_sheet <- args[1]
data_dir <- args[2]
cross_file <- args[3]


#1. Read in the sample sheet and the raw data
targets <- read.metharray.sheet(data_dir, pattern = basename(sample_sheet))
rgSet <- read.metharray.exp(targets = targets)
sampleNames(rgSet) <- targets$Sample_Name

detP <- detectionP(rgSet)

#2. Filter out poor quality reads
keep <- colMeans(detP) < 0.05
rgSet <- rgSet[,keep]


#3. Normalize the data using functional normalization
mSetSq <- preprocessQuantile(rgSet)

#4. Remove failed probes
detP <- detP[match(featureNames(mSetSq),rownames(detP)),]
keep <- rowSums(detP < 0.01) == ncol(mSetSq)
table(keep)
mSetSqFlt <- mSetSq[keep,]
mSetSqFlt

#5. Remove probes with SNPs at CpG site
mSetSqFlt <- dropLociWithSnps(mSetSqFlt) 

#6. Get methylation beta values
bVals <- getBeta(mSetSqFlt)

saveRDS(bVals, file = 'bVals.rds')
write.csv(targets, 'targets.csv', row.names = FALSE)
