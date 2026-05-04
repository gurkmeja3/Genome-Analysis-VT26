#!/bin/bash -l 

#SBATCH -A uppmax2026-1-61 
#SBATCH -p pelle 
#SBATCH -c 2 
#SBATCH --mem=64G
#SBATCH -t 18:00:00 
#SBATCH -J RNA_mapping
#SBATCH --mail-type=ALL 
#SBATCH --output=/home/ebkl9290/Genome-Analysis-VT26/outputs/%x.%j.out

#load modules
module load HISAT2/2.2.1-gompi-2024a
module load SAMtools/1.22.1-GCC-13.3.0

#define variables
GENOME_FASTA="/home/ebkl9290/Genome-Analysis-VT26/analyses/03_annotation/masking_repeatmasker/chr3_260423/pilon_polished_assembly.fasta.masked"
GENOME_INDEX="/home/ebkl9290/Genome-Analysis-VT26/analyses/04_ed_analysis/hisat2/hisat2-build/chr3_transcript_260427"
READS_DIR="/proj/uppmax2026-1-61/Genome_Analysis/2_Zhou_2023/reads/transcriptomic_data"
OUT_DIR="/home/ebkl9290/Genome-Analysis-VT26/analyses/04_ed_analysis/hisat2/chr3_transcript_260427"

mkdir -p "$GENOME_INDEX"
mkdir -p "$OUT_DIR"

#create indexing of masked file
hisat2-build "$GENOME_FASTA" "$GENOME_INDEX/polished_masked_indexed"

#mapping of reads to genome
for FORWARD in "$READS_DIR"/*_f1.fq.gz
do
  
  SAMPLE=$(basename "$FORWARD" _f1.fq.gz)
  REVERSE="$READS_DIR/${SAMPLE}_r2.fq.gz"
  
  hisat2 -p 2 -x "$GENOME_INDEX/polished_masked_indexed" -1 "$FORWARD" -2 "$REVERSE" | samtools sort -@ 2 -o "$OUT_DIR/${SAMPLE}_sorted.bam"
  
  samtools index -@ 2 "$OUT_DIR/${SAMPLE}_sorted.bam"
  
done

