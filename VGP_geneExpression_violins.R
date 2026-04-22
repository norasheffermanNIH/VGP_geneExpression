# ------
# README
# Goal: Plot gene expression of DMRT1 and FOXL2 (sex-determining genes) in the ovary, testes, and liver of different species.
# We expect to see expression of DMRT1 in the testes, expression of FOXL2 in the ovaries, and expression of neither in the liver.
# ------

# Load in packages
library(tidyverse)
library(stringr)
library(ggplot2)

# Set working directory
setwd("/vf/users/Wilson_Lab/data/VGP_geneExpression")

# Construct paths to extracted_TPMs for each dataset
GSE97367 <- "/vf/users/Wilson_Lab/data/VGP_geneExpression/GSE97367/TPMs/extracted_TPMs"
GSE160028 <- "/vf/users/Wilson_Lab/data/VGP_geneExpression/GSE160028/TPMs/extracted_TPMs"
GSE291397 <- "/vf/users/Wilson_Lab/data/VGP_geneExpression/GSE291397/TPMs/extracted_TPMs"
GSE308970 <- "/vf/users/Wilson_Lab/data/VGP_geneExpression/GSE308970/TPMs/extracted_TPMs"

# Function to read one extracted TPM file and pull out sex determining genes
read_tpm_file <- function(file_path) {
  # Read in file
  data <- read_tsv(file_path, col_types = cols())
  # Extract metadata
  filename <- basename(file_path)
  metadata <- str_split(filename, "_", simplify = TRUE)
  sample <- metadata[1]
  species <- paste(metadata[2], metadata[3])
  tissue <- metadata[4]
  # Extract GEO data set ID from path
  dataset <- str_extract(file_path, "GSE\\d+")
  # Put together dataframe
  data %>% 
    # Normalize gene names (ex. if some are dmrt1, Dmrt1, or DMRT1, make all be DMRT1)
    mutate(gene = toupper(ref_gene_name),
           gene = case_when(str_detect(gene, "^DMRT1") ~ "DMRT1",
                                  str_detect(gene, "^FOXL2") ~ "FOXL2",
                                  TRUE ~ gene)) %>% 
    filter(gene %in% c ("FOXL2", "DMRT1")) %>% 
    group_by(gene) %>% 
    summarise(TPM = sum(TPM), .groups = "drop") %>% 
    mutate(sample = sample, species = species, tissue = tissue, dataset = dataset)
}

# Load files from different datasets
all_files <- c(list.files(GSE97367, full.names = TRUE),
               list.files(GSE160028, full.names = TRUE),
               list.files(GSE291397, full.names = TRUE),
               list.files(GSE308970, full.names = TRUE))

# Merge all extracted TPM files into one dataframe using read_tpm_file function
all_data <- map_dfr(all_files, read_tpm_file)


# ======= SPECIES =======
# === Lepidosaur: Anolis carolinensis (Anole) ===
# Datasets: GSE97367 GSE291397

# Select for species
anolis <- all_data %>% 
  filter(species == "Anolis carolinensis") %>% 
  # Scale to log2
  # Write if statement that if TPM = 0, keep 0
  # Else, if TPM > 0, do log2(TPM)
  mutate(log2_TPM = ifelse(TPM == 0, 0, log2(TPM)))
# Manually set order of graph panels: Ovary, Testis, Liver
anolis$tissue <- factor(anolis$tissue, levels = c("Ovary", "Testis", "Liver"))

# Plot
anolisplot <- ggplot(anolis, aes(x = tissue, y = TPM, color = tissue, shape = dataset)) +
  geom_jitter(width = 0.15, height = 0, size = 2.5, alpha = 0.8) +
  facet_wrap(~ gene, nrow = 1, scales = "free_y") +
  theme_classic() +
  labs(title = "FOXL2 and DMRT1 expression in Anolis carolinensis",
        x = "Tissue", y = "TPM", color = "Tissue", shape = "Dataset") +
  scale_color_manual(values = c("Ovary" = "#D14949", "Testis"= "#4C72B0", "Liver" = "darkseagreen3"))
