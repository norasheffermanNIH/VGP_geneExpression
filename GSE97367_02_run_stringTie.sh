#!/bin/bash
# ------
# README:
# GSE97367, Anolis carolinensis, Mus musculus, Monodelphis domestica, Ornithorhynchus anatinus, Gallus gallus, and Xenopus tropicalis, Bos taurus and Gallus gallus
# This is the second step in processing the RNA-seq FASTQ files for this dataset. 
# It takes the sorted BAM files as input, uses the provided GTF annotation file, and runs StringTie to get TPMs.
# ------
# SBATCH --job-name=GSE97367_stringTie
# SBATCH -o /data/Wilson_Lab/data/VGP_geneExpression/GSE97367/runStringTie.out
# SBATCH -e /data/Wilson_Lab/data/VGP_geneExpression/GSE97367/runStringTie.err

set -e
module load stringtie

# files
BAM_DIR="/data/Wilson_Lab/data/VGP_geneExpression/GSE97367/processed_bams/rna"
OUT_DIR="/data/Wilson_Lab/data/VGP_geneExpression/GSE97367/TPMs"
GTF_FILE_ANOLIS="/data/Wilson_Lab/data/VGP_geneExpression/ReferenceGenomes/anolis_carolinensis/ncbi_dataset/data/GCF_035594765.1/genomic_cleaned.gtf"
GTF_FILE_MUS="/data/Wilson_Lab/data/VGP_geneExpression/ReferenceGenomes/mus_musculus/ncbi_dataset/data/GCF_000001635.27/genomic_cleaned.gtf"
GTF_FILE_MONO="/data/Wilson_Lab/data/VGP_geneExpression/ReferenceGenomes/monodelphis_domestica/ncbi_dataset/data/GCF_027887165.1/genomic_cleaned.gtf"
GTF_FILE_ORNI="/data/Wilson_Lab/data/VGP_geneExpression/ReferenceGenomes/ornithorhynchus_anatinus/ncbi_dataset/data/GCF_004115215.2/genomic_cleaned.gtf"
GTF_FILE_GALLUS="/data/Wilson_Lab/data/VGP_geneExpression/ReferenceGenomes/gallus_gallus/ncbi_dataset/data/GCF_016700215.2/genomic_cleaned.gtf"
GTF_FILE_XEN="/data/Wilson_Lab/data/VGP_geneExpression/ReferenceGenomes/xenopus_tropicalis/ncbi_dataset/data/GCF_000004195.4/genomic_cleaned.gtf"

mkdir -p $OUT_DIR

SRR_ANOLIS="SRR5412168 SRR5412169 SRR5412170 SRR5412171 SRR5412172 SRR5412173 SRR5412162 SRR5412163 SRR5412164 SRR5412165 SRR5412166 SRR5412167 SRR6337920 SRR6337921 SRR6337922 SRR6261413 SRR6261436 SRR6261441 SRR6261446"
SRR_MUS="SRR5412201 SRR5412202 SRR5412203 SRR5412204 SRR5412197 SRR5412198 SRR5412199 SRR5412200"
SRR_MONO="SRR5412219 SRR5412220 SRR5412221 SRR5412215 SRR5412216 SRR5412217 SRR5412218"
SRR_ORNI="SRR5412238 SRR5412239 SRR5412240 SRR5412241 SRR5412234 SRR5412235 SRR5412236 SRR5412237"
SRR_GALLUS="SRR5412257 SRR5412258 SRR5412259 SRR5412260 SRR5412253 SRR5412254 SRR5412255 SRR5412256"
SRR_XEN="SRR5412277 SRR5412278 SRR5412279 SRR5412280 SRR5412273 SRR5412274 SRR5412275 SRR5412276"

# Run stringtie for each sample
# Anolis carolinensis
for SRR in $SRR_ANOLIS; do
    BAM="$BAM_DIR/${SRR}_HISAT_pair_trim_sort.bam"
    SAMPLE_NAME="$SRR"

    sbatch --job-name=stringtie_$SAMPLE_NAME --mem=40g --cpus-per-task=20 --time=24:00:00 --wrap="stringtie -e -G $GTF_FILE_ANOLIS -o $OUT_DIR/${SAMPLE_NAME}_stringTie_results.gtf $BAM"
done

# Mus musculus
for SRR in $SRR_MUS; do
    BAM="$BAM_DIR/${SRR}_HISAT_pair_trim_sort.bam"
    SAMPLE_NAME="$SRR"

    sbatch --job-name=stringtie_$SAMPLE_NAME --mem=40g --cpus-per-task=20 --time=24:00:00 --wrap="stringtie -e -G $GTF_FILE_MUS -o $OUT_DIR/${SAMPLE_NAME}_stringTie_results.gtf $BAM"
done

# Ornithorhynchus anatinus
for SRR in $SRR_ORNI; do
    BAM="$BAM_DIR/${SRR}_HISAT_pair_trim_sort.bam"
    SAMPLE_NAME="$SRR"

    sbatch --job-name=stringtie_$SAMPLE_NAME --mem=40g --cpus-per-task=20 --time=24:00:00 --wrap="stringtie -e -G $GTF_FILE_ORNI -o $OUT_DIR/${SAMPLE_NAME}_stringTie_results.gtf $BAM"
done

# Monodelphis domestica
for SRR in $SRR_MONO; do
    BAM="$BAM_DIR/${SRR}_HISAT_pair_trim_sort.bam"
    SAMPLE_NAME="$SRR"

    sbatch --job-name=stringtie_$SAMPLE_NAME --mem=40g --cpus-per-task=20 --time=24:00:00 --wrap="stringtie -e -G $GTF_FILE_MONO -o $OUT_DIR/${SAMPLE_NAME}_stringTie_results.gtf $BAM"
done

## Gallus gallus
for SRR in $SRR_GALLUS; do
    BAM="$BAM_DIR/${SRR}_HISAT_pair_trim_sort.bam"
    SAMPLE_NAME="$SRR"

    sbatch --job-name=stringtie_$SAMPLE_NAME --mem=40g --cpus-per-task=20 --time=24:00:00 --wrap="stringtie -e -G $GTF_FILE_GALLUS -o $OUT_DIR/${SAMPLE_NAME}_stringTie_results.gtf $BAM"
done

## Xenopus tropicalis
for SRR in $SRR_XEN; do
    BAM="$BAM_DIR/${SRR}_HISAT_pair_trim_sort.bam"
    SAMPLE_NAME="$SRR"

    sbatch --job-name=stringtie_$SAMPLE_NAME --mem=40g --cpus-per-task=20 --time=24:00:00 --wrap="stringtie -e -G $GTF_FILE_XEN -o $OUT_DIR/${SAMPLE_NAME}_stringTie_results.gtf $BAM"
done