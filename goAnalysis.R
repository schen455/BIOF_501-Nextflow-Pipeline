library(IlluminaHumanMethylationEPICv2anno.20a1.hg38)
library(org.Hs.eg.db)
library(GO.db)
library(missMethyl)
library(ggplot2)

args <- commandArgs(trailingOnly=TRUE)

dms_file <- args[1]

DMPs <- read.csv(dms_file, header = TRUE)
DMPs$CpG <- DMPs$X
SigDMP <- subset(DMPs, adj.P.Val < 0.05)

#Read in EPIC array annotation data
ann <- getAnnotation(IlluminaHumanMethylationEPICanno.ilm10b4.hg19)
ann <- as.data.frame(ann)
ann$CpG  <- rownames(ann)
DMS <- merge(DMPs, ann, by.x="CpG", by.y="row.names")


#Run GO enrichment analysis
go_analysis.all <- gometh(sig.cpg = SigDMP$CpG, all.cpg = DMPs$CpG, collection = 'GO', array.type = 'EPIC', prior.prob = TRUE)
orderedGOterms <- topGSA(go_analysis.all)
topGOterms <- topGSA(go_analysis.all, n=10) #this orders GO terms by p-value, same as ordering it by the p-value (for over-representation).
topGOterms
sigGenes <- getMappedEntrezIDs(sig.cpg = SigDMP$CpG)


#Plot top 10 significant GO terms
pdf('topGOterms.pdf')
ggplot(topGOterms, aes(x = reorder(TERM, P.DE), y = -log10(P.DE), size = DE)) +
  geom_point(color = "red") +
  coord_flip() +
  labs(
    title = "Top 10 significant GO Terms",
    x = "GO Term",
    y = "-log10(P-Value)",
    size = "Gene Count"
  )
dev.off()

write.csv(orderedGOterms, 'goTerms.csv')
