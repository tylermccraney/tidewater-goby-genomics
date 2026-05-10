#!/bin/bash

##gatk \
##--java-options "-Xmx6G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
##HaplotypeCaller \
##--input $HOME/twg/assemblies/mapped/1988Virgin21/1988Virgin21_S224_L003_001_sortsam.bam \
##--output $HOME/twg/assemblies/mapped/1988Virgin21/1988Virgin21_haplotypecaller.g.vcf.gz \
##--reference $HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
##--pair-hmm-implementation AVX_LOGLESS_CACHING_OMP \
##--native-pair-hmm-threads 14 \
##--emit-ref-confidence GVCF \
##--tmp-dir $HOME/twg/tmp \
##--use-jdk-deflater \
##--use-jdk-inflater \
##2> $HOME/twg/assemblies/mapped/1988Virgin21/logs/1988Virgin21_haplotypecaller.g.vcf.txt
##
##gatk \
##--java-options "-Xmx6G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
##HaplotypeCaller \
##--input $HOME/twg/assemblies/mapped/1988Virgin24/1988Virgin24_S0_L001_001_sortsam.bam \
##--output $HOME/twg/assemblies/mapped/1988Virgin24/1988Virgin24_haplotypecaller.g.vcf.gz \
##--reference $HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
##--pair-hmm-implementation AVX_LOGLESS_CACHING_OMP \
##--native-pair-hmm-threads 14 \
##--emit-ref-confidence GVCF \
##--tmp-dir $HOME/twg/tmp \
##--use-jdk-deflater \
##--use-jdk-inflater \
##2> $HOME/twg/assemblies/mapped/1988Virgin24/logs/1988Virgin24_haplotypecaller.g.vcf.txt

gatk \
--java-options "-Xmx6G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
HaplotypeCaller \
--input $HOME/twg/assemblies/mapped/1988Virgin26/1988Virgin26_S226_L003_001_sortsam.bam \
--output $HOME/twg/assemblies/mapped/1988Virgin26/1988Virgin26_haplotypecaller.g.vcf.gz \
--reference $HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
--pair-hmm-implementation AVX_LOGLESS_CACHING_OMP \
--native-pair-hmm-threads 4 \
--emit-ref-confidence GVCF \
--tmp-dir $HOME/twg/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> $HOME/twg/assemblies/mapped/1988Virgin26/logs/1988Virgin26_haplotypecaller.g.vcf.txt \
& \
gatk \
--java-options "-Xmx6G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
HaplotypeCaller \
--input $HOME/twg/assemblies/mapped/1988Virgin28/1988Virgin28_S0_L001_001_sortsam.bam \
--output $HOME/twg/assemblies/mapped/1988Virgin28/1988Virgin28_haplotypecaller.g.vcf.gz \
--reference $HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
--pair-hmm-implementation AVX_LOGLESS_CACHING_OMP \
--native-pair-hmm-threads 4 \
--emit-ref-confidence GVCF \
--tmp-dir $HOME/twg/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> $HOME/twg/assemblies/mapped/1988Virgin28/logs/1988Virgin28_haplotypecaller.g.vcf.txt \
& \
gatk \
--java-options "-Xmx6G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
HaplotypeCaller \
--input $HOME/twg/assemblies/mapped/1988Virgin30/1988Virgin30_S228_L003_001_sortsam.bam \
--output $HOME/twg/assemblies/mapped/1988Virgin30/1988Virgin30_haplotypecaller.g.vcf.gz \
--reference $HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
--pair-hmm-implementation AVX_LOGLESS_CACHING_OMP \
--native-pair-hmm-threads 4 \
--emit-ref-confidence GVCF \
--tmp-dir $HOME/twg/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> $HOME/twg/assemblies/mapped/1988Virgin30/logs/1988Virgin30_haplotypecaller.g.vcf.txt \
& \
gatk \
--java-options "-Xmx6G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
HaplotypeCaller \
--input $HOME/twg/assemblies/mapped/1988Virgin31/1988Virgin31_S0_L001_001_sortsam.bam \
--output $HOME/twg/assemblies/mapped/1988Virgin31/1988Virgin31_haplotypecaller.g.vcf.gz \
--reference $HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
--pair-hmm-implementation AVX_LOGLESS_CACHING_OMP \
--native-pair-hmm-threads 4 \
--emit-ref-confidence GVCF \
--tmp-dir $HOME/twg/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> $HOME/twg/assemblies/mapped/1988Virgin31/logs/1988Virgin31_haplotypecaller.g.vcf.txt
