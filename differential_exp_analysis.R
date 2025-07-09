library("DESeq2")
library("tidyverse")
library(ggplot2)
library(ggrepel)
library(dplyr)
library(repr)

#read in gene counts data file and metadata
counts <- read.csv("/Users/shrutishirsathe/Desktop/FINAL_B_H/IFN_Comparison/IFN/IFN_Weak_Strong/Strong.csv",sep=",",row.names="GENE")
metadata <- read.csv("/Users/shrutishirsathe/Desktop/FINAL_B_H/IFN_Comparison/IFN/IFN_Weak_Strong/Strong_Metada.csv", row.names=1)
metadata <- metadata[,c("Paper","Agent","CellType","TreatmentDetails","TreatmentSimplified")]

### Check that sample names match in both files
all(colnames(counts) %in% rownames(metadata))
all(rownames(metadata) %in% colnames(counts))
identical(colnames(counts), rownames(metadata))
all(colnames(counts) == rownames(metadata))

## Create DESeq2Dataset object
dds <- DESeqDataSetFromMatrix(countData = round(counts), colData = metadata, design = ~ TreatmentSimplified )

#Set baseline as the red variable (HUMAN, BAT, PIC, or LF)
dds$TreatmentSimplified <- relevel(dds$TreatmentSimplified, ref = "HUMAN")
dds$TreatmentSimplified <- droplevels(dds$TreatmentSimplified)

dds <- DESeq(dds)
#res <- results(dds)
resultsNames(dds)

res <- DESeq2::results(dds, contrast=c("TreatmentSimplified","BAT","HUMAN"))
write.table(res, file="/Users/shrutishirsathe/Desktop/FINAL_B_H/IFN_Comparison/IFN/IFN_Weak_Strong/DE_genes_Strong_new.txt", sep="\t", quote=F, col.names=NA)


head(res[order(res$padj),], 10)

summary(res)

#read in differentially expressed genes
de_genes <- read.csv("/Users/shrutishirsathe/Desktop/Grant_Figures/IFNA/IFNA_PLOT.csv")
gene_lists <- read.csv("/Users/shrutishirsathe/Desktop/Grant_Figures/IFNA/Gene_lists.csv")

de_genes$diffexpressed<-"X"

#de_genes$diffexpressed[de_genes$log2FoldChange>1 & de_genes$padj<0.001] <- "UPREGULATED"
#de_genes$diffexpressed[de_genes$log2FoldChange< -1 & de_genes$padj<0.001] <- "DOWNREGULATED"

#based on log2FC and p value criteria, add Group classification to diffexpressed column
de_genes$diffexpressed[de_genes$log2FoldChange>1 & de_genes$padj<0.001 & de_genes$Gene %in% gene_lists$Unique_genes_IFNA & de_genes$Gene %in% gene_lists$Common_genes] <- "Group3"
de_genes$diffexpressed[de_genes$log2FoldChange< -1 & de_genes$padj<0.001 & de_genes$Gene %in% gene_lists$Unique_genes_IFNA & de_genes$Gene %in% gene_lists$Common_genes] <- "Group4"
de_genes$delabel<-NA

#order data
de_genes <- de_genes[order(de_genes$diffexpressed, decreasing = TRUE),]

#volcano plot
ggplot(data=de_genes,aes(x=log2FoldChange,y=-log10(padj),col=diffexpressed,label=delabel))+
  geom_point(size=0.2)+
  theme_minimal()+
  geom_text_repel()+
  scale_color_manual(values=c('orange','seagreen','black'))+
  theme(text=element_text(size=10))+
  ggtitle("IFNA-stimulated Human vs. Bat")

ggsave(filename = "/Users/shrutishirsathe/Desktop/Grant_Figures/PIC/foo3.png",width = 20, height = 20, dpi = 300)

