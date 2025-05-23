#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 8
#SBATCH --mem=32G
#SBATCH -t 06:00:00
#SBATCH -J differential-expression-eggnog
#SBATCH --mail-type=ALL
#SBATCH --mail-user=mama8042@student.uu.se
#SBATCH --output=%x.%j.out

module load bioinfo-tools eggNOG-mapper/2.1.9
GFF3=/home/isamaru/genome-analysis/DNA_analysis/05_DNA_annotation/braker/braker.gff3
#I innitially ran the script with this file, but this was incorrect, the correct sequence file is agat_sequence.aa
#PROTEINS=/home/isamaru/genome-analysis/DNA_analysis/05_DNA_annotation/braker/proteins.fa
PROTEINS=/home/isamaru/genome-analysis/DNA_analysis/05_DNA_annotation/braker/agat_sequence.aa
OUT_DIR=/home/isamaru/genome-analysis/DNA_analysis/07_differential_expression/rerun

mkdir -p $OUT_DIR

emapper.py \
    --cpu 8 \
    --itype proteins \
    -i $PROTEINS \
    --decorate_gff $GFF3 \
    --decorate_gff_ID_field ID \
    -o differential-expression \
    --output_dir $OUT_DIR
