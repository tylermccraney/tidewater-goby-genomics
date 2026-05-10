#!/bin/bash

source activate gatk

set -o pipefail

java \
-Xmx2G \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MarkIlluminaAdapters \
I=$HOME/twg/assemblies/mapped/2014Paredon02/2014Paredon02_HJLYTDSX2_L1_fastqtosam.bam \
O=/dev/stdout \
M=$HOME/twg/assemblies/mapped/2014Paredon02/metrics/2014Paredon02_HJLYTDSX2_L1_markilluminaadapters.txt \
COMPRESSION_LEVEL=0 \
QUIET=true \
TMP_DIR=/dev/shm/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2014Paredon02/logs/2014Paredon02_HJLYTDSX2_L1_markilluminaadapters.txt |
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
TMP_DIR=/dev/shm/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2014Paredon02/logs/2014Paredon02_HJLYTDSX2_L1_samtofastq.txt |
bwa \
mem \
-M \
-t 4 \
-p \
$HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
/dev/stdin \
2> $HOME/twg/assemblies/mapped/2014Paredon02/logs/2014Paredon02_HJLYTDSX2_L1_bwamem.txt |
java \
-Xmx2G \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MergeBamAlignment \
ALIGNED=/dev/stdin \
UNMAPPED=$HOME/twg/assemblies/mapped/2014Paredon02/2014Paredon02_HJLYTDSX2_L1_fastqtosam.bam \
O=$HOME/twg/assemblies/mapped/2014Paredon02/2014Paredon02_HJLYTDSX2_L1_mergebamalignment.bam \
R=$HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
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
2> $HOME/twg/assemblies/mapped/2014Paredon02/logs/2014Paredon02_HJLYTDSX2_L1_mergebamalignment.txt

set -o pipefail

java \
-Xmx2G \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MarkIlluminaAdapters \
I=$HOME/twg/assemblies/mapped/2014Paredon18/2014Paredon18_HVWVVDSX2_L3_fastqtosam.bam \
O=/dev/stdout \
M=$HOME/twg/assemblies/mapped/2014Paredon18/metrics/2014Paredon18_HVWVVDSX2_L3_markilluminaadapters.txt \
COMPRESSION_LEVEL=0 \
QUIET=true \
TMP_DIR=/dev/shm/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2014Paredon18/logs/2014Paredon18_HVWVVDSX2_L3_markilluminaadapters.txt |
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
TMP_DIR=/dev/shm/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2014Paredon18/logs/2014Paredon18_HVWVVDSX2_L3_samtofastq.txt |
bwa \
mem \
-M \
-t 4 \
-p \
$HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
/dev/stdin \
2> $HOME/twg/assemblies/mapped/2014Paredon18/logs/2014Paredon18_HVWVVDSX2_L3_bwamem.txt |
java \
-Xmx2G \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MergeBamAlignment \
ALIGNED=/dev/stdin \
UNMAPPED=$HOME/twg/assemblies/mapped/2014Paredon18/2014Paredon18_HVWVVDSX2_L3_fastqtosam.bam \
O=$HOME/twg/assemblies/mapped/2014Paredon18/2014Paredon18_HVWVVDSX2_L3_mergebamalignment.bam \
R=$HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
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
2> $HOME/twg/assemblies/mapped/2014Paredon18/logs/2014Paredon18_HVWVVDSX2_L3_mergebamalignment.txt

set -o pipefail

java \
-Xmx2G \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MarkIlluminaAdapters \
I=$HOME/twg/assemblies/mapped/2014Paredon28/2014Paredon28_HVWVVDSX2_L3_fastqtosam.bam \
O=/dev/stdout \
M=$HOME/twg/assemblies/mapped/2014Paredon28/metrics/2014Paredon28_HVWVVDSX2_L3_markilluminaadapters.txt \
COMPRESSION_LEVEL=0 \
QUIET=true \
TMP_DIR=/dev/shm/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2014Paredon28/logs/2014Paredon28_HVWVVDSX2_L3_markilluminaadapters.txt |
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
TMP_DIR=/dev/shm/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2014Paredon28/logs/2014Paredon28_HVWVVDSX2_L3_samtofastq.txt |
bwa \
mem \
-M \
-t 4 \
-p \
$HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
/dev/stdin \
2> $HOME/twg/assemblies/mapped/2014Paredon28/logs/2014Paredon28_HVWVVDSX2_L3_bwamem.txt |
java \
-Xmx2G \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MergeBamAlignment \
ALIGNED=/dev/stdin \
UNMAPPED=$HOME/twg/assemblies/mapped/2014Paredon28/2014Paredon28_HVWVVDSX2_L3_fastqtosam.bam \
O=$HOME/twg/assemblies/mapped/2014Paredon28/2014Paredon28_HVWVVDSX2_L3_mergebamalignment.bam \
R=$HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
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
2> $HOME/twg/assemblies/mapped/2014Paredon28/logs/2014Paredon28_HVWVVDSX2_L3_mergebamalignment.txt

set -o pipefail

