GATK Short Variant Calling Pipeline
================
Tyler McCraney
2022-04-13

#### Convert raw FASTQ to unmapped BAM

``` bash
mkdir $HOME/twg/assemblies
mkdir $HOME/twg/assemblies/mapped
mkdir $HOME/twg/assemblies/mapped/2014Burro04
mkdir $HOME/twg/assemblies/mapped/2014Burro04/logs

java \
-Xmx4G \
-jar $HOME/miniconda3/envs/picard/share/picard-2.21.2-0/picard.jar \
FastqToSam \
F1=$HOME/twg/reads/X202SC21053023-Z01-F001/raw_data/Burro04/Burro04_CSFP210003881-1a_HJLYTDSX2_L4_1.fq.gz \
F2=$HOME/twg/reads/X202SC21053023-Z01-F001/raw_data/Burro04/Burro04_CSFP210003881-1a_HJLYTDSX2_L4_2.fq.gz \
O=$HOME/twg/assemblies/mapped/2014Burro04/2014Burro04_HJLYTDSX2_L4_fastqtosam.bam \
RG=HJLYTDSX2.4 \
SM=2014Burro04 \
LB=CSFP210003881-1a \
PU=HJLYTDSX2.4.CSFP210003881-1a \
PL=illumina \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2014Burro04/logs/2014Burro04_HJLYTDSX2_L4_fastqtosam.txt
```

#### QC then map/align to reference genome

###### *MarkIlluminaAdapters \| SamToFastq \| BWA-MEM \| MergeBamAlignment*

``` bash
mkdir $HOME/twg/assemblies/mapped/2014Burro04/metrics

set -o pipefail

java \
-Xmx4G \
-jar $HOME/miniconda3/envs/gatk/share/picard-2.21.2-0/picard.jar \
MarkIlluminaAdapters \
I=$HOME/twg/assemblies/mapped/2014Burro04/2014Burro04_HJLYTDSX2_L4_fastqtosam.bam \
O=/dev/stdout \
M=$HOME/twg/assemblies/mapped/2014Burro04/metrics/2014Burro04_HJLYTDSX2_L4_markilluminaadapters.txt \
COMPRESSION_LEVEL=0 \
QUIET=true \
TMP_DIR=/dev/shm/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2014Burro04/logs/2014Burro04_HJLYTDSX2_L4_markilluminaadapters.txt |
java \
-Xmx4G \
-jar $HOME/miniconda3/envs/gatk/share/picard-2.21.2-0/picard.jar \
SamToFastq \
I=/dev/stdin \
F=/dev/stdout \
CLIPPING_ATTRIBUTE=XT \
CLIPPING_ACTION=2 \
INTERLEAVE=true \
NON_PF=true \
COMPRESSION_LEVEL=0 \
QUIET=true \
TMP_DIR=/dev/shm/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2014Burro04/logs/2014Burro04_HJLYTDSX2_L4_samtofastq.txt |
$HOME/miniconda3/envs/gatk/bin/bwa mem \
-M \
-t 8 \
-p \
$HOME/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
/dev/stdin \
2> $HOME/twg/assemblies/mapped/2014Burro04/logs/2014Burro04_HJLYTDSX2_L4_bwamem.txt |
java \
-Xmx4G \
-jar $HOME/miniconda3/envs/gatk/share/picard-2.21.2-0/picard.jar \
MergeBamAlignment \
ALIGNED=/dev/stdin \
UNMAPPED=$HOME/twg/assemblies/mapped/2014Burro04/2014Burro04_HJLYTDSX2_L4_fastqtosam.bam \
O=$HOME/twg/assemblies/mapped/2014Burro04/2014Burro04_HJLYTDSX2_L4_mergebamalignment.bam \
R=$HOME/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
CREATE_INDEX=true \
ADD_MATE_CIGAR=true \
CLIP_ADAPTERS=false \
CLIP_OVERLAPPING_READS=true \
INCLUDE_SECONDARY_ALIGNMENTS=true \
MAX_INSERTIONS_OR_DELETIONS=-1 \
PRIMARY_ALIGNMENT_STRATEGY=MostDistant \
ATTRIBUTES_TO_RETAIN=XS \
TMP_DIR=/dev/shm/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2014Burro04/logs/2014Burro04_HJLYTDSX2_L4_mergebamalignment.txt
```

#### More QC

###### *MarkDuplicates \| SortSam*

