#!/bin/bash
# ------
# README:
# GSE97367, Anolis carolinensis, Mus musculus, Monodelphis domestica, Ornithorhynchus anatinus, Gallus gallus, Xenopus tropicalis
# This is the third step in processing the RNA-seq FASTQ files for this dataset. 
# It extracts the TPM values from the StringTie output GTF files and saves them in separate text files for easier downstream analysis.
# ------
# SBATCH --job-name=GSE97367_extract_TPMs
# SBATCH -o /data/Wilson_Lab/data/VGP_geneExpression/GSE97367/extract_TPMs.out
# SBATCH -e /data/Wilson_Lab/data/VGP_geneExpression/GSE97367/extract_TPMs.err

set -e

# files
OUT_DIR="/data/Wilson_Lab/data/VGP_geneExpression/GSE97367/TPMs"

mkdir -p "$OUT_DIR/extracted_TPMs"

# Save out the TPMs in a separate file for easier downstream processing
for GTF in "$OUT_DIR"/*_stringTie_results.gtf; do
    SAMPLE_NAME=$(basename "$GTF" _stringTie_results.gtf)
    echo "Extracting TPMs for $SAMPLE_NAME"
    {
      echo -e "gene_id\ttranscript_id\tref_gene_name\tTPM"

      awk -F'\t' '$3=="transcript" {gene=""; tx=""; name=""; tpm="";
        if (match($0,/gene_id "([^"]+)"/,g)) gene=g[1];
        if (match($0,/transcript_id "([^"]+)"/,t)) tx=t[1];
        if (match($0,/ref_gene_name "([^"]+)"/,n)) name=n[1];
        if (match($0,/TPM "([^"]+)"/,p)) tpm=p[1];
        if (gene!="" && tx!="" && tpm!="") print gene, tx, name, tpm;
      }' OFS='\t' "$GTF"        
    } > "$OUT_DIR/extracted_TPMs/${SAMPLE_NAME}_TPMs.txt"
done

    