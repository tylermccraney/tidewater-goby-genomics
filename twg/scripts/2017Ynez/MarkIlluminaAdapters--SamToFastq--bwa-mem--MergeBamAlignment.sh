#!/bin/bash

source activate gatk

set -o pipefail

java \
-Xmx2G \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MarkIlluminaAdapters \
I=$HOME/twg/assemblies/mapped/2017Ynez13/2017Ynez13_HW7NGDSX2_L3_fastqtosam.bam \
O=/dev/stdout \
M=$HOME/twg/assemblies/mapped/2017Ynez13/metrics/2017Ynez13_HW7NGDSX2_L3_markilluminaadapters.txt \
COMPRESSION_LEVEL=0 \
QUIET=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2017Ynez13/logs/2017Ynez13_HW7NGDSX2_L3_markilluminaadapters.txt |
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
2> $HOME/twg/assemblies/mapped/2017Ynez13/logs/2017Ynez13_HW7NGDSX2_L3_samtofastq.txt |
bwa \
mem \
-M \
-t 8 \
-p \
$HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
/dev/stdin \
2> $HOME/twg/assemblies/mapped/2017Ynez13/logs/2017Ynez13_HW7NGDSX2_L3_bwamem.txt |
java \
-Xmx2G \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MergeBamAlignment \
ALIGNED=/dev/stdin \
UNMAPPED=$HOME/twg/assemblies/mapped/2017Ynez13/2017Ynez13_HW7NGDSX2_L3_fastqtosam.bam \
O=$HOME/twg/assemblies/mapped/2017Ynez13/2017Ynez13_HW7NGDSX2_L3_mergebamalignment.bam \
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
2> $HOME/twg/assemblies/mapped/2017Ynez13/logs/2017Ynez13_HW7NGDSX2_L3_mergebamalignment.txt

##set -o pipefail
##
##java \
##-Xmx2G \
##-XX:ParallelGCThreads=2 \
##-jar \
##$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
##MarkIlluminaAdapters \
##I=$HOME/twg/assemblies/mapped/2017Ynez14/2017Ynez14_HW7NGDSX2_L3_fastqtosam.bam \
##O=/dev/stdout \
##M=$HOME/twg/assemblies/mapped/2017Ynez14/metrics/2017Ynez14_HW7NGDSX2_L3_markilluminaadapters.txt \
##COMPRESSION_LEVEL=0 \
##QUIET=true \
##TMP_DIR=/dev/shm/tmp \
##USE_JDK_DEFLATER=true \
##USE_JDK_INFLATER=true \
##2> $HOME/twg/assemblies/mapped/2017Ynez14/logs/2017Ynez14_HW7NGDSX2_L3_markilluminaadapters.txt |
##java \
##-Xmx2G \
##-XX:ParallelGCThreads=2 \
##-jar \
##$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
##SamToFastq \
##I=/dev/stdin \
##F=/dev/stdout \
##CLIPPING_ATTRIBUTE=XT \
##CLIPPING_ACTION=2 \
##INTERLEAVE=true \
##NON_PF=true \
##COMPRESSION_LEVEL=0 \
##QUIET=true \
##TMP_DIR=/dev/shm/tmp \
##USE_JDK_DEFLATER=true \
##USE_JDK_INFLATER=true \
##2> $HOME/twg/assemblies/mapped/2017Ynez14/logs/2017Ynez14_HW7NGDSX2_L3_samtofastq.txt |
##bwa \
##mem \
##-M \
##-t 4 \
##-p \
##$HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
##/dev/stdin \
##2> $HOME/twg/assemblies/mapped/2017Ynez14/logs/2017Ynez14_HW7NGDSX2_L3_bwamem.txt |
##java \
##-Xmx2G \
##-XX:ParallelGCThreads=2 \
##-jar \
##$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
##MergeBamAlignment \
##ALIGNED=/dev/stdin \
##UNMAPPED=$HOME/twg/assemblies/mapped/2017Ynez14/2017Ynez14_HW7NGDSX2_L3_fastqtosam.bam \
##O=$HOME/twg/assemblies/mapped/2017Ynez14/2017Ynez14_HW7NGDSX2_L3_mergebamalignment.bam \
##R=$HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
##CREATE_INDEX=true \
##ADD_MATE_CIGAR=true \
##CLIP_ADAPTERS=false \
##CLIP_OVERLAPPING_READS=true \
##INCLUDE_SECONDARY_ALIGNMENTS=true \
##MAX_INSERTIONS_OR_DELETIONS=-1 \
##PRIMARY_ALIGNMENT_STRATEGY=MostDistant \
##ATTRIBUTES_TO_RETAIN=XS \
##TMP_DIR=/dev/shm/tmp \
##USE_JDK_DEFLATER=true \
##USE_JDK_INFLATER=true \
##2> $HOME/twg/assemblies/mapped/2017Ynez14/logs/2017Ynez14_HW7NGDSX2_L3_mergebamalignment.txt

