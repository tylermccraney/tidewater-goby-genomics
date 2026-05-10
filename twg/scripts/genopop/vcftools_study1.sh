#!/bin/bash

###--keep /home/wtm3/twg/popgen/pops/2011Tillas.txt \
###--keep /home/wtm3/twg/popgen/pops/2011Earl.txt \
###--keep /home/wtm3/twg/popgen/pops/2006Stone.txt \
###--keep /home/wtm3/twg/popgen/pops/2006Big.txt \
###--keep /home/wtm3/twg/popgen/pops/2009Arcata.txt \
###--keep /home/wtm3/twg/popgen/pops/1988Virgin.txt \
###--keep /home/wtm3/twg/popgen/pops/2006Virgin.txt \
###--keep /home/wtm3/twg/popgen/pops/2006Pudding.txt \
###--keep /home/wtm3/twg/popgen/pops/2017Antonio.txt \
###--keep /home/wtm3/twg/popgen/pops/2017Ynez.txt \
###--keep /home/wtm3/twg/popgen/pops/2014Burro.txt \
###--keep /home/wtm3/twg/popgen/pops/2014Paredon.txt \
##
### multi-allelic SNPs for phylogenetic analysis
### limit to 22 chromosomes, but allow singletons
##vcftools \
##--chr JAPEHO010000001.1 \
##--chr JAPEHO010000002.1 \
##--chr JAPEHO010000003.1 \
##--chr JAPEHO010000004.1 \
##--chr JAPEHO010000005.1 \
##--chr JAPEHO010000006.1 \
##--chr JAPEHO010000007.1 \
##--chr JAPEHO010000008.1 \
##--chr JAPEHO010000009.1 \
##--chr JAPEHO010000010.1 \
##--chr JAPEHO010000011.1 \
##--chr JAPEHO010000012.1 \
##--chr JAPEHO010000013.1 \
##--chr JAPEHO010000014.1 \
##--chr JAPEHO010000015.1 \
##--chr JAPEHO010000016.1 \
##--chr JAPEHO010000017.1 \
##--chr JAPEHO010000018.1 \
##--chr JAPEHO010000019.1 \
##--chr JAPEHO010000020.1 \
##--chr JAPEHO010000021.1 \
##--chr JAPEHO010000022.1 \
##--gzvcf /home/wtm3/twg/variants/selectvariants.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2011Tillas.txt \
##--keep /home/wtm3/twg/popgen/pops/2011Earl.txt \
##--keep /home/wtm3/twg/popgen/pops/2006Stone.txt \
##--keep /home/wtm3/twg/popgen/pops/2006Big.txt \
##--keep /home/wtm3/twg/popgen/pops/2009Arcata.txt \
##--keep /home/wtm3/twg/popgen/pops/1988Virgin.txt \
##--keep /home/wtm3/twg/popgen/pops/2006Virgin.txt \
##--keep /home/wtm3/twg/popgen/pops/2006Pudding.txt \
##--keep /home/wtm3/twg/popgen/pops/2017Antonio.txt \
##--keep /home/wtm3/twg/popgen/pops/2017Ynez.txt \
##--keep /home/wtm3/twg/popgen/pops/2014Burro.txt \
##--keep /home/wtm3/twg/popgen/pops/2014Paredon.txt \
##--max-alleles 4 \
##--max-missing 1 \
##--min-alleles 2 \
##--out /home/wtm3/twg/popgen/study1/12pops_multiAllelicSNPs \
##--recode \
##--remove-filtered-all \
##--remove-indels
##
##gzip /home/wtm3/twg/popgen/study1/12pops_multiAllelicSNPs.recode.vcf


