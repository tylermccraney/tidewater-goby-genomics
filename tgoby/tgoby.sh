#!/bin/bash

cp \
$HOME/twg/popgen/pops/2006Big.txt \
$HOME/twg/popgen/pops/2006Pudding.txt \
$HOME/twg/popgen/pops/2006Stone.txt \
$HOME/twg/popgen/pops/2006Virgin.txt \
$HOME/twg/popgen/pops/2011Earl.txt \
$HOME/twg/popgen/pops/2011Tillas.txt \
$HOME/twg/popgen/pops/2014Burro.txt \
$HOME/twg/popgen/pops/2014Paredon.txt \
$HOME/twg/popgen/pops/2017Antonio.txt \
$HOME/twg/popgen/pops/2017Ynez.txt \
$HOME/twg/popgen/pops/2021Big.txt \
$HOME/twg/popgen/pops/2021Pudding.txt \
$HOME/twg/popgen/pops/2021Stone.txt \
$HOME/twg/popgen/pops/2021Virgin.txt \
$HOME/tgoby/pops

vcftools \
--chr JAPEHO010000001.1 \
--chr JAPEHO010000002.1 \
--chr JAPEHO010000003.1 \
--chr JAPEHO010000004.1 \
--chr JAPEHO010000005.1 \
--chr JAPEHO010000006.1 \
--chr JAPEHO010000007.1 \
--chr JAPEHO010000008.1 \
--chr JAPEHO010000009.1 \
--chr JAPEHO010000010.1 \
--chr JAPEHO010000011.1 \
--chr JAPEHO010000012.1 \
--chr JAPEHO010000013.1 \
--chr JAPEHO010000014.1 \
--chr JAPEHO010000015.1 \
--chr JAPEHO010000016.1 \
--chr JAPEHO010000017.1 \
--chr JAPEHO010000018.1 \
--chr JAPEHO010000019.1 \
--chr JAPEHO010000020.1 \
--chr JAPEHO010000021.1 \
--chr JAPEHO010000022.1 \
--gzvcf $HOME/twg/variants/selectvariants.vcf.gz \
--max-missing 1 \
--max-alleles 2 \
--min-alleles 2 \
--max-meanDP 40 \
--min-meanDP 10 \
--minQ 30 \
--out $HOME/tgoby/vcf/snps \
--singletons \
--remove $HOME/tgoby1/pops/1988Virgin.txt \
--remove $HOME/tgoby1/pops/2009Arcata.txt \
--remove-filtered-all \
--remove-indels

cat $HOME/tgoby/vcf/snps.singletons |
awk '{print $1"\t"$2}' |
sed '1 s/./#&/' > $HOME/tgoby/vcf/snps.singletons.tab

vcftools \
--chr JAPEHO010000001.1 \
--chr JAPEHO010000002.1 \
--chr JAPEHO010000003.1 \
--chr JAPEHO010000004.1 \
--chr JAPEHO010000005.1 \
--chr JAPEHO010000006.1 \
--chr JAPEHO010000007.1 \
--chr JAPEHO010000008.1 \
--chr JAPEHO010000009.1 \
--chr JAPEHO010000010.1 \
--chr JAPEHO010000011.1 \
--chr JAPEHO010000012.1 \
--chr JAPEHO010000013.1 \
--chr JAPEHO010000014.1 \
--chr JAPEHO010000015.1 \
--chr JAPEHO010000016.1 \
--chr JAPEHO010000017.1 \
--chr JAPEHO010000018.1 \
--chr JAPEHO010000019.1 \
--chr JAPEHO010000020.1 \
--chr JAPEHO010000021.1 \
--chr JAPEHO010000022.1 \
--exclude-positions $HOME/tgoby/vcf/snps.singletons.tab \
--gzvcf $HOME/twg/variants/selectvariants.vcf.gz \
--max-missing 1 \
--max-alleles 2 \
--min-alleles 2 \
--max-meanDP 40 \
--min-meanDP 10 \
--minQ 30 \
--out $HOME/tgoby/vcf/snps \
--recode \
--remove $HOME/tgoby1/pops/1988Virgin.txt \
--remove $HOME/tgoby1/pops/2009Arcata.txt \
--remove-filtered-all \
--remove-indels

bgzip $HOME/tgoby/vcf/snps.recode.vcf


for chr in {01..22}
do vcftools \
--chr JAPEHO0100000$chr.1 \
--gzvcf $HOME/tgoby/vcf/snps.recode.vcf.gz \
--out $HOME/tgoby/vcf/chr"$chr" \
--recode & done

for chr in {01..22}
do bgzip $HOME/tgoby/vcf/chr$chr.recode.vcf & done

for chr in {01..22}
do for rep in 1 2
do beagle \
burnin=100 \
gt=$HOME/tgoby/vcf/chr$chr.recode.vcf.gz \
impute=false \
iterations=1000 \
nthreads=14 \
out=$HOME/tgoby/beagle/$rep/chr$chr \
seed=$RANDOM \
window=55 & done
wait
done

for chr in {01..22}
do vcftools \
--diff-switch-error \
--gzvcf $HOME/tgoby/beagle/1/chr$chr.vcf.gz \
--gzdiff $HOME/tgoby/beagle/2/chr$chr.vcf.gz \
--mac 3 \
--out $HOME/tgoby/stats/phase/chr$chr.mac & done

for chr in {01..22}
do vcftools \
--diff-switch-error \
--gzvcf $HOME/tgoby/beagle/1/chr$chr.vcf.gz \
--gzdiff $HOME/tgoby/beagle/2/chr$chr.vcf.gz \
--positions $HOME/tgoby/vcf/phased/segregating_sites.kept.sites \
--out $HOME/tgoby/stats/phase/chr$chr & done


for chr in {01..22}
do bcftools index $HOME/tgoby/beagle/1/chr$chr.vcf.gz & done

mkdir $HOME/tgoby/vcf/phased

bcftools concat \
--output $HOME/tgoby/vcf/phased/snps.vcf.gz \
--output-type z \
--threads 14 \
$HOME/tgoby/beagle/1/chr01.vcf.gz \
$HOME/tgoby/beagle/1/chr02.vcf.gz \
$HOME/tgoby/beagle/1/chr03.vcf.gz \
$HOME/tgoby/beagle/1/chr04.vcf.gz \
$HOME/tgoby/beagle/1/chr05.vcf.gz \
$HOME/tgoby/beagle/1/chr06.vcf.gz \
$HOME/tgoby/beagle/1/chr07.vcf.gz \
$HOME/tgoby/beagle/1/chr08.vcf.gz \
$HOME/tgoby/beagle/1/chr09.vcf.gz \
$HOME/tgoby/beagle/1/chr10.vcf.gz \
$HOME/tgoby/beagle/1/chr11.vcf.gz \
$HOME/tgoby/beagle/1/chr12.vcf.gz \
$HOME/tgoby/beagle/1/chr13.vcf.gz \
$HOME/tgoby/beagle/1/chr14.vcf.gz \
$HOME/tgoby/beagle/1/chr15.vcf.gz \
$HOME/tgoby/beagle/1/chr16.vcf.gz \
$HOME/tgoby/beagle/1/chr17.vcf.gz \
$HOME/tgoby/beagle/1/chr18.vcf.gz \
$HOME/tgoby/beagle/1/chr19.vcf.gz \
$HOME/tgoby/beagle/1/chr20.vcf.gz \
$HOME/tgoby/beagle/1/chr21.vcf.gz \
$HOME/tgoby/beagle/1/chr22.vcf.gz

for chr in {01..22}
do tabix $HOME/tgoby/beagle/1/chr$chr.vcf.gz & done

tabix $HOME/tgoby/vcf/phased/snps.vcf.gz

bcftools index $HOME/tgoby/vcf/phased/snps.vcf.gz


vcftools \
--chrom-map $HOME/tgoby/vcf/chrom-map.tab \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/plink/snps \
--plink

cd $HOME/tgoby/plink

plink \
--allow-extra-chr \
--file $HOME/tgoby/plink/snps \
--indep-pairphase 50 10 0.1

plink \
--allow-extra-chr \
--extract plink.prune.in \
--file $HOME/tgoby/plink/snps \
--make-bed \
--out $HOME/tgoby/plink/pruned

cd $HOME/tgoby/admixture

for K in {1..10}
do admixture \
--cv $HOME/tgoby/plink/pruned.bed $K -j2 | tee pruned.log${K}.out
done

grep -h CV $HOME/tgoby/admixture/pruned.log*.out > $HOME/tgoby/admixture/cv.tab

cat \
$HOME/tgoby/pops/2011Tillas.txt \
$HOME/tgoby/pops/2011Earl.txt \
$HOME/tgoby/pops/2006Stone.txt \
$HOME/tgoby/pops/2021Stone.txt \
$HOME/tgoby/pops/2006Big.txt \
$HOME/tgoby/pops/2021Big.txt \
> $HOME/tgoby/pops/NorteHumboldt

cat \
$HOME/tgoby/pops/2006Virgin.txt \
$HOME/tgoby/pops/2021Virgin.txt \
$HOME/tgoby/pops/2006Pudding.txt \
$HOME/tgoby/pops/2021Pudding.txt \
> $HOME/tgoby/pops/Mendocino

cat \
$HOME/tgoby/pops/2017Antonio.txt \
$HOME/tgoby/pops/2017Ynez.txt \
$HOME/tgoby/pops/2014Burro.txt \
$HOME/tgoby/pops/2014Paredon.txt \
> $HOME/tgoby/pops/SantaBarbara

for pop in NorteHumboldt Mendocino SantaBarbara
do vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--keep $HOME/tgoby/pops/$pop \
--mac 1 \
--out $HOME/tgoby/vcf/phased/$pop \
--recode & done

for pop in NorteHumboldt Mendocino SantaBarbara
do bgzip $HOME/tgoby/vcf/phased/$pop.recode.vcf & done

plink \
--vcf $HOME/tgoby/vcf/phased/Mendocino.recode.vcf.gz \
--double-id \
--allow-extra-chr \
--set-missing-var-ids @:\# \
--mac 3 \
--thin 0.1 \
--r2 gz dprime \
--ld-window 100 \
--ld-window-kb 1000 \
--ld-window-r2 0 \
--make-bed \
--threads 14 \
--out $HOME/tgoby/plink/Mendocino

plink \
--vcf $HOME/tgoby/vcf/phased/SantaBarbara.recode.vcf.gz \
--double-id \
--allow-extra-chr \
--set-missing-var-ids @:\# \
--mac 3 \
--thin 0.1 \
--r2 gz dprime \
--ld-window 100 \
--ld-window-kb 1000 \
--ld-window-r2 0 \
--make-bed \
--threads 14 \
--out $HOME/tgoby/plink/SantaBarbara

plink \
--vcf $HOME/tgoby/vcf/phased/NorteHumboldt.recode.vcf.gz \
--double-id \
--allow-extra-chr \
--set-missing-var-ids @:\# \
--mac 4 \
--thin 0.1 \
--r2 gz dprime \
--ld-window 100 \
--ld-window-kb 1000 \
--ld-window-r2 0 \
--make-bed \
--threads 14 \
--out $HOME/tgoby/plink/NorteHumboldt

cd $HOME/tgoby/vcf/phased

for pop in \
2011Tillas \
2011Earl \
2006Stone \
2021Stone \
2006Big \
2021Big \
2006Virgin \
2021Virgin \
2006Pudding \
2021Pudding \
2017Antonio \
2017Ynez \
2014Burro \
2014Paredon
do vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--keep $HOME/tgoby/pops/$pop.txt \
--hwe 0.05 \
--out $HOME/tgoby/vcf/phased/$pop \
--removed-sites & done

Rscript $HOME/tgoby/vcf/phased/Untitled.R

sed -i '1 s/./#&/' $HOME/tgoby/vcf/phased/recode.hwe.removed.sites

vcftools \
--exclude-positions $HOME/tgoby/vcf/phased/recode.hwe.removed.sites \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/vcf/phased/hwe \
--recode &

vcftools \
--positions $HOME/tgoby/vcf/phased/recode.hwe.removed.sites \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/vcf/phased/not.hwe \
--recode &

bgzip $HOME/tgoby/vcf/phased/hwe.recode.vcf
bgzip $HOME/tgoby/vcf/phased/not.hwe.recode.vcf

tabix $HOME/tgoby/vcf/phased/hwe.recode.vcf.gz
tabix $HOME/tgoby/vcf/phased/not.hwe.recode.vcf.gz

bcftools index $HOME/tgoby/vcf/phased/hwe.recode.vcf.gz
bcftools index $HOME/tgoby/vcf/phased/not.hwe.recode.vcf.gz

echo "#CHROM	POS" > $HOME/tgoby/plink/plink.prune.in.tab

cat $HOME/tgoby/plink/plink.prune.in >> $HOME/tgoby/plink/plink.prune.in.tab

sed -i 's%:%\t%' $HOME/tgoby/plink/plink.prune.in.tab

vcftools \
--positions $HOME/tgoby/plink/plink.prune.in.tab \
--gzvcf $HOME/tgoby/vcf/phased/hwe.recode.vcf.gz \
--out $HOME/tgoby/vcf/phased/hwe.pruned \
--recode &

bgzip $HOME/tgoby/vcf/phased/hwe.pruned.recode.vcf

tabix $HOME/tgoby/vcf/phased/hwe.pruned.recode.vcf.gz

bcftools index $HOME/tgoby/vcf/phased/hwe.pruned.recode.vcf.gz

vcftools \
--positions $HOME/tgoby/plink/plink.prune.in.tab \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/vcf/phased/pruned \
--recode

bgzip $HOME/tgoby/vcf/phased/pruned.recode.vcf

tabix $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz

bcftools index $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz


plink \
--allow-extra-chr \
--mac 1 \
--out $HOME/tgoby/plink/recode_genotypeMatrix \
--recode A-transpose \
--vcf $HOME/tgoby/vcf/phased/snps.vcf.gz

plink \
--allow-extra-chr \
--mac 1 \
--out $HOME/tgoby/plink/pruned_recode_genotypeMatrix \
--recode A-transpose \
--vcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz

plink \
--allow-extra-chr \
--mac 1 \
--out $HOME/tgoby/plink/hwe_recode_genotypeMatrix \
--recode A-transpose \
--vcf $HOME/tgoby/vcf/phased/hwe.recode.vcf.gz

plink \
--allow-extra-chr \
--mac 1 \
--out $HOME/tgoby/plink/not_hwe_recode_genotypeMatrix \
--recode A-transpose \
--vcf $HOME/tgoby/vcf/phased/not.hwe.recode.vcf.gz

plink \
--allow-extra-chr \
--mac 1 \
--out $HOME/tgoby/plink/hwe_recode_pruned_genotypeMatrix \
--recode A-transpose \
--vcf $HOME/tgoby/vcf/phased/hwe.pruned.recode.vcf.gz

#
vcftools \
--depth \
--gzvcf $HOME/tgoby/vcf/snps.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/depth/snps.recode &

vcftools \
--gzvcf $HOME/tgoby/vcf/snps.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/depth/snps.recode \
--site-mean-depth &

vcftools \
--depth \
--gzvcf $HOME/tgoby/vcf/snps.recode.vcf.gz \
--mac 3 \
--out $HOME/tgoby/stats/depth/snps.recode.mac &

vcftools \
--gzvcf $HOME/tgoby/vcf/snps.recode.vcf.gz \
--mac 3 \
--out $HOME/tgoby/stats/depth/snps.recode.mac \
--site-mean-depth &

vcftools \
--gzvcf $HOME/tgoby/vcf/snps.recode.vcf.gz \
--keep $HOME/tgoby/pops/NorteHumboldt \
--mac 4 \
--out $HOME/tgoby/stats/depth/NorteHumboldt.mac \
--site-mean-depth &

for pop in Mendocino SantaBarbara
do vcftools \
--gzvcf $HOME/tgoby/vcf/snps.recode.vcf.gz \
--keep $HOME/tgoby/pops/$pop \
--mac 3 \
--out $HOME/tgoby/stats/depth/$pop.mac \
--site-mean-depth & done

vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--het \
--mac 1 \
--out $HOME/tgoby/stats/het/snps &

for pop in \
2011Tillas \
2011Earl \
2006Stone \
2021Stone \
2006Big \
2021Big \
2006Virgin \
2021Virgin \
2006Pudding \
2021Pudding \
2017Antonio \
2017Ynez \
2014Burro \
2014Paredon
do vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--het \
--keep $HOME/tgoby/pops/$pop.txt \
--mac 1 \
--out $HOME/tgoby/stats/het/$pop & done

for pop in NorteHumboldt Mendocino SantaBarbara
do vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--het \
--keep $HOME/tgoby/pops/$pop \
--mac 1 \
--out $HOME/tgoby/stats/het/$pop & done

vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--het \
--keep $HOME/tgoby/pops/NorteHumboldt \
--mac 4 \
--out $HOME/tgoby/stats/het/NorteHumboldt.mac &

for pop in Mendocino SantaBarbara
do vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--het \
--keep $HOME/tgoby/pops/$pop \
--mac 3 \
--out $HOME/tgoby/stats/het/$pop.mac & done

vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--keep $HOME/tgoby/pops/NorteHumboldt \
--mac 4 \
--out $HOME/tgoby/stats/TsTv/NorteHumboldt.mac.100Kb \
--TsTv 100000 &

for pop in Mendocino SantaBarbara
do vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--keep $HOME/tgoby/pops/$pop \
--mac 3 \
--out $HOME/tgoby/stats/TsTv/$pop.mac.100Kb \
--TsTv 100000 & done

for pop in NorteHumboldt Mendocino SantaBarbara
do vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--keep $HOME/tgoby/pops/$pop \
--mac 1 \
--out $HOME/tgoby/stats/TsTv/$pop.100Kb \
--TsTv 100000 & done


# number of variants within each individual of specific frequency
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--indv-freq-burden \
--mac 1 \
--out $HOME/tgoby/stats/snps


# Relatedness statistic based on the method of Yang et al, 
# Nature Genetics 2010 (doi:10.1038/ng.608).
# Specifically, the unadjusted Ajk statistic. Expectation of 
# Ajk is zero for individuals within a populations, and one 
# for an individual with themselves.
for pop in 2011Tillas 2011Earl \
2006Stone 2021Stone 2006Big 2021Big \
2006Virgin 2021Virgin 2006Pudding 2021Pudding \
2017Antonio 2017Ynez 2014Burro 2014Paredon
do vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--keep $HOME/tgoby/pops/$pop.txt \
--mac 1 \
--out $HOME/tgoby/stats/relatedness/$pop \
--relatedness & done

vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--keep $HOME/tgoby/pops/NorteHumboldt \
--mac 4 \
--out $HOME/tgoby/stats/relatedness/NorteHumboldt.mac \
--relatedness &

for pop in Mendocino SantaBarbara
do vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--keep $HOME/tgoby/pops/$pop \
--mac 3 \
--out $HOME/tgoby/stats/relatedness/$pop.mac \
--relatedness & done

