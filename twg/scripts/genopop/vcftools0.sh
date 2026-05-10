#!/bin/bash

##
#vcftools \
#--gzvcf /home/instr1/twg/variants/selectvariants.vcf.gz \
#--remove-indels \
#--het \
#--out /home/instr1/twg/popgen/het_snps
#
#vcftools \
#--gzvcf /home/instr1/twg/variants/selectvariants.vcf.gz \
#--remove-indels \
#--relatedness \
#--out /home/instr1/twg/popgen/relatedness_snps
#
## geographical
#vcftools \
#--gzvcf /home/instr1/twg/variants/selectvariants.vcf.gz \
#--remove-indels \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2011Tillas.txt \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2011Earl.txt \
#--out /home/instr1/twg/popgen/2011Tillas_vs_2011Earl
#
#vcftools \
#--gzvcf /home/instr1/twg/variants/selectvariants.vcf.gz \
#--remove-indels \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2011Earl.txt \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2006Stone.txt \
#--out /home/instr1/twg/popgen/2011Earl_vs_2006Stone
#
#vcftools \
#--gzvcf /home/instr1/twg/variants/selectvariants.vcf.gz \
#--remove-indels \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2006Stone.txt \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2006Big.txt \
#--out /home/instr1/twg/popgen/2006Stone_vs_2006Big
#
#vcftools \
#--gzvcf /home/instr1/twg/variants/selectvariants.vcf.gz \
#--remove-indels \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2006Big.txt \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2009Arcata.txt \
#--out /home/instr1/twg/popgen/2006Big_vs_2009Arcata
#
#vcftools \
#--gzvcf /home/instr1/twg/variants/selectvariants.vcf.gz \
#--remove-indels \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2009Arcata.txt \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2006Virgin.txt \
#--out /home/instr1/twg/popgen/2009Arcata_vs_2006Virgin
#
#vcftools \
#--gzvcf /home/instr1/twg/variants/selectvariants.vcf.gz \
#--remove-indels \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2006Virgin.txt \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2006Pudding.txt \
#--out /home/instr1/twg/popgen/2006Virgin_vs_2006Pudding
#
#vcftools \
#--gzvcf /home/instr1/twg/variants/selectvariants.vcf.gz \
#--remove-indels \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2006Pudding.txt \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2017Antonio.txt \
#--out /home/instr1/twg/popgen/2006Pudding_vs_2017Antonio
#
#vcftools \
#--gzvcf /home/instr1/twg/variants/selectvariants.vcf.gz \
#--remove-indels \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2017Antonio.txt \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2017Ynez.txt \
#--out /home/instr1/twg/popgen/2017Antonio_vs_2017Ynez
#
#vcftools \
#--gzvcf /home/instr1/twg/variants/selectvariants.vcf.gz \
#--remove-indels \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2017Ynez.txt \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2014Paredon.txt \
#--out /home/instr1/twg/popgen/2017Ynez_vs_2014Paredon
#
#vcftools \
#--gzvcf /home/instr1/twg/variants/selectvariants.vcf.gz \
#--remove-indels \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2014Paredon.txt \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2014Burro.txt \
#--out /home/instr1/twg/popgen/2014Paredon_vs_2014Burro
#
## temporal
#vcftools \
#--gzvcf /home/instr1/twg/variants/selectvariants.vcf.gz \
#--remove-indels \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2006Stone.txt \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2021Stone.txt \
#--out /home/instr1/twg/popgen/2006Stone_vs_2021Stone
#
#vcftools \
#--gzvcf /home/instr1/twg/variants/selectvariants.vcf.gz \
#--remove-indels \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2006Big.txt \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2021Big.txt \
#--out /home/instr1/twg/popgen/2006Big_vs_2021Big
#
#vcftools \
#--gzvcf /home/instr1/twg/variants/selectvariants.vcf.gz \
#--remove-indels \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2006Virgin.txt \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2021Virgin.txt \
#--out /home/instr1/twg/popgen/2006Virgin_vs_2021Virgin
#
#vcftools \
#--gzvcf /home/instr1/twg/variants/selectvariants.vcf.gz \
#--remove-indels \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2006Pudding.txt \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2021Pudding.txt \
#--out /home/instr1/twg/popgen/2006Pudding_vs_2021Pudding
#
##
#vcftools \
#--gzvcf /home/instr1/twg/variants/selectvariants.vcf.gz \
#--remove-indels \
#--freq2 \
#--out /home/instr1/twg/popgen/freq2_snps
#
#vcftools \
#--gzvcf /home/instr1/twg/variants/selectvariants.vcf.gz \
#--remove-indels \
#--freq \
#--out /home/instr1/twg/popgen/freq_snps
#
#
## temporal sliding window FST
#vcftools \
#--gzvcf /home/instr1/twg/variants/selectvariants.vcf.gz \
#--remove-indels \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2006Stone.txt \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2021Stone.txt \
#--fst-window-size 10000 \
#--out /home/instr1/twg/popgen/2006Stone_vs_2021Stone_10kb
#
#vcftools \
#--gzvcf /home/instr1/twg/variants/selectvariants.vcf.gz \
#--remove-indels \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2006Big.txt \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2021Big.txt \
#--fst-window-size 10000 \
#--out /home/instr1/twg/popgen/2006Big_vs_2021Big_10kb
#
#vcftools \
#--gzvcf /home/instr1/twg/variants/selectvariants.vcf.gz \
#--remove-indels \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2006Virgin.txt \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2021Virgin.txt \
#--fst-window-size 10000 \
#--out /home/instr1/twg/popgen/2006Virgin_vs_2021Virgin_10kb
#
#vcftools \
#--gzvcf /home/instr1/twg/variants/selectvariants.vcf.gz \
#--remove-indels \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2006Pudding.txt \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2021Pudding.txt \
#--fst-window-size 10000 \
#--out /home/instr1/twg/popgen/2006Pudding_vs_2021Pudding_10kb
#
#
##
#vcftools \
#--gzvcf /home/instr1/twg/variants/selectvariants.vcf.gz \
#--remove-indels \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2006Stone.txt \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2021Stone.txt \
#--fst-window-size 20000 \
#--out /home/instr1/twg/popgen/2006Stone_vs_2021Stone_20kb
#
#vcftools \
#--gzvcf /home/instr1/twg/variants/selectvariants.vcf.gz \
#--remove-indels \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2006Big.txt \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2021Big.txt \
#--fst-window-size 20000 \
#--out /home/instr1/twg/popgen/2006Big_vs_2021Big_20kb
#
#vcftools \
#--gzvcf /home/instr1/twg/variants/selectvariants.vcf.gz \
#--remove-indels \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2006Virgin.txt \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2021Virgin.txt \
#--fst-window-size 20000 \
#--out /home/instr1/twg/popgen/2006Virgin_vs_2021Virgin_20kb
#
#vcftools \
#--gzvcf /home/instr1/twg/variants/selectvariants.vcf.gz \
#--remove-indels \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2006Pudding.txt \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2021Pudding.txt \
#--fst-window-size 20000 \
#--out /home/instr1/twg/popgen/2006Pudding_vs_2021Pudding_20kb
#
#vcftools \
#--gzvcf /home/instr1/twg/variants/selectvariants.vcf.gz \
#--remove-indels \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2006Stone.txt \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2021Stone.txt \
#--fst-window-size 30000 \
#--out /home/instr1/twg/popgen/2006Stone_vs_2021Stone_30kb
#
#vcftools \
#--gzvcf /home/instr1/twg/variants/selectvariants.vcf.gz \
#--remove-indels \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2006Big.txt \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2021Big.txt \
#--fst-window-size 30000 \
#--out /home/instr1/twg/popgen/2006Big_vs_2021Big_30kb
#
#vcftools \
#--gzvcf /home/instr1/twg/variants/selectvariants.vcf.gz \
#--remove-indels \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2006Virgin.txt \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2021Virgin.txt \
#--fst-window-size 30000 \
#--out /home/instr1/twg/popgen/2006Virgin_vs_2021Virgin_30kb
#
#vcftools \
#--gzvcf /home/instr1/twg/variants/selectvariants.vcf.gz \
#--remove-indels \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2006Pudding.txt \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2021Pudding.txt \
#--fst-window-size 30000 \
#--out /home/instr1/twg/popgen/2006Pudding_vs_2021Pudding_30kb
#
#vcftools \
#--gzvcf /home/instr1/twg/variants/selectvariants.vcf.gz \
#--remove-indels \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2011Earl.txt \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2021Stone.txt \
#--out /home/instr1/twg/popgen/2011Earl_vs_2021Stone
#
#vcftools \
#--gzvcf /home/instr1/twg/variants/selectvariants.vcf.gz \
#--remove-indels \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2011Earl.txt \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2021Big.txt \
#--out /home/instr1/twg/popgen/2011Earl_vs_2021Big
#
#vcftools \
#--gzvcf /home/instr1/twg/variants/selectvariants.vcf.gz \
#--remove-indels \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2011Earl.txt \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2021Virgin.txt \
#--out /home/instr1/twg/popgen/2011Earl_vs_2021Virgin
#
#vcftools \
#--gzvcf /home/instr1/twg/variants/selectvariants.vcf.gz \
#--remove-indels \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2011Earl.txt \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2021Pudding.txt \
#--out /home/instr1/twg/popgen/2011Earl_vs_2021Pudding
#
#vcftools \
#--gzvcf /home/instr1/twg/variants/selectvariants.vcf.gz \
#--remove-indels \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2021Stone.txt \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2021Big.txt \
#--out /home/instr1/twg/popgen/2021Stone_vs_2021Big
#
#vcftools \
#--gzvcf /home/instr1/twg/variants/selectvariants.vcf.gz \
#--remove-indels \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2021Stone.txt \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2021Virgin.txt \
#--out /home/instr1/twg/popgen/2021Stone_vs_2021Virgin
#
#vcftools \
#--gzvcf /home/instr1/twg/variants/selectvariants.vcf.gz \
#--remove-indels \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2021Stone.txt \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2021Pudding.txt \
#--out /home/instr1/twg/popgen/2021Stone_vs_2021Pudding
#
#vcftools \
#--gzvcf /home/instr1/twg/variants/selectvariants.vcf.gz \
#--remove-indels \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2021Big.txt \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2021Virgin.txt \
#--out /home/instr1/twg/popgen/2021Big_vs_2021Virgin
#
#vcftools \
#--gzvcf /home/instr1/twg/variants/selectvariants.vcf.gz \
#--remove-indels \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2021Big.txt \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2021Pudding.txt \
#--out /home/instr1/twg/popgen/2021Big_vs_2021Pudding
#
#vcftools \
#--gzvcf /home/instr1/twg/variants/selectvariants.vcf.gz \
#--remove-indels \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2021Virgin.txt \
#--weir-fst-pop /home/instr1/twg/popgen/pops/2021Pudding.txt \
#--out /home/instr1/twg/popgen/2021Virgin_vs_2021Pudding

