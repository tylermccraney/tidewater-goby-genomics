GATK Short Variant Calling Pipeline
================
Tyler McCraney
2022-04-13

#### Convert raw FASTQ to BAM

``` bash
mkdir ~/twg/assemblies
mkdir ~/twg/assemblies/mapped
mkdir ~/twg/assemblies/mapped/2014Burro04
mkdir ~/twg/assemblies/mapped/2014Burro04/logs

java \
-Xmx4G \
-jar ~/miniconda3/envs/picard/share/picard-2.21.2-0/picard.jar \
FastqToSam \
F1=~/twg/reads/X202SC21053023-Z01-F001/raw_data/Burro04/Burro04_CSFP210003881-1a_HJLYTDSX2_L4_1.fq.gz \
F2=~/twg/reads/X202SC21053023-Z01-F001/raw_data/Burro04/Burro04_CSFP210003881-1a_HJLYTDSX2_L4_2.fq.gz \
O=~/twg/assemblies/mapped/2014Burro04/2014Burro04_HJLYTDSX2_L4_fastqtosam.bam \
RG=HJLYTDSX2.4 \
SM=2014Burro04 \
LB=CSFP210003881-1a \
PU=HJLYTDSX2.4.CSFP210003881-1a \
PL=illumina \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> ~/twg/assemblies/mapped/2014Burro04/logs/2014Burro04_HJLYTDSX2_L4_fastqtosam.txt
```

#### 

``` bash
mkdir /home/instr1/twg/assemblies/mapped/2014Burro04/metrics

java \
-Xmx4G \
-jar ~/miniconda3/envs/gatk/share/picard-2.21.2-0/picard.jar \
MarkIlluminaAdapters \
I=~/twg/assemblies/mapped/2014Burro04/2014Burro04_HJLYTDSX2_L4_fastqtosam.bam \
O=/dev/stdout \
M=~/twg/assemblies/mapped/2014Burro04/metrics/2014Burro04_HJLYTDSX2_L4_markilluminaadapters.txt \
COMPRESSION_LEVEL=0 \
QUIET=true \
TMP_DIR=/dev/shm/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> ~/twg/assemblies/mapped/2014Burro04/logs/2014Burro04_HJLYTDSX2_L4_markilluminaadapters.txt |
java \
-Xmx4G \
-jar ~/miniconda3/envs/gatk/share/picard-2.21.2-0/picard.jar \
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
2> ~/twg/assemblies/mapped/2014Burro04/logs/2014Burro04_HJLYTDSX2_L4_samtofastq.txt |
~/miniconda3/envs/gatk/bin/bwa \
mem \
-M \
-t 8 \
-p \
~/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
/dev/stdin \
2> ~/twg/assemblies/mapped/2014Burro04/logs/2014Burro04_HJLYTDSX2_L4_bwamem.txt |
java \
-Xmx4G \
-jar ~/miniconda3/envs/gatk/share/picard-2.21.2-0/picard.jar \
MergeBamAlignment \
ALIGNED=/dev/stdin \
UNMAPPED=~/twg/assemblies/mapped/2014Burro04/2014Burro04_HJLYTDSX2_L4_fastqtosam.bam \
O=~/twg/assemblies/mapped/2014Burro04/2014Burro04_HJLYTDSX2_L4_mergebamalignment.bam \
R=~/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
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
2> ~/twg/assemblies/mapped/2014Burro04/logs/2014Burro04_HJLYTDSX2_L4_mergebamalignment.txt
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

``` bash
```

``` bash
```

``` bash
```

``` bash
```