for pop in NorteHumboldt Mendocino SantaBarbara
do vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--keep $HOME/tgoby/pops/$pop \
--mac 1 \
--out $HOME/tgoby/stats/relatedness/$pop \
--relatedness & done


# Relatedness statistic based on the method of Manichaikul et al., 
# BIOINFORMATICS 2010 (doi:10.1093/bioinformatics/btq559).
for pop in 2011Tillas 2011Earl \
2006Stone 2021Stone 2006Big 2021Big \
2006Virgin 2021Virgin 2006Pudding 2021Pudding \
2017Antonio 2017Ynez 2014Burro 2014Paredon
do vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--keep $HOME/tgoby/pops/$pop.txt \
--mac 1 \
--out $HOME/tgoby/stats/relatedness/$pop \
--relatedness2 & done

for pop in Mendocino SantaBarbara
do vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--keep $HOME/tgoby/pops/$pop \
--mac 3 \
--out $HOME/tgoby/stats/relatedness/$pop.mac \
--relatedness2 & done

vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--keep $HOME/tgoby/pops/NorteHumboldt \
--mac 4 \
--out $HOME/tgoby/stats/relatedness/NorteHumboldt.mac \
--relatedness2 &

for pop in NorteHumboldt Mendocino SantaBarbara
do vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--keep $HOME/tgoby/pops/$pop \
--mac 1 \
--out $HOME/tgoby/stats/relatedness/$pop \
--relatedness2 & done

# SNP density
for pop in Mendocino SantaBarbara
do vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--keep $HOME/tgoby/pops/$pop \
--mac 3 \
--out $HOME/tgoby/stats/SNPdensity/$pop.mac.100Kb \
--SNPdensity 100000 &
done

vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--keep $HOME/tgoby/pops/NorteHumboldt \
--mac 4 \
--out $HOME/tgoby/stats/SNPdensity/NorteHumboldt.mac.100Kb \
--SNPdensity 100000 &


# between pops
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2011Tillas.2011Earl \
--weir-fst-pop $HOME/tgoby/pops/2011Tillas.txt \
--weir-fst-pop $HOME/tgoby/pops/2011Earl.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2011Tillas.2006Stone \
--weir-fst-pop $HOME/tgoby/pops/2011Tillas.txt \
--weir-fst-pop $HOME/tgoby/pops/2006Stone.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2011Tillas.2021Stone \
--weir-fst-pop $HOME/tgoby/pops/2011Tillas.txt \
--weir-fst-pop $HOME/tgoby/pops/2021Stone.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2011Tillas.2006Big \
--weir-fst-pop $HOME/tgoby/pops/2011Tillas.txt \
--weir-fst-pop $HOME/tgoby/pops/2006Big.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2011Tillas.2021Big \
--weir-fst-pop $HOME/tgoby/pops/2011Tillas.txt \
--weir-fst-pop $HOME/tgoby/pops/2021Big.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2011Tillas.2006Virgin \
--weir-fst-pop $HOME/tgoby/pops/2011Tillas.txt \
--weir-fst-pop $HOME/tgoby/pops/2006Virgin.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2011Tillas.2021Virgin \
--weir-fst-pop $HOME/tgoby/pops/2011Tillas.txt \
--weir-fst-pop $HOME/tgoby/pops/2021Virgin.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2011Tillas.2006Pudding \
--weir-fst-pop $HOME/tgoby/pops/2011Tillas.txt \
--weir-fst-pop $HOME/tgoby/pops/2006Pudding.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2011Tillas.2021Pudding \
--weir-fst-pop $HOME/tgoby/pops/2011Tillas.txt \
--weir-fst-pop $HOME/tgoby/pops/2021Pudding.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2011Tillas.2017Antonio \
--weir-fst-pop $HOME/tgoby/pops/2011Tillas.txt \
--weir-fst-pop $HOME/tgoby/pops/2017Antonio.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2011Tillas.2017Ynez \
--weir-fst-pop $HOME/tgoby/pops/2011Tillas.txt \
--weir-fst-pop $HOME/tgoby/pops/2017Ynez.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2011Tillas.2014Burro \
--weir-fst-pop $HOME/tgoby/pops/2011Tillas.txt \
--weir-fst-pop $HOME/tgoby/pops/2014Burro.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2011Tillas.2014Paredon \
--weir-fst-pop $HOME/tgoby/pops/2011Tillas.txt \
--weir-fst-pop $HOME/tgoby/pops/2014Paredon.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2011Earl.2006Stone \
--weir-fst-pop $HOME/tgoby/pops/2011Earl.txt \
--weir-fst-pop $HOME/tgoby/pops/2006Stone.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2011Earl.2021Stone \
--weir-fst-pop $HOME/tgoby/pops/2011Earl.txt \
--weir-fst-pop $HOME/tgoby/pops/2021Stone.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2011Earl.2006Big \
--weir-fst-pop $HOME/tgoby/pops/2011Earl.txt \
--weir-fst-pop $HOME/tgoby/pops/2006Big.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2011Earl.2021Big \
--weir-fst-pop $HOME/tgoby/pops/2011Earl.txt \
--weir-fst-pop $HOME/tgoby/pops/2021Big.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2011Earl.2006Virgin \
--weir-fst-pop $HOME/tgoby/pops/2011Earl.txt \
--weir-fst-pop $HOME/tgoby/pops/2006Virgin.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2011Earl.2021Virgin \
--weir-fst-pop $HOME/tgoby/pops/2011Earl.txt \
--weir-fst-pop $HOME/tgoby/pops/2021Virgin.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2011Earl.2006Pudding \
--weir-fst-pop $HOME/tgoby/pops/2011Earl.txt \
--weir-fst-pop $HOME/tgoby/pops/2006Pudding.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2011Earl.2021Pudding \
--weir-fst-pop $HOME/tgoby/pops/2011Earl.txt \
--weir-fst-pop $HOME/tgoby/pops/2021Pudding.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2011Earl.2017Antonio \
--weir-fst-pop $HOME/tgoby/pops/2011Earl.txt \
--weir-fst-pop $HOME/tgoby/pops/2017Antonio.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2011Earl.2017Ynez \
--weir-fst-pop $HOME/tgoby/pops/2011Earl.txt \
--weir-fst-pop $HOME/tgoby/pops/2017Ynez.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2011Earl.2014Burro \
--weir-fst-pop $HOME/tgoby/pops/2011Earl.txt \
--weir-fst-pop $HOME/tgoby/pops/2014Burro.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2011Earl.2014Paredon \
--weir-fst-pop $HOME/tgoby/pops/2011Earl.txt \
--weir-fst-pop $HOME/tgoby/pops/2014Paredon.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2006Stone.2021Stone \
--weir-fst-pop $HOME/tgoby/pops/2006Stone.txt \
--weir-fst-pop $HOME/tgoby/pops/2021Stone.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2006Stone.2006Big \
--weir-fst-pop $HOME/tgoby/pops/2006Stone.txt \
--weir-fst-pop $HOME/tgoby/pops/2006Big.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2006Stone.2021Big \
--weir-fst-pop $HOME/tgoby/pops/2006Stone.txt \
--weir-fst-pop $HOME/tgoby/pops/2021Big.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2006Stone.2006Virgin \
--weir-fst-pop $HOME/tgoby/pops/2006Stone.txt \
--weir-fst-pop $HOME/tgoby/pops/2006Virgin.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2006Stone.2021Virgin \
--weir-fst-pop $HOME/tgoby/pops/2006Stone.txt \
--weir-fst-pop $HOME/tgoby/pops/2021Virgin.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2006Stone.2006Pudding \
--weir-fst-pop $HOME/tgoby/pops/2006Stone.txt \
--weir-fst-pop $HOME/tgoby/pops/2006Pudding.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2006Stone.2021Pudding \
--weir-fst-pop $HOME/tgoby/pops/2006Stone.txt \
--weir-fst-pop $HOME/tgoby/pops/2021Pudding.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2006Stone.2017Antonio \
--weir-fst-pop $HOME/tgoby/pops/2006Stone.txt \
--weir-fst-pop $HOME/tgoby/pops/2017Antonio.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2006Stone.2017Ynez \
--weir-fst-pop $HOME/tgoby/pops/2006Stone.txt \
--weir-fst-pop $HOME/tgoby/pops/2017Ynez.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2006Stone.2014Burro \
--weir-fst-pop $HOME/tgoby/pops/2006Stone.txt \
--weir-fst-pop $HOME/tgoby/pops/2014Burro.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2006Stone.2014Paredon \
--weir-fst-pop $HOME/tgoby/pops/2006Stone.txt \
--weir-fst-pop $HOME/tgoby/pops/2014Paredon.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2021Stone.2006Big \
--weir-fst-pop $HOME/tgoby/pops/2021Stone.txt \
--weir-fst-pop $HOME/tgoby/pops/2006Big.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2021Stone.2021Big \
--weir-fst-pop $HOME/tgoby/pops/2021Stone.txt \
--weir-fst-pop $HOME/tgoby/pops/2021Big.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2021Stone.2006Virgin \
--weir-fst-pop $HOME/tgoby/pops/2021Stone.txt \
--weir-fst-pop $HOME/tgoby/pops/2006Virgin.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2021Stone.2021Virgin \
--weir-fst-pop $HOME/tgoby/pops/2021Stone.txt \
--weir-fst-pop $HOME/tgoby/pops/2021Virgin.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2021Stone.2006Pudding \
--weir-fst-pop $HOME/tgoby/pops/2021Stone.txt \
--weir-fst-pop $HOME/tgoby/pops/2006Pudding.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2021Stone.2021Pudding \
--weir-fst-pop $HOME/tgoby/pops/2021Stone.txt \
--weir-fst-pop $HOME/tgoby/pops/2021Pudding.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2021Stone.2017Antonio \
--weir-fst-pop $HOME/tgoby/pops/2021Stone.txt \
--weir-fst-pop $HOME/tgoby/pops/2017Antonio.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2021Stone.2017Ynez \
--weir-fst-pop $HOME/tgoby/pops/2021Stone.txt \
--weir-fst-pop $HOME/tgoby/pops/2017Ynez.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2021Stone.2014Burro \
--weir-fst-pop $HOME/tgoby/pops/2021Stone.txt \
--weir-fst-pop $HOME/tgoby/pops/2014Burro.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2021Stone.2014Paredon \
--weir-fst-pop $HOME/tgoby/pops/2021Stone.txt \
--weir-fst-pop $HOME/tgoby/pops/2014Paredon.txt \
--fst-window-size 100000  &&
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2006Big.2021Big \
--weir-fst-pop $HOME/tgoby/pops/2006Big.txt \
--weir-fst-pop $HOME/tgoby/pops/2021Big.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2006Big.2006Virgin \
--weir-fst-pop $HOME/tgoby/pops/2006Big.txt \
--weir-fst-pop $HOME/tgoby/pops/2006Virgin.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2006Big.2021Virgin \
--weir-fst-pop $HOME/tgoby/pops/2006Big.txt \
--weir-fst-pop $HOME/tgoby/pops/2021Virgin.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2006Big.2006Pudding \
--weir-fst-pop $HOME/tgoby/pops/2006Big.txt \
--weir-fst-pop $HOME/tgoby/pops/2006Pudding.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2006Big.2021Pudding \
--weir-fst-pop $HOME/tgoby/pops/2006Big.txt \
--weir-fst-pop $HOME/tgoby/pops/2021Pudding.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2006Big.2017Antonio \
--weir-fst-pop $HOME/tgoby/pops/2006Big.txt \
--weir-fst-pop $HOME/tgoby/pops/2017Antonio.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2006Big.2017Ynez \
--weir-fst-pop $HOME/tgoby/pops/2006Big.txt \
--weir-fst-pop $HOME/tgoby/pops/2017Ynez.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2006Big.2014Burro \
--weir-fst-pop $HOME/tgoby/pops/2006Big.txt \
--weir-fst-pop $HOME/tgoby/pops/2014Burro.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2006Big.2014Paredon \
--weir-fst-pop $HOME/tgoby/pops/2006Big.txt \
--weir-fst-pop $HOME/tgoby/pops/2014Paredon.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2021Big.2006Virgin \
--weir-fst-pop $HOME/tgoby/pops/2021Big.txt \
--weir-fst-pop $HOME/tgoby/pops/2006Virgin.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2021Big.2021Virgin \
--weir-fst-pop $HOME/tgoby/pops/2021Big.txt \
--weir-fst-pop $HOME/tgoby/pops/2021Virgin.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2021Big.2006Pudding \
--weir-fst-pop $HOME/tgoby/pops/2021Big.txt \
--weir-fst-pop $HOME/tgoby/pops/2006Pudding.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2021Big.2021Pudding \
--weir-fst-pop $HOME/tgoby/pops/2021Big.txt \
--weir-fst-pop $HOME/tgoby/pops/2021Pudding.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2021Big.2017Antonio \
--weir-fst-pop $HOME/tgoby/pops/2021Big.txt \
--weir-fst-pop $HOME/tgoby/pops/2017Antonio.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2021Big.2017Ynez \
--weir-fst-pop $HOME/tgoby/pops/2021Big.txt \
--weir-fst-pop $HOME/tgoby/pops/2017Ynez.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2021Big.2014Burro \
--weir-fst-pop $HOME/tgoby/pops/2021Big.txt \
--weir-fst-pop $HOME/tgoby/pops/2014Burro.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2021Big.2014Paredon \
--weir-fst-pop $HOME/tgoby/pops/2021Big.txt \
--weir-fst-pop $HOME/tgoby/pops/2014Paredon.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2006Virgin.2021Virgin \
--weir-fst-pop $HOME/tgoby/pops/2006Virgin.txt \
--weir-fst-pop $HOME/tgoby/pops/2021Virgin.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2006Virgin.2006Pudding \
--weir-fst-pop $HOME/tgoby/pops/2006Virgin.txt \
--weir-fst-pop $HOME/tgoby/pops/2006Pudding.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2006Virgin.2021Pudding \
--weir-fst-pop $HOME/tgoby/pops/2006Virgin.txt \
--weir-fst-pop $HOME/tgoby/pops/2021Pudding.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2006Virgin.2017Antonio \
--weir-fst-pop $HOME/tgoby/pops/2006Virgin.txt \
--weir-fst-pop $HOME/tgoby/pops/2017Antonio.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2006Virgin.2017Ynez \
--weir-fst-pop $HOME/tgoby/pops/2006Virgin.txt \
--weir-fst-pop $HOME/tgoby/pops/2017Ynez.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2006Virgin.2014Burro \
--weir-fst-pop $HOME/tgoby/pops/2006Virgin.txt \
--weir-fst-pop $HOME/tgoby/pops/2014Burro.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2006Virgin.2014Paredon \
--weir-fst-pop $HOME/tgoby/pops/2006Virgin.txt \
--weir-fst-pop $HOME/tgoby/pops/2014Paredon.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2021Virgin.2006Pudding \
--weir-fst-pop $HOME/tgoby/pops/2021Virgin.txt \
--weir-fst-pop $HOME/tgoby/pops/2006Pudding.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2021Virgin.2021Pudding \
--weir-fst-pop $HOME/tgoby/pops/2021Virgin.txt \
--weir-fst-pop $HOME/tgoby/pops/2021Pudding.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2021Virgin.2017Antonio \
--weir-fst-pop $HOME/tgoby/pops/2021Virgin.txt \
--weir-fst-pop $HOME/tgoby/pops/2017Antonio.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2021Virgin.2017Ynez \
--weir-fst-pop $HOME/tgoby/pops/2021Virgin.txt \
--weir-fst-pop $HOME/tgoby/pops/2017Ynez.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2021Virgin.2014Burro \
--weir-fst-pop $HOME/tgoby/pops/2021Virgin.txt \
--weir-fst-pop $HOME/tgoby/pops/2014Burro.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2021Virgin.2014Paredon \
--weir-fst-pop $HOME/tgoby/pops/2021Virgin.txt \
--weir-fst-pop $HOME/tgoby/pops/2014Paredon.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2006Pudding.2021Pudding \
--weir-fst-pop $HOME/tgoby/pops/2006Pudding.txt \
--weir-fst-pop $HOME/tgoby/pops/2021Pudding.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2006Pudding.2017Antonio \
--weir-fst-pop $HOME/tgoby/pops/2006Pudding.txt \
--weir-fst-pop $HOME/tgoby/pops/2017Antonio.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2006Pudding.2017Ynez \
--weir-fst-pop $HOME/tgoby/pops/2006Pudding.txt \
--weir-fst-pop $HOME/tgoby/pops/2017Ynez.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2006Pudding.2014Burro \
--weir-fst-pop $HOME/tgoby/pops/2006Pudding.txt \
--weir-fst-pop $HOME/tgoby/pops/2014Burro.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2006Pudding.2014Paredon \
--weir-fst-pop $HOME/tgoby/pops/2006Pudding.txt \
--weir-fst-pop $HOME/tgoby/pops/2014Paredon.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2021Pudding.2017Antonio \
--weir-fst-pop $HOME/tgoby/pops/2021Pudding.txt \
--weir-fst-pop $HOME/tgoby/pops/2017Antonio.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2021Pudding.2017Ynez \
--weir-fst-pop $HOME/tgoby/pops/2021Pudding.txt \
--weir-fst-pop $HOME/tgoby/pops/2017Ynez.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2021Pudding.2014Burro \
--weir-fst-pop $HOME/tgoby/pops/2021Pudding.txt \
--weir-fst-pop $HOME/tgoby/pops/2014Burro.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2021Pudding.2014Paredon \
--weir-fst-pop $HOME/tgoby/pops/2021Pudding.txt \
--weir-fst-pop $HOME/tgoby/pops/2014Paredon.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2017Antonio.2017Ynez \
--weir-fst-pop $HOME/tgoby/pops/2017Antonio.txt \
--weir-fst-pop $HOME/tgoby/pops/2017Ynez.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2017Antonio.2014Burro \
--weir-fst-pop $HOME/tgoby/pops/2017Antonio.txt \
--weir-fst-pop $HOME/tgoby/pops/2014Burro.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2017Antonio.2014Paredon \
--weir-fst-pop $HOME/tgoby/pops/2017Antonio.txt \
--weir-fst-pop $HOME/tgoby/pops/2014Paredon.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2017Ynez.2014Burro \
--weir-fst-pop $HOME/tgoby/pops/2017Ynez.txt \
--weir-fst-pop $HOME/tgoby/pops/2014Burro.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2017Ynez.2014Paredon \
--weir-fst-pop $HOME/tgoby/pops/2017Ynez.txt \
--weir-fst-pop $HOME/tgoby/pops/2014Paredon.txt \
--fst-window-size 100000  &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/fst/2014Burro.2014Paredon \
--weir-fst-pop $HOME/tgoby/pops/2014Burro.txt \
--weir-fst-pop $HOME/tgoby/pops/2014Paredon.txt \
--fst-window-size 100000  &


