#!/bin/bash -l

#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 2
#SBATCH --mem=64G
#SBATCH -t 12:00:00
#SBATCH -J featureCounts
#SBATCH --mail-type=ALL
#SBATCH --output=/home/ebkl9290/Genome-Analysis-VT26/outputs/%x.%j.out

# load modules
module load Subread/2.1.1-GCC-13.3.0

#define pathways
ANNOT="/proj/uppmax2026-1-61/nobackup/work/ebkl9290/braker3_260428/braker.gtf"
BAM_DIR="/home/ebkl9290/Genome-Analysis-VT26/analyses/04_ed_analysis/hisat2/chr3_transcript_260427"
OUT_DIR="/home/ebkl9290/Genome-Analysis-VT26/analyses/04_ed_analysis/featurecounts_260504"

mkdir -p "$OUT_DIR"

#feature count
featureCounts \
-p \
-t exon \
-g gene_id \
-T 2 \
-a "$ANNOT" \
-o "$OUT_DIR"/counts_table.txt \
"$BAM_DIR"/*.bam