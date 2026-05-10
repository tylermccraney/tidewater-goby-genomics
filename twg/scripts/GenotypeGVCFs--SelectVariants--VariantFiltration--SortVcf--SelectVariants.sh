#!/bin/bash

### Process genotypes with GenotypeGVCFs
##gatk \
##--java-options "-Xmx4G -XX:+UseParallelGC -XX:ParallelGCThreads=2" \
##GenotypeGVCFs \
##--variant gendb://$HOME/twg/variants/GenomicsDB \
##--output $HOME/twg/variants/genotypeg.vcf.gz \
##--reference $HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
##--tmp-dir $HOME/twg/tmp \
##2> $HOME/twg/variants/logs/genotypeg.vcf.txt

# Select and hard-filter SNPs with SelectVariants and VariantFiltration, respectively
gatk \
--java-options "-Xmx4G -XX:+UseParallelGC -XX:ParallelGCThreads=2" \
SelectVariants \
--variant $HOME/twg/variants/genotypeg.vcf.gz \
--output $HOME/twg/variants/snps_selectvariants.vcf.gz \
--select-type-to-include SNP \
--tmp-dir $HOME/twg/tmp \
2> $HOME/twg/variants/logs/snps_selectvariants.txt

gatk \
--java-options "-Xmx4G -XX:+UseParallelGC -XX:ParallelGCThreads=2" \
VariantFiltration \
--variant $HOME/twg/variants/snps_selectvariants.vcf.gz \
--output $HOME/twg/variants/snps_variantfiltration.vcf.gz \
--filter-name 'QD2' --filter-expression 'QD < 2.0' \
--filter-name 'QUAL30' --filter-expression 'QUAL < 30.0' \
--filter-name 'SOR3' --filter-expression 'SOR > 3.0' \
--filter-name 'FS60' --filter-expression 'FS > 60.0' \
--filter-name 'MQ40' --filter-expression 'MQ < 40.0' \
--filter-name 'MQRankSum-12.5' --filter-expression 'MQRankSum < -12.5' \
--filter-name 'ReadPosRankSum-8' --filter-expression 'ReadPosRankSum < -8.0' \
--tmp-dir $HOME/twg/tmp \
2> $HOME/twg/variants/logs/snps_variantfiltration.txt

# Select and hard-filter INDELs with SelectVariants and VariantFiltration, respectively
gatk \
--java-options "-Xmx4G -XX:+UseParallelGC -XX:ParallelGCThreads=2" \
SelectVariants \
--variant $HOME/twg/variants/genotypeg.vcf.gz \
--output $HOME/twg/variants/indels_selectvariants.vcf.gz \
--select-type-to-include INDEL \
--select-type-to-include MIXED \
--tmp-dir $HOME/twg/tmp \
2> $HOME/twg/variants/logs/indels_selectvariants.txt

gatk \
--java-options "-Xmx4G -XX:+UseParallelGC -XX:ParallelGCThreads=2" \
VariantFiltration \
--variant $HOME/twg/variants/indels_selectvariants.vcf.gz \
--output $HOME/twg/variants/indels_variantfiltration.vcf.gz \
--filter-name 'QD2' --filter-expression 'QD < 2.0' \
--filter-name 'QUAL30' --filter-expression 'QUAL < 30.0' \
--filter-name 'FS200' --filter-expression 'FS > 200.0' \
--filter-name 'ReadPosRankSum-20' --filter-expression 'ReadPosRankSum < -20.0' \
--tmp-dir $HOME/twg/tmp \
2> $HOME/twg/variants/logs/indels_variantfiltration.txt

# Merge SNPs and INDELs with SortVcf
java \
-Xmx10G \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=2 \
-jar $HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
SortVcf \
I=$HOME/twg/variants/snps_variantfiltration.vcf.gz \
I=$HOME/twg/variants/indels_variantfiltration.vcf.gz \
O=$HOME/twg/variants/sort.vcf.gz \
TMP_DIR=$HOME/twg/tmp \
2> $HOME/twg/variants/logs/sort.vcf.txt

# Remove hard-filtered variants with SelectVariants
gatk \
--java-options "-Xmx10G -XX:+UseParallelGC -XX:ParallelGCThreads=2" \
SelectVariants \
--variant $HOME/twg/variants/sort.vcf.gz \
--output $HOME/twg/variants/selectvariants.vcf.gz \
--exclude-filtered \
--tmp-dir $HOME/twg/tmp \
2> $HOME/twg/variants/logs/selectvariants.txt