##vcftools \
##--gzvcf /home/instr1/twg/variants/selectvariants.vcf.gz \
##--remove-indels \
##--weir-fst-pop /home/instr1/twg/popgen/pops/2011Tillas.txt \
##--weir-fst-pop /home/instr1/twg/popgen/pops/2006Stone.txt \
##--out /home/instr1/twg/popgen/2011Tillas_vs_2006Stone
##
##vcftools \
##--gzvcf /home/instr1/twg/variants/selectvariants.vcf.gz \
##--remove-indels \
##--weir-fst-pop /home/instr1/twg/popgen/pops/2011Tillas.txt \
##--weir-fst-pop /home/instr1/twg/popgen/pops/2006Big.txt \
##--out /home/instr1/twg/popgen/2011Tillas_vs_2006Big
##
##vcftools \
##--gzvcf /home/instr1/twg/variants/selectvariants.vcf.gz \
##--remove-indels \
##--weir-fst-pop /home/instr1/twg/popgen/pops/2011Tillas.txt \
##--weir-fst-pop /home/instr1/twg/popgen/pops/2009Arcata.txt \
##--out /home/instr1/twg/popgen/2011Tillas_vs_2009Arcata
##
##vcftools \
##--gzvcf /home/instr1/twg/variants/selectvariants.vcf.gz \
##--remove-indels \
##--weir-fst-pop /home/instr1/twg/popgen/pops/2011Tillas.txt \
##--weir-fst-pop /home/instr1/twg/popgen/pops/2006Virgin.txt \
##--out /home/instr1/twg/popgen/2011Tillas_vs_2006Virgin
##
##vcftools \
##--gzvcf /home/instr1/twg/variants/selectvariants.vcf.gz \
##--remove-indels \
##--weir-fst-pop /home/instr1/twg/popgen/pops/2011Tillas.txt \
##--weir-fst-pop /home/instr1/twg/popgen/pops/2006Pudding.txt \
##--out /home/instr1/twg/popgen/2011Tillas_vs_2006Pudding
##
##vcftools \
##--gzvcf /home/instr1/twg/variants/selectvariants.vcf.gz \
##--remove-indels \
##--weir-fst-pop /home/instr1/twg/popgen/pops/2011Earl.txt \
##--weir-fst-pop /home/instr1/twg/popgen/pops/2006Big.txt \
##--out /home/instr1/twg/popgen/2011Earl_vs_2006Big
##
##vcftools \
##--gzvcf /home/instr1/twg/variants/selectvariants.vcf.gz \
##--remove-indels \
##--weir-fst-pop /home/instr1/twg/popgen/pops/2011Earl.txt \
##--weir-fst-pop /home/instr1/twg/popgen/pops/2009Arcata.txt \
##--out /home/instr1/twg/popgen/2011Earl_vs_2009Arcata
##
##vcftools \
##--gzvcf /home/instr1/twg/variants/selectvariants.vcf.gz \
##--remove-indels \
##--weir-fst-pop /home/instr1/twg/popgen/pops/2011Earl.txt \
##--weir-fst-pop /home/instr1/twg/popgen/pops/2006Virgin.txt \
##--out /home/instr1/twg/popgen/2011Earl_vs_2006Virgin
##
##vcftools \
##--gzvcf /home/instr1/twg/variants/selectvariants.vcf.gz \
##--remove-indels \
##--weir-fst-pop /home/instr1/twg/popgen/pops/2011Earl.txt \
##--weir-fst-pop /home/instr1/twg/popgen/pops/2006Pudding.txt \
##--out /home/instr1/twg/popgen/2011Earl_vs_2006Pudding
##
##vcftools \
##--gzvcf /home/instr1/twg/variants/selectvariants.vcf.gz \
##--remove-indels \
##--weir-fst-pop /home/instr1/twg/popgen/pops/2006Stone.txt \
##--weir-fst-pop /home/instr1/twg/popgen/pops/2009Arcata.txt \
##--out /home/instr1/twg/popgen/2006Stone_vs_2009Arcata
##
##vcftools \
##--gzvcf /home/instr1/twg/variants/selectvariants.vcf.gz \
##--remove-indels \
##--weir-fst-pop /home/instr1/twg/popgen/pops/2006Stone.txt \
##--weir-fst-pop /home/instr1/twg/popgen/pops/2006Virgin.txt \
##--out /home/instr1/twg/popgen/2006Stone_vs_2006Virgin
##
##vcftools \
##--gzvcf /home/instr1/twg/variants/selectvariants.vcf.gz \
##--remove-indels \
##--weir-fst-pop /home/instr1/twg/popgen/pops/2006Stone.txt \
##--weir-fst-pop /home/instr1/twg/popgen/pops/2006Pudding.txt \
##--out /home/instr1/twg/popgen/2006Stone_vs_2006Pudding
##
##vcftools \
##--gzvcf /home/instr1/twg/variants/selectvariants.vcf.gz \
##--remove-indels \
##--weir-fst-pop /home/instr1/twg/popgen/pops/2006Big.txt \
##--weir-fst-pop /home/instr1/twg/popgen/pops/2006Virgin.txt \
##--out /home/instr1/twg/popgen/2006Big_vs_2006Virgin
##
##vcftools \
##--gzvcf /home/instr1/twg/variants/selectvariants.vcf.gz \
##--remove-indels \
##--weir-fst-pop /home/instr1/twg/popgen/pops/2006Big.txt \
##--weir-fst-pop /home/instr1/twg/popgen/pops/2006Pudding.txt \
##--out /home/instr1/twg/popgen/2006Big_vs_2006Pudding
##
##vcftools \
##--gzvcf /home/instr1/twg/variants/selectvariants.vcf.gz \
##--remove-indels \
##--weir-fst-pop /home/instr1/twg/popgen/pops/2009Arcata.txt \
##--weir-fst-pop /home/instr1/twg/popgen/pops/2006Pudding.txt \
##--out /home/instr1/twg/popgen/2009Arcata_vs_2006Pudding

