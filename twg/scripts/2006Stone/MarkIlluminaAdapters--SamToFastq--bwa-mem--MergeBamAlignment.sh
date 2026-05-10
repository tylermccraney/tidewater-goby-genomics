#!/bin/bash

source activate gatk

##set -o pipefail
##
##java \
##-Xmx2G \
##-XX:ParallelGCThreads=2 \
##-jar \
##$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
##MarkIlluminaAdapters \
##I=$HOME/twg/assemblies/mapped/2006Stone03/2006Stone03_HJLYTDSX2_L4_fastqtosam.bam \
##O=/dev/stdout \
##M=$HOME/twg/assemblies/mapped/2006Stone03/metrics/2006Stone03_HJLYTDSX2_L4_markilluminaadapters.txt \
##COMPRESSION_LEVEL=0 \
##QUIET=true \
##TMP_DIR=/dev/shm/tmp \
##USE_JDK_DEFLATER=true \
##USE_JDK_INFLATER=true \
##2> $HOME/twg/assemblies/mapped/2006Stone03/logs/2006Stone03_HJLYTDSX2_L4_markilluminaadapters.txt |
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
##2> $HOME/twg/assemblies/mapped/2006Stone03/logs/2006Stone03_HJLYTDSX2_L4_samtofastq.txt |
##bwa \
##mem \
##-M \
##-t 4 \
##-p \
##$HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
##/dev/stdin \
##2> $HOME/twg/assemblies/mapped/2006Stone03/logs/2006Stone03_HJLYTDSX2_L4_bwamem.txt |
##java \
##-Xmx2G \
##-XX:ParallelGCThreads=2 \
##-jar \
##$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
##MergeBamAlignment \
##ALIGNED=/dev/stdin \
##UNMAPPED=$HOME/twg/assemblies/mapped/2006Stone03/2006Stone03_HJLYTDSX2_L4_fastqtosam.bam \
##O=$HOME/twg/assemblies/mapped/2006Stone03/2006Stone03_HJLYTDSX2_L4_mergebamalignment.bam \
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
##2> $HOME/twg/assemblies/mapped/2006Stone03/logs/2006Stone03_HJLYTDSX2_L4_mergebamalignment.txt
##
##set -o pipefail
##
##java \
##-Xmx2G \
##-XX:ParallelGCThreads=2 \
##-jar \
##$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
##MarkIlluminaAdapters \
##I=$HOME/twg/assemblies/mapped/2006Stone09/2006Stone09_HJLYTDSX2_L4_fastqtosam.bam \
##O=/dev/stdout \
##M=$HOME/twg/assemblies/mapped/2006Stone09/metrics/2006Stone09_HJLYTDSX2_L4_markilluminaadapters.txt \
##COMPRESSION_LEVEL=0 \
##QUIET=true \
##TMP_DIR=/dev/shm/tmp \
##USE_JDK_DEFLATER=true \
##USE_JDK_INFLATER=true \
##2> $HOME/twg/assemblies/mapped/2006Stone09/logs/2006Stone09_HJLYTDSX2_L4_markilluminaadapters.txt |
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
##2> $HOME/twg/assemblies/mapped/2006Stone09/logs/2006Stone09_HJLYTDSX2_L4_samtofastq.txt |
##bwa \
##mem \
##-M \
##-t 4 \
##-p \
##$HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
##/dev/stdin \
##2> $HOME/twg/assemblies/mapped/2006Stone09/logs/2006Stone09_HJLYTDSX2_L4_bwamem.txt |
##java \
##-Xmx2G \
##-XX:ParallelGCThreads=2 \
##-jar \
##$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
##MergeBamAlignment \
##ALIGNED=/dev/stdin \
##UNMAPPED=$HOME/twg/assemblies/mapped/2006Stone09/2006Stone09_HJLYTDSX2_L4_fastqtosam.bam \
##O=$HOME/twg/assemblies/mapped/2006Stone09/2006Stone09_HJLYTDSX2_L4_mergebamalignment.bam \
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
##2> $HOME/twg/assemblies/mapped/2006Stone09/logs/2006Stone09_HJLYTDSX2_L4_mergebamalignment.txt

set -o pipefail

