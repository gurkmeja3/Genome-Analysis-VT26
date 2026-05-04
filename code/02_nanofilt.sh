#!/bin/bash -l 

#SBATCH -A uppmax2026-1-61 
#SBATCH -p pelle 
#SBATCH -c 2 
#SBATCH --mem=8G
#SBATCH -t 04:00:00 
#SBATCH -J Nanofilt 
#SBATCH --mail-type=ALL 
#SBATCH --output=/home/ebkl9290/Genome-Analysis-VT26/outputs/%x.%j.out


# Load modules 
module load NanoFilt/2.8.0-foss-2023b

#Commands
zcat /proj/uppmax2026-1-61/Genome_Analysis/2_Zhou_2023/reads/genomics_chr3_data/chr3_clean_nanopore.fq.gz | \
NanoFilt -l 500 -q 10 --headcrop 50 --tailcrop 50 | \
gzip > /home/ebkl9290/Genome-Analysis-VT26/data/trimmed_data/DNA/chr3_nanopore_trimmed.fq.gz