### not run (as above)
##2011Tillas_vs_2021Stone
##2011Tillas_vs_2021Big
##2011Tillas_vs_2021Virgin
##2011Tillas_vs_2021Pudding
##2011Tillas_vs_2017Antonio
##2011Tillas_vs_2017Ynez
##2011Tillas_vs_2014Paredon
##2011Tillas_vs_2014Burro
##2011Earl_vs_2017Antonio
##2011Earl_vs_2017Ynez
##2011Earl_vs_2014Paredon
##2011Earl_vs_2014Burro
##2021Stone_vs_2017Antonio
##2021Stone_vs_2017Ynez
##2021Stone_vs_2014Paredon
##2021Stone_vs_2014Burro
##2021Big_vs_2017Antonio
##2021Big_vs_2017Ynez
##2021Big_vs_2014Paredon
##2021Big_vs_2014Burro
##2021Virgin_vs_2017Antonio
##2021Virgin_vs_2017Ynez
##2021Virgin_vs_2014Paredon
##2021Virgin_vs_2014Burro
##2021Pudding_vs_2017Antonio
##2021Pudding_vs_2017Ynez
##2021Pudding_vs_2014Paredon
##2021Pudding_vs_2014Burro
##2017Antonio_vs_2014Paredon
##2017Antonio_vs_2014Burro
##2017Ynez_vs_2014Burro

