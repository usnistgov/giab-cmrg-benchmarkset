## NOTE: Need to set working directory to giab-cmrg-benchmarkset/ for this file to work

library(tidyverse)
library(sessioninfo)
`%ni%` <- Negate(`%in%`)

# Load overlap for HG002 GRCh37 hifiasm v0.11 and v4.2.1 of medically relevant gene coordinates
hifiasm_v11_and_v421_overlap_df_grch37 <- read_tsv("workflow/smallvar_benchmark/GRCh37/GRCh37_overlap_v4.2.1_and_hifiasm.tsv", col_types = "cddcddddd")

# Find genes that are less than 90% overlap by v4.2.1 but fully covered including flanking and segdups by hifiasm 
hifiasm_v11_fully_overlap_lt90_overlap_v421_df_grch37 <- hifiasm_v11_and_v421_overlap_df_grch37 %>% 
	filter(chrom %in% paste0("", 1:22),
		   percent_flanking_plus_segdups_overlap_hifiasm == 1,
		   percent_overlap_v4.2.1 < 0.9,
		   flanking_breaks_in_dip_bed == 0)

# Load overlap for HG002 GRCh38 hifiasm v0.11 and v4.2.1 of medically relevant gene coordinates
hifiasm_v11_and_v421_overlap_df_grch38 <- read_tsv("workflow/smallvar_benchmark/GRCh38/GRCh38_overlap_v4.2.1_and_hifiasm.tsv", col_types = "cddcddddd")

# Find genes that are less than 90% overlap by v4.2.1 but fully covered including flanking and segdups by hifiasm
hifiasm_v11_fully_overlap_lt90_overlap_v421_df_grch38 <- hifiasm_v11_and_v421_overlap_df_grch38 %>% 
	filter(chrom %in% paste0("chr", 1:22),
		   percent_flanking_plus_segdups_overlap_hifiasm == 1,
		   percent_overlap_v4.2.1 < 0.9,
		   flanking_breaks_in_dip_bed == 0)

union_GRCh37_GRCh38_MRG_candidates_v421_df <- union(hifiasm_v11_fully_overlap_lt90_overlap_v421_df_grch37$gene, hifiasm_v11_fully_overlap_lt90_overlap_v421_df_grch38$gene)


union_MRG_df_grch37 <- hifiasm_v11_and_v421_overlap_df_grch37 %>% 
	filter(chrom %in% paste0("", 1:22),
		   gene %in% union_GRCh37_GRCh38_MRG_candidates_v421_df,
		   percent_flanking_plus_segdups_overlap_hifiasm == 1,
		   flanking_breaks_in_dip_bed == 0)


union_MRG_df_grch38 <- hifiasm_v11_and_v421_overlap_df_grch38 %>% 
	filter(chrom %in% paste0("chr", 1:22),
		   gene %in% union_GRCh37_GRCh38_MRG_candidates_v421_df,
		   percent_flanking_plus_segdups_overlap_hifiasm == 1,
		   flanking_breaks_in_dip_bed == 0)


# In GRCh37 benchmark not in GRCh38
in_GRCh37_not_in_GRCh38 <- union_GRCh37_GRCh38_MRG_candidates_v421_df[union_GRCh37_GRCh38_MRG_candidates_v421_df %ni% union_MRG_df_grch38$gene]
# "HEATR2"  "DLGAP2"  "TMEM5"   "DYX1C1"  "TMEM8A"  "SLC5A11" "CIRH1A"  "KIR2DL3" "KIR2DL1" "ASIP"

# In GRCh38 benchmark not in GRCh37
in_GRCh38_not_in_GRCh37 <- union_GRCh37_GRCh38_MRG_candidates_v421_df[union_GRCh37_GRCh38_MRG_candidates_v421_df %ni% union_MRG_df_grch37$gene]
# "NUTM2D"  "SIRT3"   "C1R"     "TAS2R46" "TMEM114" "INSR"    "INPP5D"  "LRPAP1"  "FAM20C"  "NAPRT"

remove_from_GRCh37_GRCh38_benchmarks_temp <- union(in_GRCh37_not_in_GRCh38, in_GRCh38_not_in_GRCh37)

# Additional genes removed after manual inspection of the lists including MHC genes (OR12D2, HLA-B, NFKBIL1, NCR3, HLA-DQB1, TAPBP, DAXX) in GRCh37 and GRCh38 
# SNORD64 is removed from each because of inconsistent coordinates for gene in ENSEMBL
additional_manual_removed_genes <- c("SNORD64", "OR12D2", "HLA-B", "NFKBIL1", "NCR3", "HLA-DQB1", "TAPBP", "DAXX")

remove_from_GRCh37_GRCh38_benchmarks <- union(remove_from_GRCh37_GRCh38_benchmarks_temp, additional_manual_removed_genes)

final_MRG_df_grch37 <- union_MRG_df_grch37 %>% 
	filter(gene %ni% remove_from_GRCh37_GRCh38_benchmarks)


final_MRG_df_grch38 <- union_MRG_df_grch38 %>% 
	filter(gene %ni% remove_from_GRCh37_GRCh38_benchmarks)


# Add SMN1
temp_to_add_SMN1_grch37 <- final_MRG_df_grch37[,1:4]

temp_to_add_SMN1_grch38 <- final_MRG_df_grch38[,1:4]

#5	70220768	70249769	SMN1
MRG_grch37 <- temp_to_add_SMN1_grch37 %>% add_row(tibble_row(chrom = "5", start = 70220768, end = 70249769, gene = "SMN1")) %>% arrange(chrom, start, end)

#chr5	70925030	70953942	SMN1
MRG_grch38 <- temp_to_add_SMN1_grch38 %>% add_row(tibble_row(chrom = "chr5", start = 70925030, end = 70953942, gene = "SMN1"))  %>% arrange(chrom, start, end)

# Write bed to file
write_tsv(MRG_grch37, "workflow/smallvar_benchmark/GRCh37/HG002_GRCh37_CMRG_coordinates.bed", col_names = FALSE)

# Write bed to file
write_tsv(MRG_grch38, "workflow/smallvar_benchmark/GRCh38/HG002_GRCh38_CMRG_coordinates.bed", col_names = FALSE)

## Notes
# Genes that are not in ENSEMBL GRCh37
union_GRCh37_GRCh38_MRG_candidates_v421_df[which(union_GRCh37_GRCh38_MRG_candidates_v421_df %ni% hifiasm_v11_and_v421_overlap_df_grch37$gene)]
# "NAPRT"

# Genes that are not in ENSEMBL GRCh38
union_GRCh37_GRCh38_MRG_candidates_v421_df[which(union_GRCh37_GRCh38_MRG_candidates_v421_df %ni% hifiasm_v11_and_v421_overlap_df_grch38$gene)]
# "HEATR2" "TMEM5"  "DYX1C1" "TMEM8A" "CIRH1A"
