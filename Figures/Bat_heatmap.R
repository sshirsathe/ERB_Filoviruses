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

#read in log 10 transforemd data
my_data1 <- read_csv("/Users/shrutishirsathe/Desktop/FINAL_B_H/IFN_Comparison/IFN/IFNA/Without_outliers/Group4.csv", col_types = cols())

#scale data and save to csv
s0 <- scale_rows(my_data1[-1:-1], center = FALSE, scale = TRUE)
write.csv(s0, "/Users/shrutishirsathe/Desktop/FINAL_B_H/IFN_Comparison/IFN/IFNA/Without_outliers/SCALED_Group4.csv", row.names=FALSE)

#read in scaled data and modify to include Gene names 
my_data2 <- read_csv("/Users/shrutishirsathe/Desktop/FINAL_B_H/IFN_Comparison/IFN/IFNA/Without_outliers/SCALED_Group4.csv", col_types = cols())
my_data2 <- cbind(my_data2, my_data1$Gene)
my_data2 = my_data2 %>% dplyr::select("my_data1$Gene", everything())
my_data2 <- my_data2 %>% 
  mutate_at(c(2:10), as.numeric)

#save data under matrix
m <- as.matrix(my_data2[, -1])
colnames(my_data2)[1] <- "Gene"
write.csv(my_data2, "/Users/shrutishirsathe/Desktop/FINAL_B_H/IFN_Comparison/IFN/IFNA/Without_outliers/SCALED_Group4.csv", row.names=FALSE)

#set rownames of matrix as gene names and find maximum value to set for quantile
rownames(m) <- my_data1$Gene
rg <- max((m))

#generate 99% quantile value of data and set this as the cap for the color range in the heatmap
quantile(m, 0.999)

#generate heatmap clustered by data columns and quantile value set as the cap for the color range
my_heatmap <- pheatmap(
  m, cluster_rows = T, Rowv=NA,clustering_distance_rows = "euclidean",
  clustering_distance_cols = "euclidean",
  Colv=as.dendrogram(hclust(dist(t(m)))),
  breaks = seq(0, 1.97   , length.out = 100),
  #color = myColor
)


save_pheatmap_png <- function(x, filename, width=9000, height=9000, res = 150) {
  png(filename, width = width, height = height, res = res)
  grid::grid.newpage()
  grid::grid.draw(x$gtable)
  dev.off()
}
#save_pheatmap_png(my_heatmap, "/Users/shrutishirsathe/Desktop/FINAL_B_H/IFN_Comparison/IFN/IFNA/Without_outliers/Group4.png")