# to remove all sites with a FILTER flag other than PASS: --remove-filtered-all
# to include only sites with a Minor Allele Frequency greater than or equal to 0.05: vcftools --vcf file1.vcf --maf 0.05
# to include only bi-allelic sites: vcftools --vcf file1.vcf --min-alleles 2 --max-alleles 2
# to exclude sites by the proportion of missing data (between 0 and 1: 0 allows sites that are completely missing; 1 indicates no missing data allowed): --max-missing 0.5

##vcftools \
##--gzvcf /home/instr1/twg/variants/selectvariants.vcf.gz \
##--remove /home/instr1/twg/popgen/pops/2006-09.txt \
##--remove-filtered-all \
##--maf 0.05 \
##--min-alleles 2 \
##--max-alleles 2 \
##--max-missing 0.5 \
##--recode \
##--out /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011-21
##
##gzip /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011-21.recode.vcf

# pairwise FST evolutionary timescale
vcftools \
--gzvcf /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011-21.recode.vcf.gz \
--weir-fst-pop /home/instr1/twg/popgen/pops/2011Tillas.txt \
--weir-fst-pop /home/instr1/twg/popgen/pops/2011Earl.txt \
--out /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011Tillas_vs_2011Earl

vcftools \
--gzvcf /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011-21.recode.vcf.gz \
--weir-fst-pop /home/instr1/twg/popgen/pops/2011Tillas.txt \
--weir-fst-pop /home/instr1/twg/popgen/pops/2021Stone.txt \
--out /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011Tillas_vs_2021Stone

