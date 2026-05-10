#!/bin/bash

beagle \
burnin=5 \
excludemarkers=$HOME/twg/popgen/beagle/2011-21.snps.100p.exclude.txt \
gt=$HOME/twg/popgen/vcftools/evo-scale/2011-21.snps.100p.recode.vcf.gz \
impute=false \
iterations=20 \
nthreads=160 \
out=$HOME/twg/popgen/beagle/2011-21.snps.100p \
seed=$RANDOM
