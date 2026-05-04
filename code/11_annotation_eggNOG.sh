#!/bin/bash -l

#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 2
#SBATCH --mem=64G
#SBATCH -t 20:00:00
#SBATCH -J eggNOG_annotation
#SBATCH --mail-type=ALL
#SBATCH --output=/home/ebkl9290/Genome-Analysis-VT26/outputs/%x.%j.out

# load modules
module load eggnog-mapper/2.1.13-gfbf-2024a

# define pathways as variables
INPUT="/crex/proj/uppmax2026-1-61/nobackup/work/ebkl9290/braker3_260428/braker.aa"
DATABASE="/dataset/eggNOG_data/5.0.0/rackham/"
OUT_DIR="/home/ebkl9290/Genome-Analysis-VT26/analyses/03_annotation/functional_eggnog_260504"

mkdir -p "$OUT_DIR"

#functional annotation with eggnog-mapper
emapper.py \
--cpu 2 \
-i "$INPUT" \
-itype proteins \
-m hmmer \
--database euk \
--data_dir "$DATABASE" \
--output_dir "$OUT_DIR" \
--output "N_jap_chr3_functional"
