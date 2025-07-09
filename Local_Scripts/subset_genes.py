import pandas as pd 
import csv

#Replace the genes variable with the list of orthologous genes
genes = [""]

reader = pd.read_csv('/path/to/Original_Dataset/normalized_ERB_by_paper_clades.csv',sep=',')
first_cols = pd.read_csv('/path/to/Original_Dataset/normalized_ERB_by_paper_clades.csv', sep=',', header=0, usecols=[0])
df = pd.DataFrame()

# loop that filters the list of genes from the input data to contain those in the genes variable

for gene in genes:  
    if (gene in list(first_cols["Unnamed: 0"])):
        ind = (list(first_cols["Unnamed: 0"])).index(gene)
        df = pd.concat([df, pd.DataFrame(reader.iloc[[ind]])], ignore_index=True)

df.to_csv("path/to/filtered_ERB_all_genes.csv", sep=',')
