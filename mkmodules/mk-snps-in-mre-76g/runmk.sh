#!/bin/bash

find -L . \
        -type f \
        -name "*.vcf.gz" \
        ! -name "*.snps_per_mre.vcf.gz" \
| sed "s#.vcf.gz#.snps_per_mre.vcf.gz#" \
| xargs mk $@