vcftools \
--gzvcf /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011-21.recode.vcf.gz \
--weir-fst-pop /home/instr1/twg/popgen/pops/2011Tillas.txt \
--weir-fst-pop /home/instr1/twg/popgen/pops/2021Big.txt \
--out /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011Tillas_vs_2021Big

vcftools \
--gzvcf /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011-21.recode.vcf.gz \
--weir-fst-pop /home/instr1/twg/popgen/pops/2011Tillas.txt \
--weir-fst-pop /home/instr1/twg/popgen/pops/2021Virgin.txt \
--out /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011Tillas_vs_2021Virgin

vcftools \
--gzvcf /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011-21.recode.vcf.gz \
--weir-fst-pop /home/instr1/twg/popgen/pops/2011Tillas.txt \
--weir-fst-pop /home/instr1/twg/popgen/pops/2021Pudding.txt \
--out /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011Tillas_vs_2021Pudding

vcftools \
--gzvcf /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011-21.recode.vcf.gz \
--weir-fst-pop /home/instr1/twg/popgen/pops/2011Tillas.txt \
--weir-fst-pop /home/instr1/twg/popgen/pops/2017Antonio.txt \
--out /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011Tillas_vs_2017Antonio

vcftools \
--gzvcf /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011-21.recode.vcf.gz \
--weir-fst-pop /home/instr1/twg/popgen/pops/2011Tillas.txt \
--weir-fst-pop /home/instr1/twg/popgen/pops/2017Ynez.txt \
--out /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011Tillas_vs_2017Ynez

vcftools \
--gzvcf /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011-21.recode.vcf.gz \
--weir-fst-pop /home/instr1/twg/popgen/pops/2011Tillas.txt \
--weir-fst-pop /home/instr1/twg/popgen/pops/2014Paredon.txt \
--out /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011Tillas_vs_2014Paredon