java \
-Xmx2G \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MarkIlluminaAdapters \
I=$HOME/twg/assemblies/mapped/2014Paredon35/2014Paredon35_HVWVVDSX2_L3_fastqtosam.bam \
O=/dev/stdout \
M=$HOME/twg/assemblies/mapped/2014Paredon35/metrics/2014Paredon35_HVWVVDSX2_L3_markilluminaadapters.txt \
COMPRESSION_LEVEL=0 \
QUIET=true \
TMP_DIR=/dev/shm/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2014Paredon35/logs/2014Paredon35_HVWVVDSX2_L3_markilluminaadapters.txt |
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
TMP_DIR=/dev/shm/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2014Paredon35/logs/2014Paredon35_HVWVVDSX2_L3_samtofastq.txt |
bwa \
mem \
-M \
-t 4 \
-p \
$HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
/dev/stdin \
2> $HOME/twg/assemblies/mapped/2014Paredon35/logs/2014Paredon35_HVWVVDSX2_L3_bwamem.txt |
java \
-Xmx2G \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MergeBamAlignment \
ALIGNED=/dev/stdin \
UNMAPPED=$HOME/twg/assemblies/mapped/2014Paredon35/2014Paredon35_HVWVVDSX2_L3_fastqtosam.bam \
O=$HOME/twg/assemblies/mapped/2014Paredon35/2014Paredon35_HVWVVDSX2_L3_mergebamalignment.bam \
R=$HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
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
2> $HOME/twg/assemblies/mapped/2014Paredon35/logs/2014Paredon35_HVWVVDSX2_L3_mergebamalignment.txt

set -o pipefail

java \
-Xmx2G \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MarkIlluminaAdapters \
I=$HOME/twg/assemblies/mapped/2014Paredon38/2014Paredon38_HVWVVDSX2_L3_fastqtosam.bam \
O=/dev/stdout \
M=$HOME/twg/assemblies/mapped/2014Paredon38/metrics/2014Paredon38_HVWVVDSX2_L3_markilluminaadapters.txt \
COMPRESSION_LEVEL=0 \
QUIET=true \
TMP_DIR=/dev/shm/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2014Paredon38/logs/2014Paredon38_HVWVVDSX2_L3_markilluminaadapters.txt |
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
TMP_DIR=/dev/shm/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2014Paredon38/logs/2014Paredon38_HVWVVDSX2_L3_samtofastq.txt |
bwa \
mem \
-M \
-t 4 \
-p \
$HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
/dev/stdin \
2> $HOME/twg/assemblies/mapped/2014Paredon38/logs/2014Paredon38_HVWVVDSX2_L3_bwamem.txt |
java \
-Xmx2G \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MergeBamAlignment \
ALIGNED=/dev/stdin \
UNMAPPED=$HOME/twg/assemblies/mapped/2014Paredon38/2014Paredon38_HVWVVDSX2_L3_fastqtosam.bam \
O=$HOME/twg/assemblies/mapped/2014Paredon38/2014Paredon38_HVWVVDSX2_L3_mergebamalignment.bam \
R=$HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
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
2> $HOME/twg/assemblies/mapped/2014Paredon38/logs/2014Paredon38_HVWVVDSX2_L3_mergebamalignment.txt

set -o pipefail

java \
-Xmx2G \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MarkIlluminaAdapters \
I=$HOME/twg/assemblies/mapped/2014Paredon39/2014Paredon39_HVWW2DSX2_L1_fastqtosam.bam \
O=/dev/stdout \
M=$HOME/twg/assemblies/mapped/2014Paredon39/metrics/2014Paredon39_HVWW2DSX2_L1_markilluminaadapters.txt \
COMPRESSION_LEVEL=0 \
QUIET=true \
TMP_DIR=/dev/shm/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2014Paredon39/logs/2014Paredon39_HVWW2DSX2_L1_markilluminaadapters.txt |
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
TMP_DIR=/dev/shm/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2014Paredon39/logs/2014Paredon39_HVWW2DSX2_L1_samtofastq.txt |
bwa \
mem \
-M \
-t 4 \
-p \
$HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
/dev/stdin \
2> $HOME/twg/assemblies/mapped/2014Paredon39/logs/2014Paredon39_HVWW2DSX2_L1_bwamem.txt |
java \
-Xmx2G \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MergeBamAlignment \
ALIGNED=/dev/stdin \
UNMAPPED=$HOME/twg/assemblies/mapped/2014Paredon39/2014Paredon39_HVWW2DSX2_L1_fastqtosam.bam \
O=$HOME/twg/assemblies/mapped/2014Paredon39/2014Paredon39_HVWW2DSX2_L1_mergebamalignment.bam \
R=$HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
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
2> $HOME/twg/assemblies/mapped/2014Paredon39/logs/2014Paredon39_HVWW2DSX2_L1_mergebamalignment.txt

set -o pipefail

java \
-Xmx2G \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MarkIlluminaAdapters \
I=$HOME/twg/assemblies/mapped/2014Paredon39/2014Paredon39_HW7NGDSX2_L3_fastqtosam.bam \
O=/dev/stdout \
M=$HOME/twg/assemblies/mapped/2014Paredon39/metrics/2014Paredon39_HW7NGDSX2_L3_markilluminaadapters.txt \
COMPRESSION_LEVEL=0 \
QUIET=true \
TMP_DIR=/dev/shm/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2014Paredon39/logs/2014Paredon39_HW7NGDSX2_L3_markilluminaadapters.txt |
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
TMP_DIR=/dev/shm/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2014Paredon39/logs/2014Paredon39_HW7NGDSX2_L3_samtofastq.txt |
bwa \
mem \
-M \
-t 4 \
-p \
$HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
/dev/stdin \
2> $HOME/twg/assemblies/mapped/2014Paredon39/logs/2014Paredon39_HW7NGDSX2_L3_bwamem.txt |
java \
-Xmx2G \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MergeBamAlignment \
ALIGNED=/dev/stdin \
UNMAPPED=$HOME/twg/assemblies/mapped/2014Paredon39/2014Paredon39_HW7NGDSX2_L3_fastqtosam.bam \
O=$HOME/twg/assemblies/mapped/2014Paredon39/2014Paredon39_HW7NGDSX2_L3_mergebamalignment.bam \
R=$HOME/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
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
2> $HOME/twg/assemblies/mapped/2014Paredon39/logs/2014Paredon39_HW7NGDSX2_L3_mergebamalignment.txt