``` bash
set -o pipefail

java \
-Xmx2G \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=2 \
-jar $HOME/apps/picard/build/libs/picard.jar \
MarkDuplicates \
I=$HOME/twg/assemblies/mapped/2014Burro04/2014Burro04_HJLYTDSX2_L4_mergebamalignment.bam \
O=/dev/stdout \
M=$HOME/twg/assemblies/mapped/2014Burro04/metrics/2014Burro04_markduplicates.txt \
MAX_FILE_HANDLES=1000 \
OPTICAL_DUPLICATE_PIXEL_DISTANCE=2500 \
COMPRESSION_LEVEL=0 \
QUIET=true \
TMP_DIR=/dev/shm/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2014Burro04/logs/2014Burro04_markduplicates.txt | 
java \
-Xmx10G \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=2 \
-jar $HOME/apps/picard/build/libs/picard.jar \
SortSam \
I=/dev/stdin \
O=$HOME/twg/assemblies/mapped/2014Burro04/2014Burro04_sortsam.bam \
SO=coordinate \
CREATE_INDEX=true \
TMP_DIR=/dev/shm/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2014Burro04/logs/2014Burro04_sortsam.txt
```

#### Call variants

``` bash
gatk \
--java-options "-Djava.io.tmpdir=/dev/shm/tmp -Djava.library.path=/home/instr1/miniconda3/envs/gatk/lib -Xmx4G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
HaplotypeCaller \
--input $HOME/twg/assemblies/mapped/2014Burro04/2014Burro04_sortsam.bam \
--output $HOME/twg/assemblies/mapped/2014Burro04/2014Burro04_haplotypecaller.g.vcf.gz \
--reference $HOME/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--pair-hmm-implementation VSX_LOGLESS_CACHING \
--native-pair-hmm-threads 8 \
--emit-ref-confidence GVCF \
--use-jdk-deflater \
--use-jdk-inflater \
2> $HOME/twg/assemblies/mapped/2014Burro04/logs/2014Burro04_haplotypecaller.g.vcf.txt
```

#### Revise block compression format to decrease gVCF file size

``` bash
$HOME/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant $HOME/twg/assemblies/mapped/2014Burro04/2014Burro04_haplotypecaller.g.vcf.gz \
--output $HOME/twg/assemblies/mapped/2014Burro04/2014Burro04_reblock.g.vcf.gz \
--reference $HOME/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> $HOME/twg/assemblies/mapped/2014Burro04/logs/2014Burro04_reblock.g.vcf.txt
```

#### Combine individual gVCF files with a ‘snowball’ strategy

``` bash
mkdir $HOME/twg/variants
mkdir $HOME/twg/variants/logs

$HOME/apps/gatk/gatk \
--java-options "-Dsamjdk.use_async_io_read_samtools=true -Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=2" \
CombineGVCFs \
--variant $HOME/twg/assemblies/mapped/2014Burro04/2014Burro04_reblock.g.vcf.gz \
--variant $HOME/twg/assemblies/mapped/2014Burro13/2014Burro13_reblock.g.vcf.gz \
--variant $HOME/twg/assemblies/mapped/2014Burro15/2014Burro15_reblock.g.vcf.gz \
--variant $HOME/twg/assemblies/mapped/2014Burro16/2014Burro16_reblock.g.vcf.gz \
--variant $HOME/twg/assemblies/mapped/2014Burro19/2014Burro19_reblock.g.vcf.gz \
--variant $HOME/twg/assemblies/mapped/2014Burro20/2014Burro20_reblock.g.vcf.gz \
--output $HOME/twg/variants/2014Burro_combine.g.vcf.gz \
--reference $HOME/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--seconds-between-progress-updates 60 \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> $HOME/twg/variants/logs/2014Burro_combine.g.vcf.txt

$HOME/apps/gatk/gatk \
--java-options "-Dsamjdk.use_async_io_read_samtools=true -Xmx6G -XX:+UseParallelGC -XX:ParallelGCThreads=2" \
CombineGVCFs \
--variant $HOME/twg/variants/2014Burro_combine.g.vcf.gz \
--variant $HOME/twg/variants/2014Paredon_combine.g.vcf.gz \
--output $HOME/twg/variants/2014BurroParedon_combine.g.vcf.gz \
--reference $HOME/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--seconds-between-progress-updates 60 \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> $HOME/twg/variants/logs/2014BurroParedon_combine.g.vcf.txt
```

``` bash
```

``` bash
```

``` bash
```

``` bash
```

``` bash
```
