#!/bin/bash -l

#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 2
#SBATCH -t 12:00:00
#SBATCH -J Trimming_RNA
#SBATCH --mail-type=ALL
#SBATCH --output=%x.%j.out

# Load module
module load Trimmomatic/0.39-Java-17

# Define in- and outputs
RNA_IN="/proj/uppmax2026-1-61/Genome_Analysis/2_Zhou_2023/reads/transcriptomic_data"
OUT="/home/ebkl9290/Genome-Analysis-VT26/data/trimmed_data"

mkdir -p $OUT
mkdir -p $OUT/RNA

# Trimmomatic for RNA using loop
for f1 in ${RNA_IN}/*_f1.fq.gz; do
    r2=${f1/_f1.fq.gz/_r2.fq.gz}
    base=$(basename $f1 _f1.fq.gz)
    echo "Processing $base ..."

    trimmomatic PE -threads 2 \
      $f1 $r2 \
      $OUT/RNA/${base}_f1_paired.fq.gz $OUT/RNA/${base}_f1_unpaired.fq.gz \
      $OUT/RNA/${base}_r2_paired.fq.gz $OUT/RNA/${base}_r2_unpaired.fq.gz \
      LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
done