echo "pop1	pop2	fst" > $HOME/tgoby/stats/fst/pairwise.fst

for pop1 in 2011Tillas 2011Earl \
2006Stone 2021Stone 2006Big 2021Big \
2006Virgin 2021Virgin 2006Pudding 2021Pudding \
2017Antonio 2017Ynez 2014Burro 2014Paredon
do for pop2 in 2011Tillas 2011Earl \
2006Stone 2021Stone 2006Big 2021Big \
2006Virgin 2021Virgin 2006Pudding 2021Pudding \
2017Antonio 2017Ynez 2014Burro 2014Paredon
do ls \
$HOME/tgoby/stats/fst/$pop1.$pop2.log \
>> $HOME/tgoby/stats/fst/pairwise.fst
grep \
"Weir and Cockerham weighted Fst estimate: " \
$HOME/tgoby/stats/fst/$pop1.$pop2.log | 
sed \
's%Weir and Cockerham weighted Fst estimate: %%g' \
>> $HOME/tgoby/stats/fst/pairwise.fst
done; done

# hapcount
for i in 0 2 4 6 8; do Rscript $HOME/tgoby/stats/hapcount/Untitled$i.R & done

for i in 0 2 4 6 8
do for pop in Mendocino SantaBarbara
do vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--hapcount $HOME/tgoby/stats/hapcount/hapcount.100Kb.$i.bed \
--keep $HOME/tgoby/pops/$pop \
--mac 3 \
--out $HOME/tgoby/stats/hapcount/$pop.mac.100Kb.$i &
done; done

for i in 0 2 4 6 8
do for pop in NorteHumboldt
do vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--hapcount $HOME/tgoby/stats/hapcount/hapcount.100Kb.$i.bed \
--keep $HOME/tgoby/pops/$pop \
--mac 4 \
--out $HOME/tgoby/stats/hapcount/$pop.mac.100Kb.$i &
done; done


# removed 2006 samples
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--out $HOME/tgoby/stats/fst/overall1 \
--mac 1 \
--weir-fst-pop $HOME/tgoby/pops/2011Tillas.txt \
--weir-fst-pop $HOME/tgoby/pops/2011Earl.txt \
--weir-fst-pop $HOME/tgoby/pops/2021Stone.txt \
--weir-fst-pop $HOME/tgoby/pops/2021Big.txt \
--weir-fst-pop $HOME/tgoby/pops/2021Virgin.txt \
--weir-fst-pop $HOME/tgoby/pops/2021Pudding.txt \
--weir-fst-pop $HOME/tgoby/pops/2017Antonio.txt \
--weir-fst-pop $HOME/tgoby/pops/2017Ynez.txt \
--weir-fst-pop $HOME/tgoby/pops/2014Burro.txt \
--weir-fst-pop $HOME/tgoby/pops/2014Paredon.txt

## all samples global fst
vcftools \
--gzvcf /Volumes/Tigrigobius/tgoby/vcf/phased/segregating_sites.recode.vcf.gz \
--out /Volumes/Tigrigobius/tgoby/stats/fst/global \
--weir-fst-pop /Volumes/Tigrigobius/tgoby/pops/2011Tillas.txt \
--weir-fst-pop /Volumes/Tigrigobius/tgoby/pops/2011Earl.txt \
--weir-fst-pop /Volumes/Tigrigobius/tgoby/pops/Stone.txt \
--weir-fst-pop /Volumes/Tigrigobius/tgoby/pops/Big.txt \
--weir-fst-pop /Volumes/Tigrigobius/tgoby/pops/Virgin.txt \
--weir-fst-pop /Volumes/Tigrigobius/tgoby/pops/Pudding.txt \
--weir-fst-pop /Volumes/Tigrigobius/tgoby/pops/2017Antonio.txt \
--weir-fst-pop /Volumes/Tigrigobius/tgoby/pops/2017Ynez.txt \
--weir-fst-pop /Volumes/Tigrigobius/tgoby/pops/2014Burro.txt \
--weir-fst-pop /Volumes/Tigrigobius/tgoby/pops/2014Paredon.txt

## No 2006 samples global fst
vcftools \
--gzvcf /Volumes/Tigrigobius/tgoby/vcf/phased/segregating_sites.recode.vcf.gz \
--out /Volumes/Tigrigobius/tgoby/stats/fst/global1 \
--weir-fst-pop /Volumes/Tigrigobius/tgoby/pops/2011Tillas.txt \
--weir-fst-pop /Volumes/Tigrigobius/tgoby/pops/2011Earl.txt \
--weir-fst-pop /Volumes/Tigrigobius/tgoby/pops/2021Stone.txt \
--weir-fst-pop /Volumes/Tigrigobius/tgoby/pops/2021Big.txt \
--weir-fst-pop /Volumes/Tigrigobius/tgoby/pops/2021Virgin.txt \
--weir-fst-pop /Volumes/Tigrigobius/tgoby/pops/2021Pudding.txt \
--weir-fst-pop /Volumes/Tigrigobius/tgoby/pops/2017Antonio.txt \
--weir-fst-pop /Volumes/Tigrigobius/tgoby/pops/2017Ynez.txt \
--weir-fst-pop /Volumes/Tigrigobius/tgoby/pops/2014Burro.txt \
--weir-fst-pop /Volumes/Tigrigobius/tgoby/pops/2014Paredon.txt



# fst pruned
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2011Tillas.2011Earl \
--weir-fst-pop $HOME/tgoby/pops/2011Tillas.txt \
--weir-fst-pop $HOME/tgoby/pops/2011Earl.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2011Tillas.2006Stone \
--weir-fst-pop $HOME/tgoby/pops/2011Tillas.txt \
--weir-fst-pop $HOME/tgoby/pops/2006Stone.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2011Tillas.2021Stone \
--weir-fst-pop $HOME/tgoby/pops/2011Tillas.txt \
--weir-fst-pop $HOME/tgoby/pops/2021Stone.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2011Tillas.2006Big \
--weir-fst-pop $HOME/tgoby/pops/2011Tillas.txt \
--weir-fst-pop $HOME/tgoby/pops/2006Big.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2011Tillas.2021Big \
--weir-fst-pop $HOME/tgoby/pops/2011Tillas.txt \
--weir-fst-pop $HOME/tgoby/pops/2021Big.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2011Tillas.2006Virgin \
--weir-fst-pop $HOME/tgoby/pops/2011Tillas.txt \
--weir-fst-pop $HOME/tgoby/pops/2006Virgin.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2011Tillas.2021Virgin \
--weir-fst-pop $HOME/tgoby/pops/2011Tillas.txt \
--weir-fst-pop $HOME/tgoby/pops/2021Virgin.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2011Tillas.2006Pudding \
--weir-fst-pop $HOME/tgoby/pops/2011Tillas.txt \
--weir-fst-pop $HOME/tgoby/pops/2006Pudding.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2011Tillas.2021Pudding \
--weir-fst-pop $HOME/tgoby/pops/2011Tillas.txt \
--weir-fst-pop $HOME/tgoby/pops/2021Pudding.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2011Tillas.2017Antonio \
--weir-fst-pop $HOME/tgoby/pops/2011Tillas.txt \
--weir-fst-pop $HOME/tgoby/pops/2017Antonio.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2011Tillas.2017Ynez \
--weir-fst-pop $HOME/tgoby/pops/2011Tillas.txt \
--weir-fst-pop $HOME/tgoby/pops/2017Ynez.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2011Tillas.2014Burro \
--weir-fst-pop $HOME/tgoby/pops/2011Tillas.txt \
--weir-fst-pop $HOME/tgoby/pops/2014Burro.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2011Tillas.2014Paredon \
--weir-fst-pop $HOME/tgoby/pops/2011Tillas.txt \
--weir-fst-pop $HOME/tgoby/pops/2014Paredon.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2011Earl.2006Stone \
--weir-fst-pop $HOME/tgoby/pops/2011Earl.txt \
--weir-fst-pop $HOME/tgoby/pops/2006Stone.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2011Earl.2021Stone \
--weir-fst-pop $HOME/tgoby/pops/2011Earl.txt \
--weir-fst-pop $HOME/tgoby/pops/2021Stone.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2011Earl.2006Big \
--weir-fst-pop $HOME/tgoby/pops/2011Earl.txt \
--weir-fst-pop $HOME/tgoby/pops/2006Big.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2011Earl.2021Big \
--weir-fst-pop $HOME/tgoby/pops/2011Earl.txt \
--weir-fst-pop $HOME/tgoby/pops/2021Big.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2011Earl.2006Virgin \
--weir-fst-pop $HOME/tgoby/pops/2011Earl.txt \
--weir-fst-pop $HOME/tgoby/pops/2006Virgin.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2011Earl.2021Virgin \
--weir-fst-pop $HOME/tgoby/pops/2011Earl.txt \
--weir-fst-pop $HOME/tgoby/pops/2021Virgin.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2011Earl.2006Pudding \
--weir-fst-pop $HOME/tgoby/pops/2011Earl.txt \
--weir-fst-pop $HOME/tgoby/pops/2006Pudding.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2011Earl.2021Pudding \
--weir-fst-pop $HOME/tgoby/pops/2011Earl.txt \
--weir-fst-pop $HOME/tgoby/pops/2021Pudding.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2011Earl.2017Antonio \
--weir-fst-pop $HOME/tgoby/pops/2011Earl.txt \
--weir-fst-pop $HOME/tgoby/pops/2017Antonio.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2011Earl.2017Ynez \
--weir-fst-pop $HOME/tgoby/pops/2011Earl.txt \
--weir-fst-pop $HOME/tgoby/pops/2017Ynez.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2011Earl.2014Burro \
--weir-fst-pop $HOME/tgoby/pops/2011Earl.txt \
--weir-fst-pop $HOME/tgoby/pops/2014Burro.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2011Earl.2014Paredon \
--weir-fst-pop $HOME/tgoby/pops/2011Earl.txt \
--weir-fst-pop $HOME/tgoby/pops/2014Paredon.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2006Stone.2021Stone \
--weir-fst-pop $HOME/tgoby/pops/2006Stone.txt \
--weir-fst-pop $HOME/tgoby/pops/2021Stone.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2006Stone.2006Big \
--weir-fst-pop $HOME/tgoby/pops/2006Stone.txt \
--weir-fst-pop $HOME/tgoby/pops/2006Big.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2006Stone.2021Big \
--weir-fst-pop $HOME/tgoby/pops/2006Stone.txt \
--weir-fst-pop $HOME/tgoby/pops/2021Big.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2006Stone.2006Virgin \
--weir-fst-pop $HOME/tgoby/pops/2006Stone.txt \
--weir-fst-pop $HOME/tgoby/pops/2006Virgin.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2006Stone.2021Virgin \
--weir-fst-pop $HOME/tgoby/pops/2006Stone.txt \
--weir-fst-pop $HOME/tgoby/pops/2021Virgin.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2006Stone.2006Pudding \
--weir-fst-pop $HOME/tgoby/pops/2006Stone.txt \
--weir-fst-pop $HOME/tgoby/pops/2006Pudding.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2006Stone.2021Pudding \
--weir-fst-pop $HOME/tgoby/pops/2006Stone.txt \
--weir-fst-pop $HOME/tgoby/pops/2021Pudding.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2006Stone.2017Antonio \
--weir-fst-pop $HOME/tgoby/pops/2006Stone.txt \
--weir-fst-pop $HOME/tgoby/pops/2017Antonio.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2006Stone.2017Ynez \
--weir-fst-pop $HOME/tgoby/pops/2006Stone.txt \
--weir-fst-pop $HOME/tgoby/pops/2017Ynez.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2006Stone.2014Burro \
--weir-fst-pop $HOME/tgoby/pops/2006Stone.txt \
--weir-fst-pop $HOME/tgoby/pops/2014Burro.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2006Stone.2014Paredon \
--weir-fst-pop $HOME/tgoby/pops/2006Stone.txt \
--weir-fst-pop $HOME/tgoby/pops/2014Paredon.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2021Stone.2006Big \
--weir-fst-pop $HOME/tgoby/pops/2021Stone.txt \
--weir-fst-pop $HOME/tgoby/pops/2006Big.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2021Stone.2021Big \
--weir-fst-pop $HOME/tgoby/pops/2021Stone.txt \
--weir-fst-pop $HOME/tgoby/pops/2021Big.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2021Stone.2006Virgin \
--weir-fst-pop $HOME/tgoby/pops/2021Stone.txt \
--weir-fst-pop $HOME/tgoby/pops/2006Virgin.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2021Stone.2021Virgin \
--weir-fst-pop $HOME/tgoby/pops/2021Stone.txt \
--weir-fst-pop $HOME/tgoby/pops/2021Virgin.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2021Stone.2006Pudding \
--weir-fst-pop $HOME/tgoby/pops/2021Stone.txt \
--weir-fst-pop $HOME/tgoby/pops/2006Pudding.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2021Stone.2021Pudding \
--weir-fst-pop $HOME/tgoby/pops/2021Stone.txt \
--weir-fst-pop $HOME/tgoby/pops/2021Pudding.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2021Stone.2017Antonio \
--weir-fst-pop $HOME/tgoby/pops/2021Stone.txt \
--weir-fst-pop $HOME/tgoby/pops/2017Antonio.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2021Stone.2017Ynez \
--weir-fst-pop $HOME/tgoby/pops/2021Stone.txt \
--weir-fst-pop $HOME/tgoby/pops/2017Ynez.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2021Stone.2014Burro \
--weir-fst-pop $HOME/tgoby/pops/2021Stone.txt \
--weir-fst-pop $HOME/tgoby/pops/2014Burro.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2021Stone.2014Paredon \
--weir-fst-pop $HOME/tgoby/pops/2021Stone.txt \
--weir-fst-pop $HOME/tgoby/pops/2014Paredon.txt \
--fst-window-size 100000
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2006Big.2021Big \
--weir-fst-pop $HOME/tgoby/pops/2006Big.txt \
--weir-fst-pop $HOME/tgoby/pops/2021Big.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2006Big.2006Virgin \
--weir-fst-pop $HOME/tgoby/pops/2006Big.txt \
--weir-fst-pop $HOME/tgoby/pops/2006Virgin.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2006Big.2021Virgin \
--weir-fst-pop $HOME/tgoby/pops/2006Big.txt \
--weir-fst-pop $HOME/tgoby/pops/2021Virgin.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2006Big.2006Pudding \
--weir-fst-pop $HOME/tgoby/pops/2006Big.txt \
--weir-fst-pop $HOME/tgoby/pops/2006Pudding.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2006Big.2021Pudding \
--weir-fst-pop $HOME/tgoby/pops/2006Big.txt \
--weir-fst-pop $HOME/tgoby/pops/2021Pudding.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2006Big.2017Antonio \
--weir-fst-pop $HOME/tgoby/pops/2006Big.txt \
--weir-fst-pop $HOME/tgoby/pops/2017Antonio.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2006Big.2017Ynez \
--weir-fst-pop $HOME/tgoby/pops/2006Big.txt \
--weir-fst-pop $HOME/tgoby/pops/2017Ynez.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2006Big.2014Burro \
--weir-fst-pop $HOME/tgoby/pops/2006Big.txt \
--weir-fst-pop $HOME/tgoby/pops/2014Burro.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2006Big.2014Paredon \
--weir-fst-pop $HOME/tgoby/pops/2006Big.txt \
--weir-fst-pop $HOME/tgoby/pops/2014Paredon.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2021Big.2006Virgin \
--weir-fst-pop $HOME/tgoby/pops/2021Big.txt \
--weir-fst-pop $HOME/tgoby/pops/2006Virgin.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2021Big.2021Virgin \
--weir-fst-pop $HOME/tgoby/pops/2021Big.txt \
--weir-fst-pop $HOME/tgoby/pops/2021Virgin.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2021Big.2006Pudding \
--weir-fst-pop $HOME/tgoby/pops/2021Big.txt \
--weir-fst-pop $HOME/tgoby/pops/2006Pudding.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2021Big.2021Pudding \
--weir-fst-pop $HOME/tgoby/pops/2021Big.txt \
--weir-fst-pop $HOME/tgoby/pops/2021Pudding.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2021Big.2017Antonio \
--weir-fst-pop $HOME/tgoby/pops/2021Big.txt \
--weir-fst-pop $HOME/tgoby/pops/2017Antonio.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2021Big.2017Ynez \
--weir-fst-pop $HOME/tgoby/pops/2021Big.txt \
--weir-fst-pop $HOME/tgoby/pops/2017Ynez.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2021Big.2014Burro \
--weir-fst-pop $HOME/tgoby/pops/2021Big.txt \
--weir-fst-pop $HOME/tgoby/pops/2014Burro.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2021Big.2014Paredon \
--weir-fst-pop $HOME/tgoby/pops/2021Big.txt \
--weir-fst-pop $HOME/tgoby/pops/2014Paredon.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2006Virgin.2021Virgin \
--weir-fst-pop $HOME/tgoby/pops/2006Virgin.txt \
--weir-fst-pop $HOME/tgoby/pops/2021Virgin.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2006Virgin.2006Pudding \
--weir-fst-pop $HOME/tgoby/pops/2006Virgin.txt \
--weir-fst-pop $HOME/tgoby/pops/2006Pudding.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2006Virgin.2021Pudding \
--weir-fst-pop $HOME/tgoby/pops/2006Virgin.txt \
--weir-fst-pop $HOME/tgoby/pops/2021Pudding.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2006Virgin.2017Antonio \
--weir-fst-pop $HOME/tgoby/pops/2006Virgin.txt \
--weir-fst-pop $HOME/tgoby/pops/2017Antonio.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2006Virgin.2017Ynez \
--weir-fst-pop $HOME/tgoby/pops/2006Virgin.txt \
--weir-fst-pop $HOME/tgoby/pops/2017Ynez.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2006Virgin.2014Burro \
--weir-fst-pop $HOME/tgoby/pops/2006Virgin.txt \
--weir-fst-pop $HOME/tgoby/pops/2014Burro.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2006Virgin.2014Paredon \
--weir-fst-pop $HOME/tgoby/pops/2006Virgin.txt \
--weir-fst-pop $HOME/tgoby/pops/2014Paredon.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2021Virgin.2006Pudding \
--weir-fst-pop $HOME/tgoby/pops/2021Virgin.txt \
--weir-fst-pop $HOME/tgoby/pops/2006Pudding.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2021Virgin.2021Pudding \
--weir-fst-pop $HOME/tgoby/pops/2021Virgin.txt \
--weir-fst-pop $HOME/tgoby/pops/2021Pudding.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2021Virgin.2017Antonio \
--weir-fst-pop $HOME/tgoby/pops/2021Virgin.txt \
--weir-fst-pop $HOME/tgoby/pops/2017Antonio.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2021Virgin.2017Ynez \
--weir-fst-pop $HOME/tgoby/pops/2021Virgin.txt \
--weir-fst-pop $HOME/tgoby/pops/2017Ynez.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2021Virgin.2014Burro \
--weir-fst-pop $HOME/tgoby/pops/2021Virgin.txt \
--weir-fst-pop $HOME/tgoby/pops/2014Burro.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2021Virgin.2014Paredon \
--weir-fst-pop $HOME/tgoby/pops/2021Virgin.txt \
--weir-fst-pop $HOME/tgoby/pops/2014Paredon.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2006Pudding.2021Pudding \
--weir-fst-pop $HOME/tgoby/pops/2006Pudding.txt \
--weir-fst-pop $HOME/tgoby/pops/2021Pudding.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2006Pudding.2017Antonio \
--weir-fst-pop $HOME/tgoby/pops/2006Pudding.txt \
--weir-fst-pop $HOME/tgoby/pops/2017Antonio.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2006Pudding.2017Ynez \
--weir-fst-pop $HOME/tgoby/pops/2006Pudding.txt \
--weir-fst-pop $HOME/tgoby/pops/2017Ynez.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2006Pudding.2014Burro \
--weir-fst-pop $HOME/tgoby/pops/2006Pudding.txt \
--weir-fst-pop $HOME/tgoby/pops/2014Burro.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2006Pudding.2014Paredon \
--weir-fst-pop $HOME/tgoby/pops/2006Pudding.txt \
--weir-fst-pop $HOME/tgoby/pops/2014Paredon.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2021Pudding.2017Antonio \
--weir-fst-pop $HOME/tgoby/pops/2021Pudding.txt \
--weir-fst-pop $HOME/tgoby/pops/2017Antonio.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2021Pudding.2017Ynez \
--weir-fst-pop $HOME/tgoby/pops/2021Pudding.txt \
--weir-fst-pop $HOME/tgoby/pops/2017Ynez.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2021Pudding.2014Burro \
--weir-fst-pop $HOME/tgoby/pops/2021Pudding.txt \
--weir-fst-pop $HOME/tgoby/pops/2014Burro.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2021Pudding.2014Paredon \
--weir-fst-pop $HOME/tgoby/pops/2021Pudding.txt \
--weir-fst-pop $HOME/tgoby/pops/2014Paredon.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2017Antonio.2017Ynez \
--weir-fst-pop $HOME/tgoby/pops/2017Antonio.txt \
--weir-fst-pop $HOME/tgoby/pops/2017Ynez.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2017Antonio.2014Burro \
--weir-fst-pop $HOME/tgoby/pops/2017Antonio.txt \
--weir-fst-pop $HOME/tgoby/pops/2014Burro.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2017Antonio.2014Paredon \
--weir-fst-pop $HOME/tgoby/pops/2017Antonio.txt \
--weir-fst-pop $HOME/tgoby/pops/2014Paredon.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2017Ynez.2014Burro \
--weir-fst-pop $HOME/tgoby/pops/2017Ynez.txt \
--weir-fst-pop $HOME/tgoby/pops/2014Burro.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2017Ynez.2014Paredon \
--weir-fst-pop $HOME/tgoby/pops/2017Ynez.txt \
--weir-fst-pop $HOME/tgoby/pops/2014Paredon.txt \
--fst-window-size 100000 
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/pruned.recode.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/pruned/fst/pruned.2014Burro.2014Paredon \
--weir-fst-pop $HOME/tgoby/pops/2014Burro.txt \
--weir-fst-pop $HOME/tgoby/pops/2014Paredon.txt \
--fst-window-size 100000 


