library(tidyverse)
library(here)

# Load ENSEMBL coordinates
GRCh37_Ensembl_101_biomart_export <- read_tsv("data/coords/GRCh37_Ensembl_101_biomart_export.tsv", col_types = "ccccc")

# Load medically relevant gene lists
mandelker_list <- read_tsv("data/mrg_lists/Mandelker_Medically_Relevant_Genes.tsv", col_types = "c", col_names = "gene")

cosmic_list <- read_tsv("data/mrg_lists/COSMIC_Gene_Census.tsv", col_types = "c", col_names = "gene")

lincoln_list <- read_tsv("data/mrg_lists/Steve_Lincoln_Compiled_Medical_Gene_List.tsv", col_types = "c", col_names = "gene")

mrg_list <- unique(union(mandelker_list$gene, union(cosmic_list$gene, lincoln_list$gene)))

# Find coordinates for MRG symbols
GRCh37_Ensembl_101_biomart_export_medically_relevant = GRCh37_Ensembl_101_biomart_export[which(GRCh37_Ensembl_101_biomart_export$`Gene name` %in% mrg_list),c(4,2,3,5)]

# Write bed file of coordinates
write_tsv(GRCh37_Ensembl_101_biomart_export_medically_relevant, "data/mrg_benchmarkset/workflow/GRCh37/GRCh37_ENSEMBL_MRG_coordinates.bed", col_names = FALSE)
