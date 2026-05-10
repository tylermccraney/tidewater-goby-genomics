#!/bin/bash

##
# to remove all sites with a FILTER flag other than PASS: --remove-filtered-all
# to include only sites with a Minor Allele Frequency greater than or equal to 0.05: vcftools --vcf file1.vcf --maf 0.05
# to include only bi-allelic sites: vcftools --vcf file1.vcf --min-alleles 2 --max-alleles 2
# to exclude sites by the proportion of missing data (between 0 and 1: 0 allows sites that are completely missing; 1 indicates no missing data allowed): --max-missing 0.95

cd /home/wtm3/twg/popgen/pops

##cat 2011Tillas.txt 2011Earl.txt 2006Stone.txt 2006Big.txt 2009Arcata.txt 1988Virgin.txt 2006Virgin.txt 2006Pudding.txt > 1988-2011.txt
##
##vcftools \
##--gzvcf /home/wtm3/twg/variants/selectvariants.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/1988-2011.txt \
##--remove-filtered-all \
##--maf 0.05 \
##--min-alleles 2 \
##--max-alleles 2 \
##--max-missing 0.95 \
##--recode \
##--out /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/1988-2011
##
##gzip /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/1988-2011.recode.vcf
##
### pairwise FST
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/1988-2011.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2011Tillas.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2011Earl.txt \
##--out /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/2011Tillas_vs_2011Earl
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/1988-2011.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2011Tillas.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Stone.txt \
##--out /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/2011Tillas_vs_2006Stone
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/1988-2011.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2011Tillas.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Big.txt \
##--out /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/2011Tillas_vs_2006Big
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/1988-2011.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2011Tillas.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2009Arcata.txt \
##--out /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/2011Tillas_vs_2009Arcata
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/1988-2011.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2011Tillas.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Virgin.txt \
##--out /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/2011Tillas_vs_2006Virgin
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/1988-2011.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2011Tillas.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Pudding.txt \
##--out /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/2011Tillas_vs_2006Pudding
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/1988-2011.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2011Earl.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Stone.txt \
##--out /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/2011Earl_vs_2006Stone
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/1988-2011.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2011Earl.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Big.txt \
##--out /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/2011Earl_vs_2006Big
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/1988-2011.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2011Earl.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2009Arcata.txt \
##--out /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/2011Earl_vs_2009Arcata
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/1988-2011.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2011Earl.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Virgin.txt \
##--out /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/2011Earl_vs_2006Virgin
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/1988-2011.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2011Earl.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Pudding.txt \
##--out /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/2011Earl_vs_2006Pudding
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/1988-2011.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Stone.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Big.txt \
##--out /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/2006Stone_vs_2006Big
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/1988-2011.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Stone.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2009Arcata.txt \
##--out /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/2006Stone_vs_2009Arcata
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/1988-2011.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Stone.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Virgin.txt \
##--out /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/2006Stone_vs_2006Virgin
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/1988-2011.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Stone.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Pudding.txt \
##--out /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/2006Stone_vs_2006Pudding
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/1988-2011.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Big.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2009Arcata.txt \
##--out /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/2006Big_vs_2009Arcata
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/1988-2011.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Big.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Virgin.txt \
##--out /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/2006Big_vs_2006Virgin
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/1988-2011.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Big.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Pudding.txt \
##--out /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/2006Big_vs_2006Pudding
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/1988-2011.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2009Arcata.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Virgin.txt \
##--out /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/2009Arcata_vs_2006Virgin
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/1988-2011.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2009Arcata.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Pudding.txt \
##--out /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/2009Arcata_vs_2006Pudding
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/1988-2011.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Virgin.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Pudding.txt \
##--out /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/2006Virgin_vs_2006Pudding
##
###
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/1988-2011.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2011Tillas.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/1988Virgin.txt \
##--out /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/2011Tillas_vs_1988Virgin
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/1988-2011.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2011Earl.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/1988Virgin.txt \
##--out /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/2011Earl_vs_1988Virgin
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/1988-2011.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Stone.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/1988Virgin.txt \
##--out /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/2006Stone_vs_1988Virgin
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/1988-2011.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Big.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/1988Virgin.txt \
##--out /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/2006Big_vs_1988Virgin
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/1988-2011.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2009Arcata.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/1988Virgin.txt \
##--out /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/2009Arcata_vs_1988Virgin
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/1988-2011.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/1988Virgin.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Virgin.txt \
##--out /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/1988Virgin_vs_2006Virgin
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/1988-2011.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/1988Virgin.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Pudding.txt \
##--out /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/1988Virgin_vs_2006Pudding

###
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/1988-2011.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2011Tillas.txt \
##--het \
##--out /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/2011Tillas
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/1988-2011.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2011Earl.txt \
##--het \
##--out /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/2011Earl
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/1988-2011.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2006Stone.txt \
##--het \
##--out /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/2006Stone
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/1988-2011.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2006Big.txt \
##--het \
##--out /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/2006Big
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/1988-2011.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2009Arcata.txt \
##--het \
##--out /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/2009Arcata
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/1988-2011.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/1988Virgin.txt \
##--het \
##--out /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/1988Virgin
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/1988-2011.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2006Virgin.txt \
##--het \
##--out /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/2006Virgin
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/1988-2011.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2006Pudding.txt \
##--het \
##--out /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/2006Pudding

#
vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/1988-2011.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2011Tillas.txt \
--hardy \
--out /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/2011Tillas

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/1988-2011.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2011Earl.txt \
--hardy \
--out /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/2011Earl

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/1988-2011.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2006Stone.txt \
--hardy \
--out /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/2006Stone

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/1988-2011.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2006Big.txt \
--hardy \
--out /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/2006Big

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/1988-2011.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2009Arcata.txt \
--hardy \
--out /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/2009Arcata

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/1988-2011.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/1988Virgin.txt \
--hardy \
--out /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/1988Virgin

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/1988-2011.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2006Virgin.txt \
--hardy \
--out /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/2006Virgin

vcftools \
--gzvcf /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/1988-2011.recode.vcf.gz \
--keep /home/wtm3/twg/popgen/pops/2006Pudding.txt \
--hardy \
--out /home/wtm3/twg/popgen/pairwise-fst/vs_Kinziger_et_al_2015/2006Pudding
