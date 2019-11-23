#!/bin/bash

find -L . \
        -type f \
        -name "*.snps_per_mre.bed" \
        ! -name "*.position.bed" \
| sed "s#.bed#.positions_in_mre.tsv#" \
| xargs mk $@