vcftools \
--gzvcf /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011-21.recode.vcf.gz \
--weir-fst-pop /home/instr1/twg/popgen/pops/2011Tillas.txt \
--weir-fst-pop /home/instr1/twg/popgen/pops/2014Burro.txt \
--out /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011Tillas_vs_2014Burro

vcftools \
--gzvcf /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011-21.recode.vcf.gz \
--weir-fst-pop /home/instr1/twg/popgen/pops/2011Earl.txt \
--weir-fst-pop /home/instr1/twg/popgen/pops/2021Stone.txt \
--out /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011Earl_vs_2021Stone

vcftools \
--gzvcf /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011-21.recode.vcf.gz \
--weir-fst-pop /home/instr1/twg/popgen/pops/2011Earl.txt \
--weir-fst-pop /home/instr1/twg/popgen/pops/2021Big.txt \
--out /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011Earl_vs_2021Big

vcftools \
--gzvcf /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011-21.recode.vcf.gz \
--weir-fst-pop /home/instr1/twg/popgen/pops/2011Earl.txt \
--weir-fst-pop /home/instr1/twg/popgen/pops/2021Virgin.txt \
--out /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011Earl_vs_2021Virgin

vcftools \
--gzvcf /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011-21.recode.vcf.gz \
--weir-fst-pop /home/instr1/twg/popgen/pops/2011Earl.txt \
--weir-fst-pop /home/instr1/twg/popgen/pops/2021Pudding.txt \
--out /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011Earl_vs_2021Pudding

vcftools \
--gzvcf /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011-21.recode.vcf.gz \
--weir-fst-pop /home/instr1/twg/popgen/pops/2011Earl.txt \
--weir-fst-pop /home/instr1/twg/popgen/pops/2017Antonio.txt \
--out /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011Earl_vs_2017Antonio

vcftools \
--gzvcf /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011-21.recode.vcf.gz \
--weir-fst-pop /home/instr1/twg/popgen/pops/2011Earl.txt \
--weir-fst-pop /home/instr1/twg/popgen/pops/2017Ynez.txt \
--out /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011Earl_vs_2017Ynez

vcftools \
--gzvcf /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011-21.recode.vcf.gz \
--weir-fst-pop /home/instr1/twg/popgen/pops/2011Earl.txt \
--weir-fst-pop /home/instr1/twg/popgen/pops/2014Paredon.txt \
--out /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011Earl_vs_2014Paredon

vcftools \
--gzvcf /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011-21.recode.vcf.gz \
--weir-fst-pop /home/instr1/twg/popgen/pops/2011Earl.txt \
--weir-fst-pop /home/instr1/twg/popgen/pops/2014Burro.txt \
--out /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011Earl_vs_2014Burro

vcftools \
--gzvcf /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011-21.recode.vcf.gz \
--weir-fst-pop /home/instr1/twg/popgen/pops/2021Stone.txt \
--weir-fst-pop /home/instr1/twg/popgen/pops/2021Big.txt \
--out /home/instr1/twg/popgen/pairwise-fst/evo-scale/2021Stone_vs_2021Big

vcftools \
--gzvcf /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011-21.recode.vcf.gz \
--weir-fst-pop /home/instr1/twg/popgen/pops/2021Stone.txt \
--weir-fst-pop /home/instr1/twg/popgen/pops/2021Virgin.txt \
--out /home/instr1/twg/popgen/pairwise-fst/evo-scale/2021Stone_vs_2021Virgin

vcftools \
--gzvcf /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011-21.recode.vcf.gz \
--weir-fst-pop /home/instr1/twg/popgen/pops/2021Stone.txt \
--weir-fst-pop /home/instr1/twg/popgen/pops/2021Pudding.txt \
--out /home/instr1/twg/popgen/pairwise-fst/evo-scale/2021Stone_vs_2021Pudding

vcftools \
--gzvcf /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011-21.recode.vcf.gz \
--weir-fst-pop /home/instr1/twg/popgen/pops/2021Stone.txt \
--weir-fst-pop /home/instr1/twg/popgen/pops/2017Antonio.txt \
--out /home/instr1/twg/popgen/pairwise-fst/evo-scale/2021Stone_vs_2017Antonio

vcftools \
--gzvcf /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011-21.recode.vcf.gz \
--weir-fst-pop /home/instr1/twg/popgen/pops/2021Stone.txt \
--weir-fst-pop /home/instr1/twg/popgen/pops/2017Ynez.txt \
--out /home/instr1/twg/popgen/pairwise-fst/evo-scale/2021Stone_vs_2017Ynez

