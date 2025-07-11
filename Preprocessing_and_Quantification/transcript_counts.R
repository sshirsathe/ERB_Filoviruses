#Acknowledgements:
#This code uses combinations of ideas, techniques and code snippets
#from: Juan Angel Patiño-Galindo

library(dplyr) 
library(DESeq2)
library(edgeR)
library(tximport) 
library(readr)
library(rhdf5) 

dir <- system.file("extdata", package = "tximportData")

samples <- read.csv("/sc/arion/projects/BAT-NATIVE/SRR_Data/Lee_2015_Metadata.csv", header=TRUE,stringsAsFactors=F,row.names=1)

setwd("/sc/arion/projects/BAT-NATIVE/SRR_Data")
files <- paste("outputs",list.files(path = "outputs",pattern = "abundance.tsv", recursive = TRUE),sep = "/")
names(files) <- samples$Run

tx2gene <- read.csv("/sc/arion/projects/BAT-NATIVE/SRR_Data/tx2gene.csv")

# import kalisto transcript counts to geneLevels
txi.kallisto.tsv <- tximport(files, type = "kallisto", tx2gene = tx2gene, ignoreAfterBar = TRUE)

#convert transcript to gene in labels from tx2gene.csv file
idx <- rownames(txi.kallisto.tsv$counts) %in% tx2gene[,1]
txi.sub <- txi.kallisto.tsv
for (mat in c("abundance","counts","length")) {
  txi.sub[[mat]] <- txi.kallisto.tsv[[mat]][idx,]
}
txi.sub

df <- data.frame(
  gene_counts = txi.kallisto.tsv$counts
)

df2 <- data.frame(sub("\\_.*", "", basename(files)))

colnames(df) <- df2$sub...._.........basename.files..

write.csv(df, "/sc/arion/projects/BAT-NATIVE/SRR_Data/Lee_2015_combined_fastqs.csv", row.names=TRUE)
