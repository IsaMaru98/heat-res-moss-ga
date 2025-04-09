#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 2:00:00
#SBATCH -J DNA-trimming-illumina
#SBATCH --mail-type=ALL
#SBATCH --mail-user mama8042@student.uu.se
#SBATCH --output=%x.%j.out
# Load modules
module load bioinfo-tools
module load trimmomatic/0.39
# Your commands
export JOBDIR=/home/isamaru/genome-analysis/DNA_analysis/02_DNA_preprocessing
cd $JOBDIR
java -jar $TRIMMOMATIC_HOME/trimmomatic.jar SE -threads 2 $JOBDIR/chr3_illumina_R1.fastq.gz $JOBDIR//output_trimmed_1U.fastq.gz ILLUMINACLIP:$TRIMMOMATIC_HOME/adapters/TruSeq3-SE:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MAXINFO:120:0.7 MINLEN:36

