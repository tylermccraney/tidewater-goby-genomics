#!/bin/bash

source activate gatk

set -o pipefail

java \
-Xmx2G \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MarkIlluminaAdapters \
I=$HOME/twg/assemblies/mapped/2021Virgin02/2021Virgin02_HW7NGDSX2_L2_fastqtosam.bam \
O=/dev/stdout \
M=$HOME/twg/assemblies/mapped/2021Virgin02/metrics/2021Virgin02_HW7NGDSX2_L2_markilluminaadapters.txt \
COMPRESSION_LEVEL=0 \
QUIET=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2021Virgin02/logs/2021Virgin02_HW7NGDSX2_L2_markilluminaadapters.txt |
java \
-Xmx2G \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
SamToFastq \
I=/dev/stdin \
F=/dev/stdout \
CLIPPING_ATTRIBUTE=XT \
CLIPPING_ACTION=2 \
INTERLEAVE=true \
NON_PF=true \
COMPRESSION_LEVEL=0 \
QUIET=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2021Virgin02/logs/2021Virgin02_HW7NGDSX2_L2_samtofastq.txt |
bwa \
mem \
-M \
-t 8 \
-p \
$HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
/dev/stdin \
2> $HOME/twg/assemblies/mapped/2021Virgin02/logs/2021Virgin02_HW7NGDSX2_L2_bwamem.txt |
java \
-Xmx2G \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MergeBamAlignment \
ALIGNED=/dev/stdin \
UNMAPPED=$HOME/twg/assemblies/mapped/2021Virgin02/2021Virgin02_HW7NGDSX2_L2_fastqtosam.bam \
O=$HOME/twg/assemblies/mapped/2021Virgin02/2021Virgin02_HW7NGDSX2_L2_mergebamalignment.bam \
R=$HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
CREATE_INDEX=true \
ADD_MATE_CIGAR=true \
CLIP_ADAPTERS=false \
CLIP_OVERLAPPING_READS=true \
INCLUDE_SECONDARY_ALIGNMENTS=true \
MAX_INSERTIONS_OR_DELETIONS=-1 \
PRIMARY_ALIGNMENT_STRATEGY=MostDistant \
ATTRIBUTES_TO_RETAIN=XS \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2021Virgin02/logs/2021Virgin02_HW7NGDSX2_L2_mergebamalignment.txt

set -o pipefail

java \
-Xmx2G \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MarkIlluminaAdapters \
I=$HOME/twg/assemblies/mapped/2021Virgin08/2021Virgin08_HW7NGDSX2_L2_fastqtosam.bam \
O=/dev/stdout \
M=$HOME/twg/assemblies/mapped/2021Virgin08/metrics/2021Virgin08_HW7NGDSX2_L2_markilluminaadapters.txt \
COMPRESSION_LEVEL=0 \
QUIET=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2021Virgin08/logs/2021Virgin08_HW7NGDSX2_L2_markilluminaadapters.txt |
java \
-Xmx2G \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
SamToFastq \
I=/dev/stdin \
F=/dev/stdout \
CLIPPING_ATTRIBUTE=XT \
CLIPPING_ACTION=2 \
INTERLEAVE=true \
NON_PF=true \
COMPRESSION_LEVEL=0 \
QUIET=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2021Virgin08/logs/2021Virgin08_HW7NGDSX2_L2_samtofastq.txt |
bwa \
mem \
-M \
-t 8 \
-p \
$HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
/dev/stdin \
2> $HOME/twg/assemblies/mapped/2021Virgin08/logs/2021Virgin08_HW7NGDSX2_L2_bwamem.txt |
java \
-Xmx2G \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MergeBamAlignment \
ALIGNED=/dev/stdin \
UNMAPPED=$HOME/twg/assemblies/mapped/2021Virgin08/2021Virgin08_HW7NGDSX2_L2_fastqtosam.bam \
O=$HOME/twg/assemblies/mapped/2021Virgin08/2021Virgin08_HW7NGDSX2_L2_mergebamalignment.bam \
R=$HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
CREATE_INDEX=true \
ADD_MATE_CIGAR=true \
CLIP_ADAPTERS=false \
CLIP_OVERLAPPING_READS=true \
INCLUDE_SECONDARY_ALIGNMENTS=true \
MAX_INSERTIONS_OR_DELETIONS=-1 \
PRIMARY_ALIGNMENT_STRATEGY=MostDistant \
ATTRIBUTES_TO_RETAIN=XS \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2021Virgin08/logs/2021Virgin08_HW7NGDSX2_L2_mergebamalignment.txt