##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_multiAllelicSNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2011Tillas.txt \
##--out /home/wtm3/twg/popgen/study1/iqtree/2011Tillas \
##--recode
##
##bgzip /home/wtm3/twg/popgen/study1/iqtree/2011Tillas.recode.vcf
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_multiAllelicSNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2011Earl.txt \
##--out /home/wtm3/twg/popgen/study1/iqtree/2011Earl \
##--recode
##
##bgzip /home/wtm3/twg/popgen/study1/iqtree/2011Earl.recode.vcf
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_multiAllelicSNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2006Stone.txt \
##--out /home/wtm3/twg/popgen/study1/iqtree/2006Stone \
##--recode
##
##bgzip /home/wtm3/twg/popgen/study1/iqtree/2006Stone.recode.vcf
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_multiAllelicSNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2006Big.txt \
##--out /home/wtm3/twg/popgen/study1/iqtree/2006Big \
##--recode
##
##bgzip /home/wtm3/twg/popgen/study1/iqtree/2006Big.recode.vcf
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_multiAllelicSNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2009Arcata.txt \
##--out /home/wtm3/twg/popgen/study1/iqtree/2009Arcata \
##--recode
##
##bgzip /home/wtm3/twg/popgen/study1/iqtree/2009Arcata.recode.vcf
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_multiAllelicSNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2006Virgin.txt \
##--out /home/wtm3/twg/popgen/study1/iqtree/2006Virgin \
##--recode
##
##bgzip /home/wtm3/twg/popgen/study1/iqtree/2006Virgin.recode.vcf
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_multiAllelicSNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2006Pudding.txt \
##--out /home/wtm3/twg/popgen/study1/iqtree/2006Pudding \
##--recode
##
##bgzip /home/wtm3/twg/popgen/study1/iqtree/2006Pudding.recode.vcf
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_multiAllelicSNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2017Antonio.txt \
##--out /home/wtm3/twg/popgen/study1/iqtree/2017Antonio \
##--recode
##
##bgzip /home/wtm3/twg/popgen/study1/iqtree/2017Antonio.recode.vcf
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_multiAllelicSNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2017Ynez.txt \
##--out /home/wtm3/twg/popgen/study1/iqtree/2017Ynez \
##--recode
##
##bgzip /home/wtm3/twg/popgen/study1/iqtree/2017Ynez.recode.vcf
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_multiAllelicSNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2014Burro.txt \
##--out /home/wtm3/twg/popgen/study1/iqtree/2014Burro \
##--recode
##
##bgzip /home/wtm3/twg/popgen/study1/iqtree/2014Burro.recode.vcf
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_multiAllelicSNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2014Paredon.txt \
##--out /home/wtm3/twg/popgen/study1/iqtree/2014Paredon \
##--recode
##
##bgzip /home/wtm3/twg/popgen/study1/iqtree/2014Paredon.recode.vcf
##
##tabix -p vcf "/home/wtm3/twg/popgen/study1/iqtree/2006Big.recode.vcf.gz"
##tabix -p vcf "/home/wtm3/twg/popgen/study1/iqtree/2006Pudding.recode.vcf.gz"
##tabix -p vcf "/home/wtm3/twg/popgen/study1/iqtree/2006Stone.recode.vcf.gz"
##tabix -p vcf "/home/wtm3/twg/popgen/study1/iqtree/2006Virgin.recode.vcf.gz"
##tabix -p vcf "/home/wtm3/twg/popgen/study1/iqtree/2009Arcata.recode.vcf.gz"
##tabix -p vcf "/home/wtm3/twg/popgen/study1/iqtree/2011Earl.recode.vcf.gz"
##tabix -p vcf "/home/wtm3/twg/popgen/study1/iqtree/2011Tillas.recode.vcf.gz"
##tabix -p vcf "/home/wtm3/twg/popgen/study1/iqtree/2014Burro.recode.vcf.gz"
##tabix -p vcf "/home/wtm3/twg/popgen/study1/iqtree/2014Paredon.recode.vcf.gz"
##tabix -p vcf "/home/wtm3/twg/popgen/study1/iqtree/2017Antonio.recode.vcf.gz"
##tabix -p vcf "/home/wtm3/twg/popgen/study1/iqtree/2017Ynez.recode.vcf.gz"

FastaVCFToCounts.py \
--merge \
/home/wtm3/twg/popgen/study1/iqtree/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna.gz \
/home/wtm3/twg/popgen/study1/iqtree/2006Big.recode.vcf.gz \
/home/wtm3/twg/popgen/study1/iqtree/2006Pudding.recode.vcf.gz \
/home/wtm3/twg/popgen/study1/iqtree/2006Stone.recode.vcf.gz \
/home/wtm3/twg/popgen/study1/iqtree/2006Virgin.recode.vcf.gz \
/home/wtm3/twg/popgen/study1/iqtree/2009Arcata.recode.vcf.gz \
/home/wtm3/twg/popgen/study1/iqtree/2011Earl.recode.vcf.gz \
/home/wtm3/twg/popgen/study1/iqtree/2011Tillas.recode.vcf.gz \
/home/wtm3/twg/popgen/study1/iqtree/2014Burro.recode.vcf.gz \
/home/wtm3/twg/popgen/study1/iqtree/2014Paredon.recode.vcf.gz \
/home/wtm3/twg/popgen/study1/iqtree/2017Antonio.recode.vcf.gz \
/home/wtm3/twg/popgen/study1/iqtree/2017Ynez.recode.vcf.gz \
/home/wtm3/twg/popgen/study1/iqtree/12pops_multiAllelicSNPs.cf







