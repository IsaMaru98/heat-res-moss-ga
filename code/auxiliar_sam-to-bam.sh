#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 8
#SBATCH --mem=32G
#SBATCH -t 05:00:00
#SBATCH -J RNA-sam-to-bam
#SBATCH --mail-type=ALL
#SBATCH --mail-user=mama8042@student.uu.se
#SBATCH --output=%x.%j.out

module load bioinfo-tools samtools

OUT=/proj/uppmax2025-3-3/nobackup/work/isamaru/hisat2

cd "$OUT"
# Convert and sort SAM files to BAM
#samtools sort -@ 4 -o control_1.sorted.bam control_1.sam
#samtools sort -@ 4 -o control_2.sorted.bam control_2.sam
samtools sort -@ 8 -o control_3.sorted.bam control_3.sam
samtools sort -@ 8 -o heat_treated_1.sorted.bam heat_treated_1.sam
samtools sort -@ 8 -o heat_treated_2.sorted.bam heat_treated_2.sam
samtools sort -@ 8 -o heat_treated_3.sorted.bam heat_treated_3.sa
