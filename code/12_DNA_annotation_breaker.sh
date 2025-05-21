#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 16
#SBATCH --mem=64G
#SBATCH -t 24:00:00
#SBATCH -J DNA-annotation-braker2
#SBATCH --mail-type=ALL
#SBATCH --mail-user=mama8042@student.uu.se
#SBATCH --output=%x.%j.out

module load bioinfo-tools samtools braker/2.1.6


GENOME=/home/isamaru/genome-analysis/DNA_analysis/05_DNA_annotation/scaffolds_scaffolds_final.fa.masked
BAM=/proj/uppmax2025-3-3/nobackup/work/isamaru/hisat2
OUT=/home/isamaru/genome-analysis/DNA_analysis/05_DNA_annotation
PROT=/proj/uppmax2025-3-3/Genome_Analysis/4_Zhou_2023/embryophyte_proteomes.faa
cd "$OUT"

#Delete dir from prev run
rm -rf braker

braker.pl --cores=16 \
--AUGUSTUS_CONFIG_PATH=$OUT/augustus_config \
--AUGUSTUS_BIN_PATH=/sw/bioinfo/augustus/3.4.0/snowy/bin \
--AUGUSTUS_SCRIPTS_PATH=/sw/bioinfo/augustus/3.4.0/snowy/scripts \
--GENEMARK_PATH=/sw/bioinfo/GeneMark/4.68-es/snowy \
--genome=$GENOME \
--bam=$BAM/control_1.sorted.bam,$BAM/control_2.sorted.bam,$BAM/control_3.sorted.bam \
--prot_seq=$PROT \
--gff3 \
--etpmode \
--softmasking

