#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 8
#SBATCH --mem=32G
#SBATCH -t 05:00:00
#SBATCH -J FeatureCount
#SBATCH --mail-type=ALL
#SBATCH --mail-user=mama8042@student.uu.se
#SBATCH --output=%x.%j.out

module load bioinfo-tools subread

BAM=/proj/uppmax2025-3-3/nobackup/work/isamaru/hisat2

featureCounts \
  -T 8 \
  -a /home/isamaru/genome-analysis/DNA_analysis/05_DNA_annotation/braker/braker.gtf \
  -o counts.txt \
  -g gene_id \
  -t exon \
  -p \
  -B \
  -C \
  $BAM/control_1.sorted.bam \
  $BAM/control_2.sorted.bam \
  $BAM/control_3.sorted.bam \
  $BAM/heat_treated_1.sorted.bam \
  $BAM/heat_treated_2.sorted.bam \
  $BAM/heat_treated_3.sorted.bam