##
##
### bi-allelic SNPs for population genetic analysis
### limit to 22 chromosomes and filter singletons
##vcftools \
##--chr JAPEHO010000001.1 \
##--chr JAPEHO010000002.1 \
##--chr JAPEHO010000003.1 \
##--chr JAPEHO010000004.1 \
##--chr JAPEHO010000005.1 \
##--chr JAPEHO010000006.1 \
##--chr JAPEHO010000007.1 \
##--chr JAPEHO010000008.1 \
##--chr JAPEHO010000009.1 \
##--chr JAPEHO010000010.1 \
##--chr JAPEHO010000011.1 \
##--chr JAPEHO010000012.1 \
##--chr JAPEHO010000013.1 \
##--chr JAPEHO010000014.1 \
##--chr JAPEHO010000015.1 \
##--chr JAPEHO010000016.1 \
##--chr JAPEHO010000017.1 \
##--chr JAPEHO010000018.1 \
##--chr JAPEHO010000019.1 \
##--chr JAPEHO010000020.1 \
##--chr JAPEHO010000021.1 \
##--chr JAPEHO010000022.1 \
##--gzvcf /home/wtm3/twg/variants/selectvariants.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2011Tillas.txt \
##--keep /home/wtm3/twg/popgen/pops/2011Earl.txt \
##--keep /home/wtm3/twg/popgen/pops/2006Stone.txt \
##--keep /home/wtm3/twg/popgen/pops/2006Big.txt \
##--keep /home/wtm3/twg/popgen/pops/2009Arcata.txt \
##--keep /home/wtm3/twg/popgen/pops/1988Virgin.txt \
##--keep /home/wtm3/twg/popgen/pops/2006Virgin.txt \
##--keep /home/wtm3/twg/popgen/pops/2006Pudding.txt \
##--keep /home/wtm3/twg/popgen/pops/2017Antonio.txt \
##--keep /home/wtm3/twg/popgen/pops/2017Ynez.txt \
##--keep /home/wtm3/twg/popgen/pops/2014Burro.txt \
##--keep /home/wtm3/twg/popgen/pops/2014Paredon.txt \
##--max-alleles 2 \
##--max-missing 1 \
##--min-alleles 2 \
##--out /home/wtm3/twg/popgen/study1/12pops_SNPs \
##--singletons \
##--remove-filtered-all \
##--remove-indels
##
##cat /home/wtm3/twg/popgen/study1/12pops_SNPs.singletons | \
##awk '{print $1"\t"$2}' | \
##sed '1 s/./#&/' \
##> /home/wtm3/twg/popgen/study1/12pops_SNPs.singletons.tab
##
##vcftools \
##--chr JAPEHO010000001.1 \
##--chr JAPEHO010000002.1 \
##--chr JAPEHO010000003.1 \
##--chr JAPEHO010000004.1 \
##--chr JAPEHO010000005.1 \
##--chr JAPEHO010000006.1 \
##--chr JAPEHO010000007.1 \
##--chr JAPEHO010000008.1 \
##--chr JAPEHO010000009.1 \
##--chr JAPEHO010000010.1 \
##--chr JAPEHO010000011.1 \
##--chr JAPEHO010000012.1 \
##--chr JAPEHO010000013.1 \
##--chr JAPEHO010000014.1 \
##--chr JAPEHO010000015.1 \
##--chr JAPEHO010000016.1 \
##--chr JAPEHO010000017.1 \
##--chr JAPEHO010000018.1 \
##--chr JAPEHO010000019.1 \
##--chr JAPEHO010000020.1 \
##--chr JAPEHO010000021.1 \
##--chr JAPEHO010000022.1 \
##--exclude-positions /home/wtm3/twg/popgen/study1/12pops_SNPs.singletons.tab \
##--gzvcf /home/wtm3/twg/variants/selectvariants.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2011Tillas.txt \
##--keep /home/wtm3/twg/popgen/pops/2011Earl.txt \
##--keep /home/wtm3/twg/popgen/pops/2006Stone.txt \
##--keep /home/wtm3/twg/popgen/pops/2006Big.txt \
##--keep /home/wtm3/twg/popgen/pops/2009Arcata.txt \
##--keep /home/wtm3/twg/popgen/pops/1988Virgin.txt \
##--keep /home/wtm3/twg/popgen/pops/2006Virgin.txt \
##--keep /home/wtm3/twg/popgen/pops/2006Pudding.txt \
##--keep /home/wtm3/twg/popgen/pops/2017Antonio.txt \
##--keep /home/wtm3/twg/popgen/pops/2017Ynez.txt \
##--keep /home/wtm3/twg/popgen/pops/2014Burro.txt \
##--keep /home/wtm3/twg/popgen/pops/2014Paredon.txt \
##--max-alleles 2 \
##--max-missing 1 \
##--min-alleles 2 \
##--out /home/wtm3/twg/popgen/study1/12pops_SNPs \
##--recode \
##--remove-filtered-all \
##--remove-indels
##
##gzip /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf
##
### OUTPUT ALLELE STATISTICS
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2011Tillas.txt \
##--freq2 \
##--out /home/wtm3/twg/popgen/study1/freq/2011Tillas
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2011Earl.txt \
##--freq2 \
##--out /home/wtm3/twg/popgen/study1/freq/2011Earl
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2006Stone.txt \
##--freq2 \
##--out /home/wtm3/twg/popgen/study1/freq/2006Stone
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2006Big.txt \
##--freq2 \
##--out /home/wtm3/twg/popgen/study1/freq/2006Big
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2009Arcata.txt \
##--freq2 \
##--out /home/wtm3/twg/popgen/study1/freq/2009Arcata
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/1988Virgin.txt \
##--freq2 \
##--out /home/wtm3/twg/popgen/study1/freq/1988Virgin
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2006Virgin.txt \
##--freq2 \
##--out /home/wtm3/twg/popgen/study1/freq/2006Virgin
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2006Pudding.txt \
##--freq2 \
##--out /home/wtm3/twg/popgen/study1/freq/2006Pudding
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2017Antonio.txt \
##--freq2 \
##--out /home/wtm3/twg/popgen/study1/freq/2017Antonio
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2017Ynez.txt \
##--freq2 \
##--out /home/wtm3/twg/popgen/study1/freq/2017Ynez
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2014Burro.txt \
##--freq2 \
##--out /home/wtm3/twg/popgen/study1/freq/2014Burro
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2014Paredon.txt \
##--freq2 \
##--out /home/wtm3/twg/popgen/study1/freq/2014Paredon
##
##
### OUTPUT DEPTH STATISTICS
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--out /home/wtm3/twg/popgen/study1/12pops_SNPs_depth \
##--depth
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--out /home/wtm3/twg/popgen/study1/12pops_SNPs_site_depth \
##--site-depth
##
##
### OUTPUT NUCLEOTIDE DIVERGENCE STATISTICS
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2011Tillas.txt \
##--site-pi \
##--out /home/wtm3/twg/popgen/study1/pi/2011Tillas
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2011Earl.txt \
##--site-pi \
##--out /home/wtm3/twg/popgen/study1/pi/2011Earl
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2006Stone.txt \
##--site-pi \
##--out /home/wtm3/twg/popgen/study1/pi/2006Stone
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2006Big.txt \
##--site-pi \
##--out /home/wtm3/twg/popgen/study1/pi/2006Big
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2009Arcata.txt \
##--site-pi \
##--out /home/wtm3/twg/popgen/study1/pi/2009Arcata
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/1988Virgin.txt \
##--site-pi \
##--out /home/wtm3/twg/popgen/study1/pi/1988Virgin
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2006Virgin.txt \
##--site-pi \
##--out /home/wtm3/twg/popgen/study1/pi/2006Virgin
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2006Pudding.txt \
##--site-pi \
##--out /home/wtm3/twg/popgen/study1/pi/2006Pudding
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2017Antonio.txt \
##--site-pi \
##--out /home/wtm3/twg/popgen/study1/pi/2017Antonio
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2017Ynez.txt \
##--site-pi \
##--out /home/wtm3/twg/popgen/study1/pi/2017Ynez
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2014Burro.txt \
##--site-pi \
##--out /home/wtm3/twg/popgen/study1/pi/2014Burro
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2014Paredon.txt \
##--site-pi \
##--out /home/wtm3/twg/popgen/study1/pi/2014Paredon
##
##
### FST
### 2011Tillas
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2011Tillas.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2011Earl.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2011Tillas_vs_2011Earl_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2011Tillas.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Stone.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2011Tillas_vs_2006Stone_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2011Tillas.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Big.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2011Tillas_vs_2006Big_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2011Tillas.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2009Arcata.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2011Tillas_vs_2009Arcata_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2011Tillas.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/1988Virgin.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2011Tillas_vs_1988Virgin_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2011Tillas.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Virgin.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2011Tillas_vs_2006Virgin_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2011Tillas.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Pudding.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2011Tillas_vs_2006Pudding_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2011Tillas.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2017Antonio.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2011Tillas_vs_2017Antonio_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2011Tillas.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2017Ynez.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2011Tillas_vs_2017Ynez_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2011Tillas.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2014Burro.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2011Tillas_vs_2014Burro_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2011Tillas.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2014Paredon.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2011Tillas_vs_2014Paredon_fst
##
### 2011Earl
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2011Earl.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Stone.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2011Earl_vs_2006Stone_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2011Earl.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Big.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2011Earl_vs_2006Big_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2011Earl.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2009Arcata.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2011Earl_vs_2009Arcata_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2011Earl.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/1988Virgin.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2011Earl_vs_1988Virgin_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2011Earl.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Virgin.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2011Earl_vs_2006Virgin_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2011Earl.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Pudding.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2011Earl_vs_2006Pudding_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2011Earl.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2017Antonio.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2011Earl_vs_2017Antonio_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2011Earl.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2017Ynez.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2011Earl_vs_2017Ynez_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2011Earl.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2014Burro.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2011Earl_vs_2014Burro_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2011Earl.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2014Paredon.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2011Earl_vs_2014Paredon_fst
##
### 2006Stone
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Stone.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Big.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2006Stone_vs_2006Big_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Stone.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2009Arcata.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2006Stone_vs_2009Arcata_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Stone.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/1988Virgin.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2006Stone_vs_1988Virgin_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Stone.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Virgin.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2006Stone_vs_2006Virgin_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Stone.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Pudding.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2006Stone_vs_2006Pudding_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Stone.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2017Antonio.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2006Stone_vs_2017Antonio_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Stone.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2017Ynez.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2006Stone_vs_2017Ynez_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Stone.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2014Burro.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2006Stone_vs_2014Burro_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Stone.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2014Paredon.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2006Stone_vs_2014Paredon_fst
##
### 2006Big
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Big.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2009Arcata.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2006Big_vs_2009Arcata_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Big.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/1988Virgin.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2006Big_vs_1988Virgin_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Big.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Virgin.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2006Big_vs_2006Virgin_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Big.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Pudding.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2006Big_vs_2006Pudding_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Big.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2017Antonio.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2006Big_vs_2017Antonio_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Big.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2017Ynez.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2006Big_vs_2017Ynez_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Big.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2014Burro.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2006Big_vs_2014Burro_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Big.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2014Paredon.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2006Big_vs_2014Paredon_fst
##
### 2009Arcata
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2009Arcata.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/1988Virgin.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2009Arcata_vs_1988Virgin_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2009Arcata.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Virgin.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2009Arcata_vs_2006Virgin_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2009Arcata.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Pudding.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2009Arcata_vs_2006Pudding_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2009Arcata.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2017Antonio.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2009Arcata_vs_2017Antonio_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2009Arcata.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2017Ynez.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2009Arcata_vs_2017Ynez_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2009Arcata.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2014Burro.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2009Arcata_vs_2014Burro_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2009Arcata.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2014Paredon.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2009Arcata_vs_2014Paredon_fst
##
### 1988Virgin
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/1988Virgin.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Virgin.txt \
##--out /home/wtm3/twg/popgen/study1/fst/1988Virgin_vs_2006Virgin_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/1988Virgin.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Pudding.txt \
##--out /home/wtm3/twg/popgen/study1/fst/1988Virgin_vs_2006Pudding_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/1988Virgin.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2017Antonio.txt \
##--out /home/wtm3/twg/popgen/study1/fst/1988Virgin_vs_2017Antonio_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/1988Virgin.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2017Ynez.txt \
##--out /home/wtm3/twg/popgen/study1/fst/1988Virgin_vs_2017Ynez_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/1988Virgin.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2014Burro.txt \
##--out /home/wtm3/twg/popgen/study1/fst/1988Virgin_vs_2014Burro_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/1988Virgin.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2014Paredon.txt \
##--out /home/wtm3/twg/popgen/study1/fst/1988Virgin_vs_2014Paredon_fst
##
### 2006Virgin
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Virgin.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Pudding.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2006Virgin_vs_2006Pudding_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Virgin.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2017Antonio.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2006Virgin_vs_2017Antonio_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Virgin.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2017Ynez.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2006Virgin_vs_2017Ynez_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Virgin.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2014Burro.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2006Virgin_vs_2014Burro_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Virgin.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2014Paredon.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2006Virgin_vs_2014Paredon_fst
##
### 2006Pudding
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Pudding.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2017Antonio.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2006Pudding_vs_2017Antonio_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Pudding.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2017Ynez.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2006Pudding_vs_2017Ynez_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Pudding.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2014Burro.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2006Pudding_vs_2014Burro_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2006Pudding.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2014Paredon.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2006Pudding_vs_2014Paredon_fst
##
### 2017Antonio
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2017Antonio.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2017Ynez.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2017Antonio_vs_2017Ynez_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2017Antonio.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2014Burro.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2017Antonio_vs_2014Burro_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2017Antonio.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2014Paredon.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2017Antonio_vs_2014Paredon_fst
##
### 2017Ynez
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2017Ynez.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2014Burro.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2017Ynez_vs_2014Burro_fst
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2017Ynez.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2014Paredon.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2017Ynez_vs_2014Paredon_fst
##
### 2014Burro
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2014Burro.txt \
##--weir-fst-pop /home/wtm3/twg/popgen/pops/2014Paredon.txt \
##--out /home/wtm3/twg/popgen/study1/fst/2014Burro_vs_2014Paredon_fst
##
##
### OUTPUT OTHER STATISTICS
### het
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2011Tillas.txt \
##--het \
##--out /home/wtm3/twg/popgen/study1/het/2011Tillas
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2011Earl.txt \
##--het \
##--out /home/wtm3/twg/popgen/study1/het/2011Earl
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2006Stone.txt \
##--het \
##--out /home/wtm3/twg/popgen/study1/het/2006Stone
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2006Big.txt \
##--het \
##--out /home/wtm3/twg/popgen/study1/het/2006Big
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2009Arcata.txt \
##--het \
##--out /home/wtm3/twg/popgen/study1/het/2009Arcata
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/1988Virgin.txt \
##--het \
##--out /home/wtm3/twg/popgen/study1/het/1988Virgin
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2006Virgin.txt \
##--het \
##--out /home/wtm3/twg/popgen/study1/het/2006Virgin
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2006Pudding.txt \
##--het \
##--out /home/wtm3/twg/popgen/study1/het/2006Pudding
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2017Antonio.txt \
##--het \
##--out /home/wtm3/twg/popgen/study1/het/2017Antonio
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2017Ynez.txt \
##--het \
##--out /home/wtm3/twg/popgen/study1/het/2017Ynez
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2014Burro.txt \
##--het \
##--out /home/wtm3/twg/popgen/study1/het/2014Burro
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2014Paredon.txt \
##--het \
##--out /home/wtm3/twg/popgen/study1/het/2014Paredon
##
### hardy
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2011Tillas.txt \
##--hardy \
##--out /home/wtm3/twg/popgen/study1/hardy/2011Tillas
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2011Earl.txt \
##--hardy \
##--out /home/wtm3/twg/popgen/study1/hardy/2011Earl
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2006Stone.txt \
##--hardy \
##--out /home/wtm3/twg/popgen/study1/hardy/2006Stone
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2006Big.txt \
##--hardy \
##--out /home/wtm3/twg/popgen/study1/hardy/2006Big
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2009Arcata.txt \
##--hardy \
##--out /home/wtm3/twg/popgen/study1/hardy/2009Arcata
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/1988Virgin.txt \
##--hardy \
##--out /home/wtm3/twg/popgen/study1/hardy/1988Virgin
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2006Virgin.txt \
##--hardy \
##--out /home/wtm3/twg/popgen/study1/hardy/2006Virgin
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2006Pudding.txt \
##--hardy \
##--out /home/wtm3/twg/popgen/study1/hardy/2006Pudding
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2017Antonio.txt \
##--hardy \
##--out /home/wtm3/twg/popgen/study1/hardy/2017Antonio
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2017Ynez.txt \
##--hardy \
##--out /home/wtm3/twg/popgen/study1/hardy/2017Ynez
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2014Burro.txt \
##--hardy \
##--out /home/wtm3/twg/popgen/study1/hardy/2014Burro
##
##vcftools \
##--gzvcf /home/wtm3/twg/popgen/study1/12pops_SNPs.recode.vcf.gz \
##--keep /home/wtm3/twg/popgen/pops/2014Paredon.txt \
##--hardy \
##--out /home/wtm3/twg/popgen/study1/hardy/2014Paredon
##