echo "pop1	pop2	fst" > $HOME/tgoby/stats/pruned/fst/pruned.pairwise.fst

for pop1 in 2011Tillas 2011Earl \
2006Stone 2021Stone 2006Big 2021Big \
2006Virgin 2021Virgin 2006Pudding 2021Pudding \
2017Antonio 2017Ynez 2014Burro 2014Paredon
do for pop2 in 2011Tillas 2011Earl \
2006Stone 2021Stone 2006Big 2021Big \
2006Virgin 2021Virgin 2006Pudding 2021Pudding \
2017Antonio 2017Ynez 2014Burro 2014Paredon
do ls \
$HOME/tgoby/stats/pruned/fst/pruned.$pop1.$pop2.log \
>> $HOME/tgoby/stats/pruned/fst/pruned.pairwise.fst
grep \
"Weir and Cockerham weighted Fst estimate: " \
$HOME/tgoby/stats/pruned/fst/pruned.$pop1.$pop2.log | 
sed \
's%Weir and Cockerham weighted Fst estimate: %%g' \
>> $HOME/tgoby/stats/pruned/fst/pruned.pairwise.fst
done; done


# re-do analyses with 5% MAF (i.e., count 3-4 minor alleles)
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--keep $HOME/tgoby/pops/NorteHumboldt \
--mac 4 \
--out $HOME/tgoby/vcf/phased/NorteHumboldt.mac \
--kept-sites &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--keep $HOME/tgoby/pops/Mendocino \
--mac 3 \
--out $HOME/tgoby/vcf/phased/Mendocino.mac \
--kept-sites &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--keep $HOME/tgoby/pops/SantaBarbara \
--mac 3 \
--out $HOME/tgoby/vcf/phased/SantaBarbara.mac \
--kept-sites &

cd $HOME/tgoby/vcf/phased
Rscript $HOME/tgoby/vcf/phased/Untitled1.R

vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--keep $HOME/tgoby/pops/NorteHumboldt \
--keep $HOME/tgoby/pops/Mendocino \
--keep $HOME/tgoby/pops/SantaBarbara \
--out $HOME/tgoby/vcf/phased/NorteHumboldt_Mendocino_SantaBarbara.mac \
--positions $HOME/tgoby/vcf/phased/NorteHumboldt_Mendocino_SantaBarbara.mac.kept.sites \
--recode &

bgzip $HOME/tgoby/vcf/phased/NorteHumboldt_Mendocino_SantaBarbara.mac.recode.vcf &&
tabix $HOME/tgoby/vcf/phased/NorteHumboldt_Mendocino_SantaBarbara.mac.recode.vcf.gz



# freq
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/stats/freq/snps \
--recode

bgzip $HOME/tgoby/stats/freq/snps.recode.vcf &&
tabix $HOME/tgoby/stats/freq/snps.recode.vcf.gz


for pop in NorteHumboldt Mendocino SantaBarbara
do vcftools \
--freq \
--gzvcf $HOME/tgoby/stats/freq/snps.recode.vcf.gz \
--keep $HOME/tgoby/pops/$pop \
--out $HOME/tgoby/stats/freq/$pop &
done



# NeEstimator
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--out $HOME/tgoby/neestimator/SantaBarbara.10Kb \
--mac 1 \
--keep $HOME/tgoby/pops/2017Antonio.txt \
--keep $HOME/tgoby/pops/2017Ynez.txt \
--keep $HOME/tgoby/pops/2014Burro.txt \
--keep $HOME/tgoby/pops/2014Paredon.txt \
--thin 10000 \
--012

vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--out $HOME/tgoby/neestimator/BigStone.10Kb \
--mac 1 \
--keep $HOME/tgoby/pops/2006Stone.txt \
--keep $HOME/tgoby/pops/2021Stone.txt \
--keep $HOME/tgoby/pops/2006Big.txt \
--keep $HOME/tgoby/pops/2021Big.txt \
--thin 10000 \
--012

vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--out $HOME/tgoby/neestimator/Mendocino.10Kb \
--mac 1 \
--keep $HOME/tgoby/pops/2006Virgin.txt \
--keep $HOME/tgoby/pops/2021Virgin.txt \
--keep $HOME/tgoby/pops/2006Pudding.txt \
--keep $HOME/tgoby/pops/2021Pudding.txt \
--thin 10000 \
--012

vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--out $HOME/tgoby/neestimator/NorteHumboldt1.10Kb \
--mac 1 \
--keep $HOME/tgoby/pops/2011Tillas.txt \
--keep $HOME/tgoby/pops/2011Earl.txt \
--keep $HOME/tgoby/pops/2021Stone.txt \
--keep $HOME/tgoby/pops/2021Big.txt \
--thin 10000 \
--012

vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--out $HOME/tgoby/neestimator/NorteHumboldt6.10Kb \
--mac 1 \
--keep $HOME/tgoby/pops/2011Tillas.txt \
--keep $HOME/tgoby/pops/2011Earl.txt \
--keep $HOME/tgoby/pops/2006Stone.txt \
--keep $HOME/tgoby/pops/2006Big.txt \
--thin 10000 \
--012

vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--out $HOME/tgoby/neestimator/DelNorte.10Kb \
--mac 1 \
--keep $HOME/tgoby/pops/2011Tillas.txt \
--keep $HOME/tgoby/pops/2011Earl.txt \
--thin 10000 \
--012



#
# xpclr with reference MAF filtering and non-overlapping windows

vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--keep $HOME/tgoby/pops/NorteHumboldt \
--keep $HOME/tgoby/pops/Mendocino \
--keep $HOME/tgoby/pops/SantaBarbara \
--out $HOME/tgoby/vcf/phased/ref_NorteHumboldt \
--positions $HOME/tgoby/vcf/phased/NorteHumboldt.mac.kept.sites \
--recode &

bgzip $HOME/tgoby/vcf/phased/ref_NorteHumboldt.recode.vcf &&
tabix $HOME/tgoby/vcf/phased/ref_NorteHumboldt.recode.vcf.gz

vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--keep $HOME/tgoby/pops/NorteHumboldt \
--keep $HOME/tgoby/pops/Mendocino \
--keep $HOME/tgoby/pops/SantaBarbara \
--out $HOME/tgoby/vcf/phased/ref_Mendocino \
--positions $HOME/tgoby/vcf/phased/Mendocino.mac.kept.sites \
--recode &

bgzip $HOME/tgoby/vcf/phased/ref_Mendocino.recode.vcf &&
tabix $HOME/tgoby/vcf/phased/ref_Mendocino.recode.vcf.gz

vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--keep $HOME/tgoby/pops/NorteHumboldt \
--keep $HOME/tgoby/pops/Mendocino \
--keep $HOME/tgoby/pops/SantaBarbara \
--out $HOME/tgoby/vcf/phased/ref_SantaBarbara \
--positions $HOME/tgoby/vcf/phased/SantaBarbara.mac.kept.sites \
--recode &

bgzip $HOME/tgoby/vcf/phased/ref_SantaBarbara.recode.vcf &&
tabix $HOME/tgoby/vcf/phased/ref_SantaBarbara.recode.vcf.gz


vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--keep $HOME/tgoby/pops/NorteHumboldt \
--keep $HOME/tgoby/pops/Mendocino \
--mac 6 \
--out $HOME/tgoby/vcf/phased/NorteHumboldtMendocino.mac \
--kept-sites &

vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--keep $HOME/tgoby/pops/NorteHumboldt \
--keep $HOME/tgoby/pops/Mendocino \
--keep $HOME/tgoby/pops/SantaBarbara \
--out $HOME/tgoby/vcf/phased/ref_NorteHumboldtMendocino \
--positions $HOME/tgoby/vcf/phased/NorteHumboldtMendocino.mac.kept.sites \
--recode

bgzip $HOME/tgoby/vcf/phased/ref_NorteHumboldtMendocino.recode.vcf &&
tabix $HOME/tgoby/vcf/phased/ref_NorteHumboldtMendocino.recode.vcf.gz





for chr in {01..22}
do xpclr \
--out $HOME/tgoby/xpclr/redo2/NorteHumboldt_Mendocino_$chr.100Kb \
--format "vcf" \
--input $HOME/tgoby/vcf/phased/ref_Mendocino.recode.vcf.gz \
--samplesA $HOME/tgoby/pops/NorteHumboldt \
--samplesB $HOME/tgoby/pops/Mendocino \
--chr JAPEHO0100000$chr.1 \
--phased \
--size 100000 \
--step 100000 \
--maxsnps 1000 \
--verbose 30 &
done

for chr in {01..22}
do xpclr \
--out $HOME/tgoby/xpclr/redo2/Mendocino_NorteHumboldt_$chr.100Kb \
--format "vcf" \
--input $HOME/tgoby/vcf/phased/ref_NorteHumboldt.recode.vcf.gz \
--samplesA $HOME/tgoby/pops/Mendocino \
--samplesB $HOME/tgoby/pops/NorteHumboldt \
--chr JAPEHO0100000$chr.1 \
--phased \
--size 100000 \
--step 100000 \
--maxsnps 1000 \
--verbose 40 &
done

for chr in {01..22}
do xpclr \
--out $HOME/tgoby/xpclr/redo2/Mendocino_SantaBarbara_$chr.100Kb \
--format "vcf" \
--input $HOME/tgoby/vcf/phased/ref_SantaBarbara.recode.vcf.gz \
--samplesA $HOME/tgoby/pops/Mendocino \
--samplesB $HOME/tgoby/pops/SantaBarbara \
--chr JAPEHO0100000$chr.1 \
--phased \
--size 100000 \
--step 100000 \
--maxsnps 1000 \
--verbose 40 &
done

for chr in {01..22}
do xpclr \
--out $HOME/tgoby/xpclr/redo2/NorteHumboldt_SantaBarbara_$chr.100Kb \
--format "vcf" \
--input $HOME/tgoby/vcf/phased/ref_SantaBarbara.recode.vcf.gz \
--samplesA $HOME/tgoby/pops/NorteHumboldt \
--samplesB $HOME/tgoby/pops/SantaBarbara \
--chr JAPEHO0100000$chr.1 \
--maxsnps 10000 \
--phased \
--size 100000 \
--step 100000 \
--maxsnps 1000 \
--verbose 40 &
done

for chr in {01..22}
do xpclr \
--out $HOME/tgoby/xpclr/redo2/NorteHumboldtMendocino_SantaBarbara_$chr.100Kb \
--format "vcf" \
--input $HOME/tgoby/vcf/phased/ref_SantaBarbara.recode.vcf.gz \
--samplesA $HOME/tgoby/pops/NorteHumboldt_Mendocino \
--samplesB $HOME/tgoby/pops/SantaBarbara \
--chr JAPEHO0100000$chr.1 \
--phased \
--size 100000 \
--step 100000 \
--maxsnps 1000 \
--verbose 40 &
done

for chr in {01..22}
do xpclr \
--out $HOME/tgoby/xpclr/redo2/SantaBarbara_NorteHumboldtMendocino_$chr.100Kb \
--format "vcf" \
--input $HOME/tgoby/vcf/phased/ref_NorteHumboldtMendocino.recode.vcf.gz \
--samplesA $HOME/tgoby/pops/SantaBarbara \
--samplesB $HOME/tgoby/pops/NorteHumboldt_Mendocino \
--chr JAPEHO0100000$chr.1 \
--phased \
--size 100000 \
--step 100000 \
--maxsnps 1000 \
--verbose 40 &
done

for chr in {01..22}
do xpclr \
--out $HOME/tgoby/xpclr/redo2/SantaBarbara_NorteHumboldt_$chr.100Kb \
--format "vcf" \
--input $HOME/tgoby/vcf/phased/ref_NorteHumboldt.recode.vcf.gz \
--samplesA $HOME/tgoby/pops/SantaBarbara \
--samplesB $HOME/tgoby/pops/NorteHumboldt \
--chr JAPEHO0100000$chr.1 \
--phased \
--size 100000 \
--step 100000 \
--maxsnps 1000 \
--verbose 40 &
done

for chr in {01..22}
do xpclr \
--out $HOME/tgoby/xpclr/redo2/SantaBarbara_Mendocino_$chr.100Kb \
--format "vcf" \
--input $HOME/tgoby/vcf/phased/ref_Mendocino.recode.vcf.gz \
--samplesA $HOME/tgoby/pops/SantaBarbara \
--samplesB $HOME/tgoby/pops/Mendocino \
--chr JAPEHO0100000$chr.1 \
--phased \
--size 100000 \
--step 100000 \
--maxsnps 1000 \
--verbose 40 &
done

# scan apolipoprotein gene cluster with overlapping 50 Kb windows
xpclr \
--out $HOME/tgoby/xpclr/redo2/NorteHumboldt_Mendocino_13.50Kb_19Mb-20Mb \
--format "vcf" \
--input $HOME/tgoby/vcf/phased/ref_Mendocino.recode.vcf.gz \
--samplesA $HOME/tgoby/pops/NorteHumboldt \
--samplesB $HOME/tgoby/pops/Mendocino \
--chr JAPEHO010000013.1 \
--phased \
--start 19000000 \
--size 50000 \
--step 1000 \
--stop 20000000 \
--verbose 40 &
xpclr \
--out $HOME/tgoby/xpclr/redo2/Mendocino_NorteHumboldt_13.50Kb_19Mb-20Mb \
--format "vcf" \
--input $HOME/tgoby/vcf/phased/ref_NorteHumboldt.recode.vcf.gz \
--samplesA $HOME/tgoby/pops/Mendocino \
--samplesB $HOME/tgoby/pops/NorteHumboldt \
--chr JAPEHO010000013.1 \
--phased \
--start 19000000 \
--size 50000 \
--step 1000 \
--stop 20000000 \
--verbose 40 &
xpclr \
--out $HOME/tgoby/xpclr/redo2/Mendocino_SantaBarbara_13.50Kb_19Mb-20Mb \
--format "vcf" \
--input $HOME/tgoby/vcf/phased/ref_SantaBarbara.recode.vcf.gz \
--samplesA $HOME/tgoby/pops/Mendocino \
--samplesB $HOME/tgoby/pops/SantaBarbara \
--chr JAPEHO010000013.1 \
--phased \
--start 19000000 \
--size 50000 \
--step 1000 \
--stop 20000000 \
--verbose 40 &
xpclr \
--out $HOME/tgoby/xpclr/redo2/NorteHumboldt_SantaBarbara_13.50Kb_19Mb-20Mb \
--format "vcf" \
--input $HOME/tgoby/vcf/phased/ref_SantaBarbara.recode.vcf.gz \
--samplesA $HOME/tgoby/pops/NorteHumboldt \
--samplesB $HOME/tgoby/pops/SantaBarbara \
--chr JAPEHO010000013.1 \
--phased \
--start 19000000 \
--size 50000 \
--step 1000 \
--stop 20000000 \
--verbose 40 &
xpclr \
--out $HOME/tgoby/xpclr/redo2/SantaBarbara_NorteHumboldt_13.50Kb_19Mb-20Mb \
--format "vcf" \
--input $HOME/tgoby/vcf/phased/ref_NorteHumboldt.recode.vcf.gz \
--samplesA $HOME/tgoby/pops/SantaBarbara \
--samplesB $HOME/tgoby/pops/NorteHumboldt \
--chr JAPEHO010000013.1 \
--phased \
--start 19000000 \
--size 50000 \
--step 1000 \
--stop 20000000 \
--verbose 40 &
xpclr \
--out $HOME/tgoby/xpclr/redo2/SantaBarbara_Mendocino_13.50Kb_19Mb-20Mb \
--format "vcf" \
--input $HOME/tgoby/vcf/phased/ref_Mendocino.recode.vcf.gz \
--samplesA $HOME/tgoby/pops/SantaBarbara \
--samplesB $HOME/tgoby/pops/Mendocino \
--chr JAPEHO010000013.1 \
--phased \
--start 19000000 \
--size 50000 \
--step 1000 \
--stop 20000000 \
--verbose 40 &