anolisplot
# Save png
ggsave("visualization/anolis_carolinensis.png", plot = anolisplot, width = 6, height = 4, dpi = 300)

# === Mammal: Mus musculus (Mouse) ===
# Datasets: GSE97367
mus <- all_data %>% 
  filter(species == "Mus musculus") %>% 
  # Scale to log2
  # Write if statement that if TPM = 0, keep 0
  # Else, if TPM > 0, do log2(TPM)
  mutate(log2_TPM = ifelse(TPM == 0, 0, log2(TPM)))
# Manually set order of graph panels: Ovary, Testis, Liver
mus$tissue <- factor(mus$tissue, levels = c("Ovary", "Testis", "Liver"))

# Plot
musplot <- ggplot(mus, aes(x = tissue, y = TPM, color = tissue)) +
  geom_jitter(width = 0.15, height = 0, size = 2.5, alpha = 0.8) +
  facet_wrap(~ gene, nrow = 1, scales = "free_y") +
  theme_classic() +
  labs(title = "FOXL2 and DMRT1 expression in Mus musculus",
       x = "Tissue", y = "TPM") +
  theme(legend.position = "none") +
  scale_color_manual(values = c("Ovary" = "#D14949", "Testis"= "#4C72B0", "Liver" = "darkseagreen3"))
musplot
# Save png
ggsave("visualization/mus_musculus.png", plot = musplot, width = 6, height = 4, dpi = 300)

# === Mammal: Ornithorhynchus anantinus (Platypus) ===
# Datasets: GSE97367
orni <- all_data %>% 
  filter(species == "Ornithorhynchus anatinus") %>% 
  # Scale to log2
  # Write if statement that if TPM = 0, keep 0
  # Else, if TPM > 0, do log2(TPM)
  mutate(log2_TPM = ifelse(TPM == 0, 0, log2(TPM)))
# Manually set order of graph panels: Ovary, Testis, Liver
orni$tissue <- factor(orni$tissue, levels = c("Ovary", "Testis", "Liver"))

# Plot
orniplot <- ggplot(orni, aes(x = tissue, y = TPM, color = tissue)) +
  geom_jitter(width = 0.15, height = 0, size = 2.5, alpha = 0.8) +
  facet_wrap(~ gene, nrow = 1, scales = "free_y") +
  theme_classic() +
  labs(title = "FOXL2 and DMRT1 expression in Ornithorhynchus anantinus",
       x = "Tissue", y = "TPM") +
  theme(legend.position = "none") +
  scale_color_manual(values = c("Ovary" = "#D14949", "Testis"= "#4C72B0", "Liver" = "darkseagreen3"))
orniplot
# Save png
ggsave("visualization/ornithorhynchus_anatinus.png", plot = orniplot, width = 6, height = 4, dpi = 300)

# === Bird: Gallus gallus (Chicken) ===
# Datasets: GSE97367 GSE160028
gallus <- all_data %>% 
  filter(species == "Gallus gallus") %>% 
  # Scale to log2
  # Write if statement that if TPM = 0, keep 0
  # Else, if TPM > 0, do log2(TPM)
  mutate(log2_TPM = ifelse(TPM == 0, 0, log2(TPM)))
# Manually set order of graph panels: Ovary, Testis, Liver
gallus$tissue <- factor(gallus$tissue, levels = c("Ovary", "Testis", "Liver"))

# Plot
gallusplot <- ggplot(gallus, aes(x = tissue, y = TPM, color = tissue, shape = dataset)) +
  geom_jitter(width = 0.15, height = 0, size = 2.5, alpha = 0.8) +
  facet_wrap(~ gene, nrow = 1, scales = "free_y") +
  theme_classic() +
  labs(title = "FOXL2 and DMRT1 expression in Gallus gallus",
       x = "Tissue", y = "TPM",
       color = "Tissue", shape = "Dataset") +
  scale_color_manual(values = c("Ovary" = "#D14949", "Testis"= "#4C72B0", "Liver" = "darkseagreen3"))
