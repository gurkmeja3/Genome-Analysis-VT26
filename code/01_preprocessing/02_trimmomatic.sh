#!/bin/bash -l

#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 2
#SBATCH -t 10:00:00
#SBATCH -J Trimming_illumina
#SBATCH --mail-type=ALL
#SBATCH --output=/home/ebkl9290/Genome-Analysis-VT26/outputs/%x.%j.out

# Load module
module load Trimmomatic/0.39-Java-17

mkdir -p /home/ebkl9290/Genome-Analysis-VT26/data/trimmed_data/chr3_illumina_260416

# Trimmomatic 
trimmomatic PE -threads 2 \
  /proj/uppmax2026-1-61/Genome_Analysis/2_Zhou_2023/reads/genomics_chr3_data/chr3_illumina_R1.fastq.gz /proj/uppmax2026-1-61/Genome_Analysis/2_Zhou_2023/reads/genomics_chr3_data/chr3_illumina_R2.fastq.gz \
  /home/ebkl9290/Genome-Analysis-VT26/data/trimmed_data/chr3_illumina_260416/chr3_dna_R1_paired.fq.gz /home/ebkl9290/Genome-Analysis-VT26/data/trimmed_data/chr3_illumina_260416/chr3_dna_R1_unpaired.fq.gz \
  /home/ebkl9290/Genome-Analysis-VT26/data/trimmed_data/chr3_illumina_260416/chr3_dna_R2_paired.fq.gz /home/ebkl9290/Genome-Analysis-VT26/data/trimmed_data/chr3_illumina_260416/chr3_dna_R2_unpaired.fq.gz \
  LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