# scan apolipoprotein gene cluster with overlapping 100 Kb windows
xpclr \
--out $HOME/tgoby/xpclr/redo2/NorteHumboldt_Mendocino_13.100Kb_19Mb-20Mb \
--format "vcf" \
--input $HOME/tgoby/vcf/phased/ref_Mendocino.recode.vcf.gz \
--samplesA $HOME/tgoby/pops/NorteHumboldt \
--samplesB $HOME/tgoby/pops/Mendocino \
--chr JAPEHO010000013.1 \
--phased \
--start 19000001 \
--size 100000 \
--step 1000 \
--stop 20000000 \
--maxsnps 1000 \
--verbose 40 &
xpclr \
--out $HOME/tgoby/xpclr/redo2/Mendocino_NorteHumboldt_13.100Kb_19Mb-20Mb \
--format "vcf" \
--input $HOME/tgoby/vcf/phased/ref_NorteHumboldt.recode.vcf.gz \
--samplesA $HOME/tgoby/pops/Mendocino \
--samplesB $HOME/tgoby/pops/NorteHumboldt \
--chr JAPEHO010000013.1 \
--phased \
--start 19000001 \
--size 100000 \
--step 1000 \
--stop 20000000 \
--maxsnps 1000 \
--verbose 40 &
xpclr \
--out $HOME/tgoby/xpclr/redo2/Mendocino_SantaBarbara_13.100Kb_19Mb-20Mb \
--format "vcf" \
--input $HOME/tgoby/vcf/phased/ref_SantaBarbara.recode.vcf.gz \
--samplesA $HOME/tgoby/pops/Mendocino \
--samplesB $HOME/tgoby/pops/SantaBarbara \
--chr JAPEHO010000013.1 \
--phased \
--start 19000001 \
--size 100000 \
--step 1000 \
--stop 20000000 \
--maxsnps 1000 \
--verbose 40 &
xpclr \
--out $HOME/tgoby/xpclr/redo2/NorteHumboldt_SantaBarbara_13.100Kb_19Mb-20Mb \
--format "vcf" \
--input $HOME/tgoby/vcf/phased/ref_SantaBarbara.recode.vcf.gz \
--samplesA $HOME/tgoby/pops/NorteHumboldt \
--samplesB $HOME/tgoby/pops/SantaBarbara \
--chr JAPEHO010000013.1 \
--phased \
--start 19000001 \
--size 100000 \
--step 1000 \
--stop 20000000 \
--maxsnps 1000 \
--verbose 40 &
xpclr \
--out $HOME/tgoby/xpclr/redo2/SantaBarbara_NorteHumboldt_13.100Kb_19Mb-20Mb \
--format "vcf" \
--input $HOME/tgoby/vcf/phased/ref_NorteHumboldt.recode.vcf.gz \
--samplesA $HOME/tgoby/pops/SantaBarbara \
--samplesB $HOME/tgoby/pops/NorteHumboldt \
--chr JAPEHO010000013.1 \
--phased \
--start 19000001 \
--size 100000 \
--step 1000 \
--stop 20000000 \
--maxsnps 1000 \
--verbose 40 &
xpclr \
--out $HOME/tgoby/xpclr/redo2/SantaBarbara_Mendocino_13.100Kb_19Mb-20Mb \
--format "vcf" \
--input $HOME/tgoby/vcf/phased/ref_Mendocino.recode.vcf.gz \
--samplesA $HOME/tgoby/pops/SantaBarbara \
--samplesB $HOME/tgoby/pops/Mendocino \
--chr JAPEHO010000013.1 \
--phased \
--start 19000001 \
--size 100000 \
--step 1000 \
--stop 20000000 \
--maxsnps 1000 \
--verbose 40 &






# genetic diversity for Andrew
for pop in \
2011Tillas 2011Earl 2006Stone 2021Stone 2006Big 2021Big \
2006Virgin 2021Virgin 2006Pudding 2021Pudding \
2017Antonio 2017Ynez 2014Burro 2014Paredon
do vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--keep $HOME/tgoby/pops/$pop.txt \
--site-pi \
--out $HOME/tgoby/stats/pi/$pop \
--mac 1 &
done

for pop in \
2011Tillas 2011Earl 2006Stone 2021Stone 2006Big 2021Big \
2006Virgin 2021Virgin 2006Pudding 2021Pudding \
2017Antonio 2017Ynez 2014Burro 2014Paredon
do vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--keep $HOME/tgoby/pops/$pop.txt \
--window-pi 100000 \
--out $HOME/tgoby/stats/pi/$pop.mac1 \
--mac 1 &
done


# keep monomorphic loci
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/vcf/phased/segregating_sites \
--kept-sites

vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--mac 1 \
--out $HOME/tgoby/vcf/phased/segregating_sites \
--recode

bgzip $HOME/tgoby/vcf/phased/segregating_sites.recode.vcf

tabix $HOME/tgoby/vcf/phased/segregating_sites.recode.vcf.gz

bcftools index $HOME/tgoby/vcf/phased/segregating_sites.recode.vcf.gz



for pop in \
2011Tillas 2011Earl 2006Stone 2021Stone 2006Big 2021Big \
2006Virgin 2021Virgin 2006Pudding 2021Pudding \
2017Antonio 2017Ynez 2014Burro 2014Paredon
do vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--keep $HOME/tgoby/pops/$pop.txt \
--site-pi \
--out $HOME/tgoby/stats/pi/$pop.1250159 \
--positions $HOME/tgoby/vcf/phased/segregating_sites.kept.sites &
done

for pop in \
2011Tillas 2011Earl 2006Stone 2021Stone 2006Big 2021Big \
2006Virgin 2021Virgin 2006Pudding 2021Pudding \
2017Antonio 2017Ynez 2014Burro 2014Paredon
do vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--keep $HOME/tgoby/pops/$pop.txt \
--window-pi 100000 \
--out $HOME/tgoby/stats/pi/$pop.1250159 \
--positions $HOME/tgoby/vcf/phased/segregating_sites.kept.sites &
done

for pop in \
2011Tillas 2011Earl 2006Stone 2021Stone 2006Big 2021Big \
2006Virgin 2021Virgin 2006Pudding 2021Pudding \
2017Antonio 2017Ynez 2014Burro 2014Paredon
do vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--keep $HOME/tgoby/pops/$pop.txt \
--out $HOME/tgoby/stats/D/$pop.1250159 \
--TajimaD 100000 \
--positions $HOME/tgoby/vcf/phased/segregating_sites.kept.sites &
done

for pop in \
2011Tillas 2011Earl 2006Stone 2021Stone 2006Big 2021Big \
2006Virgin 2021Virgin 2006Pudding 2021Pudding \
2017Antonio 2017Ynez 2014Burro 2014Paredon
do vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--keep $HOME/tgoby/pops/$pop.txt \
--freq2 \
--out $HOME/tgoby/stats/freq/$pop.1250159 \
--positions $HOME/tgoby/vcf/phased/segregating_sites.kept.sites &
done

for pop in \
2011Tillas 2011Earl 2006Stone 2021Stone 2006Big 2021Big \
2006Virgin 2021Virgin 2006Pudding 2021Pudding \
2017Antonio 2017Ynez 2014Burro 2014Paredon
do vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--keep $HOME/tgoby/pops/$pop.txt \
--het \
--out $HOME/tgoby/stats/het/$pop.1250159 \
--positions $HOME/tgoby/vcf/phased/segregating_sites.kept.sites &
done

for pop in \
2011Tillas 2011Earl 2006Stone 2021Stone 2006Big 2021Big \
2006Virgin 2021Virgin 2006Pudding 2021Pudding \
2017Antonio 2017Ynez 2014Burro 2014Paredon
do vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--keep $HOME/tgoby/pops/$pop.txt \
--hardy \
--out $HOME/tgoby/stats/hardy/$pop.1250159 \
--positions $HOME/tgoby/vcf/phased/segregating_sites.kept.sites &
done





vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--keep $HOME/tgoby/pops/2006Stone.txt \
--keep $HOME/tgoby/pops/2021Stone.txt \
--TajimaD 100000 \
--out $HOME/tgoby/stats/D/Stone.1250159 \
--positions $HOME/tgoby/vcf/phased/segregating_sites.kept.sites &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--keep $HOME/tgoby/pops/2006Big.txt \
--keep $HOME/tgoby/pops/2021Big.txt \
--TajimaD 100000 \
--out $HOME/tgoby/stats/D/Big.1250159 \
--positions $HOME/tgoby/vcf/phased/segregating_sites.kept.sites &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--keep $HOME/tgoby/pops/2006Virgin.txt \
--keep $HOME/tgoby/pops/2021Virgin.txt \
--TajimaD 100000 \
--out $HOME/tgoby/stats/D/Virgin.1250159 \
--positions $HOME/tgoby/vcf/phased/segregating_sites.kept.sites &
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--keep $HOME/tgoby/pops/2006Pudding.txt \
--keep $HOME/tgoby/pops/2021Pudding.txt \
--TajimaD 100000 \
--out $HOME/tgoby/stats/D/Pudding.1250159 \
--positions $HOME/tgoby/vcf/phased/segregating_sites.kept.sites &





vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--out $HOME/tgoby/stats/fst/SantaBarbara.1250159.100Kb \
--fst-window-size 100000 \
--positions $HOME/tgoby/vcf/phased/segregating_sites.kept.sites \
--weir-fst-pop $HOME/tgoby/pops/2017Antonio.txt \
--weir-fst-pop $HOME/tgoby/pops/2017Ynez.txt \
--weir-fst-pop $HOME/tgoby/pops/2014Burro.txt \
--weir-fst-pop $HOME/tgoby/pops/2014Paredon.txt

# removed 2006 samples
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--out $HOME/tgoby/stats/fst/NorteHumboldt1.1250159.100Kb \
--positions $HOME/tgoby/vcf/phased/segregating_sites.kept.sites \
--weir-fst-pop $HOME/tgoby/pops/2011Tillas.txt \
--weir-fst-pop $HOME/tgoby/pops/2011Earl.txt \
--weir-fst-pop $HOME/tgoby/pops/2021Stone.txt \
--weir-fst-pop $HOME/tgoby/pops/2021Big.txt \
--fst-window-size 100000

vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--out $HOME/tgoby/stats/fst/Mendocino1.1250159.100Kb \
--positions $HOME/tgoby/vcf/phased/segregating_sites.kept.sites \
--weir-fst-pop $HOME/tgoby/pops/2021Virgin.txt \
--weir-fst-pop $HOME/tgoby/pops/2021Pudding.txt \
--fst-window-size 100000

# removed 2021 samples
vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--out $HOME/tgoby/stats/fst/NorteHumboldt6.1250159.100Kb \
--positions $HOME/tgoby/vcf/phased/segregating_sites.kept.sites \
--weir-fst-pop $HOME/tgoby/pops/2011Tillas.txt \
--weir-fst-pop $HOME/tgoby/pops/2011Earl.txt \
--weir-fst-pop $HOME/tgoby/pops/2006Stone.txt \
--weir-fst-pop $HOME/tgoby/pops/2006Big.txt \
--fst-window-size 100000

vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--out $HOME/tgoby/stats/fst/Mendocino6.1250159.100Kb \
--positions $HOME/tgoby/vcf/phased/segregating_sites.kept.sites \
--weir-fst-pop $HOME/tgoby/pops/2006Virgin.txt \
--weir-fst-pop $HOME/tgoby/pops/2006Pudding.txt \
--fst-window-size 100000


for pop in \
2011Tillas 2011Earl 2006Stone 2021Stone 2006Big 2021Big \
2006Virgin 2021Virgin 2006Pudding 2021Pudding \
2017Antonio 2017Ynez 2014Burro 2014Paredon Stone Big Virgin Pudding
do vcftools \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--hapcount $HOME/tgoby/stats/hapcount/hapcount.100Kb.bed \
--keep $HOME/tgoby/pops/$pop.txt \
--out $HOME/tgoby/stats/hapcount/$pop.1250159.100Kb \
--positions $HOME/tgoby/vcf/phased/segregating_sites.kept.sites &
done



# LDhat
# single map
for i in {00..54}
do completeLDhat \
-n 168 \
-rhomax 100 \
-n_pts 101 \
-theta 0.1 \
-split 55 \
-element $i \
-prefix lk_n168_t0.1 &
done

cat lk_n168_t0.1new_lk* > lk_n168_t0.1

for chr in {01..22}
do vcftools \
--chr JAPEHO0100000$chr.1 \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--ldhat \
--out $HOME/tgoby/ldhat/data3/chr"$chr" \
--phased \
--mac 1 &
done

for chr in {01..22}
do interval \
-seq $HOME/tgoby/ldhat/data3/chr"$chr".ldhat.sites \
-loc $HOME/tgoby/ldhat/data3/chr"$chr".ldhat.locs \
-lk $HOME/tgoby/ldhat/complete/lk_n168_t0.1 \
-its 20000000 \
-bpen 5 \
-samp 10000 \
-seed $RANDOM \
-prefix $HOME/tgoby/ldhat/interval3/chr"$chr" &
done

for chr in {01..22}
do statLDhat \
-input $HOME/tgoby/ldhat/interval3/chr"$chr"rates.txt \
-burn 1000 \
-loc $HOME/tgoby/ldhat/data3/chr"$chr".ldhat.locs \
-prefix $HOME/tgoby/ldhat/stat3/chr"$chr"rates_ &
done

for chr in {01..22}
do statLDhat \
-input $HOME/tgoby/ldhat/interval3/chr"$chr"bounds.txt \
-burn 1000 \
-loc $HOME/tgoby/ldhat/data3/chr"$chr".ldhat.locs \
-prefix $HOME/tgoby/ldhat/stat3/chr"$chr"bounds_ &
done

for chr in {01..22}
do echo -en \\n" " >> /Volumes/Tigrigobius/tgoby/ldhat/stat3/chr"$chr"rates_res.txt
tail -n 1 /Volumes/Tigrigobius/tgoby/ldhat/data3/chr"$chr".ldhat.locs |
tr -d '\n' >> /Volumes/Tigrigobius/tgoby/ldhat/stat3/chr"$chr"rates_res.txt
echo -en "\\t   0.00000\\t   0.00000\\t   0.00000\\t   0.00000" >> \
/Volumes/Tigrigobius/tgoby/ldhat/stat3/chr"$chr"rates_res.txt
done

# selscan
for pop in NorteHumboldt Mendocino SantaBarbara
do for chr in {01..22}
do vcftools \
--chr JAPEHO0100000$chr.1 \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--keep $HOME/tgoby/pops/$pop \
--out $HOME/tgoby/ldhat/data3/"$pop"_"$chr" \
--phased \
--positions $HOME/tgoby/vcf/phased/segregating_sites.kept.sites \
--recode & done; wait; done

for pop in NorteHumboldt Mendocino SantaBarbara
do for chr in {01..22}
do bgzip $HOME/tgoby/ldhat/data3/"$pop"_"$chr".recode.vcf &
done; wait; done


#
for pop in NorteHumboldt Mendocino SantaBarbara
do for chr in {01..22}
do selscan \
--ihs \
--vcf $HOME/tgoby/ldhat/data3/"$pop"_"$chr".recode.vcf.gz \
--map $HOME/tgoby/ldhat/map3/chr"$chr".map \
--out $HOME/tgoby/ihs/selscan/gmap/"$pop".chr"$chr" &
done; wait; done

norm \
--bins 71 \
--ihs \
--files  \
$HOME/tgoby/ihs/selscan/gmap/NorteHumboldt.chr01.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/NorteHumboldt.chr02.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/NorteHumboldt.chr03.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/NorteHumboldt.chr04.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/NorteHumboldt.chr05.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/NorteHumboldt.chr06.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/NorteHumboldt.chr07.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/NorteHumboldt.chr08.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/NorteHumboldt.chr09.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/NorteHumboldt.chr10.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/NorteHumboldt.chr11.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/NorteHumboldt.chr12.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/NorteHumboldt.chr13.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/NorteHumboldt.chr14.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/NorteHumboldt.chr15.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/NorteHumboldt.chr16.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/NorteHumboldt.chr17.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/NorteHumboldt.chr18.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/NorteHumboldt.chr19.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/NorteHumboldt.chr20.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/NorteHumboldt.chr21.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/NorteHumboldt.chr22.ihs.out \
--log $HOME/tgoby/ihs/selscan/gmap/NorteHumboldt.norm.log \
--bp-win

norm \
--bins 47 \
--ihs \
--files  \
$HOME/tgoby/ihs/selscan/gmap/Mendocino.chr01.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/Mendocino.chr02.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/Mendocino.chr03.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/Mendocino.chr04.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/Mendocino.chr05.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/Mendocino.chr06.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/Mendocino.chr07.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/Mendocino.chr08.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/Mendocino.chr09.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/Mendocino.chr10.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/Mendocino.chr11.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/Mendocino.chr12.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/Mendocino.chr13.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/Mendocino.chr14.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/Mendocino.chr15.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/Mendocino.chr16.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/Mendocino.chr17.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/Mendocino.chr18.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/Mendocino.chr19.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/Mendocino.chr20.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/Mendocino.chr21.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/Mendocino.chr22.ihs.out \
--log $HOME/tgoby/ihs/selscan/gmap/Mendocino.norm.log \
--bp-win

norm \
--bins 47 \
--ihs \
--files  \
$HOME/tgoby/ihs/selscan/gmap/SantaBarbara.chr01.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/SantaBarbara.chr02.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/SantaBarbara.chr03.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/SantaBarbara.chr04.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/SantaBarbara.chr05.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/SantaBarbara.chr06.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/SantaBarbara.chr07.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/SantaBarbara.chr08.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/SantaBarbara.chr09.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/SantaBarbara.chr10.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/SantaBarbara.chr11.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/SantaBarbara.chr12.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/SantaBarbara.chr13.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/SantaBarbara.chr14.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/SantaBarbara.chr15.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/SantaBarbara.chr16.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/SantaBarbara.chr17.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/SantaBarbara.chr18.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/SantaBarbara.chr19.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/SantaBarbara.chr20.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/SantaBarbara.chr21.ihs.out \
$HOME/tgoby/ihs/selscan/gmap/SantaBarbara.chr22.ihs.out \
--log $HOME/tgoby/ihs/selscan/gmap/SantaBarbara.norm.log \
--bp-win

