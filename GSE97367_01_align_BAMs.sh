#!/bin/bash
# ------
# README:
# GSE97367, Anolis carolinensis, Mus musculus, Monodelphis domestica, Ornithorhynchus anatinus, Gallus gallus, and Xenopus tropicalis
# This is the first step in processing the RNA-seq FASTQ files for this dataset. 
# This script makes BAM files from raw FASTQ files and sorts them.
# ------
# SBATCH --job-name=GSE97367_alignBAMs
# SBATCH -o /data/Wilson_Lab/data/VGP_geneExpression/GSE97367/AlignBAMs.out
# SBATCH -e /data/Wilson_Lab/data/VGP_geneExpression/GSE97367/AlignBAMs.err

set -e
module load hisat2
module load samtools

# files
INDEX_ANOLIS="/data/Wilson_Lab/data/VGP_geneExpression/ReferenceGenomes/anolis_carolinensis/ncbi_dataset/data/GCF_035594765.1/rAnoCar3_index"
INDEX_MUS="/data/Wilson_Lab/data/VGP_geneExpression/ReferenceGenomes/mus_musculus/ncbi_dataset/data/GCF_000001635.27/rMus_index"
INDEX_MONO="/data/Wilson_Lab/data/VGP_geneExpression/ReferenceGenomes/monodelphis_domestica/ncbi_dataset/data/GCF_027887165.1/rMono_index"
INDEX_ORNI="/data/Wilson_Lab/data/VGP_geneExpression/ReferenceGenomes/ornithorhynchus_anatinus/ncbi_dataset/data/GCF_004115215.2/rOrni_index"
INDEX_GALLUS="/data/Wilson_Lab/data/VGP_geneExpression/ReferenceGenomes/gallus_gallus/ncbi_dataset/data/GCF_016700215.2/rGal_index"
INDEX_XEN="/data/Wilson_Lab/data/VGP_geneExpression/ReferenceGenomes/xenopus_tropicalis/ncbi_dataset/data/GCF_000004195.4/rXen_index"
FASTQ_DIR="/data/Wilson_Lab/data/VGP_geneExpression/GSE97367/fastq"
BAM_DIR="/data/Wilson_Lab/data/VGP_geneExpression/GSE97367/processed_bams/rna"

mkdir -p $BAM_DIR

SRR_ANOLIS="SRR5412168 SRR5412169 SRR5412170 SRR5412171 SRR5412172 SRR5412173 SRR5412162 SRR5412163 SRR5412164 SRR5412165 SRR5412166 SRR5412167 SRR6337920 SRR6337921 SRR6337922 SRR6261413 SRR6261436 SRR6261441 SRR6261446"
SRR_MUS="SRR5412201 SRR5412202 SRR5412203 SRR5412204 SRR5412197 SRR5412198 SRR5412199 SRR5412200"
SRR_MONO="SRR5412219 SRR5412220 SRR5412221 SRR5412215 SRR5412216 SRR5412217 SRR5412218"
SRR_ORNI="SRR5412238 SRR5412239 SRR5412240 SRR5412241 SRR5412234 SRR5412235 SRR5412236 SRR5412237"
SRR_GALLUS="SRR5412257 SRR5412258 SRR5412259 SRR5412260 SRR5412253 SRR5412254 SRR5412255 SRR5412256"
SRR_XEN="SRR5412277 SRR5412278 SRR5412279 SRR5412280 SRR5412273 SRR5412274 SRR5412275 SRR5412276"

# Make RNA BAMs from FASTQs and sort them
## 01_If reference genome is not indexed, run the following command to index it first (only need to do this once):
#hisat2-build /data/Wilson_Lab/data/VGP_geneExpression/ReferenceGenomes/mus_musculus/ncbi_dataset/data/GCF_000001635.27/GCF_000001635.27_GRCm39_genomic.fna /data/Wilson_Lab/data/VGP_geneExpression/ReferenceGenomes/mus_musculus/ncbi_dataset/data/GCF_000001635.27/rMus_index
#hisat2-build /data/Wilson_Lab/data/VGP_geneExpression/ReferenceGenomes/monodelphis_domestica/ncbi_dataset/data/GCF_027887165.1/GCF_027887165.1_mMonDom1.pri_genomic.fna /data/Wilson_Lab/data/VGP_geneExpression/ReferenceGenomes/monodelphis_domestica/ncbi_dataset/data/GCF_027887165.1/rMono_index
#hisat2-build /data/Wilson_Lab/data/VGP_geneExpression/ReferenceGenomes/ornithorhynchus_anatinus/ncbi_dataset/data/GCF_004115215.2/GCF_004115215.2_mOrnAna1.pri.v4_genomic.fna /data/Wilson_Lab/data/VGP_geneExpression/ReferenceGenomes/ornithorhynchus_anatinus/ncbi_dataset/data/GCF_004115215.2/rOrni_index
#hisat2-build /data/Wilson_Lab/data/VGP_geneExpression/ReferenceGenomes/xenopus_tropicalis/ncbi_dataset/data/GCF_000004195.4/GCF_000004195.4_UCB_Xtro_10.0_genomic.fna /data/Wilson_Lab/data/VGP_geneExpression/ReferenceGenomes/xenopus_tropicalis/ncbi_dataset/data/GCF_000004195.4/rXen_index

