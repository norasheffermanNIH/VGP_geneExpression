# SERIES GSE97367
#### https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE97367
**Title:** Convergent origination of a Drosophila-like dosage compensation mechanism in a reptile lineage (Gene expression profiling in several tetrapod species, bulk tissue RNA-seq)

**Species:** Anolis carolinensis, Mus musculus, Monodelphis domestica, Ornithorhynchus anatinus, Gallus gallus, Xenopus tropicalis

## To get files from GEO ##
1) Go to webpage for the GEO series (https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE97367)
2) Click on 'SRA Run Selector' (bottom of page)
    Number of ovaries: 12 (3 Anolis carolinensis, 2 Mus musculus, 1 Monodelphis domestica, 2 Ornithorhynchus anatinus, 2 Gallus gallus, 2 Xenopus tropicalis)
    Number of testes: 13 (3 Anolis carolinensis, 2 Mus musculus, 2 Monodelphis domestica, 2 Ornithorhynchus anatinus, 2 Gallus gallus, 2 Xenopus tropicalis)
    Number of liver: 33 (13 Anolis carolinensis, 4 Mus musculus, 4 Monodelphis domestica, 4 Ornithorhynchus anatinus, 4 Gallus gallus, 4 Xenopus tropicalis)
3) Download the 'Accession List' txt file (/Users/sheffermannm/Desktop/VGP_Accession/GSE97367/SRR_Acc_List.txt) 
4) Convert this list to be space-delimited (/Users/sheffermannm/Desktop/VGP_Accession/GSE97367/SRR_Acc_List_spaceDelimited.txt)
```
#!/bin/bash
tr '\n' ' ' < GSE97367_SRR_Acc_List.txt > GSE97367_SRR_Acc_List.spaceDelimited.txt
```

## Load the data onto Biowulf ##
*!! NOTE:* Table with species, SRR, tissue, and project info can be found at /data/Wilson_Lab/data/VGP_geneExpression/SRA_metadataCSVs/GSE97367.csv

All scripts and further analysis should be run in the GSE97367 directory
```
cd /data/Wilson_Lab/data/VGP_geneExpression/GSE97367
```
* Upload spaceDelimited list to this directory

5) Fetch data using fasterq-dump to get fastq files:
```
sbatch --mail-type=ALL --gres=lscratch:10 /data/Wilson_Lab/data/VGP_geneExpression/GSE97367/GSE97367_loadSRA.sh
```

