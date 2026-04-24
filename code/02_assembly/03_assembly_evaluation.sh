#!/bin/bash -l 

#SBATCH -A uppmax2026-1-61 
#SBATCH -p pelle 
#SBATCH -c 2 
#SBATCH --mem=64G
#SBATCH -t 00:30:00 
#SBATCH -J assembly_evaluation
#SBATCH --mail-type=ALL 
#SBATCH --output=/home/ebkl9290/Genome-Analysis-VT26/outputs/%x.%j.out

 module load BUSCO/5.8.2-gfbf-2024a
 module load QUAST/5.3.0-gfbf-2024a
 
 mkdir -p /home/ebkl9290/Genome-Analysis-VT26/analyses/02_assembly/evaluation_busco
 mkdir -p /home/ebkl9290/Genome-Analysis-VT26/analyses/02_assembly/evaluation_busco/chr3_260420
  mkdir -p /home/ebkl9290/Genome-Analysis-VT26/analyses/02_assembly/evaluation_quast
  mkdir -p /home/ebkl9290/Genome-Analysis-VT26/analyses/02_assembly/evaluation_quast/chr3_260420

  
 busco \
 --in /home/ebkl9290/Genome-Analysis-VT26/analyses/02_assembly/polish_pilon/chr3_260418/pilon_polished_assembly.fasta \
 --mode genome \
 --lineage_dataset viridiplantae_odb10 \
 --cpu 2 \
 --out_path /home/ebkl9290/Genome-Analysis-VT26/analyses/02_assembly/evaluation_busco/chr3_260420 
 
 quast \
 -o /home/ebkl9290/Genome-Analysis-VT26/analyses/02_assembly/evaluation_quast/chr3_260420 \
 -t 2 \
 /home/ebkl9290/Genome-Analysis-VT26/analyses/02_assembly/polish_pilon/chr3_260418/pilon_polished_assembly.fasta
