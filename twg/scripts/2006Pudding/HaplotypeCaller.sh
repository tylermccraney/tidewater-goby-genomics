#!/bin/bash

gatk \
--java-options "-Xmx6G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
HaplotypeCaller \
--input $HOME/twg/assemblies/mapped/2006Pudding16/2006Pudding16_sortsam.bam \
--output $HOME/twg/assemblies/mapped/2006Pudding16/2006Pudding16_haplotypecaller.g.vcf.gz \
--reference $HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
--pair-hmm-implementation AVX_LOGLESS_CACHING_OMP \
--native-pair-hmm-threads 8 \
--emit-ref-confidence GVCF \
--tmp-dir $HOME/twg/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> $HOME/twg/assemblies/mapped/2006Pudding16/logs/2006Pudding16_haplotypecaller.g.vcf.txt \
& \
gatk \
--java-options "-Xmx6G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
HaplotypeCaller \
--input $HOME/twg/assemblies/mapped/2006Pudding21/2006Pudding21_sortsam.bam \
--output $HOME/twg/assemblies/mapped/2006Pudding21/2006Pudding21_haplotypecaller.g.vcf.gz \
--reference $HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
--pair-hmm-implementation AVX_LOGLESS_CACHING_OMP \
--native-pair-hmm-threads 8 \
--emit-ref-confidence GVCF \
--tmp-dir $HOME/twg/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> $HOME/twg/assemblies/mapped/2006Pudding21/logs/2006Pudding21_haplotypecaller.g.vcf.txt \
& \
gatk \
--java-options "-Xmx6G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
HaplotypeCaller \
--input $HOME/twg/assemblies/mapped/2006Pudding25/2006Pudding25_sortsam.bam \
--output $HOME/twg/assemblies/mapped/2006Pudding25/2006Pudding25_haplotypecaller.g.vcf.gz \
--reference $HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
--pair-hmm-implementation AVX_LOGLESS_CACHING_OMP \
--native-pair-hmm-threads 8 \
--emit-ref-confidence GVCF \
--tmp-dir $HOME/twg/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> $HOME/twg/assemblies/mapped/2006Pudding25/logs/2006Pudding25_haplotypecaller.g.vcf.txt \
& \
gatk \
--java-options "-Xmx6G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
HaplotypeCaller \
--input $HOME/twg/assemblies/mapped/2006Pudding31/2006Pudding31_sortsam.bam \
--output $HOME/twg/assemblies/mapped/2006Pudding31/2006Pudding31_haplotypecaller.g.vcf.gz \
--reference $HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
--pair-hmm-implementation AVX_LOGLESS_CACHING_OMP \
--native-pair-hmm-threads 8 \
--emit-ref-confidence GVCF \
--tmp-dir $HOME/twg/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> $HOME/twg/assemblies/mapped/2006Pudding31/logs/2006Pudding31_haplotypecaller.g.vcf.txt \
& \
gatk \
--java-options "-Xmx6G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
HaplotypeCaller \
--input $HOME/twg/assemblies/mapped/2006Pudding41/2006Pudding41_sortsam.bam \
--output $HOME/twg/assemblies/mapped/2006Pudding41/2006Pudding41_haplotypecaller.g.vcf.gz \
--reference $HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
--pair-hmm-implementation AVX_LOGLESS_CACHING_OMP \
--native-pair-hmm-threads 8 \
--emit-ref-confidence GVCF \
--tmp-dir $HOME/twg/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> $HOME/twg/assemblies/mapped/2006Pudding41/logs/2006Pudding41_haplotypecaller.g.vcf.txt \
& \
gatk \
--java-options "-Xmx6G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
HaplotypeCaller \
--input $HOME/twg/assemblies/mapped/2006Pudding47/2006Pudding47_sortsam.bam \
--output $HOME/twg/assemblies/mapped/2006Pudding47/2006Pudding47_haplotypecaller.g.vcf.gz \
--reference $HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
--pair-hmm-implementation AVX_LOGLESS_CACHING_OMP \
--native-pair-hmm-threads 8 \
--emit-ref-confidence GVCF \
--tmp-dir $HOME/twg/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> $HOME/twg/assemblies/mapped/2006Pudding47/logs/2006Pudding47_haplotypecaller.g.vcf.txt
wait