# iHS calc using physical map instead of genetic map
for pop in NorteHumboldt Mendocino SantaBarbara
do for chr in {01..22}
do selscan \
--ihs \
--vcf $HOME/tgoby/ldhat/data3/"$pop"_"$chr".recode.vcf.gz \
--pmap \
--out $HOME/tgoby/ihs/selscan/pmap/"$pop".chr"$chr" &
done; wait; done

norm \
--bins 71 \
--ihs \
--files  \
$HOME/tgoby/ihs/selscan/pmap/NorteHumboldt.chr01.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/NorteHumboldt.chr02.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/NorteHumboldt.chr03.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/NorteHumboldt.chr04.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/NorteHumboldt.chr05.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/NorteHumboldt.chr06.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/NorteHumboldt.chr07.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/NorteHumboldt.chr08.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/NorteHumboldt.chr09.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/NorteHumboldt.chr10.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/NorteHumboldt.chr11.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/NorteHumboldt.chr12.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/NorteHumboldt.chr13.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/NorteHumboldt.chr14.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/NorteHumboldt.chr15.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/NorteHumboldt.chr16.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/NorteHumboldt.chr17.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/NorteHumboldt.chr18.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/NorteHumboldt.chr19.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/NorteHumboldt.chr20.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/NorteHumboldt.chr21.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/NorteHumboldt.chr22.ihs.out \
--log $HOME/tgoby/ihs/selscan/pmap/NorteHumboldt.norm.log \
--bp-win &

norm \
--bins 47 \
--ihs \
--files  \
$HOME/tgoby/ihs/selscan/pmap/Mendocino.chr01.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/Mendocino.chr02.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/Mendocino.chr03.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/Mendocino.chr04.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/Mendocino.chr05.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/Mendocino.chr06.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/Mendocino.chr07.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/Mendocino.chr08.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/Mendocino.chr09.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/Mendocino.chr10.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/Mendocino.chr11.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/Mendocino.chr12.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/Mendocino.chr13.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/Mendocino.chr14.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/Mendocino.chr15.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/Mendocino.chr16.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/Mendocino.chr17.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/Mendocino.chr18.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/Mendocino.chr19.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/Mendocino.chr20.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/Mendocino.chr21.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/Mendocino.chr22.ihs.out \
--log $HOME/tgoby/ihs/selscan/pmap/Mendocino.norm.log \
--bp-win &

norm \
--bins 47 \
--ihs \
--files  \
$HOME/tgoby/ihs/selscan/pmap/SantaBarbara.chr01.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/SantaBarbara.chr02.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/SantaBarbara.chr03.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/SantaBarbara.chr04.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/SantaBarbara.chr05.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/SantaBarbara.chr06.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/SantaBarbara.chr07.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/SantaBarbara.chr08.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/SantaBarbara.chr09.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/SantaBarbara.chr10.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/SantaBarbara.chr11.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/SantaBarbara.chr12.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/SantaBarbara.chr13.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/SantaBarbara.chr14.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/SantaBarbara.chr15.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/SantaBarbara.chr16.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/SantaBarbara.chr17.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/SantaBarbara.chr18.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/SantaBarbara.chr19.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/SantaBarbara.chr20.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/SantaBarbara.chr21.ihs.out \
$HOME/tgoby/ihs/selscan/pmap/SantaBarbara.chr22.ihs.out \
--log $HOME/tgoby/ihs/selscan/pmap/SantaBarbara.norm.log \
--bp-win &

# nSL
for pop in NorteHumboldt Mendocino SantaBarbara
do for chr in {01..22}
do selscan \
--nsl \
--vcf $HOME/tgoby/ldhat/data3/"$pop"_"$chr".recode.vcf.gz \
--out $HOME/tgoby/nsl/selscan/"$pop".chr"$chr" &
done; wait; done

norm \
--bins 71 \
--nsl \
--files  \
$HOME/tgoby/nsl/selscan/NorteHumboldt.chr01.nsl.out \
$HOME/tgoby/nsl/selscan/NorteHumboldt.chr02.nsl.out \
$HOME/tgoby/nsl/selscan/NorteHumboldt.chr03.nsl.out \
$HOME/tgoby/nsl/selscan/NorteHumboldt.chr04.nsl.out \
$HOME/tgoby/nsl/selscan/NorteHumboldt.chr05.nsl.out \
$HOME/tgoby/nsl/selscan/NorteHumboldt.chr06.nsl.out \
$HOME/tgoby/nsl/selscan/NorteHumboldt.chr07.nsl.out \
$HOME/tgoby/nsl/selscan/NorteHumboldt.chr08.nsl.out \
$HOME/tgoby/nsl/selscan/NorteHumboldt.chr09.nsl.out \
$HOME/tgoby/nsl/selscan/NorteHumboldt.chr10.nsl.out \
$HOME/tgoby/nsl/selscan/NorteHumboldt.chr11.nsl.out \
$HOME/tgoby/nsl/selscan/NorteHumboldt.chr12.nsl.out \
$HOME/tgoby/nsl/selscan/NorteHumboldt.chr13.nsl.out \
$HOME/tgoby/nsl/selscan/NorteHumboldt.chr14.nsl.out \
$HOME/tgoby/nsl/selscan/NorteHumboldt.chr15.nsl.out \
$HOME/tgoby/nsl/selscan/NorteHumboldt.chr16.nsl.out \
$HOME/tgoby/nsl/selscan/NorteHumboldt.chr17.nsl.out \
$HOME/tgoby/nsl/selscan/NorteHumboldt.chr18.nsl.out \
$HOME/tgoby/nsl/selscan/NorteHumboldt.chr19.nsl.out \
$HOME/tgoby/nsl/selscan/NorteHumboldt.chr20.nsl.out \
$HOME/tgoby/nsl/selscan/NorteHumboldt.chr21.nsl.out \
$HOME/tgoby/nsl/selscan/NorteHumboldt.chr22.nsl.out \
--log $HOME/tgoby/nsl/selscan/NorteHumboldt.norm.log \
--bp-win &

norm \
--bins 47 \
--nsl \
--files  \
$HOME/tgoby/nsl/selscan/Mendocino.chr01.nsl.out \
$HOME/tgoby/nsl/selscan/Mendocino.chr02.nsl.out \
$HOME/tgoby/nsl/selscan/Mendocino.chr03.nsl.out \
$HOME/tgoby/nsl/selscan/Mendocino.chr04.nsl.out \
$HOME/tgoby/nsl/selscan/Mendocino.chr05.nsl.out \
$HOME/tgoby/nsl/selscan/Mendocino.chr06.nsl.out \
$HOME/tgoby/nsl/selscan/Mendocino.chr07.nsl.out \
$HOME/tgoby/nsl/selscan/Mendocino.chr08.nsl.out \
$HOME/tgoby/nsl/selscan/Mendocino.chr09.nsl.out \
$HOME/tgoby/nsl/selscan/Mendocino.chr10.nsl.out \
$HOME/tgoby/nsl/selscan/Mendocino.chr11.nsl.out \
$HOME/tgoby/nsl/selscan/Mendocino.chr12.nsl.out \
$HOME/tgoby/nsl/selscan/Mendocino.chr13.nsl.out \
$HOME/tgoby/nsl/selscan/Mendocino.chr14.nsl.out \
$HOME/tgoby/nsl/selscan/Mendocino.chr15.nsl.out \
$HOME/tgoby/nsl/selscan/Mendocino.chr16.nsl.out \
$HOME/tgoby/nsl/selscan/Mendocino.chr17.nsl.out \
$HOME/tgoby/nsl/selscan/Mendocino.chr18.nsl.out \
$HOME/tgoby/nsl/selscan/Mendocino.chr19.nsl.out \
$HOME/tgoby/nsl/selscan/Mendocino.chr20.nsl.out \
$HOME/tgoby/nsl/selscan/Mendocino.chr21.nsl.out \
$HOME/tgoby/nsl/selscan/Mendocino.chr22.nsl.out \
--log $HOME/tgoby/nsl/selscan/Mendocino.norm.log \
--bp-win &

norm \
--bins 47 \
--nsl \
--files  \
$HOME/tgoby/nsl/selscan/SantaBarbara.chr01.nsl.out \
$HOME/tgoby/nsl/selscan/SantaBarbara.chr02.nsl.out \
$HOME/tgoby/nsl/selscan/SantaBarbara.chr03.nsl.out \
$HOME/tgoby/nsl/selscan/SantaBarbara.chr04.nsl.out \
$HOME/tgoby/nsl/selscan/SantaBarbara.chr05.nsl.out \
$HOME/tgoby/nsl/selscan/SantaBarbara.chr06.nsl.out \
$HOME/tgoby/nsl/selscan/SantaBarbara.chr07.nsl.out \
$HOME/tgoby/nsl/selscan/SantaBarbara.chr08.nsl.out \
$HOME/tgoby/nsl/selscan/SantaBarbara.chr09.nsl.out \
$HOME/tgoby/nsl/selscan/SantaBarbara.chr10.nsl.out \
$HOME/tgoby/nsl/selscan/SantaBarbara.chr11.nsl.out \
$HOME/tgoby/nsl/selscan/SantaBarbara.chr12.nsl.out \
$HOME/tgoby/nsl/selscan/SantaBarbara.chr13.nsl.out \
$HOME/tgoby/nsl/selscan/SantaBarbara.chr14.nsl.out \
$HOME/tgoby/nsl/selscan/SantaBarbara.chr15.nsl.out \
$HOME/tgoby/nsl/selscan/SantaBarbara.chr16.nsl.out \
$HOME/tgoby/nsl/selscan/SantaBarbara.chr17.nsl.out \
$HOME/tgoby/nsl/selscan/SantaBarbara.chr18.nsl.out \
$HOME/tgoby/nsl/selscan/SantaBarbara.chr19.nsl.out \
$HOME/tgoby/nsl/selscan/SantaBarbara.chr20.nsl.out \
$HOME/tgoby/nsl/selscan/SantaBarbara.chr21.nsl.out \
$HOME/tgoby/nsl/selscan/SantaBarbara.chr22.nsl.out \
--log $HOME/tgoby/nsl/selscan/SantaBarbara.norm.log \
--bp-win &

# 
for chr in {01..22}
do selscan \
--xpnsl \
--vcf $HOME/tgoby/ldhat/data3/NorteHumboldt_"$chr".recode.vcf.gz \
--vcf-ref $HOME/tgoby/ldhat/data3/Mendocino_"$chr".recode.vcf.gz \
--out $HOME/tgoby/xpnsl/selscan/NorteHumboldt_Mendocino.chr"$chr" &
done 
wait
for chr in {01..22}
do selscan \
--xpnsl \
--vcf $HOME/tgoby/ldhat/data3/NorteHumboldt_"$chr".recode.vcf.gz \
--vcf-ref $HOME/tgoby/ldhat/data3/SantaBarbara_"$chr".recode.vcf.gz \
--out $HOME/tgoby/xpnsl/selscan/NorteHumboldt_SantaBarbara.chr"$chr" &
done
wait
for chr in {01..22}
do selscan \
--xpnsl \
--vcf $HOME/tgoby/ldhat/data3/Mendocino_"$chr".recode.vcf.gz \
--vcf-ref $HOME/tgoby/ldhat/data3/SantaBarbara_"$chr".recode.vcf.gz \
--out $HOME/tgoby/xpnsl/selscan/Mendocino_SantaBarbara.chr"$chr" &
done



for chr in {01..22}
do selscan \
--xpnsl \
--vcf $HOME/tgoby/ldhat/data3/Mendocino_"$chr".recode.vcf.gz \
--vcf-ref $HOME/tgoby/ldhat/data3/NorteHumboldt_"$chr".recode.vcf.gz \
--out $HOME/tgoby/xpnsl/selscan/Mendocino_NorteHumboldt.chr"$chr" &
done 
wait
for chr in {01..22}
do selscan \
--xpnsl \
--vcf $HOME/tgoby/ldhat/data3/SantaBarbara_"$chr".recode.vcf.gz \
--vcf-ref $HOME/tgoby/ldhat/data3/NorteHumboldt_"$chr".recode.vcf.gz \
--out $HOME/tgoby/xpnsl/selscan/SantaBarbara_NorteHumboldt.chr"$chr" &
done
wait
for chr in {01..22}
do selscan \
--xpnsl \
--vcf $HOME/tgoby/ldhat/data3/SantaBarbara_"$chr".recode.vcf.gz \
--vcf-ref $HOME/tgoby/ldhat/data3/Mendocino_"$chr".recode.vcf.gz \
--out $HOME/tgoby/xpnsl/selscan/SantaBarbara_Mendocino.chr"$chr" &
done


norm \
--xpnsl \
--files  \
$HOME/tgoby/xpnsl/selscan/NorteHumboldt_Mendocino.chr01.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/NorteHumboldt_Mendocino.chr02.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/NorteHumboldt_Mendocino.chr03.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/NorteHumboldt_Mendocino.chr04.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/NorteHumboldt_Mendocino.chr05.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/NorteHumboldt_Mendocino.chr06.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/NorteHumboldt_Mendocino.chr07.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/NorteHumboldt_Mendocino.chr08.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/NorteHumboldt_Mendocino.chr09.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/NorteHumboldt_Mendocino.chr10.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/NorteHumboldt_Mendocino.chr11.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/NorteHumboldt_Mendocino.chr12.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/NorteHumboldt_Mendocino.chr13.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/NorteHumboldt_Mendocino.chr14.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/NorteHumboldt_Mendocino.chr15.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/NorteHumboldt_Mendocino.chr16.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/NorteHumboldt_Mendocino.chr17.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/NorteHumboldt_Mendocino.chr18.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/NorteHumboldt_Mendocino.chr19.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/NorteHumboldt_Mendocino.chr20.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/NorteHumboldt_Mendocino.chr21.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/NorteHumboldt_Mendocino.chr22.xpnsl.out \
--log $HOME/tgoby/xpnsl/selscan/NorteHumboldt_Mendocino.norm.log \
--bp-win

norm \
--xpnsl \
--files  \
$HOME/tgoby/xpnsl/selscan/NorteHumboldt_SantaBarbara.chr01.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/NorteHumboldt_SantaBarbara.chr02.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/NorteHumboldt_SantaBarbara.chr03.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/NorteHumboldt_SantaBarbara.chr04.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/NorteHumboldt_SantaBarbara.chr05.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/NorteHumboldt_SantaBarbara.chr06.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/NorteHumboldt_SantaBarbara.chr07.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/NorteHumboldt_SantaBarbara.chr08.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/NorteHumboldt_SantaBarbara.chr09.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/NorteHumboldt_SantaBarbara.chr10.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/NorteHumboldt_SantaBarbara.chr11.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/NorteHumboldt_SantaBarbara.chr12.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/NorteHumboldt_SantaBarbara.chr13.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/NorteHumboldt_SantaBarbara.chr14.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/NorteHumboldt_SantaBarbara.chr15.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/NorteHumboldt_SantaBarbara.chr16.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/NorteHumboldt_SantaBarbara.chr17.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/NorteHumboldt_SantaBarbara.chr18.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/NorteHumboldt_SantaBarbara.chr19.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/NorteHumboldt_SantaBarbara.chr20.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/NorteHumboldt_SantaBarbara.chr21.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/NorteHumboldt_SantaBarbara.chr22.xpnsl.out \
--log $HOME/tgoby/xpnsl/selscan/NorteHumboldt_SantaBarbara.norm.log \
--bp-win

norm \
--xpnsl \
--files  \
$HOME/tgoby/xpnsl/selscan/Mendocino_SantaBarbara.chr01.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/Mendocino_SantaBarbara.chr02.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/Mendocino_SantaBarbara.chr03.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/Mendocino_SantaBarbara.chr04.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/Mendocino_SantaBarbara.chr05.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/Mendocino_SantaBarbara.chr06.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/Mendocino_SantaBarbara.chr07.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/Mendocino_SantaBarbara.chr08.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/Mendocino_SantaBarbara.chr09.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/Mendocino_SantaBarbara.chr10.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/Mendocino_SantaBarbara.chr11.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/Mendocino_SantaBarbara.chr12.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/Mendocino_SantaBarbara.chr13.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/Mendocino_SantaBarbara.chr14.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/Mendocino_SantaBarbara.chr15.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/Mendocino_SantaBarbara.chr16.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/Mendocino_SantaBarbara.chr17.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/Mendocino_SantaBarbara.chr18.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/Mendocino_SantaBarbara.chr19.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/Mendocino_SantaBarbara.chr20.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/Mendocino_SantaBarbara.chr21.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/Mendocino_SantaBarbara.chr22.xpnsl.out \
--log $HOME/tgoby/xpnsl/selscan/Mendocino_SantaBarbara.norm.log \
--bp-win

norm \
--xpnsl \
--files  \
$HOME/tgoby/xpnsl/selscan/Mendocino_NorteHumboldt.chr01.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/Mendocino_NorteHumboldt.chr02.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/Mendocino_NorteHumboldt.chr03.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/Mendocino_NorteHumboldt.chr04.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/Mendocino_NorteHumboldt.chr05.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/Mendocino_NorteHumboldt.chr06.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/Mendocino_NorteHumboldt.chr07.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/Mendocino_NorteHumboldt.chr08.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/Mendocino_NorteHumboldt.chr09.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/Mendocino_NorteHumboldt.chr10.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/Mendocino_NorteHumboldt.chr11.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/Mendocino_NorteHumboldt.chr12.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/Mendocino_NorteHumboldt.chr13.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/Mendocino_NorteHumboldt.chr14.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/Mendocino_NorteHumboldt.chr15.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/Mendocino_NorteHumboldt.chr16.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/Mendocino_NorteHumboldt.chr17.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/Mendocino_NorteHumboldt.chr18.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/Mendocino_NorteHumboldt.chr19.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/Mendocino_NorteHumboldt.chr20.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/Mendocino_NorteHumboldt.chr21.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/Mendocino_NorteHumboldt.chr22.xpnsl.out \
--log $HOME/tgoby/xpnsl/selscan/Mendocino_NorteHumboldt.norm.log \
--bp-win

norm \
--xpnsl \
--files  \
$HOME/tgoby/xpnsl/selscan/SantaBarbara_NorteHumboldt.chr01.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/SantaBarbara_NorteHumboldt.chr02.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/SantaBarbara_NorteHumboldt.chr03.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/SantaBarbara_NorteHumboldt.chr04.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/SantaBarbara_NorteHumboldt.chr05.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/SantaBarbara_NorteHumboldt.chr06.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/SantaBarbara_NorteHumboldt.chr07.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/SantaBarbara_NorteHumboldt.chr08.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/SantaBarbara_NorteHumboldt.chr09.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/SantaBarbara_NorteHumboldt.chr10.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/SantaBarbara_NorteHumboldt.chr11.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/SantaBarbara_NorteHumboldt.chr12.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/SantaBarbara_NorteHumboldt.chr13.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/SantaBarbara_NorteHumboldt.chr14.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/SantaBarbara_NorteHumboldt.chr15.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/SantaBarbara_NorteHumboldt.chr16.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/SantaBarbara_NorteHumboldt.chr17.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/SantaBarbara_NorteHumboldt.chr18.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/SantaBarbara_NorteHumboldt.chr19.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/SantaBarbara_NorteHumboldt.chr20.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/SantaBarbara_NorteHumboldt.chr21.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/SantaBarbara_NorteHumboldt.chr22.xpnsl.out \
--log $HOME/tgoby/xpnsl/selscan/SantaBarbara_NorteHumboldt.norm.log \
--bp-win