set -o pipefail

java \
-Xmx2G \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MarkIlluminaAdapters \
I=$HOME/twg/assemblies/mapped/2017Ynez17/2017Ynez17_HW7NGDSX2_L3_fastqtosam.bam \
O=/dev/stdout \
M=$HOME/twg/assemblies/mapped/2017Ynez17/metrics/2017Ynez17_HW7NGDSX2_L3_markilluminaadapters.txt \
COMPRESSION_LEVEL=0 \
QUIET=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2017Ynez17/logs/2017Ynez17_HW7NGDSX2_L3_markilluminaadapters.txt |
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
2> $HOME/twg/assemblies/mapped/2017Ynez17/logs/2017Ynez17_HW7NGDSX2_L3_samtofastq.txt |
bwa \
mem \
-M \
-t 8 \
-p \
$HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
/dev/stdin \
2> $HOME/twg/assemblies/mapped/2017Ynez17/logs/2017Ynez17_HW7NGDSX2_L3_bwamem.txt |
java \
-Xmx2G \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MergeBamAlignment \
ALIGNED=/dev/stdin \
UNMAPPED=$HOME/twg/assemblies/mapped/2017Ynez17/2017Ynez17_HW7NGDSX2_L3_fastqtosam.bam \
O=$HOME/twg/assemblies/mapped/2017Ynez17/2017Ynez17_HW7NGDSX2_L3_mergebamalignment.bam \
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
2> $HOME/twg/assemblies/mapped/2017Ynez17/logs/2017Ynez17_HW7NGDSX2_L3_mergebamalignment.txt

##set -o pipefail
##
##java \
##-Xmx2G \
##-XX:ParallelGCThreads=2 \
##-jar \
##$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
##MarkIlluminaAdapters \
##I=$HOME/twg/assemblies/mapped/2017Ynez20/2017Ynez20_HVWW2DSX2_L1_fastqtosam.bam \
##O=/dev/stdout \
##M=$HOME/twg/assemblies/mapped/2017Ynez20/metrics/2017Ynez20_HVWW2DSX2_L1_markilluminaadapters.txt \
##COMPRESSION_LEVEL=0 \
##QUIET=true \
##TMP_DIR=/dev/shm/tmp \
##USE_JDK_DEFLATER=true \
##USE_JDK_INFLATER=true \
##2> $HOME/twg/assemblies/mapped/2017Ynez20/logs/2017Ynez20_HVWW2DSX2_L1_markilluminaadapters.txt |
##java \
##-Xmx2G \
##-XX:ParallelGCThreads=2 \
##-jar \
##$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
##SamToFastq \
##I=/dev/stdin \
##F=/dev/stdout \
##CLIPPING_ATTRIBUTE=XT \
##CLIPPING_ACTION=2 \
##INTERLEAVE=true \
##NON_PF=true \
##COMPRESSION_LEVEL=0 \
##QUIET=true \
##TMP_DIR=/dev/shm/tmp \
##USE_JDK_DEFLATER=true \
##USE_JDK_INFLATER=true \
##2> $HOME/twg/assemblies/mapped/2017Ynez20/logs/2017Ynez20_HVWW2DSX2_L1_samtofastq.txt |
##bwa \
##mem \
##-M \
##-t 4 \
##-p \
##$HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
##/dev/stdin \
##2> $HOME/twg/assemblies/mapped/2017Ynez20/logs/2017Ynez20_HVWW2DSX2_L1_bwamem.txt |
##java \
##-Xmx2G \
##-XX:ParallelGCThreads=2 \
##-jar \
##$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
##MergeBamAlignment \
##ALIGNED=/dev/stdin \
##UNMAPPED=$HOME/twg/assemblies/mapped/2017Ynez20/2017Ynez20_HVWW2DSX2_L1_fastqtosam.bam \
##O=$HOME/twg/assemblies/mapped/2017Ynez20/2017Ynez20_HVWW2DSX2_L1_mergebamalignment.bam \
##R=$HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
##CREATE_INDEX=true \
##ADD_MATE_CIGAR=true \
##CLIP_ADAPTERS=false \
##CLIP_OVERLAPPING_READS=true \
##INCLUDE_SECONDARY_ALIGNMENTS=true \
##MAX_INSERTIONS_OR_DELETIONS=-1 \
##PRIMARY_ALIGNMENT_STRATEGY=MostDistant \
##ATTRIBUTES_TO_RETAIN=XS \
##TMP_DIR=/dev/shm/tmp \
##USE_JDK_DEFLATER=true \
##USE_JDK_INFLATER=true \
##2> $HOME/twg/assemblies/mapped/2017Ynez20/logs/2017Ynez20_HVWW2DSX2_L1_mergebamalignment.txt

