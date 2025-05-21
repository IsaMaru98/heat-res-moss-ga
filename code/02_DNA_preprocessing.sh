#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 2:00:00
#SBATCH -J DNA-quality-after-trimming
#SBATCH --mail-type=ALL
#SBATCH --mail-user mama8042@student.uu.se
#SBATCH --output=%x.%j.out
# Load modules
module load bioinfo-tools
module load FastQC/0.11.9

# Your commands
export JOBDIR=/home/isamaru/genome-analysis/DNA_analysis/02_DNA_preprocessing
cd $JOBDIR
#fastqc $JOBDIR/output_trimmed_1U.fastq.gz -o $JOBDIR
fastqc output_forward_paired.fastq.gz output_reverse_paired.fastq.gz -o $JOBDIR

