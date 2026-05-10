#!/bin/bash

### filter singletons
vcftools \
--gzvcf $HOME/twg/variants/selectvariants.vcf.gz \
--keep $HOME/twg/popgen/pops/2011-21.txt \
--min-alleles 2 \
--max-alleles 2 \
--max-missing 1 \
--remove-filtered-all \
--remove-indels \
--singletons \
--out $HOME/twg/popgen/vcftools/evo-scale/2011-21.snps.100p

cat $HOME/twg/popgen/vcftools/evo-scale/2011-21.snps.100p.singletons | \
awk '{print $1"\t"$2}' \
> $HOME/twg/popgen/vcftools/evo-scale/2011-21.snps.100p.singletons.tab

echo -n "#" | \
cat - $HOME/twg/popgen/vcftools/evo-scale/2011-21.snps.100p.singletons.tab \
> $HOME/twg/popgen/vcftools/evo-scale/2011-21.snps.100p.singletons.exclude

vcftools \
--exclude-positions $HOME/twg/popgen/vcftools/evo-scale/2011-21.snps.100p.singletons.exclude \
--gzvcf $HOME/twg/variants/selectvariants.vcf.gz \
--keep $HOME/twg/popgen/pops/2011-21.txt \
--min-alleles 2 \
--max-alleles 2 \
--max-missing 1 \
--recode \
--remove-filtered-all \
--remove-indels \
--out $HOME/twg/popgen/vcftools/evo-scale/2011-21.snps.100p

gzip $HOME/twg/popgen/vcftools/evo-scale/2011-21.snps.100p.recode.vcf

## find 40 Mb windows with only 1 SNP
vcftools \
--gzvcf $HOME/twg/popgen/vcftools/evo-scale/2011-21.snps.100p.recode.vcf.gz \
--SNPdensity 40000000 \
--out $HOME/twg/popgen/vcftools/evo-scale/2011-21.snps.100p

# get SNP pos
vcftools \
--gzvcf $HOME/twg/popgen/vcftools/evo-scale/2011-21.snps.100p.recode.vcf.gz \
--chr h1tg000140l \
--chr h1tg000286l \
--chr h1tg000293l \
--chr h1tg000404l \
--chr h1tg000701l \
--chr h1tg000769l \
--chr h1tg000770l \
--chr h1tg001057l \
--chr h1tg001088l \
--chr h1tg001192l \
--chr h1tg001201l \
--chr h1tg001229l \
--chr h1tg001275l \
--chr h1tg001304l \
--chr h1tg001352l \
--chr h1tg001357l \
--chr h1tg001365l \
--chr h1tg001397l \
--chr h1tg001428l \
--chr h1tg001438l \
--chr h1tg001444l \
--chr h1tg001479l \
--chr h1tg001518l \
--chr h1tg001563l \
--chr h1tg001566l \
--chr h1tg001569l \
--chr h1tg001575l \
--chr h1tg001583l \
--chr h1tg001601l \
--chr h1tg001623l \
--chr h1tg001656l \
--chr h1tg001664l \
--chr h1tg001726l \
--chr h1tg001753l \
--chr h1tg001844l \
--out $HOME/twg/popgen/vcftools/evo-scale/1snp \
--site-pi

# prepare exclude file for beagle
tail -n +2 $HOME/twg/popgen/vcftools/evo-scale/1snp.sites.pi | \
awk '{print $1":"$2}' \
> $HOME/twg/popgen/beagle/2011-21.snps.100p.exclude.txt


## check site depth for anomolies  (e.g., mtDNA, bacterial genomes)
vcftools \
--gzvcf $HOME/twg/popgen/vcftools/evo-scale/2011-21.snps.100p.recode.vcf.gz \
--site-mean-depth \
--out $HOME/twg/popgen/vcftools/evo-scale/2011-21.snps.100p


## OUTPUT LD STATISTICS
cd $HOME/twg/popgen/vcftools/evo-scale
mkdir 2011Tillas 2011Earl 2021Stone 2021Big 2021Virgin 2021Pudding 2017Antonio 2017Ynez 2014Burro 2014Paredon

