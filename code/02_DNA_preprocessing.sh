#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 1:00:00
#SBATCH -J DNA-preprocesing-illumina
#SBATCH --mail-type=ALL
#SBATCH --mail-user mama8042@student.uu.se
#SBATCH --output=%x.%j.out
# Load modules
module load bioinfo-tools
module load FastQC/0.11.9ll
# Your commands
export JOBDIR=/home/isamaru/genome-analysis/DNA_analysis/01_DNA_preprocessing
cd $JOBDIR
fastqc $JOBDIR/chr3_illumina_R1.fastq.gz -o $JOBDIR