java \
-Xmx2G \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MarkIlluminaAdapters \
I=$HOME/twg/assemblies/mapped/2006Stone30/2006Stone30_HVWV2DSX2_L3_fastqtosam.bam \
O=/dev/stdout \
M=$HOME/twg/assemblies/mapped/2006Stone30/metrics/2006Stone30_HVWV2DSX2_L3_markilluminaadapters.txt \
COMPRESSION_LEVEL=0 \
QUIET=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2006Stone30/logs/2006Stone30_HVWV2DSX2_L3_markilluminaadapters.txt |
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
2> $HOME/twg/assemblies/mapped/2006Stone30/logs/2006Stone30_HVWV2DSX2_L3_samtofastq.txt |
bwa \
mem \
-M \
-t 8 \
-p \
$HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
/dev/stdin \
2> $HOME/twg/assemblies/mapped/2006Stone30/logs/2006Stone30_HVWV2DSX2_L3_bwamem.txt |
java \
-Xmx2G \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MergeBamAlignment \
ALIGNED=/dev/stdin \
UNMAPPED=$HOME/twg/assemblies/mapped/2006Stone30/2006Stone30_HVWV2DSX2_L3_fastqtosam.bam \
O=$HOME/twg/assemblies/mapped/2006Stone30/2006Stone30_HVWV2DSX2_L3_mergebamalignment.bam \
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
2> $HOME/twg/assemblies/mapped/2006Stone30/logs/2006Stone30_HVWV2DSX2_L3_mergebamalignment.txt

##set -o pipefail
##
##java \
##-Xmx2G \
##-XX:ParallelGCThreads=2 \
##-jar \
##$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
##MarkIlluminaAdapters \
##I=$HOME/twg/assemblies/mapped/2006Stone30/2006Stone30_HYGC3DSX2_L1_fastqtosam.bam \
##O=/dev/stdout \
##M=$HOME/twg/assemblies/mapped/2006Stone30/metrics/2006Stone30_HYGC3DSX2_L1_markilluminaadapters.txt \
##COMPRESSION_LEVEL=0 \
##QUIET=true \
##TMP_DIR=/dev/shm/tmp \
##USE_JDK_DEFLATER=true \
##USE_JDK_INFLATER=true \
##2> $HOME/twg/assemblies/mapped/2006Stone30/logs/2006Stone30_HYGC3DSX2_L1_markilluminaadapters.txt |
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
##2> $HOME/twg/assemblies/mapped/2006Stone30/logs/2006Stone30_HYGC3DSX2_L1_samtofastq.txt |
##bwa \
##mem \
##-M \
##-t 4 \
##-p \
##$HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
##/dev/stdin \
##2> $HOME/twg/assemblies/mapped/2006Stone30/logs/2006Stone30_HYGC3DSX2_L1_bwamem.txt |
##java \
##-Xmx2G \
##-XX:ParallelGCThreads=2 \
##-jar \
##$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
##MergeBamAlignment \
##ALIGNED=/dev/stdin \
##UNMAPPED=$HOME/twg/assemblies/mapped/2006Stone30/2006Stone30_HYGC3DSX2_L1_fastqtosam.bam \
##O=$HOME/twg/assemblies/mapped/2006Stone30/2006Stone30_HYGC3DSX2_L1_mergebamalignment.bam \
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
##2> $HOME/twg/assemblies/mapped/2006Stone30/logs/2006Stone30_HYGC3DSX2_L1_mergebamalignment.txt
##
##set -o pipefail
##
##java \
##-Xmx2G \
##-XX:ParallelGCThreads=2 \
##-jar \
##$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
##MarkIlluminaAdapters \
##I=$HOME/twg/assemblies/mapped/2006Stone31/2006Stone31_HVWV2DSX2_L2_fastqtosam.bam \
##O=/dev/stdout \
##M=$HOME/twg/assemblies/mapped/2006Stone31/metrics/2006Stone31_HVWV2DSX2_L2_markilluminaadapters.txt \
##COMPRESSION_LEVEL=0 \
##QUIET=true \
##TMP_DIR=/dev/shm/tmp \
##USE_JDK_DEFLATER=true \
##USE_JDK_INFLATER=true \
##2> $HOME/twg/assemblies/mapped/2006Stone31/logs/2006Stone31_HVWV2DSX2_L2_markilluminaadapters.txt |
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
##2> $HOME/twg/assemblies/mapped/2006Stone31/logs/2006Stone31_HVWV2DSX2_L2_samtofastq.txt |
##bwa \
##mem \
##-M \
##-t 4 \
##-p \
##$HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
##/dev/stdin \
##2> $HOME/twg/assemblies/mapped/2006Stone31/logs/2006Stone31_HVWV2DSX2_L2_bwamem.txt |
##java \
##-Xmx2G \
##-XX:ParallelGCThreads=2 \
##-jar \
##$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
##MergeBamAlignment \
##ALIGNED=/dev/stdin \
##UNMAPPED=$HOME/twg/assemblies/mapped/2006Stone31/2006Stone31_HVWV2DSX2_L2_fastqtosam.bam \
##O=$HOME/twg/assemblies/mapped/2006Stone31/2006Stone31_HVWV2DSX2_L2_mergebamalignment.bam \
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
##2> $HOME/twg/assemblies/mapped/2006Stone31/logs/2006Stone31_HVWV2DSX2_L2_mergebamalignment.txt
##
##set -o pipefail
##
##java \
##-Xmx2G \
##-XX:ParallelGCThreads=2 \
##-jar \
##$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
##MarkIlluminaAdapters \
##I=$HOME/twg/assemblies/mapped/2006Stone32/2006Stone32_HVWV2DSX2_L2_fastqtosam.bam \
##O=/dev/stdout \
##M=$HOME/twg/assemblies/mapped/2006Stone32/metrics/2006Stone32_HVWV2DSX2_L2_markilluminaadapters.txt \
##COMPRESSION_LEVEL=0 \
##QUIET=true \
##TMP_DIR=/dev/shm/tmp \
##USE_JDK_DEFLATER=true \
##USE_JDK_INFLATER=true \
##2> $HOME/twg/assemblies/mapped/2006Stone32/logs/2006Stone32_HVWV2DSX2_L2_markilluminaadapters.txt |
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
##2> $HOME/twg/assemblies/mapped/2006Stone32/logs/2006Stone32_HVWV2DSX2_L2_samtofastq.txt |
##bwa \
##mem \
##-M \
##-t 4 \
##-p \
##$HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
##/dev/stdin \
##2> $HOME/twg/assemblies/mapped/2006Stone32/logs/2006Stone32_HVWV2DSX2_L2_bwamem.txt |
##java \
##-Xmx2G \
##-XX:ParallelGCThreads=2 \
##-jar \
##$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
##MergeBamAlignment \
##ALIGNED=/dev/stdin \
##UNMAPPED=$HOME/twg/assemblies/mapped/2006Stone32/2006Stone32_HVWV2DSX2_L2_fastqtosam.bam \
##O=$HOME/twg/assemblies/mapped/2006Stone32/2006Stone32_HVWV2DSX2_L2_mergebamalignment.bam \
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
##2> $HOME/twg/assemblies/mapped/2006Stone32/logs/2006Stone32_HVWV2DSX2_L2_mergebamalignment.txt