set -o pipefail

java \
-Xmx2G \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MarkIlluminaAdapters \
I=$HOME/twg/assemblies/mapped/2017Ynez20/2017Ynez20_HW7NGDSX2_L3_fastqtosam.bam \
O=/dev/stdout \
M=$HOME/twg/assemblies/mapped/2017Ynez20/metrics/2017Ynez20_HW7NGDSX2_L3_markilluminaadapters.txt \
COMPRESSION_LEVEL=0 \
QUIET=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2017Ynez20/logs/2017Ynez20_HW7NGDSX2_L3_markilluminaadapters.txt |
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
2> $HOME/twg/assemblies/mapped/2017Ynez20/logs/2017Ynez20_HW7NGDSX2_L3_samtofastq.txt |
bwa \
mem \
-M \
-t 8 \
-p \
$HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
/dev/stdin \
2> $HOME/twg/assemblies/mapped/2017Ynez20/logs/2017Ynez20_HW7NGDSX2_L3_bwamem.txt |
java \
-Xmx2G \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MergeBamAlignment \
ALIGNED=/dev/stdin \
UNMAPPED=$HOME/twg/assemblies/mapped/2017Ynez20/2017Ynez20_HW7NGDSX2_L3_fastqtosam.bam \
O=$HOME/twg/assemblies/mapped/2017Ynez20/2017Ynez20_HW7NGDSX2_L3_mergebamalignment.bam \
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
2> $HOME/twg/assemblies/mapped/2017Ynez20/logs/2017Ynez20_HW7NGDSX2_L3_mergebamalignment.txt

