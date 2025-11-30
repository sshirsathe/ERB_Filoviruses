# Species-specific antiviral programs drive immunity to Marburg virus in Egyptian rousette bats and humans
Pastor, AF<sup>1</sup>; Shirsathe, S.<sup>1</sup>; Somavarapu, R<sup>1</sup>; Vidal, S.<sup>1</sup>; Ferressini-Gerpe, N.M<sup>1</sup>; Schneor, L.<sup>2</sup>; Friedman, S.<sup>2</sup>, Barrall, E<sup>1</sup>, Siu, T<sup>1,3</sup>; Giannetti, E.<sup>1</sup>; Tagliavia, M.<sup>1</sup>; Patiño, J.<sup>1</sup>; Heng, P<sup>1</sup>.; Guito, J<sup>4</sup>.;  Garcia-Sastre, A.<sup>1,5</sup>; Kuhn, J. <sup>6</sup>; Rosenberg, B. <sup>1</sup>, M; Towner J.<sup>4,7</sup>;, Kepler<sup>8</sup>, T; Johnson, J. R<sup>1</sup>; Hagai, T.<sup>2</sup>, Sanchez-Lockhart<sup>9</sup>, Palacios, G<sup>1, 5</sup>.
## Overview
This directory contains scripts used to perform the bioinformatic methods described in this work:
1. Process Bulk RNA Seq NCBI samples given by SRR number and map to reference transcriptome
2. Quantify abundances of genes of interest and generate a count matrix
3. Normalize and scale the count matrix
4. Extract orthologous genes between samples for downstream comparative analysis
5. Perform differential expression analysis between groupings
6. Generate gene expression heatmaps volcano plots

Bulk RNA Seq processing, abundance quantification and count matrix generation are performed in a Minerva high performance computing cluster while normalization and procedures following are performed locally in python and R.

### Directory Structure
This project is organized into the following directories:

**Preprocessing_and_Quantification** : contains .sh scripts used to complete steps 1 and 2

**Local_Scripts** : contains .py and .R files used to complete steps 3-5

**Figures** : contains scripts used in figure generation

Note: The reference transcriptome utilized for transcript mapping is a modified version of Raegyp2.0 containing 5 IFNW genes representative of the original 22. This collapsing procedure is performed in Preprocessing_and_Quantification/collapse_IFNW.py

## References
*Kovatch P, Gai L, Cho HM, Fluder E, Jiang D. Optimizing High-Performance Computing Systems for Biomedical Workloads. IEEE Int Symp Parallel Distrib Process Workshops Phd Forum. 2020 May;2020:183-192. doi: 10.1109/ipdpsw50202.2020.00040. Epub 2020 Jul 28. PMID: 33088611; PMCID: PMC7575271*

*Love MI, Huber W, Anders S (2014). “Moderated estimation of fold change and dispersion for RNA-seq data with DESeq2.” Genome Biology, 15, 550. doi:10.1186/s13059-014-0550-8*



