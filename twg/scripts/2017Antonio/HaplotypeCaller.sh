#!/bin/bash

gatk \
--java-options "-Xmx6G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
HaplotypeCaller \
--input $HOME/twg/assemblies/mapped/2017Antonio11/2017Antonio11_sortsam.bam \
--output $HOME/twg/assemblies/mapped/2017Antonio11/2017Antonio11_haplotypecaller.g.vcf.gz \
--reference $HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
--pair-hmm-implementation AVX_LOGLESS_CACHING_OMP \
--native-pair-hmm-threads 8 \
--emit-ref-confidence GVCF \
--tmp-dir $HOME/twg/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> $HOME/twg/assemblies/mapped/2017Antonio11/logs/2017Antonio11_haplotypecaller.g.vcf.txt \
& \
gatk \
--java-options "-Xmx6G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
HaplotypeCaller \
--input $HOME/twg/assemblies/mapped/2017Antonio17/2017Antonio17_sortsam.bam \
--output $HOME/twg/assemblies/mapped/2017Antonio17/2017Antonio17_haplotypecaller.g.vcf.gz \
--reference $HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
--pair-hmm-implementation AVX_LOGLESS_CACHING_OMP \
--native-pair-hmm-threads 8 \
--emit-ref-confidence GVCF \
--tmp-dir $HOME/twg/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> $HOME/twg/assemblies/mapped/2017Antonio17/logs/2017Antonio17_haplotypecaller.g.vcf.txt \
& \
gatk \
--java-options "-Xmx6G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
HaplotypeCaller \
--input $HOME/twg/assemblies/mapped/2017Antonio18/2017Antonio18_sortsam.bam \
--output $HOME/twg/assemblies/mapped/2017Antonio18/2017Antonio18_haplotypecaller.g.vcf.gz \
--reference $HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
--pair-hmm-implementation AVX_LOGLESS_CACHING_OMP \
--native-pair-hmm-threads 8 \
--emit-ref-confidence GVCF \
--tmp-dir $HOME/twg/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> $HOME/twg/assemblies/mapped/2017Antonio18/logs/2017Antonio18_haplotypecaller.g.vcf.txt \
& \
gatk \
--java-options "-Xmx6G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
HaplotypeCaller \
--input $HOME/twg/assemblies/mapped/2017Antonio22/2017Antonio22_sortsam.bam \
--output $HOME/twg/assemblies/mapped/2017Antonio22/2017Antonio22_haplotypecaller.g.vcf.gz \
--reference $HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
--pair-hmm-implementation AVX_LOGLESS_CACHING_OMP \
--native-pair-hmm-threads 8 \
--emit-ref-confidence GVCF \
--tmp-dir $HOME/twg/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> $HOME/twg/assemblies/mapped/2017Antonio22/logs/2017Antonio22_haplotypecaller.g.vcf.txt \
& \
gatk \
--java-options "-Xmx6G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
HaplotypeCaller \
--input $HOME/twg/assemblies/mapped/2017Antonio29/2017Antonio29_sortsam.bam \
--output $HOME/twg/assemblies/mapped/2017Antonio29/2017Antonio29_haplotypecaller.g.vcf.gz \
--reference $HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
--pair-hmm-implementation AVX_LOGLESS_CACHING_OMP \
--native-pair-hmm-threads 8 \
--emit-ref-confidence GVCF \
--tmp-dir $HOME/twg/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> $HOME/twg/assemblies/mapped/2017Antonio29/logs/2017Antonio29_haplotypecaller.g.vcf.txt \
& \
gatk \
--java-options "-Xmx6G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
HaplotypeCaller \
--input $HOME/twg/assemblies/mapped/2017Antonio30/2017Antonio30_sortsam.bam \
--output $HOME/twg/assemblies/mapped/2017Antonio30/2017Antonio30_haplotypecaller.g.vcf.gz \
--reference $HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
--pair-hmm-implementation AVX_LOGLESS_CACHING_OMP \
--native-pair-hmm-threads 8 \
--emit-ref-confidence GVCF \
--tmp-dir $HOME/twg/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> $HOME/twg/assemblies/mapped/2017Antonio30/logs/2017Antonio30_haplotypecaller.g.vcf.txt
wait