norm \
--xpnsl \
--files  \
$HOME/tgoby/xpnsl/selscan/SantaBarbara_Mendocino.chr01.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/SantaBarbara_Mendocino.chr02.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/SantaBarbara_Mendocino.chr03.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/SantaBarbara_Mendocino.chr04.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/SantaBarbara_Mendocino.chr05.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/SantaBarbara_Mendocino.chr06.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/SantaBarbara_Mendocino.chr07.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/SantaBarbara_Mendocino.chr08.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/SantaBarbara_Mendocino.chr09.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/SantaBarbara_Mendocino.chr10.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/SantaBarbara_Mendocino.chr11.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/SantaBarbara_Mendocino.chr12.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/SantaBarbara_Mendocino.chr13.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/SantaBarbara_Mendocino.chr14.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/SantaBarbara_Mendocino.chr15.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/SantaBarbara_Mendocino.chr16.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/SantaBarbara_Mendocino.chr17.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/SantaBarbara_Mendocino.chr18.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/SantaBarbara_Mendocino.chr19.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/SantaBarbara_Mendocino.chr20.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/SantaBarbara_Mendocino.chr21.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/SantaBarbara_Mendocino.chr22.xpnsl.out \
--log $HOME/tgoby/xpnsl/selscan/SantaBarbara_Mendocino.norm.log \
--bp-win




# unphased
for pop in NorteHumboldt Mendocino SantaBarbara
do for chr in {01..22}
do selscan \
--nsl \
--unphased \
--vcf $HOME/tgoby/ldhat/data3/"$pop"_"$chr".recode.vcf.gz \
--out $HOME/tgoby/nsl/selscan/unphased/"$pop".chr"$chr" &
done; wait; done

norm \
--bins 71 \
--nsl \
--files  \
$HOME/tgoby/nsl/selscan/unphased/NorteHumboldt.chr01.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/NorteHumboldt.chr02.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/NorteHumboldt.chr03.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/NorteHumboldt.chr04.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/NorteHumboldt.chr05.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/NorteHumboldt.chr06.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/NorteHumboldt.chr07.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/NorteHumboldt.chr08.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/NorteHumboldt.chr09.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/NorteHumboldt.chr10.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/NorteHumboldt.chr11.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/NorteHumboldt.chr12.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/NorteHumboldt.chr13.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/NorteHumboldt.chr14.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/NorteHumboldt.chr15.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/NorteHumboldt.chr16.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/NorteHumboldt.chr17.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/NorteHumboldt.chr18.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/NorteHumboldt.chr19.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/NorteHumboldt.chr20.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/NorteHumboldt.chr21.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/NorteHumboldt.chr22.nsl.out \
--log $HOME/tgoby/nsl/selscan/unphased/NorteHumboldt.norm.log \
--bp-win

norm \
--bins 47 \
--nsl \
--files  \
$HOME/tgoby/nsl/selscan/unphased/Mendocino.chr01.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/Mendocino.chr02.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/Mendocino.chr03.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/Mendocino.chr04.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/Mendocino.chr05.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/Mendocino.chr06.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/Mendocino.chr07.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/Mendocino.chr08.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/Mendocino.chr09.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/Mendocino.chr10.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/Mendocino.chr11.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/Mendocino.chr12.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/Mendocino.chr13.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/Mendocino.chr14.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/Mendocino.chr15.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/Mendocino.chr16.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/Mendocino.chr17.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/Mendocino.chr18.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/Mendocino.chr19.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/Mendocino.chr20.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/Mendocino.chr21.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/Mendocino.chr22.nsl.out \
--log $HOME/tgoby/nsl/selscan/unphased/Mendocino.norm.log \
--bp-win

norm \
--bins 47 \
--nsl \
--files  \
$HOME/tgoby/nsl/selscan/unphased/SantaBarbara.chr01.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/SantaBarbara.chr02.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/SantaBarbara.chr03.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/SantaBarbara.chr04.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/SantaBarbara.chr05.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/SantaBarbara.chr06.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/SantaBarbara.chr07.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/SantaBarbara.chr08.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/SantaBarbara.chr09.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/SantaBarbara.chr10.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/SantaBarbara.chr11.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/SantaBarbara.chr12.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/SantaBarbara.chr13.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/SantaBarbara.chr14.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/SantaBarbara.chr15.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/SantaBarbara.chr16.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/SantaBarbara.chr17.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/SantaBarbara.chr18.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/SantaBarbara.chr19.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/SantaBarbara.chr20.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/SantaBarbara.chr21.nsl.out \
$HOME/tgoby/nsl/selscan/unphased/SantaBarbara.chr22.nsl.out \
--log $HOME/tgoby/nsl/selscan/unphased/SantaBarbara.norm.log \
--bp-win

# 
for chr in {01..22}
do selscan \
--xpnsl \
--unphased \
--vcf $HOME/tgoby/ldhat/data3/NorteHumboldt_"$chr".recode.vcf.gz \
--vcf-ref $HOME/tgoby/ldhat/data3/Mendocino_"$chr".recode.vcf.gz \
--out $HOME/tgoby/xpnsl/selscan/unphased/NorteHumboldt_Mendocino.chr"$chr" &
done 
wait
for chr in {01..22}
do selscan \
--xpnsl \
--unphased \
--vcf $HOME/tgoby/ldhat/data3/NorteHumboldt_"$chr".recode.vcf.gz \
--vcf-ref $HOME/tgoby/ldhat/data3/SantaBarbara_"$chr".recode.vcf.gz \
--out $HOME/tgoby/xpnsl/selscan/unphased/NorteHumboldt_SantaBarbara.chr"$chr" &
done
wait
for chr in {01..22}
do selscan \
--xpnsl \
--unphased \
--vcf $HOME/tgoby/ldhat/data3/Mendocino_"$chr".recode.vcf.gz \
--vcf-ref $HOME/tgoby/ldhat/data3/SantaBarbara_"$chr".recode.vcf.gz \
--out $HOME/tgoby/xpnsl/selscan/unphased/Mendocino_SantaBarbara.chr"$chr" &
done


norm \
--xpnsl \
--files  \
$HOME/tgoby/xpnsl/selscan/unphased/NorteHumboldt_Mendocino.chr01.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/NorteHumboldt_Mendocino.chr02.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/NorteHumboldt_Mendocino.chr03.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/NorteHumboldt_Mendocino.chr04.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/NorteHumboldt_Mendocino.chr05.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/NorteHumboldt_Mendocino.chr06.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/NorteHumboldt_Mendocino.chr07.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/NorteHumboldt_Mendocino.chr08.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/NorteHumboldt_Mendocino.chr09.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/NorteHumboldt_Mendocino.chr10.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/NorteHumboldt_Mendocino.chr11.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/NorteHumboldt_Mendocino.chr12.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/NorteHumboldt_Mendocino.chr13.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/NorteHumboldt_Mendocino.chr14.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/NorteHumboldt_Mendocino.chr15.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/NorteHumboldt_Mendocino.chr16.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/NorteHumboldt_Mendocino.chr17.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/NorteHumboldt_Mendocino.chr18.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/NorteHumboldt_Mendocino.chr19.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/NorteHumboldt_Mendocino.chr20.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/NorteHumboldt_Mendocino.chr21.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/NorteHumboldt_Mendocino.chr22.xpnsl.out \
--log $HOME/tgoby/xpnsl/selscan/unphased/NorteHumboldt_Mendocino.norm.log \
--bp-win

norm \
--xpnsl \
--files  \
$HOME/tgoby/xpnsl/selscan/unphased/NorteHumboldt_SantaBarbara.chr01.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/NorteHumboldt_SantaBarbara.chr02.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/NorteHumboldt_SantaBarbara.chr03.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/NorteHumboldt_SantaBarbara.chr04.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/NorteHumboldt_SantaBarbara.chr05.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/NorteHumboldt_SantaBarbara.chr06.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/NorteHumboldt_SantaBarbara.chr07.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/NorteHumboldt_SantaBarbara.chr08.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/NorteHumboldt_SantaBarbara.chr09.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/NorteHumboldt_SantaBarbara.chr10.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/NorteHumboldt_SantaBarbara.chr11.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/NorteHumboldt_SantaBarbara.chr12.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/NorteHumboldt_SantaBarbara.chr13.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/NorteHumboldt_SantaBarbara.chr14.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/NorteHumboldt_SantaBarbara.chr15.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/NorteHumboldt_SantaBarbara.chr16.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/NorteHumboldt_SantaBarbara.chr17.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/NorteHumboldt_SantaBarbara.chr18.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/NorteHumboldt_SantaBarbara.chr19.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/NorteHumboldt_SantaBarbara.chr20.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/NorteHumboldt_SantaBarbara.chr21.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/NorteHumboldt_SantaBarbara.chr22.xpnsl.out \
--log $HOME/tgoby/xpnsl/selscan/unphased/NorteHumboldt_SantaBarbara.norm.log \
--bp-win

norm \
--xpnsl \
--files  \
$HOME/tgoby/xpnsl/selscan/unphased/Mendocino_SantaBarbara.chr01.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/Mendocino_SantaBarbara.chr02.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/Mendocino_SantaBarbara.chr03.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/Mendocino_SantaBarbara.chr04.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/Mendocino_SantaBarbara.chr05.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/Mendocino_SantaBarbara.chr06.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/Mendocino_SantaBarbara.chr07.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/Mendocino_SantaBarbara.chr08.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/Mendocino_SantaBarbara.chr09.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/Mendocino_SantaBarbara.chr10.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/Mendocino_SantaBarbara.chr11.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/Mendocino_SantaBarbara.chr12.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/Mendocino_SantaBarbara.chr13.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/Mendocino_SantaBarbara.chr14.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/Mendocino_SantaBarbara.chr15.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/Mendocino_SantaBarbara.chr16.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/Mendocino_SantaBarbara.chr17.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/Mendocino_SantaBarbara.chr18.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/Mendocino_SantaBarbara.chr19.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/Mendocino_SantaBarbara.chr20.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/Mendocino_SantaBarbara.chr21.xpnsl.out \
$HOME/tgoby/xpnsl/selscan/unphased/Mendocino_SantaBarbara.chr22.xpnsl.out \
--log $HOME/tgoby/xpnsl/selscan/unphased/Mendocino_SantaBarbara.norm.log \
--bp-win




# no MAF filtering
for chr in {01..22}
do xpclr \
--out $HOME/tgoby/xpclr/redo4/NorteHumboldt_Mendocino_$chr.100Kb \
--format "vcf" \
--input $HOME/tgoby/vcf/phased/segregating_sites.recode.vcf.gz \
--samplesA $HOME/tgoby/pops/NorteHumboldt \
--samplesB $HOME/tgoby/pops/Mendocino \
--chr JAPEHO0100000$chr.1 \
--phased \
--size 100000 \
--step 100000 \
--maxsnps 1000 \
--verbose 40 &
done

for chr in {01..22}
do xpclr \
--out $HOME/tgoby/xpclr/redo4/Mendocino_NorteHumboldt_$chr.100Kb \
--format "vcf" \
--input $HOME/tgoby/vcf/phased/segregating_sites.recode.vcf.gz \
--samplesA $HOME/tgoby/pops/Mendocino \
--samplesB $HOME/tgoby/pops/NorteHumboldt \
--chr JAPEHO0100000$chr.1 \
--phased \
--size 100000 \
--step 100000 \
--maxsnps 1000 \
--verbose 40 &
done

for chr in {01..22}
do xpclr \
--out $HOME/tgoby/xpclr/redo4/Mendocino_SantaBarbara_$chr.100Kb \
--format "vcf" \
--input $HOME/tgoby/vcf/phased/segregating_sites.recode.vcf.gz \
--samplesA $HOME/tgoby/pops/Mendocino \
--samplesB $HOME/tgoby/pops/SantaBarbara \
--chr JAPEHO0100000$chr.1 \
--phased \
--size 100000 \
--step 100000 \
--maxsnps 1000 \
--verbose 40 &
done

for chr in {01..22}
do xpclr \
--out $HOME/tgoby/xpclr/redo4/NorteHumboldt_SantaBarbara_$chr.100Kb \
--format "vcf" \
--input $HOME/tgoby/vcf/phased/segregating_sites.recode.vcf.gz \
--samplesA $HOME/tgoby/pops/NorteHumboldt \
--samplesB $HOME/tgoby/pops/SantaBarbara \
--chr JAPEHO0100000$chr.1 \
--phased \
--size 100000 \
--step 100000 \
--maxsnps 1000 \
--verbose 40 &
done

## for chr in {01..22}
## do xpclr \
## --out $HOME/tgoby/xpclr/redo4/NorteHumboldtMendocino_SantaBarbara_$chr.100Kb \
## --format "vcf" \
## --input $HOME/tgoby/vcf/phased/segregating_sites.recode.vcf.gz \
## --samplesA $HOME/tgoby/pops/NorteHumboldt_Mendocino \
## --samplesB $HOME/tgoby/pops/SantaBarbara \
## --chr JAPEHO0100000$chr.1 \
## --phased \
## --size 100000 \
## --step 100000 \
## --maxsnps 1000 \
## --verbose 40 &
## done

for chr in {01..22}
do xpclr \
--out $HOME/tgoby/xpclr/redo4/SantaBarbara_NorteHumboldtMendocino_$chr.100Kb \
--format "vcf" \
--input $HOME/tgoby/vcf/phased/segregating_sites.recode.vcf.gz \
--samplesA $HOME/tgoby/pops/SantaBarbara \
--samplesB $HOME/tgoby/pops/NorteHumboldt_Mendocino \
--chr JAPEHO0100000$chr.1 \
--phased \
--size 100000 \
--step 100000 \
--maxsnps 1000 \
--verbose 40 &
done

for chr in {01..22}
do xpclr \
--out $HOME/tgoby/xpclr/redo4/SantaBarbara_NorteHumboldt_$chr.100Kb \
--format "vcf" \
--input $HOME/tgoby/vcf/phased/segregating_sites.recode.vcf.gz \
--samplesA $HOME/tgoby/pops/SantaBarbara \
--samplesB $HOME/tgoby/pops/NorteHumboldt \
--chr JAPEHO0100000$chr.1 \
--phased \
--size 100000 \
--step 100000 \
--maxsnps 1000 \
--verbose 40 &
done

for chr in {01..22}
do xpclr \
--out $HOME/tgoby/xpclr/redo4/SantaBarbara_Mendocino_$chr.100Kb \
--format "vcf" \
--input $HOME/tgoby/vcf/phased/segregating_sites.recode.vcf.gz \
--samplesA $HOME/tgoby/pops/SantaBarbara \
--samplesB $HOME/tgoby/pops/Mendocino \
--chr JAPEHO0100000$chr.1 \
--phased \
--size 100000 \
--step 100000 \
--maxsnps 1000 \
--verbose 40 &
done





# plot haplotypes at APOL3 gene cluster
# get list of SNPs after 5% MAF
for pop in NorteHumboldt Mendocino SantaBarbara
do for chr in {01..22}
do vcftools \
--chr JAPEHO0100000$chr.1 \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--keep $HOME/tgoby/pops/$pop \
--kept-sites \
--maf 0.05 \
--out $HOME/tgoby/apolipoprotein/"$pop"_"$chr" \
--phased &
done; wait; done


vcftools \
--chr JAPEHO010000013.1 \
--from-bp 19400001 \
--to-bp 19800000 \
--gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz \
--ldhat \
--out $HOME/tgoby/apolipoprotein/chr13_19400001_19800000 \
--phased \
--mac 1



# UCE phylogeny
faToTwoBit \
$HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
$HOME/tgoby1/uces/fEucNew1_0_hap1_genomic/fEucNew1_0_hap1_genomic.2bit

twoBitInfo \
$HOME/tgoby1/uces/fEucNew1_0_hap1_genomic/fEucNew1_0_hap1_genomic.2bit \
$HOME/tgoby1/uces/fEucNew1_0_hap1_genomic/sizes.tab


# align probes to .2bit genomes
phyluce_probe_run_multiple_lastzs_sqlite \
--db uce-genomes.sqlite \
--output uce-genomes-lastz \
--scaffoldlist \
fEucNew1_0_hap1_genomic \
--genome-base-path ./ \
--probefile fish-uce-1k-probes.fasta \
--cores 14 \
--log-path log

# extract UCEs
phyluce_probe_slice_sequence_from_genomes \
--lastz uce-genomes-lastz \
--conf uce-genomes.conf \
--contig_orient \
--flank 1000 \
--name-pattern "fish-uce-1k-probes.fasta_v_{}.lastz.clean" \
--output uce-genomes-fasta \
--log-path log


mv \
$HOME/tgoby1/uces/uce-genomes-fasta/feucnew1_0_hap1_genomic.fasta \
$HOME/tgoby1/uces/uce-genomes-fasta/fEucNew1_0_hap1_genomic.fasta

# get UCE info
grep \
">" \
$HOME/tgoby1/uces/uce-genomes-fasta/fEucNew1_0_hap1_genomic.fasta \
> $HOME/tgoby/uces/fEucNew1_0_hap1_genomic.uces.txt

# Find:		>\w+\|contig:(\w+\.1)\|slice:(\d+)-(\d+)\|uce:(uce-\d+)\|match:\d+-\d+\|orient:{'\+'}\|probes:\d
# Replace: 	vcftools --gzvcf $HOME/tgoby/vcf/phased/snps.vcf.gz --chr \1 --from-bp \2 --to-bp \3 --out $HOME/tgoby/vcf/uces/\4 --recode \& \\

conda activate vcftools

# split by uce
$HOME/tgoby/vcf/uces/get_uce_vcf.sh