## 02_If reference genome is already indexed, run the following command to align and sort the BAM files:
### Anolis carolinensis
for SRR in $SRR_ANOLIS; do
    FASTQ="$FASTQ_DIR/${SRR}.fastq"
    BAM_OUTPUT="${BAM_DIR}/${SRR}_HISAT_pair_trim_sort.bam"

    sbatch --job-name=hisat2_$SRR --mem=40g --cpus-per-task=20 --time=24:00:00 --wrap="hisat2 -p 20 -x "$INDEX_ANOLIS" -U "$FASTQ" | samtools sort -o "$BAM_OUTPUT"; samtools index "$BAM_OUTPUT""
done

### Mus musculus
for SRR in $SRR_MUS; do
    FASTQ="$FASTQ_DIR/${SRR}.fastq"
    BAM_OUTPUT="${BAM_DIR}/${SRR}_HISAT_pair_trim_sort.bam"

    sbatch --job-name=hisat2_$SRR --mem=40g --cpus-per-task=20 --time=24:00:00 --wrap="hisat2 -p 20 -x "$INDEX_MUS" -U "$FASTQ" | samtools sort -o "$BAM_OUTPUT"; samtools index "$BAM_OUTPUT""
done

### Monodelphis domestica
for SRR in $SRR_MONO; do
    FASTQ="$FASTQ_DIR/${SRR}.fastq"
    BAM_OUTPUT="${BAM_DIR}/${SRR}_HISAT_pair_trim_sort.bam"

    sbatch --job-name=hisat2_$SRR --mem=40g --cpus-per-task=20 --time=24:00:00 --wrap="hisat2 -p 20 -x "$INDEX_MONO" -U "$FASTQ" | samtools sort -o "$BAM_OUTPUT"; samtools index "$BAM_OUTPUT""
done

### Ornithorhynchus anatinus
for SRR in $SRR_ORNI; do
    FASTQ="$FASTQ_DIR/${SRR}.fastq"
    BAM_OUTPUT="${BAM_DIR}/${SRR}_HISAT_pair_trim_sort.bam"

    sbatch --job-name=hisat2_$SRR --mem=40g --cpus-per-task=20 --time=24:00:00 --wrap="hisat2 -p 20 -x "$INDEX_ORNI" -U "$FASTQ" | samtools sort -o "$BAM_OUTPUT"; samtools index "$BAM_OUTPUT""
done

### Gallus gallus
for SRR in $SRR_GALLUS; do
    FASTQ="$FASTQ_DIR/${SRR}.fastq"
    BAM_OUTPUT="${BAM_DIR}/${SRR}_HISAT_pair_trim_sort.bam"

    sbatch --job-name=hisat2_$SRR --mem=40g --cpus-per-task=20 --time=24:00:00 --wrap="hisat2 -p 20 -x "$INDEX_GALLUS" -U "$FASTQ" | samtools sort -o "$BAM_OUTPUT"; samtools index "$BAM_OUTPUT""
done

### Xenopus tropicalis
for SRR in $SRR_XEN; do
    FASTQ="$FASTQ_DIR/${SRR}.fastq"
    BAM_OUTPUT="${BAM_DIR}/${SRR}_HISAT_pair_trim_sort.bam"

    sbatch --job-name=hisat2_$SRR --mem=40g --cpus-per-task=20 --time=24:00:00 --wrap="hisat2 -p 20 -x "$INDEX_XEN" -U "$FASTQ" | samtools sort -o "$BAM_OUTPUT"; samtools index "$BAM_OUTPUT""
done