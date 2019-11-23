#!/bin/bash

find -L . \
        -type f \
        -name "*.vcf.gz" \
        ! -name "*.mre_snps.vcf.gz" \
| sed "s#.vcf.gz#.mre_snps.vcf.gz#" \
| xargs mk $@
