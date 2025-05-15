#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 16
#SBATCH --mem=64G
#SBATCH -t 05:00:00
#SBATCH -J RNA-HISAT2-control
#SBATCH --mail-type=ALL
#SBATCH --mail-user=mama8042@student.uu.se
#SBATCH --output=%x.%j.out

module load bioinfo-tools HISAT2/2.2.1 samtools

GENOME=/home/isamaru/genome-analysis/DNA_analysis/05_DNA_annotation

#hisat2-build -p 16 "$GENOME"/scaffolds_scaffolds_final.fa.masked "$GENOME"/hisat2/index

DATA=/home/isamaru/genome-analysis/RNA_analysis/01_RNA_mapping
OUT=/proj/uppmax2025-3-3/nobackup/work/isamaru/hisat2
INDEX="$GENOME"/hisat2/index

hisat2 -p 8 -x "$INDEX" -1 "$DATA"/Control_1_f1.fq.gz -2 "$DATA"/Control_1_r2.fq.gz -S "$OUT"/control_1.sam 
hisat2 -p 8 -x "$INDEX" -1 "$DATA"/Control_2_f1.fq.gz -2 "$DATA"/Control_2_r2.fq.gz -S "$OUT"/control_2.sam 
hisat2 -p 8 -x "$INDEX" -1 "$DATA"/Control_3_f1.fq.gz -2 "$DATA"/Control_3_r2.fq.gz -S "$OUT"/control_3.sam 

hisat2 -p 8 -x "$INDEX" -1 "$DATA"/Heat_treated_42_12h_1_f1.fq.gz -2 "$DATA"/Heat_treated_42_12h_1_r2.fq.gz -S "$OUT"/heat_treated_1.sam 
hisat2 -p 8 -x "$INDEX" -1 "$DATA"/Heat_treated_42_12h_2_f1.fq.gz -2 "$DATA"/Heat_treated_42_12h_2_r2.fq.gz -S "$OUT"/heat_treated_2.sam 
hisat2 -p 8 -x "$INDEX" -1 "$DATA"/Heat_treated_42_12h_3_f1.fq.gz -2 "$DATA"/Heat_treated_42_12h_3_r2.fq.gz -S "$OUT"/heat_treated_3.sam

cd "$OUT"
# Convert and sort SAM files to BAM
samtools sort -@ 4 -o control_1.sorted.bam control_1.sam
samtools sort -@ 4 -o control_2.sorted.bam control_2.sam
samtools sort -@ 4 -o control_3.sorted.bam control_3.sam
samtools sort -@ 4 -o heat_treated_1.sorted.bam heat_treated_1.sam
samtools sort -@ 4 -o heat_treated_2.sorted.bam heat_treated_2.sam
samtools sort -@ 4 -o heat_treated_3.sorted.bam heat_treated_3.sam

# Index BAM files
samtools index control_1.sorted.bam
samtools index control_2.sorted.bam
samtools index control_3.sorted.bam
samtools index heat_treated_1.sorted.bam
samtools index heat_treated_2.sorted.bam
samtools index heat_treated_3.sorted.bam
