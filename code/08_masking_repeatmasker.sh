#!/bin/bash -l 

#SBATCH -A uppmax2026-1-61 
#SBATCH -p pelle 
#SBATCH -c 2 
#SBATCH --mem=64G
#SBATCH -t 08:00:00 
#SBATCH -J masking
#SBATCH --mail-type=ALL 
#SBATCH --output=/home/ebkl9290/Genome-Analysis-VT26/outputs/%x.%j.out

#load modules
module load RepeatMasker/4.2.1-foss-2024a

mkdir -p /home/ebkl9290/Genome-Analysis-VT26/analyses/03_annotation/masking_repeatmasker/chr3_260423

cd /home/ebkl9290/Genome-Analysis-VT26/analyses/03_annotation/masking_repeatmasker/chr3_260423

RepeatMasker \
-lib /home/ebkl9290/Genome-Analysis-VT26/analyses/03_annotation/masking_repeatmodeler/chr3_260423/njap_chr3_database-families.fa \
-pa 2 \
-dir /home/ebkl9290/Genome-Analysis-VT26/analyses/03_annotation/masking_repeatmasker/chr3_260423 \
-xsmall \
-gff \
-html \
/home/ebkl9290/Genome-Analysis-VT26/analyses/02_assembly/polish_pilon/chr3_260418/pilon_polished_assembly.fasta