6) Locate or load Anolis carolinensis, Mus musculus, Monodelphis domestica, Ornithorhynchus anatinus, Gallus gallus, and Xenopus tropicalis reference genomes onto Biowulf

   a) Create directory to store reference genomes
   ```
    /data/Wilson_Lab/data/VGP_geneExpression/ReferenceGenomes
   ```
    --> anolis_carolinensis: downloaded from NCBI
    --> mus_musculus: /data/Wilson_Lab/data/VGP_genomes_phase1/genomes/Mus_musculus
    --> monodelphis_domestica: /data/Wilson_Lab/data/VGP_genomes_phase1/genomes/Monodelphis_domestica
    --> ornithorhynchus_anatinus: /data/Wilson_Lab/data/VGP_genomes_phase1/genomes/Ornithorhynchus_anatinus
    --> gallus_gallus: downloaded from NCBI
    --> xenopus_tropicalis: downloaded from NCBI

    b_i) Download Mus musculus reference genome (https://www.ncbi.nlm.nih.gov/datasets/genome/GCF_000001635.27/)
    Load conda:
   ```
    source myconda
   ```

    Create ncbi_datasets conda environment (only need to do this once):
   ```
    mamba env create -f /data/Wilson_Lab/projects/VGP_Phase_1_Sex_Chr_Project/jacksondan/referencelists/yamls/ncbi_datasets.yml
   ```

    Activate ncbi_datasets environment:
   ```
    mamba activate ncbi_datasets
   ```
    
    Download Mus musculus dataset:
   ```
   # Run in /data/Wilson_Lab/data/VGP_geneExpression/ReferenceGenomes/mus_musculus
   datasets download genome accession GCF_000001635.27 --include genome,gtf --filename mus_musculus.zip
   ```

   Unzip:
   ```
   unzip mus_musculus.zip -d /data/Wilson_Lab/data/VGP_geneExpression/ReferenceGenomes/mus_musculus
   ```

    b_ii) Download Monodelphis domestica reference genome (https://www.ncbi.nlm.nih.gov/datasets/genome/GCF_027887165.1/)
    Load conda:
   ```
    source myconda
   ```

    Create ncbi_datasets conda environment (only need to do this once):
   ```
    mamba env create -f /data/Wilson_Lab/projects/VGP_Phase_1_Sex_Chr_Project/jacksondan/referencelists/yamls/ncbi_datasets.yml
   ```

    Activate ncbi_datasets environment:
   ```
    mamba activate ncbi_datasets
   ```
    
    Download Gallus gallus dataset:
   ```
    # Run in /data/Wilson_Lab/data/VGP_geneExpression/ReferenceGenomes/monodelphis_domestica
    datasets download genome accession GCF_027887165.1 --include genome,gtf --filename monodelphis_domestica.zip
   ```

    Unzip:
   ```
    unzip monodelphis_domestica.zip -d /data/Wilson_Lab/data/VGP_geneExpression/ReferenceGenomes/monodelphis_domestica
   ```

    b_iii) Download Ornithorhynchus anatinus reference genome (https://www.ncbi.nlm.nih.gov/datasets/genome/GCF_004115215.2/)
    Load conda:
   ```
    source myconda
   ```

    Create ncbi_datasets conda environment (only need to do this once):
   ```
    mamba env create -f /data/Wilson_Lab/projects/VGP_Phase_1_Sex_Chr_Project/jacksondan/referencelists/yamls/ncbi_datasets.yml
   ```

    Activate ncbi_datasets environment:
   ```
    mamba activate ncbi_datasets
   ```
    
    Download Ornithorhynchus anatinus dataset:
   ```
    # Run in /data/Wilson_Lab/data/VGP_geneExpression/ReferenceGenomes/ornithorhynchus_anatinus
    datasets download genome accession GCF_004115215.2 --include genome,gtf --filename ornithorhynchus_anatinus.zip
   ```

    Unzip:
   ```
    unzip ornithorhynchus_anatinus.zip -d /data/Wilson_Lab/data/VGP_geneExpression/ReferenceGenomes/ornithorhynchus_anatinus
   ```

    b_iv) Download Xenopus tropicalis reference genome (https://www.ncbi.nlm.nih.gov/datasets/genome/GCF_000004195.4/)
    Load conda:
   ```
    source myconda
   ```

    Create ncbi_datasets conda environment (only need to do this once):
   ```
    mamba env create -f /data/Wilson_Lab/projects/VGP_Phase_1_Sex_Chr_Project/jacksondan/referencelists/yamls/ncbi_datasets.yml
   ```

    Activate ncbi_datasets environment:
   ```
    mamba activate ncbi_datasets
   ```
    
    Download Ornithorhynchus anatinus dataset:
   ```
    # Run in /data/Wilson_Lab/data/VGP_geneExpression/ReferenceGenomes/xenopus_tropicalis
    datasets download genome accession GCF_000004195.4 --include genome,gtf --filename xenopus_tropicalis.zip
   ```

    Unzip:
   ```
    unzip xenopus_tropicalis.zip -d /data/Wilson_Lab/data/VGP_geneExpression/ReferenceGenomes/xenopus_tropicalis
   ```

8) Align FASTQ files to make RNA BAMs and run StringTie to get TPMs.

*!! NOTE:*  StringTie does not work with transcript_id=="". However, most GTF files from NCBI contain this for gene lines in the GTF.

