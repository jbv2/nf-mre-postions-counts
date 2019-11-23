#!/bin/#!/usr/bin/env bash

## ENVIRONMENTE VARIABLES REQUIRED
export VCF_FILE="test/data/sample_76g_PASS.snps_per_mre.vcf.gz"
# borrar resultados de prueba anterior
rm -fr test/results/

# Crear un test/results vacío
mkdir -p test/results
bash runmk.sh && rm test/data/*.tmp.bed && mv test/data/*.tsv test/results/ \
 && echo "module test successful"
