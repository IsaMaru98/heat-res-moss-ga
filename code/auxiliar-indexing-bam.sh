#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH --mem=32G
#SBATCH -t 05:00:00
#SBATCH -J INDEX-bam
#SBATCH --mail-type=ALL
#SBATCH --mail-user=mama8042@student.uu.se
#SBATCH --output=%x.%j.out

module load bioinfo-tools samtools

OUT=/proj/uppmax2025-3-3/nobackup/work/isamaru/hisat2

cd "$OUT"
# Index BAM files
samtools index control_1.sorted.bam
samtools index control_2.sorted.bam
samtools index control_3.sorted.bam
samtools index heat_treated_1.sorted.bam
samtools index heat_treated_2.sorted.bam
samtools index heat_treated_3.sorted.bam
