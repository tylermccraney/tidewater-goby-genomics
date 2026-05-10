#!/bin/bash

cd /home/wtm3/twg/popgen/pops

cat 2009Arcata.txt 2006Big.txt 2021Big.txt > Big_Arcata.txt

# find/filter singletons and recode callset
vcftools \
--gzvcf /home/wtm3/twg/variants/selectvariants.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/Big_Arcata.txt \
--max-alleles 2 \
--max-missing 1 \
--min-alleles 2 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata \
--singletons \
--remove-filtered-all

cat /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata.singletons | \
awk '{print $1"\t"$2}' | \
sed '1 s/./#&/' \
> /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata.singletons.tab

vcftools \
--exclude-positions /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata.singletons.tab \
--gzvcf /home/wtm3/twg/variants/selectvariants.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/Big_Arcata.txt \
--max-alleles 2 \
--max-missing 1 \
--min-alleles 2 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata \
--recode \
--remove-filtered-all

gzip /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata.recode.vcf

# fst
vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata.recode.vcf.gz \
--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Big.txt \
--weir-fst-pop /home/wtm3/twg/popgen/pops/2021Big.txt \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Big_vs_2021Big_fst

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata.recode.vcf.gz \
--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Big.txt \
--weir-fst-pop /home/wtm3/twg/popgen/pops/2009Arcata.txt \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Big_vs_2009Arcata_fst

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata.recode.vcf.gz \
--weir-fst-pop /home/wtm3/twg/popgen/pops/2009Arcata.txt \
--weir-fst-pop /home/wtm3/twg/popgen/pops/2021Big.txt \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Big_vs_2009Arcata_fst

# allele frequency
vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2006Big.txt \
--freq2 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Big_freq2

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2021Big.txt \
--freq2 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2021Big_freq2

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2009Arcata.txt \
--freq2 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2009Arcata_freq2

# heterozygosity
vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2006Big.txt \
--het \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Big_het

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2021Big.txt \
--het \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2021Big_het

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2009Arcata.txt \
--het \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2009Arcata_het

# window pi
vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2006Big.txt \
--window-pi 1000000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Big_1Mb_pi

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2006Big.txt \
--window-pi 2000000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Big_2Mb_pi

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2006Big.txt \
--window-pi 3000000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Big_3Mb_pi

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2021Big.txt \
--window-pi 1000000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2021Big_1Mb_pi

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2021Big.txt \
--window-pi 2000000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2021Big_2Mb_pi

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2021Big.txt \
--window-pi 3000000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2021Big_3Mb_pi

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2009Arcata.txt \
--window-pi 1000000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2009Arcata_1Mb_pi

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2009Arcata.txt \
--window-pi 2000000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2009Arcata_2Mb_pi

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2009Arcata.txt \
--window-pi 3000000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2009Arcata_3Mb_pi

# window Tajima's D
vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2006Big.txt \
--TajimaD 1000000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Big_1Mb_TajimaD

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2006Big.txt \
--TajimaD 2000000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Big_2Mb_TajimaD

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2006Big.txt \
--TajimaD 3000000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Big_3Mb_TajimaD

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2021Big.txt \
--TajimaD 1000000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2021Big_1Mb_TajimaD

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2021Big.txt \
--TajimaD 2000000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2021Big_2Mb_TajimaD

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2021Big.txt \
--TajimaD 3000000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2021Big_3Mb_TajimaD

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2009Arcata.txt \
--TajimaD 1000000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2009Arcata_1Mb_TajimaD

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2009Arcata.txt \
--TajimaD 2000000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2009Arcata_2Mb_TajimaD

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2009Arcata.txt \
--TajimaD 3000000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2009Arcata_3Mb_TajimaD

# site mean depth
vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2006Big.txt \
--site-mean-depth \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Big_site_mean_depth

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2021Big.txt \
--site-mean-depth \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2021Big_site_mean_depth

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2009Arcata.txt \
--site-mean-depth \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2009Arcata_site_mean_depth

# depth
vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2006Big.txt \
--depth \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Big_depth

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2021Big.txt \
--depth \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2021Big_depth

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2009Arcata.txt \
--depth \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2009Arcata_depth


