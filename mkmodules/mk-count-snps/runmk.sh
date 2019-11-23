#!/bin/bash

find -L . \
        -type f \
        -name "*.vcf.gz" \
| sed "s#.vcf.gz#.snps_per_mre.bed#" \
| xargs mk $@
