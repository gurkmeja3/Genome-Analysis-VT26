#!/bin/bash -l 

#SBATCH -A uppmax2026-1-61 
#SBATCH -p pelle 
#SBATCH -c 2 
#SBATCH --mem=64G
#SBATCH -t 30:00:00 
#SBATCH -J map_and_polish
#SBATCH --mail-type=ALL 
#SBATCH --output=/home/ebkl9290/Genome-Analysis-VT26/outputs/%x.%j.out

java -Xmx8G -jar $EBROOTPILON/pilon.jar

module load bwa-mem2/2.3-GCC-13.3.0
module load SAMtools/1.22.1-GCC-13.3.0
module load Pilon/1.24-Java-17

mkdir -p /home/ebkl9290/Genome-Analysis-VT26/analyses/02_assembly/polish_pilon
mkdir -p /home/ebkl9290/Genome-Analysis-VT26/analyses/02_assembly/polish_pilon/chr3_260418

bwa-mem2 index /home/ebkl9290/Genome-Analysis-VT26/analyses/02_assembly/assembly_flye/chr3_nanopore_260416/assembly.fasta

bwa-mem2 mem -t 2 /home/ebkl9290/Genome-Analysis-VT26/analyses/02_assembly/assembly_flye/chr3_nanopore_260416/assembly.fasta /home/ebkl9290/Genome-Analysis-VT26/data/trimmed_data/chr3_illumina_260416/chr3_dna_R1_paired.fq.gz /home/ebkl9290/Genome-Analysis-VT26/data/trimmed_data/chr3_illumina_260416/chr3_dna_R2_paired.fq.gz | \
samtools sort -@ 2 -o /home/ebkl9290/Genome-Analysis-VT26/analyses/02_assembly/polish_pilon/chr3_260418/aligned_sorted.bam 

samtools index /home/ebkl9290/Genome-Analysis-VT26/analyses/02_assembly/polish_pilon/chr3_260418/aligned_sorted.bam

echo "bwa + samtools done, proceeding with pilon"

java -Xmx32G -jar $EBROOTPILON/pilon.jar \
--genome /home/ebkl9290/Genome-Analysis-VT26/analyses/02_assembly/assembly_flye/chr3_nanopore_260416/assembly.fasta \
--frags /home/ebkl9290/Genome-Analysis-VT26/analyses/02_assembly/polish_pilon/chr3_260418/aligned_sorted.bam \
--threads 2 \
--output pilon_polished_assembly \
--outdir /home/ebkl9290/Genome-Analysis-VT26/analyses/02_assembly/polish_pilon/chr3_260418
