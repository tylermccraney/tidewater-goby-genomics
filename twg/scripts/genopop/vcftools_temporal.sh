#!/bin/bash

##cd /home/wtm3/twg/popgen/pops
##
##cat 2006Stone.txt 2021Stone.txt > Stone.txt
##cat 2006Big.txt 2021Big.txt > Big.txt
##cat 2006Virgin.txt 2021Virgin.txt > Virgin.txt
##cat 2006Pudding.txt 2021Pudding.txt > Pudding.txt
##
##cat 2006Stone.txt 2021Stone.txt 2006Big.txt 2021Big.txt 1988Virgin.txt 2006Virgin.txt 2021Virgin.txt 2006Pudding.txt 2021Pudding.txt > Mendocino_Humboldt_1988-2021.txt
##
### find/filter singletons and recode callsets
##vcftools \
##--gzvcf /home/wtm3/twg/variants/selectvariants.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/Mendocino_Humboldt_1988-2021.txt \
##--max-alleles 2 \
##--max-missing 1 \
##--min-alleles 2 \
##--out /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_Humboldt_1988-2021 \
##--singletons \
##--remove-filtered-all
##
##cat /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_Humboldt_1988-2021.singletons | \
##awk '{print $1"\t"$2}' | \
##sed '1 s/./#&/' \
##> /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_Humboldt_1988-2021.singletons.tab
##
##echo -n "#" | \
##cat - /home/wtm3/twg/popgen/pairwise-fst/temporal/Humboldt_2006-2021.singletons.tab \
##> /home/wtm3/twg/popgen/pairwise-fst/temporal/Humboldt_2006-2021.singletons.exclude
##
##vcftools \
##--exclude-positions /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_Humboldt_1988-2021.singletons.tab \
##--gzvcf /home/wtm3/twg/variants/selectvariants.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/Mendocino_Humboldt_1988-2021.txt \
##--max-alleles 2 \
##--max-missing 1 \
##--min-alleles 2 \
##--out /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_Humboldt_1988-2021 \
##--recode \
##--remove-filtered-all
##
##gzip /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_Humboldt_1988-2021.recode.vcf
##
### Mendocino
##vcftools \
##--gzvcf /home/wtm3/twg/variants/selectvariants.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/Mendocino_1988-2021.txt \
##--max-alleles 2 \
##--max-missing 1 \
##--min-alleles 2 \
##--out /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_1988-2021 \
##--singletons \
##--remove-filtered-all
##
##cat /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_1988-2021.singletons | \
##awk '{print $1"\t"$2}' \
##> /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_1988-2021.singletons.tab
##
##echo -n "#" | \
##cat - /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_1988-2021.singletons.tab \
##> /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_1988-2021.singletons.exclude
##
##vcftools \
##--exclude-positions /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_1988-2021.singletons.exclude \
##--gzvcf /home/wtm3/twg/variants/selectvariants.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/Mendocino_1988-2021.txt \
##--max-alleles 2 \
##--max-missing 1 \
##--min-alleles 2 \
##--out /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_1988-2021 \
##--recode \
##--remove-filtered-all
##
##gzip /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_1988-2021.recode.vcf
##
##
### fst
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_Humboldt_1988-2021.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Stone.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2021Stone.txt \
##--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Stone_vs_2021Stone_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_Humboldt_1988-2021.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Big.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2021Big.txt \
##--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Big_vs_2021Big_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_Humboldt_1988-2021.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/1988Virgin.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Virgin.txt \
##--out /home/wtm3/twg/popgen/pairwise-fst/temporal/1988Virgin_vs_2006Virgin_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_Humboldt_1988-2021.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/1988Virgin.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2021Virgin.txt \
##--out /home/wtm3/twg/popgen/pairwise-fst/temporal/1988Virgin_vs_2021Virgin_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_Humboldt_1988-2021.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Virgin.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2021Virgin.txt \
##--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Virgin_vs_2021Virgin_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_Humboldt_1988-2021.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/1988Virgin.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Virgin.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2021Virgin.txt \
##--out /home/wtm3/twg/popgen/pairwise-fst/temporal/1988Virgin_vs_2006Virgin_vs_2021Virgin_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_Humboldt_1988-2021.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Pudding.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2021Pudding.txt \
##--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Pudding_vs_2021Pudding_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_Humboldt_1988-2021.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/Stone.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/Big.txt \
##--out /home/wtm3/twg/popgen/pairwise-fst/temporal/Stone_vs_Big_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_Humboldt_1988-2021.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/Big.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/Virgin.txt \
##--out /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_vs_Virgin_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_Humboldt_1988-2021.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/Virgin.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/Pudding.txt \
##--out /home/wtm3/twg/popgen/pairwise-fst/temporal/Virgin_vs_Pudding_fst
##
### allele frequency
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_Humboldt_1988-2021.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2006Stone.txt \
##--keep /home/wtm3/twg/popgen/pops/2021Stone.txt \
##--freq2 \
##--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Stone_vs_2021Stone_freq2
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_Humboldt_1988-2021.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2006Big.txt \
##--keep /home/wtm3/twg/popgen/pops/2021Big.txt \
##--freq2 \
##--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Big_vs_2021Big_freq2
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_Humboldt_1988-2021.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/1988Virgin.txt \
##--keep /home/wtm3/twg/popgen/pops/2006Virgin.txt \
##--freq2 \
##--out /home/wtm3/twg/popgen/pairwise-fst/temporal/1988Virgin_vs_2006Virgin_freq2
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_Humboldt_1988-2021.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/1988Virgin.txt \
##--keep /home/wtm3/twg/popgen/pops/2021Virgin.txt \
##--freq2 \
##--out /home/wtm3/twg/popgen/pairwise-fst/temporal/1988Virgin_vs_2021Virgin_freq2
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_Humboldt_1988-2021.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2006Virgin.txt \
##--keep /home/wtm3/twg/popgen/pops/2021Virgin.txt \
##--freq2 \
##--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Virgin_vs_2021Virgin_freq2
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_Humboldt_1988-2021.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/1988Virgin.txt \
##--keep /home/wtm3/twg/popgen/pops/2006Virgin.txt \
##--keep /home/wtm3/twg/popgen/pops/2021Virgin.txt \
##--freq2 \
##--out /home/wtm3/twg/popgen/pairwise-fst/temporal/1988Virgin_vs_2006Virgin_vs_2021Virgin_freq2
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_Humboldt_1988-2021.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2006Pudding.txt \
##--keep /home/wtm3/twg/popgen/pops/2021Pudding.txt \
##--freq2 \
##--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Pudding_vs_2021Pudding_freq2
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_Humboldt_1988-2021.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2006Stone.txt \
##--freq2 \
##--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Stone_freq2
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_Humboldt_1988-2021.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2021Stone.txt \
##--freq2 \
##--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2021Stone_freq2
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_Humboldt_1988-2021.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2006Big.txt \
##--freq2 \
##--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Big_freq2
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_Humboldt_1988-2021.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2021Big.txt \
##--freq2 \
##--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2021Big_freq2
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_Humboldt_1988-2021.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/1988Virgin.txt \
##--freq2 \
##--out /home/wtm3/twg/popgen/pairwise-fst/temporal/1988Virgin_freq2
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_Humboldt_1988-2021.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2006Virgin.txt \
##--freq2 \
##--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Virgin_freq2
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_Humboldt_1988-2021.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2021Virgin.txt \
##--freq2 \
##--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2021Virgin_freq2
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_Humboldt_1988-2021.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2006Pudding.txt \
##--freq2 \
##--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Pudding_freq2
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_Humboldt_1988-2021.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2021Pudding.txt \
##--freq2 \
##--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2021Pudding_freq2
##
### SNPs only
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_Humboldt_1988-2021.recode.vcf.gz \
##--out /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_Humboldt_1988-2021_SNPs \
##--recode \
##--remove-filtered-all \
##--remove-indels
##
##gzip /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_Humboldt_1988-2021_SNPs.recode.vcf

