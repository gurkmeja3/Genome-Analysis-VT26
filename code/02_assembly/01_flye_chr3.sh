#!/bin/bash -l 

#SBATCH -A uppmax2026-1-61 
#SBATCH -p pelle 
#SBATCH -c 2 
#SBATCH --mem=64G
#SBATCH -t 40:00:00 
#SBATCH -J Flye_chr3
#SBATCH --mail-type=ALL 
#SBATCH --output=/home/ebkl9290/Genome-Analysis-VT26/outputs/%x.%j.out

module load Flye/2.9.6-GCC-13.3.0

mkdir -p /home/ebkl9290/Genome-Analysis-VT26/analyses/02_assembly/assembly_flye
mkdir -p /home/ebkl9290/Genome-Analysis-VT26/analyses/02_assembly/assembly_flye/chr3_nanopore_260416


flye \
--nano-raw /home/ebkl9290/Genome-Analysis-VT26/data/trimmed_data/chr3_260413/chr3_nanopore_trimmed.fq.gz \
--genome-size 16m \
--threads 2 \
--out-dir "/home/ebkl9290/Genome-Analysis-VT26/analyses/02_assembly/assembly_flye/chr3_nanopore_260416" 

