#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 16
#SBATCH --mem=64G
#SBATCH -t 03:00:00
#SBATCH -J masking-scaffold
#SBATCH --mail-type=ALL
#SBATCH --mail-user=mama8042@student.uu.se
#SBATCH --output=%x.%j.out

module load bioinfo-tools RepeatMasker/4.1.5

export SCA=/home/isamaru/genome-analysis/DNA_analysis/04_DNA_scaffolding/scaffolds_scaffolds_final.fa
export OUTDIR=/home/isamaru/genome-analysis/DNA_analysis/05_DNA_annotation
module load boiinfo-tools RepeatMasker/4.1.5

RepeatMasker -pa 4 -xsmall -dir $OUTDIR $SCA
