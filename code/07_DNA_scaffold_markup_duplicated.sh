#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 8
#SBATCH --mem=32G
#SBATCH -t 04:00:00
#SBATCH -J DNA_hic_markdup
#SBATCH --mail-user=mama8042@student.uu.se
#SBATCH --output=%x.%j.out

# Load modules
module load bioinfo-tools bwa samtools

export REFERENCE=/home/isamaru/genome-analysis/DNA_analysis/01_DNA_assembly/polished_assembly.fasta

export JOBDIR=/home/isamaru/genome-analysis/DNA_analysis/04_DNA_scaffolding

cd $JOBDIR
# Align Hi-C reads
bwa mem -t 8 $REFERENCE chr3_hiC_R1.fastq.gz chr3_hiC_R2.fastq.gz | \
samtools view -@ 8 -b -o hic_aligned.bam

# Sort by name
samtools sort -@ 8 -n -o hic_name_sorted.bam hic_aligned.bam

# Mark duplicates
samtools collate -@ 8 -O -u hic_name_sorted.bam | \
samtools fixmate -@ 8 -m -u - - | \
samtools sort -@ 8 -u - | \
samtools markdup -@ 8 - hic_markdup.bam

# Index
samtools index -@ 8 hic_markdup.bam