People have fixed this problem by just removing the gene lines because they are not necessary for StringTie (https://www.biostars.org/p/488062/)

First, check if the GTF has empty transcript_id lines: 
```
head /data/Wilson_Lab/data/VGP_geneExpression/ReferenceGenomes/mus_musculus/ncbi_dataset/data/GCF_000001635.27/genomic.gtf
head /data/Wilson_Lab/data/VGP_geneExpression/ReferenceGenomes/monodelphis_domestica/ncbi_dataset/data/GCF_027887165.1/genomic.gtf
head /data/Wilson_Lab/data/VGP_geneExpression/ReferenceGenomes/ornithorhynchus_anatinus/ncbi_dataset/data/GCF_004115215.2/genomic.gtf
head /data/Wilson_Lab/data/VGP_geneExpression/ReferenceGenomes/xenopus_tropicalis/ncbi_dataset/data/GCF_000004195.4/genomic.gtf
```
If so, run: 
```
grep -v 'transcript_id ""' /data/Wilson_Lab/data/VGP_geneExpression/ReferenceGenomes/mus_musculus/ncbi_dataset/data/GCF_000001635.27/genomic.gtf > /data/Wilson_Lab/data/VGP_geneExpression/ReferenceGenomes/mus_musculus/ncbi_dataset/data/GCF_000001635.27/genomic_cleaned.gtf
grep -v 'transcript_id ""' /data/Wilson_Lab/data/VGP_geneExpression/ReferenceGenomes/monodelphis_domestica/ncbi_dataset/data/GCF_027887165.1/genomic.gtf > /data/Wilson_Lab/data/VGP_geneExpression/ReferenceGenomes/monodelphis_domestica/ncbi_dataset/data/GCF_027887165.1/genomic_cleaned.gtf
grep -v 'transcript_id ""' /data/Wilson_Lab/data/VGP_geneExpression/ReferenceGenomes/ornithorhynchus_anatinus/ncbi_dataset/data/GCF_004115215.2/genomic.gtf >/data/Wilson_Lab/data/VGP_geneExpression/ReferenceGenomes/ornithorhynchus_anatinus/ncbi_dataset/data/GCF_004115215.2/genomic_cleaned.gtf
grep -v 'transcript_id ""' /data/Wilson_Lab/data/VGP_geneExpression/ReferenceGenomes/xenopus_tropicalis/ncbi_dataset/data/GCF_000004195.4/genomic.gtf > /data/Wilson_Lab/data/VGP_geneExpression/ReferenceGenomes/xenopus_tropicalis/ncbi_dataset/data/GCF_000004195.4/genomic_cleaned.gtf
```

Then, run each script sequentially. Do not run the next one until all of the previous jobs are finished
```
sbatch --mem=40g --cpus-per-task=20 --gres=lscratch:20 --time=24:00:00 --mail-type=ALL /data/Wilson_Lab/data/VGP_geneExpression/GSE97367/GSE97367_01_align_BAMs.sh
```
```
sbatch --mem=40g --cpus-per-task=20 --gres=lscratch:20 --time=24:00:00 --mail-type=ALL /data/Wilson_Lab/data/VGP_geneExpression/GSE97367/GSE97367_02_run_stringTie.sh
```
```
sbatch --mem=40g --cpus-per-task=20 --gres=lscratch:20 --time=24:00:00 --mail-type=ALL /data/Wilson_Lab/data/VGP_geneExpression/GSE97367/GSE97367_03_extract_TPMs.sh
```

8) Rename extracted TPM .txt files to SRR_species_tissue.txt
```
# Run from /data/Wilson_Lab/data/VGP_geneExpression/GSE97367/TPMs/extracted_TPMs
tail -n +2 /data/Wilson_Lab/data/VGP_geneExpression/SRA_metadataCSVs/GSE97367.csv | while IFS=, read -r SPECIES SRR TISSUE PROJECT; do SPECIES=$(echo "$SPECIES" | xargs); SRR=$(echo "$SRR" | xargs); TISSUE=$(echo "$TISSUE" | xargs); TISSUE=$(echo "$TISSUE" | tr ' ' '_'); [ -f "${SRR}_TPMs.txt" ] && mv "${SRR}_TPMs.txt" "${SRR}_${SPECIES}_${TISSUE}_TPMs.txt"; done
```

9) Plot gene expression of DMRT1 and FOXL2 in the ovary, testes, and liver.
The `VGP_geneExpression_violin.R` script contains the code to make a violin plot for each species, but it can be adapted to just focus on one species.
