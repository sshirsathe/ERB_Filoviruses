library(pheatmap)
library(dplyr)
library(conflicted)
library(sparrow)
library(RColorBrewer)
library(viridis)
library(grDevices)
options(digits=9)
library("DESeq2")
library("tidyverse")

#read in raw data
example_file <- read.csv(file="/Users/shrutishirsathe/Desktop/Proteomics_visusal_PIC_and_IFNA.csv", row.names=1, check.names=F, stringsAsFactors=F)
example_file

#convert to matrix
m <- as.matrix(example_file)

#set color range and palette
my_colors <- c(seq(-5,5,by=0.2),1000000000000000000)
my_palette <- c(colorRampPalette(colors = c("blue","white","red"))
                (n = length(my_colors)-2), "firebrick")

#create dataframe with specific set of proteins along with their 4 quadrant classification
annotdf <- data.frame(row.names = c("CASP1", "DHX58*", "IRF7", "IRF9", "UBA7", "DHX58* ", "MORC3", "JAK2* ", "TAP1", "TAP2", "DDX60* ", "RIGI", "IFIT2", "MX2", "CCL20", "CMPK2", "CASP8", "NOS3", "TOR3A", "ZBP1", "DDX60*", "STING1", "ISG20", "MX1", "JAK2*"), Quadrant = c(rep("BCL", 5), rep("BIH", 5), rep("HIH", 5), rep("HCL", 1), rep("BIH", 4), rep("HIH", 5)), Treatment = c(rep("PIC", 15), rep("IFNA", 10)))

#generate heatmap displaying groupings
pheatmap(m, cellwidth=30, 
         cellheight=13,
         na_col = "darkgrey",
         main = "",
         #border_color = NA,
         color = my_palette,
         #breaks = seq(-1, 5, length.out = 100),
         breaks = my_colors,
         cluster_rows=FALSE, 
         cluster_cols=FALSE,
         gaps_row = c(5,10,15,16, 20),
         annotation_row = annotdf,
         #anotation_col = annotcoldf,
         )

