#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 02:00:00
#SBATCH -J DNA-busco-quality-polished-assembly
#SBATCH --mail-type=ALL
#SBATCH --mail-user mama8042@student.uu.se
#SBATCH --output=%x.%j.out
# Load modules
module load bioinfo-tools
module load BUSCO/5.7.1
# Your commands
export JOBDIR=/home/isamaru/genome-analysis/DNA_analysis/03_DNA_evaluation/03_2_busco
export SEQUENCE=/home/isamaru/genome-analysis/DNA_analysis/01_DNA_assembly/polished_assembly.fasta
cd $JOBDIR
#Set up august 
source $AUGUSTUS_CONFIG_COPY

busco -i $SEQUENCE -m genome -o $JOBDIR -l $BUSCO_LINEAGE_SETS/embryophyta_odb10 -c 2 -f 