set -o pipefail

java \
-Xmx2G \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MarkIlluminaAdapters \
I=$HOME/twg/assemblies/mapped/2006Stone37/2006Stone37_HVWV2DSX2_L2_fastqtosam.bam \
O=/dev/stdout \
M=$HOME/twg/assemblies/mapped/2006Stone37/metrics/2006Stone37_HVWV2DSX2_L2_markilluminaadapters.txt \
COMPRESSION_LEVEL=0 \
QUIET=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2006Stone37/logs/2006Stone37_HVWV2DSX2_L2_markilluminaadapters.txt |
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
2> $HOME/twg/assemblies/mapped/2006Stone37/logs/2006Stone37_HVWV2DSX2_L2_samtofastq.txt |
bwa \
mem \
-M \
-t 8 \
-p \
$HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
/dev/stdin \
2> $HOME/twg/assemblies/mapped/2006Stone37/logs/2006Stone37_HVWV2DSX2_L2_bwamem.txt |
java \
-Xmx2G \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MergeBamAlignment \
ALIGNED=/dev/stdin \
UNMAPPED=$HOME/twg/assemblies/mapped/2006Stone37/2006Stone37_HVWV2DSX2_L2_fastqtosam.bam \
O=$HOME/twg/assemblies/mapped/2006Stone37/2006Stone37_HVWV2DSX2_L2_mergebamalignment.bam \
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
2> $HOME/twg/assemblies/mapped/2006Stone37/logs/2006Stone37_HVWV2DSX2_L2_mergebamalignment.txt
