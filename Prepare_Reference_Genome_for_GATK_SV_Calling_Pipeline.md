Prepare Reference Genome for GATK SV Calling Pipeline
================
Tyler McCraney
2022-04-13

#### The reference genome assembly needs to be indexed and dictionaried before it can be used in GATK SV calling pipeline

``` bash
gunzip $HOME/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta.gz

bwa \
index \
-a bwtsw \
$HOME/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
2> $HOME/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.log

java \
-Xmx10G \
-jar \
$HOME/miniconda3/envs/picard/share/picard-2.21.2-0/picard.jar \
CreateSequenceDictionary \
R=$HOME/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
O=$HOME/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta.dict \
2>> $HOME/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.log

samtools \
faidx \
$HOME/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
2>> $HOME/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.log

# HaplotypeCaller wants "fEucNew1.0.p_ctg.dict" (not "fEucNew1.0.p_ctg.fasta.dict")
cp \
$HOME/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta.dict \
$HOME/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.dict
```

#### Split reference genome into equal-sized intervals to use a scatter-gather strategy

###### This is optional but can really speed-up the GATK SV calling pipeline

``` bash
java \
-Xmx1G \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=1 \
-jar $HOME/apps/picard/build/libs/picard.jar \
ScatterIntervalsByNs \
R=$HOME/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
O=$HOME/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.interval_list \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2>> $HOME/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.log

$HOME/apps/gatk/gatk \
--java-options "-Djava.io.tmpdir=/dev/shm/tmp -Xmx1G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
SplitIntervals \
--reference $HOME/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--output $HOME/twg/assemblies/reference/fEucNew1.0/intervals \
--intervals $HOME/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.interval_list \
--scatter-count 40 \
--subdivision-mode BALANCING_WITHOUT_INTERVAL_SUBDIVISION_WITH_OVERFLOW \
--interval-merging-rule OVERLAPPING_ONLY \
--use-jdk-deflater \
--use-jdk-inflater \
2>> $HOME/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.log
```

``` bash
```