# fst
vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_Humboldt_1988-2021_SNPs.recode.vcf.gz \
--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Stone.txt \
--weir-fst-pop /home/wtm3/twg/popgen/pops/2021Stone.txt \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Stone_vs_2021Stone_fst

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_Humboldt_1988-2021_SNPs.recode.vcf.gz \
--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Big.txt \
--weir-fst-pop /home/wtm3/twg/popgen/pops/2021Big.txt \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Big_vs_2021Big_fst

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_Humboldt_1988-2021_SNPs.recode.vcf.gz \
--weir-fst-pop /home/wtm3/twg/popgen/pops/1988Virgin.txt \
--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Virgin.txt \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/1988Virgin_vs_2006Virgin_fst

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_Humboldt_1988-2021_SNPs.recode.vcf.gz \
--weir-fst-pop /home/wtm3/twg/popgen/pops/1988Virgin.txt \
--weir-fst-pop /home/wtm3/twg/popgen/pops/2021Virgin.txt \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/1988Virgin_vs_2021Virgin_fst

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_Humboldt_1988-2021_SNPs.recode.vcf.gz \
--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Virgin.txt \
--weir-fst-pop /home/wtm3/twg/popgen/pops/2021Virgin.txt \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Virgin_vs_2021Virgin_fst

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_Humboldt_1988-2021_SNPs.recode.vcf.gz \
--weir-fst-pop /home/wtm3/twg/popgen/pops/1988Virgin.txt \
--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Virgin.txt \
--weir-fst-pop /home/wtm3/twg/popgen/pops/2021Virgin.txt \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/1988Virgin_vs_2006Virgin_vs_2021Virgin_fst

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_Humboldt_1988-2021_SNPs.recode.vcf.gz \
--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Pudding.txt \
--weir-fst-pop /home/wtm3/twg/popgen/pops/2021Pudding.txt \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Pudding_vs_2021Pudding_fst

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_Humboldt_1988-2021_SNPs.recode.vcf.gz \
--weir-fst-pop /home/wtm3/twg/popgen/pops/Stone.txt \
--weir-fst-pop /home/wtm3/twg/popgen/pops/Big.txt \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/Stone_vs_Big_fst

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_Humboldt_1988-2021_SNPs.recode.vcf.gz \
--weir-fst-pop /home/wtm3/twg/popgen/pops/Big.txt \
--weir-fst-pop /home/wtm3/twg/popgen/pops/Virgin.txt \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/Big_vs_Virgin_fst

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_Humboldt_1988-2021_SNPs.recode.vcf.gz \
--weir-fst-pop /home/wtm3/twg/popgen/pops/Virgin.txt \
--weir-fst-pop /home/wtm3/twg/popgen/pops/Pudding.txt \
--out /home/wtm3/twg/popgen/pairwise-fst/temporal/Virgin_vs_Pudding_fst




















