#!/bin/bash -l 

#SBATCH -A uppmax2026-1-61 
#SBATCH -p pelle 
#SBATCH -c 2 
#SBATCH -t 01:00:00 
#SBATCH -J FastQC_post_trim
#SBATCH --mail-type=ALL 
#SBATCH --output=/home/ebkl9290/Genome-Analysis-VT26/outputs/%x.%j.out

module load FastQC/0.12.1-Java-17 

mkdir -p /home/ebkl9290/Genome-Analysis-VT26/analyses/01_preprocessing/fastqc_post_trim/
mkdir -p /home/ebkl9290/Genome-Analysis-VT26/analyses/01_preprocessing/fastqc_post_trim/chr3_nanopore_260418/
mkdir -p /home/ebkl9290/Genome-Analysis-VT26/analyses/01_preprocessing/fastqc_post_trim/chr3_illumina_260418/

fastqc \
--outdir "/home/ebkl9290/Genome-Analysis-VT26/analyses/01_preprocessing/fastqc_post_trim/chr3_nanopore_260418/" \
--threads 2 \
/home/ebkl9290/Genome-Analysis-VT26/data/trimmed_data/chr3_260413/chr3_nanopore_trimmed.fq.gz

fastqc \
--outdir "/home/ebkl9290/Genome-Analysis-VT26/analyses/01_preprocessing/fastqc_post_trim/chr3_illumina_260418/" \
--threads 2 \
/home/ebkl9290/Genome-Analysis-VT26/data/trimmed_data/chr3_illumina_260416/chr3_dna*.fq.gz
