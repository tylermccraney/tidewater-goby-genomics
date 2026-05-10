#!/bin/bash

gatk \
--java-options "-Xmx6G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
HaplotypeCaller \
--input $HOME/twg/assemblies/mapped/2009Arcata01/2009Arcata01_S0_L001_001_sortsam.bam \
--output $HOME/twg/assemblies/mapped/2009Arcata01/2009Arcata01_haplotypecaller.g.vcf.gz \
--reference $HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
--pair-hmm-implementation AVX_LOGLESS_CACHING_OMP \
--native-pair-hmm-threads 4 \
--emit-ref-confidence GVCF \
--tmp-dir $HOME/twg/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> $HOME/twg/assemblies/mapped/2009Arcata01/logs/2009Arcata01_haplotypecaller.g.vcf.txt \
& \
gatk \
--java-options "-Xmx6G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
HaplotypeCaller \
--input $HOME/twg/assemblies/mapped/2009Arcata02/2009Arcata02_S231_L003_001_sortsam.bam \
--output $HOME/twg/assemblies/mapped/2009Arcata02/2009Arcata02_haplotypecaller.g.vcf.gz \
--reference $HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
--pair-hmm-implementation AVX_LOGLESS_CACHING_OMP \
--native-pair-hmm-threads 4 \
--emit-ref-confidence GVCF \
--tmp-dir $HOME/twg/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> $HOME/twg/assemblies/mapped/2009Arcata02/logs/2009Arcata02_haplotypecaller.g.vcf.txt \
& \
gatk \
--java-options "-Xmx6G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
HaplotypeCaller \
--input $HOME/twg/assemblies/mapped/2009Arcata03/2009Arcata03_S0_L001_001_sortsam.bam \
--output $HOME/twg/assemblies/mapped/2009Arcata03/2009Arcata03_haplotypecaller.g.vcf.gz \
--reference $HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
--pair-hmm-implementation AVX_LOGLESS_CACHING_OMP \
--native-pair-hmm-threads 4 \
--emit-ref-confidence GVCF \
--tmp-dir $HOME/twg/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> $HOME/twg/assemblies/mapped/2009Arcata03/logs/2009Arcata03_haplotypecaller.g.vcf.txt \
& \
gatk \
--java-options "-Xmx6G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
HaplotypeCaller \
--input $HOME/twg/assemblies/mapped/2009Arcata04/2009Arcata04_S0_L001_001_sortsam.bam \
--output $HOME/twg/assemblies/mapped/2009Arcata04/2009Arcata04_haplotypecaller.g.vcf.gz \
--reference $HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
--pair-hmm-implementation AVX_LOGLESS_CACHING_OMP \
--native-pair-hmm-threads 4 \
--emit-ref-confidence GVCF \
--tmp-dir $HOME/twg/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> $HOME/twg/assemblies/mapped/2009Arcata04/logs/2009Arcata04_haplotypecaller.g.vcf.txt \
& \
gatk \
--java-options "-Xmx6G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
HaplotypeCaller \
--input $HOME/twg/assemblies/mapped/2009Arcata05/2009Arcata05_S234_L003_001_sortsam.bam \
--output $HOME/twg/assemblies/mapped/2009Arcata05/2009Arcata05_haplotypecaller.g.vcf.gz \
--reference $HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
--pair-hmm-implementation AVX_LOGLESS_CACHING_OMP \
--native-pair-hmm-threads 4 \
--emit-ref-confidence GVCF \
--tmp-dir $HOME/twg/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> $HOME/twg/assemblies/mapped/2009Arcata05/logs/2009Arcata05_haplotypecaller.g.vcf.txt \
& \
gatk \
--java-options "-Xmx6G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
HaplotypeCaller \
--input $HOME/twg/assemblies/mapped/2009Arcata06/2009Arcata06_S0_L001_001_sortsam.bam \
--output $HOME/twg/assemblies/mapped/2009Arcata06/2009Arcata06_haplotypecaller.g.vcf.gz \
--reference $HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
--pair-hmm-implementation AVX_LOGLESS_CACHING_OMP \
--native-pair-hmm-threads 4 \
--emit-ref-confidence GVCF \
--tmp-dir $HOME/twg/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> $HOME/twg/assemblies/mapped/2009Arcata06/logs/2009Arcata06_haplotypecaller.g.vcf.txt


##gatk \
##--java-options "-Xmx6G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
##HaplotypeCaller \
##--input $HOME/twg/assemblies/mapped/2009Arcata20/2009Arcata20_sortsam.bam \
##--output $HOME/twg/assemblies/mapped/2009Arcata20/2009Arcata20_haplotypecaller.g.vcf.gz \
##--reference $HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
##--pair-hmm-implementation AVX_LOGLESS_CACHING_OMP \
##--native-pair-hmm-threads 8 \
##--emit-ref-confidence GVCF \
##--tmp-dir $HOME/twg/tmp \
##--use-jdk-deflater \
##--use-jdk-inflater \
##2> $HOME/twg/assemblies/mapped/2009Arcata20/logs/2009Arcata20_haplotypecaller.g.vcf.txt \
##& \
##gatk \
##--java-options "-Xmx6G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
##HaplotypeCaller \
##--input $HOME/twg/assemblies/mapped/2009Arcata21/2009Arcata21_sortsam.bam \
##--output $HOME/twg/assemblies/mapped/2009Arcata21/2009Arcata21_haplotypecaller.g.vcf.gz \
##--reference $HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
##--pair-hmm-implementation AVX_LOGLESS_CACHING_OMP \
##--native-pair-hmm-threads 8 \
##--emit-ref-confidence GVCF \
##--tmp-dir $HOME/twg/tmp \
##--use-jdk-deflater \
##--use-jdk-inflater \
##2> $HOME/twg/assemblies/mapped/2009Arcata21/logs/2009Arcata21_haplotypecaller.g.vcf.txt
