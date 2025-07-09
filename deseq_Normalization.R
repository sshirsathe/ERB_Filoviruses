library("DESeq2")
library("tidyverse")
library("airway2")

#read in gene counts data file and metadata
data <- as.matrix(read.csv("/Users/shrutishirsathe/Desktop/Orthologs_Speranza.csv",sep=",",row.names="Gene"))
meta <- read.csv("/Users/shrutishirsathe/Desktop/Speranza_2018_Metadata.csv", row.names=1)
meta <- meta[,c("Paper","Agent","CellType","TreatmentDetails","TreatmentSimplified")]

### Check that sample names match in both files
all(colnames(data) %in% rownames(meta))
all(rownames(meta) %in% colnames(data))
identical(colnames(data), rownames(meta))
all(colnames(data) == rownames(meta))

## Create DESeq2Dataset object
dds <- DESeqDataSetFromMatrix(countData = round(data), colData = meta, design = ~ Paper)
dds <- estimateSizeFactors(dds)
sizeFactors(dds)

normalized_counts <- counts(dds, normalized=TRUE)
normalized_counts

write.table(normalized_counts, file="/Users/shrutishirsathe/Desktop//NORMALIZED_Speranza_2018.csv", sep="\t", quote=F, col.names=NA)
#CONVERT THIS TO CSV


