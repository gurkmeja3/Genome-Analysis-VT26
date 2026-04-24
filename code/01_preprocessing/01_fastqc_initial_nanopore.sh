#!/bin/bash -l 

#SBATCH -A uppmax2026-1-61 
#SBATCH -p pelle 
#SBATCH -c 2 
#SBATCH --mem=8G
#SBATCH -t 00:30:00 
#SBATCH -J FastQC_Nanopore 
#SBATCH --mail-type=ALL 
#SBATCH --output=/home/ebkl9290/Genome-Analysis-VT26/outputs/%x.%j.out


# Load modules 
module load FastQC/0.12.1-Java-17 

# Commands
fastqc \
--outdir "/home/ebkl9290/Genome-Analysis-VT26/analyses/01_preprocessing/fastqc_initial/chr3_nanopore/" \
--threads 2 \
/proj/uppmax2026-1-61/Genome_Analysis/2_Zhou_2023/reads/genomics_chr3_data/chr3_clean_nanopore.fq.gz