vcftools \
--gzvcf $HOME/twg/popgen/beagle/2011-21.snps.100p.vcf.gz \
--hap-r2 \
--keep $HOME/twg/popgen/pops/2011Tillas.txt \
--ld-window-bp-min 1000 \
--mac 1 \
--min-r2 0.0001 \
--out $HOME/twg/popgen/vcftools/evo-scale/2011Tillas/2011Tillas.snps.100p.1kb \
& \
vcftools \
--gzvcf $HOME/twg/popgen/beagle/2011-21.snps.100p.vcf.gz \
--hap-r2 \
--keep $HOME/twg/popgen/pops/2011Earl.txt \
--ld-window-bp-min 1000 \
--mac 1 \
--min-r2 0.0001 \
--out $HOME/twg/popgen/vcftools/evo-scale/2011Earl/2011Earl.snps.100p.1kb \
& \
vcftools \
--gzvcf $HOME/twg/popgen/beagle/2011-21.snps.100p.vcf.gz \
--hap-r2 \
--keep $HOME/twg/popgen/pops/2021Stone.txt \
--ld-window-bp-min 1000 \
--mac 1 \
--min-r2 0.0001 \
--out $HOME/twg/popgen/vcftools/evo-scale/2021Stone/2021Stone.snps.100p.1kb \
& \
vcftools \
--gzvcf $HOME/twg/popgen/beagle/2011-21.snps.100p.vcf.gz \
--hap-r2 \
--keep $HOME/twg/popgen/pops/2021Big.txt \
--ld-window-bp-min 1000 \
--mac 1 \
--min-r2 0.0001 \
--out $HOME/twg/popgen/vcftools/evo-scale/2021Big/2021Big.snps.100p.1kb \
& \
vcftools \
--gzvcf $HOME/twg/popgen/beagle/2011-21.snps.100p.vcf.gz \
--hap-r2 \
--keep $HOME/twg/popgen/pops/2021Virgin.txt \
--ld-window-bp-min 1000 \
--mac 1 \
--min-r2 0.0001 \
--out $HOME/twg/popgen/vcftools/evo-scale/2021Virgin/2021Virgin.snps.100p.1kb \
& \
vcftools \
--gzvcf $HOME/twg/popgen/beagle/2011-21.snps.100p.vcf.gz \
--hap-r2 \
--keep $HOME/twg/popgen/pops/2021Pudding.txt \
--ld-window-bp-min 1000 \
--mac 1 \
--min-r2 0.0001 \
--out $HOME/twg/popgen/vcftools/evo-scale/2021Pudding/2021Pudding.snps.100p.1kb \
& \
vcftools \
--gzvcf $HOME/twg/popgen/beagle/2011-21.snps.100p.vcf.gz \
--hap-r2 \
--keep $HOME/twg/popgen/pops/2017Antonio.txt \
--ld-window-bp-min 1000 \
--mac 1 \
--min-r2 0.0001 \
--out $HOME/twg/popgen/vcftools/evo-scale/2017Antonio/2017Antonio.snps.100p.1kb \
& \
vcftools \
--gzvcf $HOME/twg/popgen/beagle/2011-21.snps.100p.vcf.gz \
--hap-r2 \
--keep $HOME/twg/popgen/pops/2017Ynez.txt \
--ld-window-bp-min 1000 \
--mac 1 \
--min-r2 0.0001 \
--out $HOME/twg/popgen/vcftools/evo-scale/2017Ynez/2017Ynez.snps.100p.1kb \
& \
vcftools \
--gzvcf $HOME/twg/popgen/beagle/2011-21.snps.100p.vcf.gz \
--hap-r2 \
--keep $HOME/twg/popgen/pops/2014Burro.txt \
--ld-window-bp-min 1000 \
--mac 1 \
--min-r2 0.0001 \
--out $HOME/twg/popgen/vcftools/evo-scale/2014Burro/2014Burro.snps.100p.1kb \
& \
vcftools \
--gzvcf $HOME/twg/popgen/beagle/2011-21.snps.100p.vcf.gz \
--hap-r2 \
--keep $HOME/twg/popgen/pops/2014Paredon.txt \
--ld-window-bp-min 1000 \
--mac 1 \
--min-r2 0.0001 \
--out $HOME/twg/popgen/vcftools/evo-scale/2014Paredon/2014Paredon.snps.100p.1kb
wait

