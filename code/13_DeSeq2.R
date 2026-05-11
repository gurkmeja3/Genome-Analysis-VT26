# Install BiocManager if not present
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

# Install DESeq2 and EnhancedVolcano (once)
BiocManager::install("DESeq2")
BiocManager::install("EnhancedVolcano")

# Load library 
library(DESeq2)
library(EnhancedVolcano)

countData <- read.table("counts_table.txt", header = TRUE, row.names = 1)
countData <- countData[, 6:ncol(countData)] 

colnames(countData) <- c("Control_1", "Control_2", "Control_3", "Heat_1", "Heat_2", "Heat_3") 
colData <- data.frame(heat_stress = factor(c("Control", "Control", "Control", "Heat", "Heat", "Heat")), 
                      row.names = colnames(countData))

dds <- DESeqDataSetFromMatrix(countData = countData,
                              colData = colData,
                              design = ~ heat_stress)

dds <- DESeq(dds)
res <- results(dds, contrast=c("heat_stress", "Heat", "Control"))