set -o pipefail

java \
-Xmx2G \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MarkIlluminaAdapters \
I=$HOME/twg/assemblies/mapped/2021Virgin09/2021Virgin09_HW7NGDSX2_L2_fastqtosam.bam \
O=/dev/stdout \
M=$HOME/twg/assemblies/mapped/2021Virgin09/metrics/2021Virgin09_HW7NGDSX2_L2_markilluminaadapters.txt \
COMPRESSION_LEVEL=0 \
QUIET=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2021Virgin09/logs/2021Virgin09_HW7NGDSX2_L2_markilluminaadapters.txt |
java \
-Xmx2G \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
SamToFastq \
I=/dev/stdin \
F=/dev/stdout \
CLIPPING_ATTRIBUTE=XT \
CLIPPING_ACTION=2 \
INTERLEAVE=true \
NON_PF=true \
COMPRESSION_LEVEL=0 \
QUIET=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2021Virgin09/logs/2021Virgin09_HW7NGDSX2_L2_samtofastq.txt |
bwa \
mem \
-M \
-t 8 \
-p \
$HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
/dev/stdin \
2> $HOME/twg/assemblies/mapped/2021Virgin09/logs/2021Virgin09_HW7NGDSX2_L2_bwamem.txt |
java \
-Xmx2G \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MergeBamAlignment \
ALIGNED=/dev/stdin \
UNMAPPED=$HOME/twg/assemblies/mapped/2021Virgin09/2021Virgin09_HW7NGDSX2_L2_fastqtosam.bam \
O=$HOME/twg/assemblies/mapped/2021Virgin09/2021Virgin09_HW7NGDSX2_L2_mergebamalignment.bam \
R=$HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
CREATE_INDEX=true \
ADD_MATE_CIGAR=true \
CLIP_ADAPTERS=false \
CLIP_OVERLAPPING_READS=true \
INCLUDE_SECONDARY_ALIGNMENTS=true \
MAX_INSERTIONS_OR_DELETIONS=-1 \
PRIMARY_ALIGNMENT_STRATEGY=MostDistant \
ATTRIBUTES_TO_RETAIN=XS \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2021Virgin09/logs/2021Virgin09_HW7NGDSX2_L2_mergebamalignment.txt

set -o pipefail

java \
-Xmx2G \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MarkIlluminaAdapters \
I=$HOME/twg/assemblies/mapped/2021Virgin13/2021Virgin13_H7VKWDSX3_L2_fastqtosam.bam \
O=/dev/stdout \
M=$HOME/twg/assemblies/mapped/2021Virgin13/metrics/2021Virgin13_H7VKWDSX3_L2_markilluminaadapters.txt \
COMPRESSION_LEVEL=0 \
QUIET=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2021Virgin13/logs/2021Virgin13_H7VKWDSX3_L2_markilluminaadapters.txt |
java \
-Xmx2G \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
SamToFastq \
I=/dev/stdin \
F=/dev/stdout \
CLIPPING_ATTRIBUTE=XT \
CLIPPING_ACTION=2 \
INTERLEAVE=true \
NON_PF=true \
COMPRESSION_LEVEL=0 \
QUIET=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2021Virgin13/logs/2021Virgin13_H7VKWDSX3_L2_samtofastq.txt |
bwa \
mem \
-M \
-t 8 \
-p \
$HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
/dev/stdin \
2> $HOME/twg/assemblies/mapped/2021Virgin13/logs/2021Virgin13_H7VKWDSX3_L2_bwamem.txt |
java \
-Xmx2G \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MergeBamAlignment \
ALIGNED=/dev/stdin \
UNMAPPED=$HOME/twg/assemblies/mapped/2021Virgin13/2021Virgin13_H7VKWDSX3_L2_fastqtosam.bam \
O=$HOME/twg/assemblies/mapped/2021Virgin13/2021Virgin13_H7VKWDSX3_L2_mergebamalignment.bam \
R=$HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
CREATE_INDEX=true \
ADD_MATE_CIGAR=true \
CLIP_ADAPTERS=false \
CLIP_OVERLAPPING_READS=true \
INCLUDE_SECONDARY_ALIGNMENTS=true \
MAX_INSERTIONS_OR_DELETIONS=-1 \
PRIMARY_ALIGNMENT_STRATEGY=MostDistant \
ATTRIBUTES_TO_RETAIN=XS \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2021Virgin13/logs/2021Virgin13_H7VKWDSX3_L2_mergebamalignment.txt