#
cat $HOME/twg/popgen/vcftools/evo-scale/2011Tillas/2011Tillas.snps.100p.1kb.hap.ld |
awk '{print $1"\t"$2"\t"$3"\t"$5}' |
gzip \
> $HOME/twg/popgen/vcftools/evo-scale/2011Tillas/2011Tillas.snps.100p.1kb.hap.ld.r2.gz

cat $HOME/twg/popgen/vcftools/evo-scale/2011Earl/2011Earl.snps.100p.1kb.hap.ld |
awk '{print $1"\t"$2"\t"$3"\t"$5}' |
gzip \
> $HOME/twg/popgen/vcftools/evo-scale/2011Earl/2011Earl.snps.100p.1kb.hap.ld.r2.gz

cat $HOME/twg/popgen/vcftools/evo-scale/2021Stone/2021Stone.snps.100p.1kb.hap.ld |
awk '{print $1"\t"$2"\t"$3"\t"$5}' |
gzip \
> $HOME/twg/popgen/vcftools/evo-scale/2021Stone/2021Stone.snps.100p.1kb.hap.ld.r2.gz

cat $HOME/twg/popgen/vcftools/evo-scale/2021Big/2021Big.snps.100p.1kb.hap.ld |
awk '{print $1"\t"$2"\t"$3"\t"$5}' |
gzip \
> $HOME/twg/popgen/vcftools/evo-scale/2021Big/2021Big.snps.100p.1kb.hap.ld.r2.gz

cat $HOME/twg/popgen/vcftools/evo-scale/2021Virgin/2021Virgin.snps.100p.1kb.hap.ld |
awk '{print $1"\t"$2"\t"$3"\t"$5}' |
gzip \
> $HOME/twg/popgen/vcftools/evo-scale/2021Virgin/2021Virgin.snps.100p.1kb.hap.ld.r2.gz

cat $HOME/twg/popgen/vcftools/evo-scale/2021Pudding/2021Pudding.snps.100p.1kb.hap.ld |
awk '{print $1"\t"$2"\t"$3"\t"$5}' |
gzip \
> $HOME/twg/popgen/vcftools/evo-scale/2021Pudding/2021Pudding.snps.100p.1kb.hap.ld.r2.gz

cat $HOME/twg/popgen/vcftools/evo-scale/2017Antonio/2017Antonio.snps.100p.1kb.hap.ld |
awk '{print $1"\t"$2"\t"$3"\t"$5}' |
gzip \
> $HOME/twg/popgen/vcftools/evo-scale/2017Antonio/2017Antonio.snps.100p.1kb.hap.ld.r2.gz

cat $HOME/twg/popgen/vcftools/evo-scale/2017Ynez/2017Ynez.snps.100p.1kb.hap.ld |
awk '{print $1"\t"$2"\t"$3"\t"$5}' |
gzip \
> $HOME/twg/popgen/vcftools/evo-scale/2017Ynez/2017Ynez.snps.100p.1kb.hap.ld.r2.gz

cat $HOME/twg/popgen/vcftools/evo-scale/2014Burro/2014Burro.snps.100p.1kb.hap.ld |
awk '{print $1"\t"$2"\t"$3"\t"$5}' |
gzip \
> $HOME/twg/popgen/vcftools/evo-scale/2014Burro/2014Burro.snps.100p.1kb.hap.ld.r2.gz

cat $HOME/twg/popgen/vcftools/evo-scale/2014Paredon/2014Paredon.snps.100p.1kb.hap.ld |
awk '{print $1"\t"$2"\t"$3"\t"$5}' |
gzip \
> $HOME/twg/popgen/vcftools/evo-scale/2014Paredon/2014Paredon.snps.100p.1kb.hap.ld.r2.gz

