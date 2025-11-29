library(minfi)
library(limma)


args <- commandArgs(trailingOnly=TRUE)
bvals_file   <- args[1]
targets_file <- args[2]

# Read in data
bVals   <- readRDS(bvals_file)
targets <- read.csv(targets_file)

# Fix the factor for diagnosis
levels(targets$Group) <- c("NCBRS", "CONTROL")
Diagnosis <- factor(targets$Group)

# Covariates
Sex <- as.factor(targets$Sex)
Age <- as.numeric(targets$Age)

# Design matrix 
design <- model.matrix(~0 + Diagnosis + Sex + Age)

# Fit linear model
fit <- lmFit(bVals, design)

#Create a contrast matrix for specific comparisons
contMatrix <- makeContrasts(
    DiagnosisCONTROL - DiagnosisNCBRS,
    levels = design
)

#Fit the contrasts
fit2 <- contrasts.fit(fit, contMatrix)

#Rank the genes
fit2 <- eBayes(fit2)

#Get the table of top DMPs
DMPs <- topTable(fit2, number=Inf, coef=1)

write.csv(DMPs, "DMPs_results.csv", row.names=TRUE)
