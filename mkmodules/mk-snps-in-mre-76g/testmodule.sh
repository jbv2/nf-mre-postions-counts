#!/bin/#!/usr/bin/env bash

## ENVIRONMENTE VARIABLES REQUIRED
export BED_FILE="test/data/targets_sample.bed"
# borrar resultados de prueba anterior
rm -fr test/results/

# Crear un test/results vacío
mkdir -p test/results
bash runmk.sh && mv test/data/*.mre_snps.vcf.gz test/results/ \
 && echo "module test successful"
