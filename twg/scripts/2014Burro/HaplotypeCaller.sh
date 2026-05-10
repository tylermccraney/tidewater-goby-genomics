#!/bin/bash

gatk \
--java-options "-Xmx6G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
HaplotypeCaller \
--input $HOME/twg/assemblies/mapped/2014Burro04/2014Burro04_sortsam.bam \
--output $HOME/twg/assemblies/mapped/2014Burro04/2014Burro04_haplotypecaller.g.vcf.gz \
--reference $HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
--pair-hmm-implementation AVX_LOGLESS_CACHING_OMP \
--native-pair-hmm-threads 8 \
--emit-ref-confidence GVCF \
--tmp-dir $HOME/twg/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> $HOME/twg/assemblies/mapped/2014Burro04/logs/2014Burro04_haplotypecaller.g.vcf.txt \
& \
gatk \
--java-options "-Xmx6G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
HaplotypeCaller \
--input $HOME/twg/assemblies/mapped/2014Burro13/2014Burro13_sortsam.bam \
--output $HOME/twg/assemblies/mapped/2014Burro13/2014Burro13_haplotypecaller.g.vcf.gz \
--reference $HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
--pair-hmm-implementation AVX_LOGLESS_CACHING_OMP \
--native-pair-hmm-threads 8 \
--emit-ref-confidence GVCF \
--tmp-dir $HOME/twg/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> $HOME/twg/assemblies/mapped/2014Burro13/logs/2014Burro13_haplotypecaller.g.vcf.txt \
& \
gatk \
--java-options "-Xmx6G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
HaplotypeCaller \
--input $HOME/twg/assemblies/mapped/2014Burro15/2014Burro15_sortsam.bam \
--output $HOME/twg/assemblies/mapped/2014Burro15/2014Burro15_haplotypecaller.g.vcf.gz \
--reference $HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
--pair-hmm-implementation AVX_LOGLESS_CACHING_OMP \
--native-pair-hmm-threads 8 \
--emit-ref-confidence GVCF \
--tmp-dir $HOME/twg/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> $HOME/twg/assemblies/mapped/2014Burro15/logs/2014Burro15_haplotypecaller.g.vcf.txt \
& \
gatk \
--java-options "-Xmx6G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
HaplotypeCaller \
--input $HOME/twg/assemblies/mapped/2014Burro16/2014Burro16_sortsam.bam \
--output $HOME/twg/assemblies/mapped/2014Burro16/2014Burro16_haplotypecaller.g.vcf.gz \
--reference $HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
--pair-hmm-implementation AVX_LOGLESS_CACHING_OMP \
--native-pair-hmm-threads 8 \
--emit-ref-confidence GVCF \
--tmp-dir $HOME/twg/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> $HOME/twg/assemblies/mapped/2014Burro16/logs/2014Burro16_haplotypecaller.g.vcf.txt \
& \
gatk \
--java-options "-Xmx6G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
HaplotypeCaller \
--input $HOME/twg/assemblies/mapped/2014Burro19/2014Burro19_sortsam.bam \
--output $HOME/twg/assemblies/mapped/2014Burro19/2014Burro19_haplotypecaller.g.vcf.gz \
--reference $HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
--pair-hmm-implementation AVX_LOGLESS_CACHING_OMP \
--native-pair-hmm-threads 8 \
--emit-ref-confidence GVCF \
--tmp-dir $HOME/twg/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> $HOME/twg/assemblies/mapped/2014Burro19/logs/2014Burro19_haplotypecaller.g.vcf.txt \
& \
gatk \
--java-options "-Xmx6G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
HaplotypeCaller \
--input $HOME/twg/assemblies/mapped/2014Burro20/2014Burro20_sortsam.bam \
--output $HOME/twg/assemblies/mapped/2014Burro20/2014Burro20_haplotypecaller.g.vcf.gz \
--reference $HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
--pair-hmm-implementation AVX_LOGLESS_CACHING_OMP \
--native-pair-hmm-threads 8 \
--emit-ref-confidence GVCF \
--tmp-dir $HOME/twg/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> $HOME/twg/assemblies/mapped/2014Burro20/logs/2014Burro20_haplotypecaller.g.vcf.txt
wait
