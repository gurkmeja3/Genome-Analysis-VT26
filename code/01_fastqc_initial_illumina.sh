#!/bin/bash -l 

#SBATCH -A uppmax2026-1-61 
#SBATCH -p pelle 
#SBATCH -c 2 
#SBATCH -t 02:00:00 
#SBATCH -J FastQC 
#SBATCH --mail-type=ALL 
#SBATCH --output=/home/ebkl9290/Genome-Analysis-VT26/outputs/%x.%j.out
 
# Load modules 
module load FastQC/0.12.1-Java-17 

# Commands 
INPUT_DIR="/proj/uppmax2026-1-61/Genome_Analysis/2_Zhou_2023/reads"
OUTPUT_DIR_DNA="/home/ebkl9290/Genome-Analysis-VT26/analyses/01_preprocessing/fastqc_initial/chr3_illumina/"
OUTPUT_DIR_RNA="/gorilla/home/ebkl9290/Genome-Analysis-VT26/analyses/01_preprocessing/fastqc_initial/transcriptomic/"

mkdir -p $OUTPUT_DIR_DNA
mkdir -p $OUTPUT_DIR_RNA

fastqc $INPUT_DIR/genomics_chr3_data/chr3_illumina_R*.fastq.gz -o $OUTPUT_DIR_DNA
fastqc $INPUT_DIR/transcriptomic_data/*.fq.gz -o $OUTPUT_DIR_RNA


