nstall.packages("BiocManager")
BiocManager::install("DESeq2", version = "3.20")

library(DESeq2)

# ==== 1. Read featureCounts data ====
# Adjust the path if needed
counts_file <- "counts.txt"

# Read file, skipping comment lines and using gene IDs as row names
raw_counts <- read.table(counts_file, header = TRUE, sep = "\t", comment.char = "#", row.names = 1)

# Keep only count columns (assuming the last 6 columns are counts)
count_data <- raw_counts[ ,6:ncol(raw_counts)]
# Check the first few rows
print("Preview of count data:")
print(head(count_data))
# ==== 2. Define sample metadata ====
# Replace column names if needed
colnames(count_data) <- c("control_1", "control_2", "control_3", "heat_1", "heat_2", "heat_3")

sample_info <- data.frame(
  row.names = colnames(count_data),
  condition = factor(c("control", "control", "control", "heat", "heat", "heat"))
)

# ==== 3. Create DESeq2 object ====
dds <- DESeqDataSetFromMatrix(
  countData = count_data,
  colData = sample_info,
  design = ~ condition
)

# Optional: filter low-count genes
dds <- dds[ rowSums(counts(dds)) > 10, ]

# ==== 4. Run DESeq2 analysis ====
dds <- DESeq(dds)
res <- results(dds)

# ==== 5. Summary and export ====
summary(res)

# Order by adjusted p-value and save to CSV
res_ordered <- res[order(res$padj), ]
write.csv(as.data.frame(res_ordered), file = "deseq2_results.csv")

# ==== 6. Plots ====
# MA plot
pdf("MA_plot.pdf")
plotMA(res, ylim=c(-5,5))
dev.off()

# PCA plot
vsd <- vst(dds, blind=FALSE)
pdf("PCA_plot.pdf")
plotPCA(vsd, intgroup="condition")
dev.off()

# Convert to data frame and add gene names
res_df <- as.data.frame(res)
res_df$gene <- rownames(res_df)

# Clean gene names
res_df$gene <- sub("^file_1_file_1_", "", res_df$gene)

# Add significance classification
res_df$significance <- "Not Significant"
res_df$significance[res_df$padj < 0.05 & res_df$log2FoldChange > 1] <- "Upregulated"
res_df$significance[res_df$padj < 0.05 & res_df$log2FoldChange < -1] <- "Downregulated"

# Install ggplot2 if not already installed
if (!requireNamespace("ggplot2", quietly = TRUE)) {
  install.packages("ggplot2")
}
if (!requireNamespace("ggrepel", quietly = TRUE)) install.packages("ggrepel")

library(ggplot2)
library(ggrepel)

# Select genes to label (top 10 most significant)
label_genes <- res_df[res_df$padj < 0.05 & abs(res_df$log2FoldChange) > 1, ]
label_genes <- label_genes[order(label_genes$padj), ][1:20, ]  # top 10 by significance
label_genes <- subset(label_genes, significance != "Not Significant")

# Volcano Plot
pdf("Volcano_plot_labeled.pdf")
ggplot(res_df, aes(x = log2FoldChange, y = -log10(padj), color = significance)) +
  geom_point(alpha = 0.8, size = 1.5) +
  scale_color_manual(values = c("Downregulated" = "blue", "Upregulated" = "red", "Not Significant" = "grey")) +
  geom_vline(xintercept = c(-1, 1), linetype = "dashed", color = "black") +
  geom_hline(yintercept = -log10(0.05), linetype = "dashed", color = "black") +
  geom_text_repel(data = label_genes, aes(label = gene), size = 3, max.overlaps = 20) +
  labs(title = "Volcano Plot with Gene Labels", x = "Log2 Fold Change", y = "-Log10 Adjusted p-value") +
  theme_minimal()
dev.off()

#===7. List of significant up and down regulated genes ===

# Filter significant genes (adjusted p-value < 0.05)
sig_genes <- subset(res, padj < 0.05)

# Upregulated genes (log2FoldChange > 0)
up_genes <- subset(sig_genes, log2FoldChange > 0)
up_gene_list <- rownames(up_genes)
up_gene_list <- sub("^file_1_file_1_", "", up_gene_list)
writeLines(up_gene_list, "DEGs_upregulated.txt")
# Downregulated genes (log2FoldChange < 0)
down_genes <- subset(sig_genes, log2FoldChange < 0)
down_gene_list <- rownames(down_genes)
down_gene_list <- sub("^file_1_file_1_", "", down_gene_list)
writeLines(down_gene_list, "DEGs_downregulated.txt")

cat("Upregulated genes:", length(up_gene_list), "\n")
cat("Downregulated genes:", length(down_gene_list), "\n")


cat("DESeq2 analysis completed. Results saved to 'deseq2_results.csv'.\n")