gallusplot
# Save png
ggsave("visualization/gallus_gallus.png", plot = gallusplot

# === Frog: Xenopus tropicalis (Tropical clawed frog) ===
# Datasets: GSE97367
xenopus <- all_data %>% 
  filter(species == "Xenopus tropicalis") %>% 
  # Scale to log2
  # Write if statement that if TPM = 0, keep 0
  # Else, if TPM > 0, do log2(TPM)
  mutate(log2_TPM = ifelse(TPM == 0, 0, log2(TPM)))
# Manually set order of graph panels: Ovary, Testis, Liver
xenopus$tissue <- factor(xenopus$tissue, levels = c("Ovary", "Testis", "Liver"))

# Plot
xenopusplot <- ggplot(xenopus, aes(x = tissue, y = TPM, color = tissue)) +
  geom_jitter(width = 0.15, height = 0, size = 2.5, alpha = 0.8) +
  facet_wrap(~ gene, nrow = 1, scales = "free_y") +
  theme_classic() +
  labs(title = "FOXL2 and DMRT1 expression in Xenopus tropicalis",
       x = "Tissue", y = "TPM") +
  theme(legend.position = "none") +
  scale_color_manual(values = c("Ovary" = "#D14949", "Testis"= "#4C72B0", "Liver" = "darkseagreen3"))
xenopusplot
# Save png
ggsave("visualization/xenopus_tropicalis.png", plot = xenopusplot, width = 6, height = 4, dpi = 300)

# === Mammal: Bos taurus (Cattle) ===
# Datasets: GSE160028
bos <- all_data %>% 
  filter(species == "Bos taurus") %>% 
  # Scale to log2
  # Write if statement that if TPM = 0, keep 0
  # Else, if TPM > 0, do log2(TPM)
  mutate(log2_TPM = ifelse(TPM == 0, 0, log2(TPM)))
# Manually set order of graph panels: Ovary, Testis, Liver
bos$tissue <- factor(bos$tissue, levels = c("Ovary", "Testis", "Liver"))

# Plot 
bosplot <- ggplot(bos, aes(x = tissue, y = TPM, color = tissue)) +
  geom_jitter(width = 0.15, height = 0, size = 2.5, alpha = 0.8) +
  facet_wrap(~ gene, nrow = 1, scales = "free_y") +
  theme_classic() +
  labs(title = "FOXL2 and DMRT1 expression in Bos taurus",
       x = "Tissue", y = "TPM") +
  theme(legend.position = "none") +
  scale_color_manual(values = c("Ovary" = "#D14949", "Testis"= "#4C72B0", "Liver" = "darkseagreen3"))
bosplot
# Save png
ggsave("visualization/bos_taurus.png", plot = bosplot, width = 6, height = 4, dpi = 300)

# === Ray-finned fish: Nothobranchius furzeri (Killifish) ===
# Datasets: GSE308970
notho <- all_data %>% 
  filter(species == "Nothobranchius furzeri") %>% 
  # Scale to log2
  # Write if statement that if TPM = 0, keep 0
  # Else, if TPM > 0, do log2(TPM)
  mutate(log2_TPM = ifelse(TPM == 0, 0, log2(TPM)))
# Manually set order of graph panels: Ovary, Testis, Liver
notho$tissue <- factor(notho$tissue, levels = c("Ovary", "Testis", "Liver"))

# Plot
nothoplot <- ggplot(notho, aes(x = tissue, y = TPM, color = tissue)) +
  geom_jitter(width = 0.15, height = 0, size = 2.5, alpha = 0.8) +
  facet_wrap(~ gene, nrow = 1, scales = "free_y") +
  theme_classic() +
  labs(title = "FOXL2 and DMRT1 expression in Nothobranchius furzeri",
       x = "Tissue", y = "TPM") +
  theme(legend.position = "none") +
  scale_color_manual(values = c("Ovary" = "#D14949", "Testis"= "#4C72B0", "Liver" = "darkseagreen3"))
nothoplot
# Save png
ggsave("visualization/nothobranchius_furzeri.png", plot = nothoplot, width = 6, height = 4, dpi = 300)