#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 8
#SBATCH -t 10:00:00
#SBATCH -J ilumina_alignment
#SBATCH --mail-type=ALL
#SBATCH --mail-user [mama8042@student.uu.se](mailto:mama8042@student.uu.se)
#SBATCH --output=%x.%j.out

# Load modules
module load bioinfo-tools bwa samtools

# Your commands

export JOBDIR=/home/isamaru/genome-analysis/DNA_analysis/01_DNA_assembly
cd $JOBDIR

bwa index assembly.fasta 

bwa mem -t 8 assembly.fasta chr3_illumina_R1.fastq.gz chr3_illumina_R2.fastq.gz | samtools sort -@ 8 -o $JOBDIR/aligned.bam
samtools index aligned.bam  # Required for Pilon
