#!/usr/bin/env nextflow
/*
==============================
Fecha: NOV 22, 2019
Version: 0.001
Autores: Judith Ballesteros Villascán
Descripción: To count snps in targets, and know its positions.
GIT Repository:
==============================
INITIALIZE PARAMETERS
==============================
Pipeline processes in brief:
Core-Processing:
_001_counts_snps
_002_snps_in_mre
_003_position_in_mre

==============================
*/

/*
PIPELINE START
*/
/* DEFINE INPUT PATHS
/* Load feature files into channel*/
Channel
  .fromPath( "${params.input_dir}/*.vcf.g*" )
    .toList()
//    .view()
   .into{ inputs_for_001; inputs_for_002 }
/*
===========================================
Process for counting snps
===========================================
*/
/* Loading mkfiles*/
Channel
  .fromPath("mkmodules/mk-count-snps/*")
    .toList()
    .set{mkfiles_001}

process _001_counts_snps {
  publishDir "test/results/_001_count_snps/", mode: "copy"
  input:
    file vcf from inputs_for_001
    file mkfiles from mkfiles_001
  output:
    file "*.snps_per_mre.bed" into results_001_count_snps
    """
    export BED_FILE="${params.bed_file}"
    bash runmk.sh
    """
    }

/*
===========================================
Process for listing snps
===========================================
*/

Channel
  .fromPath("mkmodules/mk-snps-in-mre-76g/*")
    .toList()
    //.view()
    .set{mkfiles_002}

process _002_snps_in_mre {
  publishDir "test/results/_002_snps_in_mre/", mode: "copy"
  input:
    file vcf from inputs_for_002
    file mkfiles from mkfiles_002
  output:
    file "*.snps_per_mre.vcf.gz" into results_002_snps_in_mre
    """
    export BED_FILE="${params.bed_file}"
    bash runmk.sh
    """
  }

/*
===========================================
Process for giving position in mre of snp
===========================================
*/
/* Prepare inputs */
results_001_count_snps
//.view()
 .toList()
//.view()
.set{inputs_for_003}

Channel
  .fromPath("mkmodules/mk-position-snp-in-mre/*")
    .toList()
  // .view()
    .set{mkfiles_003}
  process _003_position_in_mre {
  publishDir "test/results/_003_position_in_mre/", mode: "copy"
  input:
    file bed from inputs_for_003
    file mkfiles from mkfiles_003
    file vcf from results_002_snps_in_mre
  output:
    file "*.tsv" into results_003_position_in_mre
    """
    bash runmk.sh
    """
}
