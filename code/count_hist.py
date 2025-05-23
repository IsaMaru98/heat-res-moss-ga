import pandas as pd
import matplotlib.pyplot as plt

# Load the counts file (skip comment lines)
counts_df = pd.read_csv("counts.txt", sep="\t", comment="#", header=0)

# Sum counts across all samples for each gene
counts_df['total_counts'] = counts_df.iloc[:, 6:].sum(axis=1)

# Plot histogram (log-scaled for better visualization)
plt.figure(figsize=(10, 6))
plt.hist(counts_df['total_counts'], bins=50, log=True, edgecolor='black', alpha=0.7)
plt.axvline(x=10, color='red', linestyle='--', label='Cutoff (10 reads)')  # Example cutoff
plt.xlabel('Total Read Counts per Gene (log scale)')
plt.ylabel('Frequency (log scale)')
plt.title('Distribution of Read Counts per Gene')
plt.legend()
plt.grid(True, which="both", ls="--", alpha=0.2)
plt.savefig('read_counts_histogram.png', dpi=300, bbox_inches='tight')
plt.show()
