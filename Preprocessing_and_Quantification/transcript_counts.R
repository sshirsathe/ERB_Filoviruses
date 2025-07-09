library(dplyr) # data wrangling
library(ggplot2) # plotting
library(DESeq2) # rna-seq
library(edgeR) # rna-seq
library(tximport) # importing kalisto transcript counts to geneLevels
library(readr) # Fast readr of files.
library(rhdf5) # read/convert kalisto output files.

dir <- system.file("extdata", package = "tximportData")
#dir

#                                                           ****************************
samples <- read.csv("/sc/arion/projects/BAT-NATIVE/SRR_Data/Schneor_2023_metadata.csv", header=TRUE,stringsAsFactors=F,row.names=1)
samples

setwd("/sc/arion/projects/BAT-NATIVE/SRR_Data")
files <- paste("outputs",list.files(path = "outputs",pattern = "abundance.tsv", recursive = TRUE),sep = "/")
names(files) <- samples$Run
files

tx2gene <- read.csv("/sc/arion/projects/BAT-NATIVE/SRR_Data/tx2gene.csv")
#                                                         *****************

txi.kallisto.tsv <- tximport(files, type = "kallisto", tx2gene = tx2gene, ignoreAfterBar = TRUE)

df <- data.frame(
  gene_counts = txi.kallisto.tsv$counts
)
#df

df2 <- data.frame(sub("\\_.*", "", basename(files)))

df2

#colnames(df2)

colnames(df) <- df2$sub...._.........basename.files..

#                                                           *                            *******************************************************
write.csv(df,"/sc/arion/projects/BAT-NATIVE/SRR_Data/Final_Gene_Counts_Tables_All_Papers/Schneor_2023_gene_counts_collapsed_IFNW_FINAL_ALL_60.csv", row.names=TRUE)