### temporal sliding window FST
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Humboldt_2006-2021.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Stone.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2021Stone.txt \
##--fst-window-size 10000 \
##--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Stone_vs_2021Stone_10kb
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Humboldt_2006-2021.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Big.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2021Big.txt \
##--fst-window-size 10000 \
##--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Big_vs_2021Big_10kb
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_1988-2021.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/1988Virgin.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Virgin.txt \
##--fst-window-size 10000 \
##--out /home/wtm3/twg/popgen/pairwise-fst/temporal/1988Virgin_vs_2006Virgin_10kb
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_1988-2021.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/1988Virgin.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2021Virgin.txt \
##--fst-window-size 10000 \
##--out /home/wtm3/twg/popgen/pairwise-fst/temporal/1988Virgin_vs_2021Virgin_10kb
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_1988-2021.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Virgin.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2021Virgin.txt \
##--fst-window-size 10000 \
##--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Virgin_vs_2021Virgin_10kb
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_1988-2021.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Pudding.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2021Pudding.txt \
##--fst-window-size 10000 \
##--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Pudding_vs_2021Pudding_10kb
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Humboldt_2006-2021.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Stone.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2021Stone.txt \
##--fst-window-size 20000 \
##--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Stone_vs_2021Stone_20kb
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Humboldt_2006-2021.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Big.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2021Big.txt \
##--fst-window-size 20000 \
##--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Big_vs_2021Big_20kb
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_1988-2021.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/1988Virgin.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Virgin.txt \
##--fst-window-size 20000 \
##--out /home/wtm3/twg/popgen/pairwise-fst/temporal/1988Virgin_vs_2006Virgin_20kb
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_1988-2021.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/1988Virgin.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2021Virgin.txt \
##--fst-window-size 20000 \
##--out /home/wtm3/twg/popgen/pairwise-fst/temporal/1988Virgin_vs_2021Virgin_20kb
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_1988-2021.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Virgin.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2021Virgin.txt \
##--fst-window-size 20000 \
##--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Virgin_vs_2021Virgin_20kb
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_1988-2021.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Pudding.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2021Pudding.txt \
##--fst-window-size 20000 \
##--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Pudding_vs_2021Pudding_20kb
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Humboldt_2006-2021.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Stone.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2021Stone.txt \
##--fst-window-size 30000 \
##--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Stone_vs_2021Stone_30kb
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Humboldt_2006-2021.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Big.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2021Big.txt \
##--fst-window-size 30000 \
##--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Big_vs_2021Big_30kb
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_1988-2021.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/1988Virgin.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Virgin.txt \
##--fst-window-size 30000 \
##--out /home/wtm3/twg/popgen/pairwise-fst/temporal/1988Virgin_vs_2006Virgin_30kb
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_1988-2021.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/1988Virgin.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2021Virgin.txt \
##--fst-window-size 30000 \
##--out /home/wtm3/twg/popgen/pairwise-fst/temporal/1988Virgin_vs_2021Virgin_30kb
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_1988-2021.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Virgin.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2021Virgin.txt \
##--fst-window-size 30000 \
##--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Virgin_vs_2021Virgin_30kb
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/temporal/Mendocino_1988-2021.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Pudding.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2021Pudding.txt \
##--fst-window-size 30000 \
##--out /home/wtm3/twg/popgen/pairwise-fst/temporal/2006Pudding_vs_2021Pudding_30kb
##
##
### pi
##vcftools \
##--gzvcf $HOME/twg/popgen/vcftools/temporal/100p/Stone/2006Stone-21Stone.snps.100p.recode.vcf.gz \
##--window-pi 10000 \
##--out $HOME/twg/popgen/vcftools/temporal/100p/Stone/2006Stone-21Stone.snps.100p-10kb
##
##vcftools \
##--gzvcf $HOME/twg/popgen/vcftools/temporal/100p/Stone/2006Stone-21Stone.snps.100p.recode.vcf.gz \
##--window-pi 20000 \
##--out $HOME/twg/popgen/vcftools/temporal/100p/Stone/2006Stone-21Stone.snps.100p-20kb
##
##vcftools \
##--gzvcf $HOME/twg/popgen/vcftools/temporal/100p/Stone/2006Stone-21Stone.snps.100p.recode.vcf.gz \
##--window-pi 30000 \
##--out $HOME/twg/popgen/vcftools/temporal/100p/Stone/2006Stone-21Stone.snps.100p-30kb
##
### fst
##vcftools \
##--gzvcf $HOME/twg/popgen/vcftools/temporal/100p/Stone/2006Stone-21Stone.snps.100p.recode.vcf.gz \
##--weir-fst-pop $HOME/twg/popgen/pops/2006Stone.txt \
##--weir-fst-pop $HOME/twg/popgen/pops/2021Stone.txt \
##--fst-window-size 10000 \
##--out $HOME/twg/popgen/vcftools/temporal/100p/Stone/2006Stone-21Stone.snps.100p-10kb
##
##vcftools \
##--gzvcf $HOME/twg/popgen/vcftools/temporal/100p/Stone/2006Stone-21Stone.snps.100p.recode.vcf.gz \
##--weir-fst-pop $HOME/twg/popgen/pops/2006Stone.txt \
##--weir-fst-pop $HOME/twg/popgen/pops/2021Stone.txt \
##--fst-window-size 20000 \
##--out $HOME/twg/popgen/vcftools/temporal/100p/Stone/2006Stone-21Stone.snps.100p-20kb
##
##vcftools \
##--gzvcf $HOME/twg/popgen/vcftools/temporal/100p/Stone/2006Stone-21Stone.snps.100p.recode.vcf.gz \
##--weir-fst-pop $HOME/twg/popgen/pops/2006Stone.txt \
##--weir-fst-pop $HOME/twg/popgen/pops/2021Stone.txt \
##--fst-window-size 30000 \
##--out $HOME/twg/popgen/vcftools/temporal/100p/Stone/2006Stone-21Stone.snps.100p-30kb
##
### D
##vcftools \
##--gzvcf $HOME/twg/popgen/vcftools/temporal/100p/Stone/2006Stone-21Stone.snps.100p.recode.vcf.gz \
##--TajimaD 10000 \
##--out $HOME/twg/popgen/vcftools/temporal/100p/Stone/2006Stone-21Stone.snps.100p-10kb
##
##vcftools \
##--gzvcf $HOME/twg/popgen/vcftools/temporal/100p/Stone/2006Stone-21Stone.snps.100p.recode.vcf.gz \
##--TajimaD 20000 \
##--out $HOME/twg/popgen/vcftools/temporal/100p/Stone/2006Stone-21Stone.snps.100p-20kb
##
##vcftools \
##--gzvcf $HOME/twg/popgen/vcftools/temporal/100p/Stone/2006Stone-21Stone.snps.100p.recode.vcf.gz \
##--TajimaD 30000 \
##--out $HOME/twg/popgen/vcftools/temporal/100p/Stone/2006Stone-21Stone.snps.100p-30kb
##
### pi cohort
##vcftools \
##--gzvcf $HOME/twg/popgen/vcftools/temporal/100p/Stone/2006Stone-21Stone.snps.100p.recode.vcf.gz \
##--keep $HOME/twg/popgen/pops/2006Stone.txt \
##--window-pi 10000 \
##--out $HOME/twg/popgen/vcftools/temporal/100p/Stone/2006Stone.snps.100p-10kb
##
##vcftools \
##--gzvcf $HOME/twg/popgen/vcftools/temporal/100p/Stone/2006Stone-21Stone.snps.100p.recode.vcf.gz \
##--keep $HOME/twg/popgen/pops/2021Stone.txt \
##--window-pi 10000 \
##--out $HOME/twg/popgen/vcftools/temporal/100p/Stone/21Stone.snps.100p-10kb
##
##vcftools \
##--gzvcf $HOME/twg/popgen/vcftools/temporal/100p/Stone/2006Stone-21Stone.snps.100p.recode.vcf.gz \
##--keep $HOME/twg/popgen/pops/2006Stone.txt \
##--window-pi 20000 \
##--out $HOME/twg/popgen/vcftools/temporal/100p/Stone/2006Stone.snps.100p-20kb
##
##vcftools \
##--gzvcf $HOME/twg/popgen/vcftools/temporal/100p/Stone/2006Stone-21Stone.snps.100p.recode.vcf.gz \
##--keep $HOME/twg/popgen/pops/2021Stone.txt \
##--window-pi 20000 \
##--out $HOME/twg/popgen/vcftools/temporal/100p/Stone/21Stone.snps.100p-20kb
##
##vcftools \
##--gzvcf $HOME/twg/popgen/vcftools/temporal/100p/Stone/2006Stone-21Stone.snps.100p.recode.vcf.gz \
##--keep $HOME/twg/popgen/pops/2006Stone.txt \
##--window-pi 30000 \
##--out $HOME/twg/popgen/vcftools/temporal/100p/Stone/2006Stone.snps.100p-30kb
##
##vcftools \
##--gzvcf $HOME/twg/popgen/vcftools/temporal/100p/Stone/2006Stone-21Stone.snps.100p.recode.vcf.gz \
##--keep $HOME/twg/popgen/pops/2021Stone.txt \
##--window-pi 30000 \
##--out $HOME/twg/popgen/vcftools/temporal/100p/Stone/21Stone.snps.100p-30kb
##
### TsTv
##vcftools \
##--gzvcf $HOME/twg/popgen/vcftools/temporal/100p/Stone/2006Stone-21Stone.snps.100p.recode.vcf.gz \
##--TsTv 10000 \
##--out $HOME/twg/popgen/vcftools/temporal/100p/Stone/2006Stone-21Stone.snps.100p-10kb
##
##vcftools \
##--gzvcf $HOME/twg/popgen/vcftools/temporal/100p/Stone/2006Stone-21Stone.snps.100p.recode.vcf.gz \
##--TsTv 20000 \
##--out $HOME/twg/popgen/vcftools/temporal/100p/Stone/2006Stone-21Stone.snps.100p-20kb
##
##vcftools \
##--gzvcf $HOME/twg/popgen/vcftools/temporal/100p/Stone/2006Stone-21Stone.snps.100p.recode.vcf.gz \
##--TsTv 30000 \
##--out $HOME/twg/popgen/vcftools/temporal/100p/Stone/2006Stone-21Stone.snps.100p-30kb
##
###
##vcftools \
##--gzvcf $HOME/twg/popgen/vcftools/temporal/100p/Stone/2006Stone-21Stone.snps.100p.recode.vcf.gz \
##--TsTv-summary \
##--out $HOME/twg/popgen/vcftools/temporal/100p/Stone/2006Stone-21Stone.snps.100p
##
##vcftools \
##--gzvcf $HOME/twg/popgen/vcftools/temporal/100p/Stone/2006Stone-21Stone.snps.100p.recode.vcf.gz \
##--TsTv-by-count \
##--out $HOME/twg/popgen/vcftools/temporal/100p/Stone/2006Stone-21Stone.snps.100p