##set -o pipefail
##
##java \
##-Xmx2G \
##-XX:ParallelGCThreads=2 \
##-jar \
##$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
##MarkIlluminaAdapters \
##I=$HOME/twg/assemblies/mapped/2017Ynez25/2017Ynez25_HW7NGDSX2_L2_fastqtosam.bam \
##O=/dev/stdout \
##M=$HOME/twg/assemblies/mapped/2017Ynez25/metrics/2017Ynez25_HW7NGDSX2_L2_markilluminaadapters.txt \
##COMPRESSION_LEVEL=0 \
##QUIET=true \
##TMP_DIR=/dev/shm/tmp \
##USE_JDK_DEFLATER=true \
##USE_JDK_INFLATER=true \
##2> $HOME/twg/assemblies/mapped/2017Ynez25/logs/2017Ynez25_HW7NGDSX2_L2_markilluminaadapters.txt |
##java \
##-Xmx2G \
##-XX:ParallelGCThreads=2 \
##-jar \
##$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
##SamToFastq \
##I=/dev/stdin \
##F=/dev/stdout \
##CLIPPING_ATTRIBUTE=XT \
##CLIPPING_ACTION=2 \
##INTERLEAVE=true \
##NON_PF=true \
##COMPRESSION_LEVEL=0 \
##QUIET=true \
##TMP_DIR=/dev/shm/tmp \
##USE_JDK_DEFLATER=true \
##USE_JDK_INFLATER=true \
##2> $HOME/twg/assemblies/mapped/2017Ynez25/logs/2017Ynez25_HW7NGDSX2_L2_samtofastq.txt |
##bwa \
##mem \
##-M \
##-t 4 \
##-p \
##$HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
##/dev/stdin \
##2> $HOME/twg/assemblies/mapped/2017Ynez25/logs/2017Ynez25_HW7NGDSX2_L2_bwamem.txt |
##java \
##-Xmx2G \
##-XX:ParallelGCThreads=2 \
##-jar \
##$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
##MergeBamAlignment \
##ALIGNED=/dev/stdin \
##UNMAPPED=$HOME/twg/assemblies/mapped/2017Ynez25/2017Ynez25_HW7NGDSX2_L2_fastqtosam.bam \
##O=$HOME/twg/assemblies/mapped/2017Ynez25/2017Ynez25_HW7NGDSX2_L2_mergebamalignment.bam \
##R=$HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
##CREATE_INDEX=true \
##ADD_MATE_CIGAR=true \
##CLIP_ADAPTERS=false \
##CLIP_OVERLAPPING_READS=true \
##INCLUDE_SECONDARY_ALIGNMENTS=true \
##MAX_INSERTIONS_OR_DELETIONS=-1 \
##PRIMARY_ALIGNMENT_STRATEGY=MostDistant \
##ATTRIBUTES_TO_RETAIN=XS \
##TMP_DIR=/dev/shm/tmp \
##USE_JDK_DEFLATER=true \
##USE_JDK_INFLATER=true \
##2> $HOME/twg/assemblies/mapped/2017Ynez25/logs/2017Ynez25_HW7NGDSX2_L2_mergebamalignment.txt
##
##set -o pipefail
##
##java \
##-Xmx2G \
##-XX:ParallelGCThreads=2 \
##-jar \
##$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
##MarkIlluminaAdapters \
##I=$HOME/twg/assemblies/mapped/2017Ynez28/2017Ynez28_HW7NGDSX2_L2_fastqtosam.bam \
##O=/dev/stdout \
##M=$HOME/twg/assemblies/mapped/2017Ynez28/metrics/2017Ynez28_HW7NGDSX2_L2_markilluminaadapters.txt \
##COMPRESSION_LEVEL=0 \
##QUIET=true \
##TMP_DIR=/dev/shm/tmp \
##USE_JDK_DEFLATER=true \
##USE_JDK_INFLATER=true \
##2> $HOME/twg/assemblies/mapped/2017Ynez28/logs/2017Ynez28_HW7NGDSX2_L2_markilluminaadapters.txt |
##java \
##-Xmx2G \
##-XX:ParallelGCThreads=2 \
##-jar \
##$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
##SamToFastq \
##I=/dev/stdin \
##F=/dev/stdout \
##CLIPPING_ATTRIBUTE=XT \
##CLIPPING_ACTION=2 \
##INTERLEAVE=true \
##NON_PF=true \
##COMPRESSION_LEVEL=0 \
##QUIET=true \
##TMP_DIR=/dev/shm/tmp \
##USE_JDK_DEFLATER=true \
##USE_JDK_INFLATER=true \
##2> $HOME/twg/assemblies/mapped/2017Ynez28/logs/2017Ynez28_HW7NGDSX2_L2_samtofastq.txt |
##bwa \
##mem \
##-M \
##-t 4 \
##-p \
##$HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
##/dev/stdin \
##2> $HOME/twg/assemblies/mapped/2017Ynez28/logs/2017Ynez28_HW7NGDSX2_L2_bwamem.txt |
##java \
##-Xmx2G \
##-XX:ParallelGCThreads=2 \
##-jar \
##$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
##MergeBamAlignment \
##ALIGNED=/dev/stdin \
##UNMAPPED=$HOME/twg/assemblies/mapped/2017Ynez28/2017Ynez28_HW7NGDSX2_L2_fastqtosam.bam \
##O=$HOME/twg/assemblies/mapped/2017Ynez28/2017Ynez28_HW7NGDSX2_L2_mergebamalignment.bam \
##R=$HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
##CREATE_INDEX=true \
##ADD_MATE_CIGAR=true \
##CLIP_ADAPTERS=false \
##CLIP_OVERLAPPING_READS=true \
##INCLUDE_SECONDARY_ALIGNMENTS=true \
##MAX_INSERTIONS_OR_DELETIONS=-1 \
##PRIMARY_ALIGNMENT_STRATEGY=MostDistant \
##ATTRIBUTES_TO_RETAIN=XS \
##TMP_DIR=/dev/shm/tmp \
##USE_JDK_DEFLATER=true \
##USE_JDK_INFLATER=true \
##2> $HOME/twg/assemblies/mapped/2017Ynez28/logs/2017Ynez28_HW7NGDSX2_L2_mergebamalignment.txt