##########################################################################################

# SNPs only
vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata.recode.vcf.gz \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs \
--recode \
--remove-filtered-all \
--remove-indels

gzip /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf

# fst
vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Big.txt \
--weir-fst-pop /home/wtm3/twg/popgen/pops/2021Big.txt \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Big_vs_2021Big_fst_SNPs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Big.txt \
--weir-fst-pop /home/wtm3/twg/popgen/pops/2009Arcata.txt \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Big_vs_2009Arcata_fst_SNPs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--weir-fst-pop /home/wtm3/twg/popgen/pops/2009Arcata.txt \
--weir-fst-pop /home/wtm3/twg/popgen/pops/2021Big.txt \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Big_vs_2009Arcata_fst_SNPs

# allele frequency
vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2006Big.txt \
--freq2 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Big_freq2_SNPs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2021Big.txt \
--freq2 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2021Big_freq2_SNPs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2009Arcata.txt \
--freq2 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2009Arcata_freq2_SNPs

# heterozygosity
vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2006Big.txt \
--het \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Big_het_SNPs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2021Big.txt \
--het \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2021Big_het_SNPs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2009Arcata.txt \
--het \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2009Arcata_het_SNPs

# window pi
vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2006Big.txt \
--window-pi 1000000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Big_1Mb_pi_SNPs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2006Big.txt \
--window-pi 2000000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Big_2Mb_pi_SNPs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2006Big.txt \
--window-pi 3000000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Big_3Mb_pi_SNPs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2021Big.txt \
--window-pi 1000000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2021Big_1Mb_pi_SNPs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2021Big.txt \
--window-pi 2000000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2021Big_2Mb_pi_SNPs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2021Big.txt \
--window-pi 3000000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2021Big_3Mb_pi_SNPs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2009Arcata.txt \
--window-pi 1000000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2009Arcata_1Mb_pi_SNPs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2009Arcata.txt \
--window-pi 2000000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2009Arcata_2Mb_pi_SNPs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2009Arcata.txt \
--window-pi 3000000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2009Arcata_3Mb_pi_SNPs

# window Tajima's D
vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2006Big.txt \
--TajimaD 1000000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Big_1Mb_TajimaD_SNPs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2006Big.txt \
--TajimaD 2000000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Big_2Mb_TajimaD_SNPs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2006Big.txt \
--TajimaD 3000000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Big_3Mb_TajimaD_SNPs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2021Big.txt \
--TajimaD 1000000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2021Big_1Mb_TajimaD_SNPs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2021Big.txt \
--TajimaD 2000000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2021Big_2Mb_TajimaD_SNPs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2021Big.txt \
--TajimaD 3000000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2021Big_3Mb_TajimaD_SNPs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2009Arcata.txt \
--TajimaD 1000000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2009Arcata_1Mb_TajimaD_SNPs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2009Arcata.txt \
--TajimaD 2000000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2009Arcata_2Mb_TajimaD_SNPs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2009Arcata.txt \
--TajimaD 3000000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2009Arcata_3Mb_TajimaD_SNPs

# depth
vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2006Big.txt \
--depth \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Big_depth_SNPs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2021Big.txt \
--depth \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2021Big_depth_SNPs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2009Arcata.txt \
--depth \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2009Arcata_depth_SNPs

# window pi
vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2006Big.txt \
--window-pi 10000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Big_10Kb_pi_SNPs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2006Big.txt \
--window-pi 20000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Big_20Kb_pi_SNPs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2006Big.txt \
--window-pi 30000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Big_30Kb_pi_SNPs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2021Big.txt \
--window-pi 10000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2021Big_10Kb_pi_SNPs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2021Big.txt \
--window-pi 20000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2021Big_20Kb_pi_SNPs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2021Big.txt \
--window-pi 30000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2021Big_30Kb_pi_SNPs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2009Arcata.txt \
--window-pi 10000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2009Arcata_10Kb_pi_SNPs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2009Arcata.txt \
--window-pi 20000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2009Arcata_20Kb_pi_SNPs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2009Arcata.txt \
--window-pi 30000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2009Arcata_30Kb_pi_SNPs

