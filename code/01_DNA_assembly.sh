#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 8
#SBATCH -t 10:00:00
#SBATCH -J DNA-assembly
#SBATCH --mail-type=ALL
#SBATCH --mail-user mama8042@student.uu.se
#SBATCH --output=%x.%j.out
# Load modules
module load bioinfo-tools
module load Flye/2.9.5
# Your commands
export JOBDIR=/home/isamaru/genome-analysis/DNA_analysis/02_DNA_assembly
cd $JOBDIR
flye --nano-raw $JOBDIR/chr3_clean_nanopore.fq.gz --out-dir $JOBDIR --threads 8 
