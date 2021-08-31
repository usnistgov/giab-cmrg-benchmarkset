# Manually generated data dependencies
Benchmark set generation dependencies that were manually created.

## File List

### Genomic Regions
* `{GRCh,GRCh38}_MRG_GAPs.bed`: Gaps in reference for medically relevant genes
* `{GRCh,GRCh38}_mrg_full_gene.bed`: Gene coordinates for full medically relevant gene list.
* `GRCh38_CD4_gaps_slop50.bed`: TODO

### Manually Curated Errors
* `GRCh37_curation_medicalgene_SV_errorsorunsure.bed`: Errors identified through manual curation of all SVs in the CMRG genes.
* `GRCh38_curation_medicalgene_SV_errorsorunsure_repeatexpanded.bed`: GRCh37 SVs errors expanded to completely cover any overlapping homopolymers and tandem repeatsidentified by manual curation lifted over to GRCh38 using NCBI remap.
* `GRCh37_curation_medicalgene_smallvar_complexrepeat_errorsorunsure_repeatexpanded.bed`: TODO
* `{GRCh37,GRCh38}_hifiasm_error.bed` : Assembly error on Chr21 identified through manual curation of clusters of errors identified during evaluation steps of benchmark development
* `HiCanu_2.1_HG002_{GRCh37,GRCh38}_difficult_medical_gene_smallvar_benchmark_v0.02.03_intersected_FPs_repeatexpanded_slop50.bed`: TODO
* `HiCanu_2.1_HG002_GRCh38_difficult_medical_gene_smallvar_benchmark_v0.02.03_intersected_subtract_FPs_repeatexpanded_slop50_manual_curation_sites.tsv_manual_curation_sites.txt`: TODO
* `combined curation responses from benchmarking with sm variant v0.02.03 - GRCh37andGRCh38.tsv`: TODO



