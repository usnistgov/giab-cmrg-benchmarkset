# Manually generated data dependencies
Benchmark set generation dependencies that were manually created.

## File List

### Genomic Regions
* `{GRCh,GRCh38}_MRG_GAPs.bed`: Gaps in reference for medically relevant genes
* `{GRCh,GRCh38}_mrg_full_gene.bed`: Gene coordinates for full medically relevant gene list. Gene coordinates were obtained from ENSEMBL using ``scripts/GRCh37_lookup_MRG_symbol_coordinates_ENSEMBL.R`. Duplicate gene entries were corrected based on `https://gitlab.nist.gov/gitlab/nolson/mrg-bench-manuscript/-/blob/master/data/gene_coords/ensembl_coords/selected_coordinates_for_duplicated_gene_symbol_entries.tsv`. 
* `GRCh38_CD4_gaps_slop50.bed`: Single base reference Ns at chr12:6801301 and chr12:6801537 in gene CD4 on GRCh38 with 50bp of slop

### Manually Curated Errors
* `GRCh37_curation_medicalgene_SV_errorsorunsure.bed`: Errors identified through manual curation of all SVs in the CMRG genes.
* `GRCh38_curation_medicalgene_SV_errorsorunsure_repeatexpanded.bed`: GRCh37 SVs errors expanded to completely cover any overlapping homopolymers and tandem repeatsidentified by manual curation lifted over to GRCh38 using NCBI remap.
* `GRCh37_curation_medicalgene_smallvar_complexrepeat_errorsorunsure_repeatexpanded.bed`: Errors found in complex variants in tandem repeats in draft benchmark to exclude. From the spreadsheet with curations of FNs and FN_FPs after comparing HiCanu2.1 dipcall vcf to MRG small variant benchmark v0.02.03 `https://docs.google.com/spreadsheets/d/10s0vx8RzK_FmyVYDzNIfeBjsWyCMhOcc2mqjjPP6Jsk/edit?usp=sharing` create bed with sites curated as unsure or incorrect in the benchmark in GRCh38 coordinates then expand bed coordinates to completely cover any overlapping homopolymers and tandem repeats. Use NCBI remap on `GRCh38_curation_medicalgene_smallvar_complexrepeat_errorsorunsure_repeatexpanded.bed` with default parameters to find coordinates on GRCh37.
* `{GRCh37,GRCh38}_hifiasm_error.bed` : Assembly error on Chr21 identified through manual curation of clusters of errors identified during evaluation steps of benchmark development
* `HiCanu_2.1_HG002_{GRCh37,GRCh38}_difficult_medical_gene_smallvar_benchmark_v0.02.03_intersected_FPs_repeatexpanded_slop50.bed`: Result of intersecting hap.py vcf (query = `HG002_HiCanu_2.1-align2-GRCh37.vcf`, truth = `HG002_GRCh37_difficult_medical_gene_smallvar_benchmark_v0.02.03`) with `HG002_{GRCh37,GRCh38}_MRG_stratification_ComplexVar_in_TR.bed`. From the intersection find FPs then expand it to include any overlapping homopolymers/TRs.
* `HiCanu_2.1_HG002_GRCh38_difficult_medical_gene_smallvar_benchmark_v0.02.03_intersected_subtract_FPs_repeatexpanded_slop50_manual_curation_sites.tsv_manual_curation_sites.txt`: Curations of FNs and FN_FPs after comparing vcf from HiCanu2.1 HG002 assmebly called with dipcall to MRG small variant benchmark v0.02.03 available at `https://docs.google.com/spreadsheets/d/10s0vx8RzK_FmyVYDzNIfeBjsWyCMhOcc2mqjjPP6Jsk/edit?usp=sharing`.
* `combined curation responses from benchmarking with sm variant v0.02.03 - GRCh37andGRCh38.tsv`: Supplementary File 5 of `https://www.biorxiv.org/content/10.1101/2021.06.07.444885v2.full.pdf`. Manual curation of a random subset of 20 false positives, 20 false negatives, and 20 genotyping errors from each callset (split evenly between GRCh37 and GRCh38, and between SNVs and INDELs). Also, curations for all of the false positives, false negatives, and genotyping errors that were in at least half of the callsets on GRCh37 or GRCh38.



