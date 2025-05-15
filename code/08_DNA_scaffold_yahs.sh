#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 8
#SBATCH --mem=64G
#SBATCH -t 12:00:00
#SBATCH -J DNA-yahs-scaffolding
#SBATCH --mail-type=ALL
#SBATCH --mail-user=mama8042@student.uu.se
#SBATCH --output=%x.%j.out

# Load modules
module load bioinfo-tools bwa samtools

# Set paths
export ASSEMBLY="/home/isamaru/genome-analysis/DNA_analysis/01_DNA_assembly/polished_assembly.fasta"
export BAM="/home/isamaru/genome-analysis/DNA_analysis/04_DNA_scaffolding/hic_markdup.bam"
export YAHSPATH="/home/isamaru/genome-analysis/code/yahs/yahs"
export OUTDIR="/home/isamaru/genome-analysis/DNA_analysis/04_DNA_scaffolding/scaffolds"

# Run YaHS
$YAHSPATH -o $OUTDIR -l 30 $ASSEMBLY $BAM