# window Tajima's D
vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2006Big.txt \
--TajimaD 10000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Big_10Kb_TajimaD_SNPs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2006Big.txt \
--TajimaD 20000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Big_20Kb_TajimaD_SNPs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2006Big.txt \
--TajimaD 30000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Big_30Kb_TajimaD_SNPs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2021Big.txt \
--TajimaD 10000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2021Big_10Kb_TajimaD_SNPs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2021Big.txt \
--TajimaD 20000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2021Big_20Kb_TajimaD_SNPs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2021Big.txt \
--TajimaD 30000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2021Big_30Kb_TajimaD_SNPs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2009Arcata.txt \
--TajimaD 10000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2009Arcata_10Kb_TajimaD_SNPs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2009Arcata.txt \
--TajimaD 20000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2009Arcata_20Kb_TajimaD_SNPs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2009Arcata.txt \
--TajimaD 30000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2009Arcata_30Kb_TajimaD_SNPs

# window pi
vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2006Big.txt \
--window-pi 100000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Big_100Kb_pi_SNPs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2006Big.txt \
--window-pi 200000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Big_200Kb_pi_SNPs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2006Big.txt \
--window-pi 500000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Big_500Kb_pi_SNPs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2021Big.txt \
--window-pi 100000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2021Big_100Kb_pi_SNPs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2021Big.txt \
--window-pi 200000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2021Big_200Kb_pi_SNPs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2021Big.txt \
--window-pi 500000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2021Big_500Kb_pi_SNPs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2009Arcata.txt \
--window-pi 100000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2009Arcata_100Kb_pi_SNPs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2009Arcata.txt \
--window-pi 200000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2009Arcata_200Kb_pi_SNPs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2009Arcata.txt \
--window-pi 500000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2009Arcata_500Kb_pi_SNPs

# window Tajima's D
vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2006Big.txt \
--TajimaD 100000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Big_100Kb_TajimaD_SNPs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2006Big.txt \
--TajimaD 200000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Big_200Kb_TajimaD_SNPs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2006Big.txt \
--TajimaD 500000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Big_500Kb_TajimaD_SNPs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2021Big.txt \
--TajimaD 100000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2021Big_100Kb_TajimaD_SNPs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2021Big.txt \
--TajimaD 200000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2021Big_200Kb_TajimaD_SNPs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2021Big.txt \
--TajimaD 500000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2021Big_500Kb_TajimaD_SNPs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2009Arcata.txt \
--TajimaD 100000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2009Arcata_100Kb_TajimaD_SNPs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2009Arcata.txt \
--TajimaD 200000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2009Arcata_200Kb_TajimaD_SNPs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_SNPs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2009Arcata.txt \
--TajimaD 500000 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2009Arcata_500Kb_TajimaD_SNPs


##########################################################################################

# INDELs only
vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata.recode.vcf.gz \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_INDELs \
--recode \
--remove-filtered-all \
--keep-only-indels

gzip /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_INDELs.recode.vcf

# fst
vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_INDELs.recode.vcf.gz \
--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Big.txt \
--weir-fst-pop /home/wtm3/twg/popgen/pops/2021Big.txt \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Big_vs_2021Big_fst_INDELs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_INDELs.recode.vcf.gz \
--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Big.txt \
--weir-fst-pop /home/wtm3/twg/popgen/pops/2009Arcata.txt \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Big_vs_2009Arcata_fst_INDELs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_INDELs.recode.vcf.gz \
--weir-fst-pop /home/wtm3/twg/popgen/pops/2009Arcata.txt \
--weir-fst-pop /home/wtm3/twg/popgen/pops/2021Big.txt \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Big_vs_2009Arcata_fst_INDELs

# allele frequency
vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_INDELs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2006Big.txt \
--freq2 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Big_freq2_INDELs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_INDELs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2021Big.txt \
--freq2 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2021Big_freq2_INDELs

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_Arcata_INDELs.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2009Arcata.txt \
--freq2 \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2009Arcata_freq2_INDELs

