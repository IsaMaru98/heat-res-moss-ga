#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 8
#SBATCH -t 1-12:00:00
#SBATCH -J DNA-polish-with-short-read
#SBATCH --mail-type=ALL
#SBATCH --mail-user [mama8042@student.uu.se](mailto:mama8042@student.uu.se)
#SBATCH --output=%x.%j.out

# Load modules

module load bioinfo-tools
module load Pilon/1.24

# Your commands

export JOBDIR=/home/isamaru/genome-analysis/DNA_analysis/01_DNA_assembly
cd $JOBDIR
java -Xmx64G -jar $PILON_HOME/pilon.jar \
--genome assembly.fasta \
--bam aligned.bam \
--output polished_assembly \
--threads 8 \
--changes