# find polymorphic seqs
for i in \
1 2 3 4 5 6 8 9 10 12 13 14 15 16 17 20 21 22 23 24 25 28 29 30 31 32 33 35 36 37 38 39 40 41 43 45 46 47 48 50 52 53 54 55 57 60  \
61 62 63 64 65 66 68 70 71 72 75 77 78 80 82 83 84 85 86 88 89 90 93 94 95 96 97 98 99 100 101 102 103 104 106 107 108 109 110 114  \
115 118 120 121 122 124 125 126 127 129 130 131 132 134 135 136 137 138 141 143 144 145 147 148 149 151 152 154 156 157 160 162 163  \
167 169 170 171 172 173 174 175 176 177 178 180 181 182 184 186 187 188 190 191 192 193 195 196 199 200 201 203 204 205 206 207 208  \
209 210 211 213 214 215 216 217 219 221 222 224 225 226 227 228 229 231 233 236 237 238 240 241 242 243 246 247 249 250 252 254 255  \
256 257 258 259 260 262 264 265 266 267 269 270 271 273 274 275 278 279 280 281 283 284 286 287 288 289 290 291 292 293 294 296 297  \
299 303 304 305 307 308 309 310 311 312 313 314 315 316 317 319 320 321 322 325 326 327 328 329 330 332 333 334 335 338 339 340 341  \
342 344 345 346 347 349 351 353 354 356 357 359 360 361 362 363 364 365 367 368 370 371 372 373 374 375 376 377 379 381 382 383 384  \
385 386 389 391 392 393 394 397 398 401 403 405 406 408 409 411 413 414 415 417 419 420 421 422 423 424 426 428 429 430 432 433 435  \
436 437 439 440 442 443 445 446 447 448 449 450 451 453 454 455 456 457 458 459 462 464 465 466 468 469 470 473 474 476 477 479 480  \
481 482 484 485 486 487 488 489 490 491 493 494 499 502 504 505 506 508 509 510 511 513 515 516 517 518 519 521 522 525 526 527 528  \
529 530 531 532 533 534 535 537 538 539 540 541 542 547 548 549 551 552 553 554 555 556 557 558 559 560 561 562 565 566 567 568 569  \
570 573 575 576 577 579 580 581 585 588 589 590 592 595 596 597 600 601 603 604 605 606 609 610 611 615 616 620 622 624 625 626 629  \
630 631 633 634 635 637 641 643 644 645 646 648 649 651 652 653 654 655 656 659 662 663 667 672 673 674 675 676 678 680 681 682 684  \
685 686 687 688 690 692 693 695 696 698 699 700 701 702 703 705 708 709 710 712 713 715 716 717 718 719 721 725 726 727 728 731 732  \
736 737 739 740 741 742 744 745 748 749 751 752 753 754 756 757 758 759 761 763 764 765 766 768 769 772 773 774 775 777 778 779 780  \
781 785 787 789 790 791 792 795 796 797 799 800 802 803 805 807 808 810 812 813 814 815 816 817 818 819 821 822 823 824 825 826 828  \
830 831 832 833 836 839 841 842 843 844 845 846 847 848 850 851 852 853 854 855 856 857 858 859 860 861 862 863 864 865 866 867 868  \
870 871 873 874 875 876 877 879 880 881 882 883 884 886 887 888 889 890 891 892 893 894 895 897 898 899 900 903 904 906 907 908 909  \
910 913 914 915 916 919 920 921 922 923 924 925 926 927 928 929 930 931 933 934 935 936 937 941 943 944 946 947 948 950 951 952 954  \
956 957 959 960 961 962 963 964 965 966 967 968 969 970 971 972 973 974 976 977 978 979 980 981 982 983 984 986 987 989 990 991 992  \
993 996 997 998 999 1000 1001 1002 1003 1004 1005 1007 1008 1009 1010 1011 1013 1014 1016 1017 1022 1024 1025 1026 1027 1028 1029 1031  \
1032 1036 1037 1038 1040 1042 1043 1044 1046 1047 1049 1052 1053 1054 1055 1057 1060 1061 1062 1064 1065 1066 1067 1068 1070 1071 1072  \
1073 1074 1077 1078 1080 1081 1082 1083 1084 1085 1087 1089 1091 1092 1094 1095 1096 1097 1098 1099 1100 1102 1104 1105 1106 1109 1110  \
1113 1114 1115 1116 1117 1118 1121 1122 1123 1124 1125 1126 1127 1128 1129 1130 1131 1132 1133 1134 1135 1140 1141 1142 1144 1145 1146  \
1147 1149 1150 1151 1153 1155 1156 1157 1158 1160 1164 1167 1170 1171 1172 1173 1175 1176 1177 1179 1180 1181 1182 1184 1185 1186 1187  \
1190 1191 1192 1193 1197 1199 1202 1203 1205 1206 1207 1208 1209 1210 1211 1214 1215 1216 1217 1218 1219 1220 1221 1223 1224 1226 1228  \
1232 1233 1234 1235 1236 1238 1240 1243 1246 1247 1249 1251 1252 1253 1255 1256 1257 1258 1259 1260 1262 1264 1266 1267 1268 1270 1272  \
1273 1275 1276 1278 1279 1282 1283 1285 1286 1287 1288 1289 1290 1291 1292 1293 1294 1295 1296 1297 1298 1300 1301 1302 1304 1305 1306  \
1308 1309 1310 1314 1315 1316 1317 1319 1321 1322 1324 1326 1327 1328 1329 1332 1335 1336 1337 1338 1339 1340 1341 1342
do echo \
-n \
uce-$i'	' \
>> $HOME/tgoby/vcf/uces/uce.log;
grep \
-P \
"After filtering, kept \d* out of a possible 1543714 Sites" \
$HOME/tgoby/vcf/uces/uce-$i.log \
>> $HOME/tgoby/vcf/uces/uce.log
done

# rm invariant seqs
for i in \
8 46 54 55 72 88 106 122 125 132 147 152 154 157 160 180 206 208 242 260 269 292 296 304 307 315 321 353 360 370 386 423 437 442 448 451 \
458 469 473 476 487 490 491 508 519 529 530 538 548 557 558 579 589 603 611 620 622 625 633 651 656 673 674 693 696 701 702 705 709 713 \
728 751 753 777 778 785 789 825 828 833 845 861 889 898 900 908 909 916 935 943 982 987 990 1001 1008 1013 1017 1026 1070 1072 1073 1087 \
1089 1091 1099 1115 1126 1131 1144 1160 1177 1180 1199 1205 1206 1215 1262 1276 1283 1285 1295 1298 1310 1321 1335
do rm $HOME/tgoby/vcf/uces/uce-$i.*
done

cd $HOME/tgoby/vcfR/uces

Rscript $HOME/tgoby/vcfR/uces/Untitled.R

# ML gene trees
# shuffle seqs (to avoid artifact from identical ordering)
for i in $HOME/tgoby/vcfR/uces/fasta/uce-* \
do seqkit shuffle -s $RANDOM $i > "$i"ta
done

for i in {1..28}
do iqtree2 --boot 100 --prefix $HOME/tgoby/vcfR/uces/tre/uce-$i -s $HOME/tgoby/vcfR/uces/fasta/uce-$i.fasta -T 1
done &
for i in {29..56}
do iqtree2 --boot 100 --prefix $HOME/tgoby/vcfR/uces/tre/uce-$i -s $HOME/tgoby/vcfR/uces/fasta/uce-$i.fasta -T 1
done &
for i in {57..84}
do iqtree2 --boot 100 --prefix $HOME/tgoby/vcfR/uces/tre/uce-$i -s $HOME/tgoby/vcfR/uces/fasta/uce-$i.fasta -T 1
done &
for i in {85..112}
do iqtree2 --boot 100 --prefix $HOME/tgoby/vcfR/uces/tre/uce-$i -s $HOME/tgoby/vcfR/uces/fasta/uce-$i.fasta -T 1
done &
for i in {113..140}
do iqtree2 --boot 100 --prefix $HOME/tgoby/vcfR/uces/tre/uce-$i -s $HOME/tgoby/vcfR/uces/fasta/uce-$i.fasta -T 1
done &
for i in {141..168}
do iqtree2 --boot 100 --prefix $HOME/tgoby/vcfR/uces/tre/uce-$i -s $HOME/tgoby/vcfR/uces/fasta/uce-$i.fasta -T 1
done &
for i in {169..196}
do iqtree2 --boot 100 --prefix $HOME/tgoby/vcfR/uces/tre/uce-$i -s $HOME/tgoby/vcfR/uces/fasta/uce-$i.fasta -T 1
done &
for i in {197..224}
do iqtree2 --boot 100 --prefix $HOME/tgoby/vcfR/uces/tre/uce-$i -s $HOME/tgoby/vcfR/uces/fasta/uce-$i.fasta -T 1
done &
for i in {225..252}
do iqtree2 --boot 100 --prefix $HOME/tgoby/vcfR/uces/tre/uce-$i -s $HOME/tgoby/vcfR/uces/fasta/uce-$i.fasta -T 1
done &
for i in {253..280}
do iqtree2 --boot 100 --prefix $HOME/tgoby/vcfR/uces/tre/uce-$i -s $HOME/tgoby/vcfR/uces/fasta/uce-$i.fasta -T 1
done &
for i in {281..308}
do iqtree2 --boot 100 --prefix $HOME/tgoby/vcfR/uces/tre/uce-$i -s $HOME/tgoby/vcfR/uces/fasta/uce-$i.fasta -T 1
done &
for i in {309..336}
do iqtree2 --boot 100 --prefix $HOME/tgoby/vcfR/uces/tre/uce-$i -s $HOME/tgoby/vcfR/uces/fasta/uce-$i.fasta -T 1
done &
for i in {337..364}
do iqtree2 --boot 100 --prefix $HOME/tgoby/vcfR/uces/tre/uce-$i -s $HOME/tgoby/vcfR/uces/fasta/uce-$i.fasta -T 1
done &
for i in {365..392}
do iqtree2 --boot 100 --prefix $HOME/tgoby/vcfR/uces/tre/uce-$i -s $HOME/tgoby/vcfR/uces/fasta/uce-$i.fasta -T 1
done &
for i in {393..420}
do iqtree2 --boot 100 --prefix $HOME/tgoby/vcfR/uces/tre/uce-$i -s $HOME/tgoby/vcfR/uces/fasta/uce-$i.fasta -T 1
done &
for i in {421..448}
do iqtree2 --boot 100 --prefix $HOME/tgoby/vcfR/uces/tre/uce-$i -s $HOME/tgoby/vcfR/uces/fasta/uce-$i.fasta -T 1
done &
for i in {449..476}
do iqtree2 --boot 100 --prefix $HOME/tgoby/vcfR/uces/tre/uce-$i -s $HOME/tgoby/vcfR/uces/fasta/uce-$i.fasta -T 1
done &
for i in {477..504}
do iqtree2 --boot 100 --prefix $HOME/tgoby/vcfR/uces/tre/uce-$i -s $HOME/tgoby/vcfR/uces/fasta/uce-$i.fasta -T 1
done &
for i in {505..532}
do iqtree2 --boot 100 --prefix $HOME/tgoby/vcfR/uces/tre/uce-$i -s $HOME/tgoby/vcfR/uces/fasta/uce-$i.fasta -T 1
done &
for i in {533..560}
do iqtree2 --boot 100 --prefix $HOME/tgoby/vcfR/uces/tre/uce-$i -s $HOME/tgoby/vcfR/uces/fasta/uce-$i.fasta -T 1
done &
for i in {561..588}
do iqtree2 --boot 100 --prefix $HOME/tgoby/vcfR/uces/tre/uce-$i -s $HOME/tgoby/vcfR/uces/fasta/uce-$i.fasta -T 1
done &
for i in {589..616}
do iqtree2 --boot 100 --prefix $HOME/tgoby/vcfR/uces/tre/uce-$i -s $HOME/tgoby/vcfR/uces/fasta/uce-$i.fasta -T 1
done &
for i in {617..644}
do iqtree2 --boot 100 --prefix $HOME/tgoby/vcfR/uces/tre/uce-$i -s $HOME/tgoby/vcfR/uces/fasta/uce-$i.fasta -T 1
done &
for i in {645..672}
do iqtree2 --boot 100 --prefix $HOME/tgoby/vcfR/uces/tre/uce-$i -s $HOME/tgoby/vcfR/uces/fasta/uce-$i.fasta -T 1
done &
for i in {673..700}
do iqtree2 --boot 100 --prefix $HOME/tgoby/vcfR/uces/tre/uce-$i -s $HOME/tgoby/vcfR/uces/fasta/uce-$i.fasta -T 1
done &
for i in {701..728}
do iqtree2 --boot 100 --prefix $HOME/tgoby/vcfR/uces/tre/uce-$i -s $HOME/tgoby/vcfR/uces/fasta/uce-$i.fasta -T 1
done &
for i in {729..756}
do iqtree2 --boot 100 --prefix $HOME/tgoby/vcfR/uces/tre/uce-$i -s $HOME/tgoby/vcfR/uces/fasta/uce-$i.fasta -T 1
done &
for i in {757..784}
do iqtree2 --boot 100 --prefix $HOME/tgoby/vcfR/uces/tre/uce-$i -s $HOME/tgoby/vcfR/uces/fasta/uce-$i.fasta -T 1
done &
for i in {785..812}
do iqtree2 --boot 100 --prefix $HOME/tgoby/vcfR/uces/tre/uce-$i -s $HOME/tgoby/vcfR/uces/fasta/uce-$i.fasta -T 1
done &
for i in {813..840}
do iqtree2 --boot 100 --prefix $HOME/tgoby/vcfR/uces/tre/uce-$i -s $HOME/tgoby/vcfR/uces/fasta/uce-$i.fasta -T 1
done &
for i in {841..868}
do iqtree2 --boot 100 --prefix $HOME/tgoby/vcfR/uces/tre/uce-$i -s $HOME/tgoby/vcfR/uces/fasta/uce-$i.fasta -T 1
done &
for i in {869..896}
do iqtree2 --boot 100 --prefix $HOME/tgoby/vcfR/uces/tre/uce-$i -s $HOME/tgoby/vcfR/uces/fasta/uce-$i.fasta -T 1
done &
for i in {897..924}
do iqtree2 --boot 100 --prefix $HOME/tgoby/vcfR/uces/tre/uce-$i -s $HOME/tgoby/vcfR/uces/fasta/uce-$i.fasta -T 1
done &
for i in {925..952}
do iqtree2 --boot 100 --prefix $HOME/tgoby/vcfR/uces/tre/uce-$i -s $HOME/tgoby/vcfR/uces/fasta/uce-$i.fasta -T 1
done &
for i in {953..980}
do iqtree2 --boot 100 --prefix $HOME/tgoby/vcfR/uces/tre/uce-$i -s $HOME/tgoby/vcfR/uces/fasta/uce-$i.fasta -T 1
done &
for i in {981..1008}
do iqtree2 --boot 100 --prefix $HOME/tgoby/vcfR/uces/tre/uce-$i -s $HOME/tgoby/vcfR/uces/fasta/uce-$i.fasta -T 1
done &
for i in {1009..1036}
do iqtree2 --boot 100 --prefix $HOME/tgoby/vcfR/uces/tre/uce-$i -s $HOME/tgoby/vcfR/uces/fasta/uce-$i.fasta -T 1
done &
for i in {1037..1064}
do iqtree2 --boot 100 --prefix $HOME/tgoby/vcfR/uces/tre/uce-$i -s $HOME/tgoby/vcfR/uces/fasta/uce-$i.fasta -T 1
done &
for i in {1065..1092}
do iqtree2 --boot 100 --prefix $HOME/tgoby/vcfR/uces/tre/uce-$i -s $HOME/tgoby/vcfR/uces/fasta/uce-$i.fasta -T 1
done &
for i in {1093..1120}
do iqtree2 --boot 100 --prefix $HOME/tgoby/vcfR/uces/tre/uce-$i -s $HOME/tgoby/vcfR/uces/fasta/uce-$i.fasta -T 1
done &
for i in {1121..1148}
do iqtree2 --boot 100 --prefix $HOME/tgoby/vcfR/uces/tre/uce-$i -s $HOME/tgoby/vcfR/uces/fasta/uce-$i.fasta -T 1
done &
for i in {1149..1176}
do iqtree2 --boot 100 --prefix $HOME/tgoby/vcfR/uces/tre/uce-$i -s $HOME/tgoby/vcfR/uces/fasta/uce-$i.fasta -T 1
done &
for i in {1177..1204}
do iqtree2 --boot 100 --prefix $HOME/tgoby/vcfR/uces/tre/uce-$i -s $HOME/tgoby/vcfR/uces/fasta/uce-$i.fasta -T 1
done &
for i in {1205..1232}
do iqtree2 --boot 100 --prefix $HOME/tgoby/vcfR/uces/tre/uce-$i -s $HOME/tgoby/vcfR/uces/fasta/uce-$i.fasta -T 1
done &
for i in {1233..1260}
do iqtree2 --boot 100 --prefix $HOME/tgoby/vcfR/uces/tre/uce-$i -s $HOME/tgoby/vcfR/uces/fasta/uce-$i.fasta -T 1
done &
for i in {1261..1288}
do iqtree2 --boot 100 --prefix $HOME/tgoby/vcfR/uces/tre/uce-$i -s $HOME/tgoby/vcfR/uces/fasta/uce-$i.fasta -T 1
done &
for i in {1289..1316}
do iqtree2 --boot 100 --prefix $HOME/tgoby/vcfR/uces/tre/uce-$i -s $HOME/tgoby/vcfR/uces/fasta/uce-$i.fasta -T 1
done &
for i in {1317..1342}
do iqtree2 --boot 100 --prefix $HOME/tgoby/vcfR/uces/tre/uce-$i -s $HOME/tgoby/vcfR/uces/fasta/uce-$i.fasta -T 1
done


cat $HOME/tgoby/vcfR/uces/tre/uce-*.treefile | sed 's%;%;\n%g' > $HOME/tgoby/astral/uces.treefile


astral-hybrid \
-a $HOME/tgoby/astral/uces.hybrid.map2 \
-i $HOME/tgoby/astral/uces.treefile \
-o $HOME/tgoby/astral/uces.astral-hybrid.2 \
-S \
-t 28 \
2> $HOME/tgoby/astral/uces.astral-hybrid.2.log &

nw_reroot -s /Volumes/Tigrigobius/tgoby/astral/uces.astral-hybrid.2 \
2014Paredon02 2014Paredon39 2014Burro15 2014Paredon38 2014Paredon35 2014Burro20 2014Burro16 2014Burro13 2014Burro19 \
2014Burro04 2014Paredon28 2014Paredon18 2017Ynez28 2017Ynez13 2017Ynez25 2017Ynez17 2017Ynez20 2017Ynez14 \
2017Antonio11 2017Antonio22 2017Antonio17 2017Antonio30 2017Antonio29 2017Antonio18 |
nw_order -c n - |
> /Volumes/Tigrigobius/tgoby/astral/uces.astral-hybrid.2.tre

#Find:		(\d{4}\w+\d{2})
#Replace:	\1:0.000001

nw_reroot -d /Volumes/Tigrigobius/tgoby/astral/uces.astral-hybrid.2.tre \
> /Volumes/Tigrigobius/tgoby/astral/uces.astral-hybrid.2.nwk




for i in $(ls *.log)
do echo \
-n \
$i'	' \
>> $HOME/tgoby/vcf/exons/exons.tab;
grep \
-P \
"After filtering, kept \d* out of a possible 1250159 Sites" \
$i \
>> $HOME/tgoby/vcf/exons/exons.tab
done