vcftools \
--gzvcf /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011-21.recode.vcf.gz \
--weir-fst-pop /home/instr1/twg/popgen/pops/2021Stone.txt \
--weir-fst-pop /home/instr1/twg/popgen/pops/2014Paredon.txt \
--out /home/instr1/twg/popgen/pairwise-fst/evo-scale/2021Stone_vs_2014Paredon

vcftools \
--gzvcf /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011-21.recode.vcf.gz \
--weir-fst-pop /home/instr1/twg/popgen/pops/2021Stone.txt \
--weir-fst-pop /home/instr1/twg/popgen/pops/2014Burro.txt \
--out /home/instr1/twg/popgen/pairwise-fst/evo-scale/2021Stone_vs_2014Burro

vcftools \
--gzvcf /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011-21.recode.vcf.gz \
--weir-fst-pop /home/instr1/twg/popgen/pops/2021Big.txt \
--weir-fst-pop /home/instr1/twg/popgen/pops/2021Virgin.txt \
--out /home/instr1/twg/popgen/pairwise-fst/evo-scale/2021Big_vs_2021Virgin

vcftools \
--gzvcf /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011-21.recode.vcf.gz \
--weir-fst-pop /home/instr1/twg/popgen/pops/2021Big.txt \
--weir-fst-pop /home/instr1/twg/popgen/pops/2021Pudding.txt \
--out /home/instr1/twg/popgen/pairwise-fst/evo-scale/2021Big_vs_2021Pudding

vcftools \
--gzvcf /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011-21.recode.vcf.gz \
--weir-fst-pop /home/instr1/twg/popgen/pops/2021Big.txt \
--weir-fst-pop /home/instr1/twg/popgen/pops/2017Antonio.txt \
--out /home/instr1/twg/popgen/pairwise-fst/evo-scale/2021Big_vs_2017Antonio

vcftools \
--gzvcf /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011-21.recode.vcf.gz \
--weir-fst-pop /home/instr1/twg/popgen/pops/2021Big.txt \
--weir-fst-pop /home/instr1/twg/popgen/pops/2017Ynez.txt \
--out /home/instr1/twg/popgen/pairwise-fst/evo-scale/2021Big_vs_2017Ynez

vcftools \
--gzvcf /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011-21.recode.vcf.gz \
--weir-fst-pop /home/instr1/twg/popgen/pops/2021Big.txt \
--weir-fst-pop /home/instr1/twg/popgen/pops/2014Paredon.txt \
--out /home/instr1/twg/popgen/pairwise-fst/evo-scale/2021Big_vs_2014Paredon

vcftools \
--gzvcf /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011-21.recode.vcf.gz \
--weir-fst-pop /home/instr1/twg/popgen/pops/2021Big.txt \
--weir-fst-pop /home/instr1/twg/popgen/pops/2014Burro.txt \
--out /home/instr1/twg/popgen/pairwise-fst/evo-scale/2021Big_vs_2014Burro

vcftools \
--gzvcf /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011-21.recode.vcf.gz \
--weir-fst-pop /home/instr1/twg/popgen/pops/2021Virgin.txt \
--weir-fst-pop /home/instr1/twg/popgen/pops/2021Pudding.txt \
--out /home/instr1/twg/popgen/pairwise-fst/evo-scale/2021Virgin_vs_2021Pudding

vcftools \
--gzvcf /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011-21.recode.vcf.gz \
--weir-fst-pop /home/instr1/twg/popgen/pops/2021Virgin.txt \
--weir-fst-pop /home/instr1/twg/popgen/pops/2017Antonio.txt \
--out /home/instr1/twg/popgen/pairwise-fst/evo-scale/2021Virgin_vs_2017Antonio

vcftools \
--gzvcf /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011-21.recode.vcf.gz \
--weir-fst-pop /home/instr1/twg/popgen/pops/2021Virgin.txt \
--weir-fst-pop /home/instr1/twg/popgen/pops/2017Ynez.txt \
--out /home/instr1/twg/popgen/pairwise-fst/evo-scale/2021Virgin_vs_2017Ynez