set -o pipefail

java \
-Xmx2G \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MarkIlluminaAdapters \
I=$HOME/twg/assemblies/mapped/2021Virgin16/2021Virgin16_H7VKWDSX3_L2_fastqtosam.bam \
O=/dev/stdout \
M=$HOME/twg/assemblies/mapped/2021Virgin16/metrics/2021Virgin16_H7VKWDSX3_L2_markilluminaadapters.txt \
COMPRESSION_LEVEL=0 \
QUIET=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2021Virgin16/logs/2021Virgin16_H7VKWDSX3_L2_markilluminaadapters.txt |
java \
-Xmx2G \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
SamToFastq \
I=/dev/stdin \
F=/dev/stdout \
CLIPPING_ATTRIBUTE=XT \
CLIPPING_ACTION=2 \
INTERLEAVE=true \
NON_PF=true \
COMPRESSION_LEVEL=0 \
QUIET=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2021Virgin16/logs/2021Virgin16_H7VKWDSX3_L2_samtofastq.txt |
bwa \
mem \
-M \
-t 8 \
-p \
$HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
/dev/stdin \
2> $HOME/twg/assemblies/mapped/2021Virgin16/logs/2021Virgin16_H7VKWDSX3_L2_bwamem.txt |
java \
-Xmx2G \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MergeBamAlignment \
ALIGNED=/dev/stdin \
UNMAPPED=$HOME/twg/assemblies/mapped/2021Virgin16/2021Virgin16_H7VKWDSX3_L2_fastqtosam.bam \
O=$HOME/twg/assemblies/mapped/2021Virgin16/2021Virgin16_H7VKWDSX3_L2_mergebamalignment.bam \
R=$HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
CREATE_INDEX=true \
ADD_MATE_CIGAR=true \
CLIP_ADAPTERS=false \
CLIP_OVERLAPPING_READS=true \
INCLUDE_SECONDARY_ALIGNMENTS=true \
MAX_INSERTIONS_OR_DELETIONS=-1 \
PRIMARY_ALIGNMENT_STRATEGY=MostDistant \
ATTRIBUTES_TO_RETAIN=XS \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2021Virgin16/logs/2021Virgin16_H7VKWDSX3_L2_mergebamalignment.txt

set -o pipefail

java \
-Xmx2G \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MarkIlluminaAdapters \
I=$HOME/twg/assemblies/mapped/2021Virgin17/2021Virgin17_HW7NGDSX2_L2_fastqtosam.bam \
O=/dev/stdout \
M=$HOME/twg/assemblies/mapped/2021Virgin17/metrics/2021Virgin17_HW7NGDSX2_L2_markilluminaadapters.txt \
COMPRESSION_LEVEL=0 \
QUIET=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2021Virgin17/logs/2021Virgin17_HW7NGDSX2_L2_markilluminaadapters.txt |
java \
-Xmx2G \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
SamToFastq \
I=/dev/stdin \
F=/dev/stdout \
CLIPPING_ATTRIBUTE=XT \
CLIPPING_ACTION=2 \
INTERLEAVE=true \
NON_PF=true \
COMPRESSION_LEVEL=0 \
QUIET=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2021Virgin17/logs/2021Virgin17_HW7NGDSX2_L2_samtofastq.txt |
bwa \
mem \
-M \
-t 8 \
-p \
$HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
/dev/stdin \
2> $HOME/twg/assemblies/mapped/2021Virgin17/logs/2021Virgin17_HW7NGDSX2_L2_bwamem.txt |
java \
-Xmx2G \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MergeBamAlignment \
ALIGNED=/dev/stdin \
UNMAPPED=$HOME/twg/assemblies/mapped/2021Virgin17/2021Virgin17_HW7NGDSX2_L2_fastqtosam.bam \
O=$HOME/twg/assemblies/mapped/2021Virgin17/2021Virgin17_HW7NGDSX2_L2_mergebamalignment.bam \
R=$HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
CREATE_INDEX=true \
ADD_MATE_CIGAR=true \
CLIP_ADAPTERS=false \
CLIP_OVERLAPPING_READS=true \
INCLUDE_SECONDARY_ALIGNMENTS=true \
MAX_INSERTIONS_OR_DELETIONS=-1 \
PRIMARY_ALIGNMENT_STRATEGY=MostDistant \
ATTRIBUTES_TO_RETAIN=XS \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2021Virgin17/logs/2021Virgin17_HW7NGDSX2_L2_mergebamalignment.txt
