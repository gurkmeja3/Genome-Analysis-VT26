#!/bin/bash -l

#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 2
#SBATCH --mem=64G
#SBATCH -t 24:00:00
#SBATCH -J braker3_annotation
#SBATCH --mail-type=ALL
#SBATCH --output=/home/ebkl9290/Genome-Analysis-VT26/outputs/%x.%j.out

# load modules
module load SAMtools/1.22.1-GCC-13.3.0

# define pathways as variables
GENOME="/home/ebkl9290/Genome-Analysis-VT26/analyses/03_annotation/masking_repeatmasker/chr3_260423/pilon_polished_assembly.fasta.masked"
BAM_DIR="/home/ebkl9290/Genome-Analysis-VT26/analyses/04_ed_analysis/hisat2/chr3_transcript_260427"
OUT_DIR="/proj/uppmax2026-1-61/nobackup/work/ebkl9290/braker3_260428"
SIF="/proj/uppmax2026-1-61/Genome_Analysis/2_Zhou_2023/braker3.sif"
PROT_REF="/proj/uppmax2026-1-61/Genome_Analysis/2_Zhou_2023/Ceratodon_purpureus"
LOCAL_CONFIG="/home/ebkl9290/bin/augustus_config"

mkdir -p "$LOCAL_CONFIG"

# merge all transcriptomic .bam
samtools merge -@ 2 "$OUT_DIR/merged_transcript.bam" "$BAM_DIR"/*.bam
samtools index "$OUT_DIR/merged_transcript.bam"

# augustus copying (run once)
singularity exec "$SIF" cp -r /opt/Augustus/config/. "$LOCAL_CONFIG"

# BRAKER through singularity
singularity exec \
  -B /home/ebkl9290:/home/ebkl9290 \
  -B /proj/uppmax2026-1-61:/proj/uppmax2026-1-61 \
  -B "$LOCAL_CONFIG":/opt/augustus_config_local \
  --env AUGUSTUS_CONFIG_PATH=/opt/augustus_config_local \
  "$SIF" \
  braker.pl \
  --genome="$GENOME" \
  --bam="$OUT_DIR/merged_transcript.bam" \
  --prot_seq="$PROT_REF/C_purpureus.faa" \
  --softmasking \
  --species=N_japonicum \
  --threads=2 \
  --min_contig=5000 \
  --workingdir="$OUT_DIR"
  
#create softlinks to remote results
ln -sfn "$OUT_DIR" "/home/ebkl9290/Genome-Analysis-VT26/analyses/03_annotation/"
ln -sfn "$PROT_REF" "/home/ebkl9290/Genome-Analysis-VT26/data/references/"