vcftools \
--gzvcf /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011-21.recode.vcf.gz \
--weir-fst-pop /home/instr1/twg/popgen/pops/2021Virgin.txt \
--weir-fst-pop /home/instr1/twg/popgen/pops/2014Paredon.txt \
--out /home/instr1/twg/popgen/pairwise-fst/evo-scale/2021Virgin_vs_2014Paredon

vcftools \
--gzvcf /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011-21.recode.vcf.gz \
--weir-fst-pop /home/instr1/twg/popgen/pops/2021Virgin.txt \
--weir-fst-pop /home/instr1/twg/popgen/pops/2014Burro.txt \
--out /home/instr1/twg/popgen/pairwise-fst/evo-scale/2021Virgin_vs_2014Burro

vcftools \
--gzvcf /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011-21.recode.vcf.gz \
--weir-fst-pop /home/instr1/twg/popgen/pops/2021Pudding.txt \
--weir-fst-pop /home/instr1/twg/popgen/pops/2017Antonio.txt \
--out /home/instr1/twg/popgen/pairwise-fst/evo-scale/2021Pudding_vs_2017Antonio

vcftools \
--gzvcf /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011-21.recode.vcf.gz \
--weir-fst-pop /home/instr1/twg/popgen/pops/2021Pudding.txt \
--weir-fst-pop /home/instr1/twg/popgen/pops/2017Ynez.txt \
--out /home/instr1/twg/popgen/pairwise-fst/evo-scale/2021Pudding_vs_2017Ynez

vcftools \
--gzvcf /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011-21.recode.vcf.gz \
--weir-fst-pop /home/instr1/twg/popgen/pops/2021Pudding.txt \
--weir-fst-pop /home/instr1/twg/popgen/pops/2014Paredon.txt \
--out /home/instr1/twg/popgen/pairwise-fst/evo-scale/2021Pudding_vs_2014Paredon

vcftools \
--gzvcf /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011-21.recode.vcf.gz \
--weir-fst-pop /home/instr1/twg/popgen/pops/2021Pudding.txt \
--weir-fst-pop /home/instr1/twg/popgen/pops/2014Burro.txt \
--out /home/instr1/twg/popgen/pairwise-fst/evo-scale/2021Pudding_vs_2014Burro

vcftools \
--gzvcf /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011-21.recode.vcf.gz \
--weir-fst-pop /home/instr1/twg/popgen/pops/2017Antonio.txt \
--weir-fst-pop /home/instr1/twg/popgen/pops/2017Ynez.txt \
--out /home/instr1/twg/popgen/pairwise-fst/evo-scale/2017Antonio_vs_2017Ynez

vcftools \
--gzvcf /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011-21.recode.vcf.gz \
--weir-fst-pop /home/instr1/twg/popgen/pops/2017Antonio.txt \
--weir-fst-pop /home/instr1/twg/popgen/pops/2014Paredon.txt \
--out /home/instr1/twg/popgen/pairwise-fst/evo-scale/2017Antonio_vs_2014Paredon

vcftools \
--gzvcf /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011-21.recode.vcf.gz \
--weir-fst-pop /home/instr1/twg/popgen/pops/2017Antonio.txt \
--weir-fst-pop /home/instr1/twg/popgen/pops/2014Burro.txt \
--out /home/instr1/twg/popgen/pairwise-fst/evo-scale/2017Antonio_vs_2014Burro

vcftools \
--gzvcf /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011-21.recode.vcf.gz \
--weir-fst-pop /home/instr1/twg/popgen/pops/2017Ynez.txt \
--weir-fst-pop /home/instr1/twg/popgen/pops/2014Paredon.txt \
--out /home/instr1/twg/popgen/pairwise-fst/evo-scale/2017Ynez_vs_2014Paredon

vcftools \
--gzvcf /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011-21.recode.vcf.gz \
--weir-fst-pop /home/instr1/twg/popgen/pops/2017Ynez.txt \
--weir-fst-pop /home/instr1/twg/popgen/pops/2014Burro.txt \
--out /home/instr1/twg/popgen/pairwise-fst/evo-scale/2017Ynez_vs_2014Burro

vcftools \
--gzvcf /home/instr1/twg/popgen/pairwise-fst/evo-scale/2011-21.recode.vcf.gz \
--weir-fst-pop /home/instr1/twg/popgen/pops/2014Paredon.txt \
--weir-fst-pop /home/instr1/twg/popgen/pops/2014Burro.txt \
--out /home/instr1/twg/popgen/pairwise-fst/evo-scale/2014Paredon_vs_2014Burro

