#!/bin/#!/usr/bin/env bash

## ENVIRONMENTE VARIABLES REQUIRED
export BED_FILE="test/data/targets_sample.bed"
# borrar resultados de prueba anterior
rm -fr test/results/

# Crear un test/results vacío
mkdir -p test/results
bash runmk.sh && mv test/data/*.snps_per_mre.bed test/results/ && rm test/data/*.all_snps_per_mre.bed \
 && echo "module test successful"
