#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH --mem=32G
#SBATCH -t 05:00:00
#SBATCH -J DNA-Unpolished-merqury-eval
#SBATCH --mail-type=ALL
#SBATCH --mail-user=mama8042@student.uu.se
#SBATCH --output=%x.%j.out

module load bioinfo-tools
set -e

OUT_DIR="/home/isamaru/genome-analysis/DNA_analysis/03_DNA_evaluation"
TOOLS_SIF="/proj/uppmax2025-3-3/Genome_Analysis/tools.sif"
DATABASE="$OUT_DIR/merqury_database"
ASSEMBLY_DIR="/home/isamaru/genome-analysis/DNA_analysis/01_DNA_assembly"
CLEAN_NP="$ASSEMBLY_DIR/chr3_clean_nanopore.fq.gz"
UNPOLISHED="$ASSEMBLY_DIR/assembly.fasta"
POLISHED="$ASSEMBLY_DIR/polished_assembly.fasta"

mkdir -p "${DATABASE}"

#singularity exec "${TOOLS_SIF}" FastK -t -T4 -k15 -N"/home/isamaru/genome-analysis/DNA_analysis/03_DNA_evaluation/merqury_database/nanopore_db" "${CLEAN_NP}"

#echo 'Database created'

#singularity exec "${TOOLS_SIF}" MerquryFK "/home/isamaru/genome-analysis/DNA_analysis/03_DNA_evaluation/merqury_database/nanopore_db" "/home/isamaru/genome-analysis/DNA_analysis/01_DNA_assembly/assembly.fasta" "${OUT_DIR}/unpolished_eval"

#echo 'Unpolished evaluation finished'

#singularity exec "${TOOLS_SIF}" MerquryFK "/home/isamaru/genome-analysis/DNA_analysis/03_DNA_evaluation/merqury_database/nanopore_db" "/home/isamaru/genome-analysis/DNA_analysis/01_DNA_assembly/polished_assembly.fasta" "${OUT_DIR}/polished_eval"

#echo 'Polished evaluation finished'

singularity exec "${TOOLS_SIF}" MerquryFK "/home/isamaru/genome-analysis/DNA_analysis/03_DNA_evaluation/merqury_database/nanopore_db" "/home/isamaru/genome-analysis/DNA_analysis/04_DNA_scaffolding/scaffolds_scaffolds_final.fa" "${OUT_DIR}/scaffold_eval"
