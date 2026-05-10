#!/bin/bash

set -o pipefail

java \
-Xmx2G \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MarkDuplicates \
I=$HOME/twg/assemblies/mapped/2021Big01/2021Big01_H3JFWDSX3_L1_mergebamalignment.bam \
O=/dev/stdout \
M=$HOME/twg/assemblies/mapped/2021Big01/metrics/2021Big01_markduplicates.txt \
MAX_FILE_HANDLES=1000 \
OPTICAL_DUPLICATE_PIXEL_DISTANCE=2500 \
COMPRESSION_LEVEL=0 \
QUIET=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2021Big01/logs/2021Big01_markduplicates.txt | 
java \
-Xmx10G \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
SortSam \
I=/dev/stdin \
O=$HOME/twg/assemblies/mapped/2021Big01/2021Big01_sortsam.bam \
SO=coordinate \
CREATE_INDEX=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2021Big01/logs/2021Big01_sortsam.txt

set -o pipefail

java \
-Xmx2G \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MarkDuplicates \
I=$HOME/twg/assemblies/mapped/2021Big02/2021Big02_H7W3MDSX3_L4_mergebamalignment.bam \
O=/dev/stdout \
M=$HOME/twg/assemblies/mapped/2021Big02/metrics/2021Big02_markduplicates.txt \
MAX_FILE_HANDLES=1000 \
OPTICAL_DUPLICATE_PIXEL_DISTANCE=2500 \
COMPRESSION_LEVEL=0 \
QUIET=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2021Big02/logs/2021Big02_markduplicates.txt | 
java \
-Xmx10G \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
SortSam \
I=/dev/stdin \
O=$HOME/twg/assemblies/mapped/2021Big02/2021Big02_sortsam.bam \
SO=coordinate \
CREATE_INDEX=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2021Big02/logs/2021Big02_sortsam.txt

set -o pipefail

java \
-Xmx2G \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MarkDuplicates \
I=$HOME/twg/assemblies/mapped/2021Big03/2021Big03_H7W3MDSX3_L4_mergebamalignment.bam \
O=/dev/stdout \
M=$HOME/twg/assemblies/mapped/2021Big03/metrics/2021Big03_markduplicates.txt \
MAX_FILE_HANDLES=1000 \
OPTICAL_DUPLICATE_PIXEL_DISTANCE=2500 \
COMPRESSION_LEVEL=0 \
QUIET=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2021Big03/logs/2021Big03_markduplicates.txt | 
java \
-Xmx10G \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
SortSam \
I=/dev/stdin \
O=$HOME/twg/assemblies/mapped/2021Big03/2021Big03_sortsam.bam \
SO=coordinate \
CREATE_INDEX=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2021Big03/logs/2021Big03_sortsam.txt

set -o pipefail

java \
-Xmx2G \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MarkDuplicates \
I=$HOME/twg/assemblies/mapped/2021Big04/2021Big04_H7W3MDSX3_L4_mergebamalignment.bam \
O=/dev/stdout \
M=$HOME/twg/assemblies/mapped/2021Big04/metrics/2021Big04_markduplicates.txt \
MAX_FILE_HANDLES=1000 \
OPTICAL_DUPLICATE_PIXEL_DISTANCE=2500 \
COMPRESSION_LEVEL=0 \
QUIET=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2021Big04/logs/2021Big04_markduplicates.txt | 
java \
-Xmx10G \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
SortSam \
I=/dev/stdin \
O=$HOME/twg/assemblies/mapped/2021Big04/2021Big04_sortsam.bam \
SO=coordinate \
CREATE_INDEX=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2021Big04/logs/2021Big04_sortsam.txt

set -o pipefail

java \
-Xmx2G \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MarkDuplicates \
I=$HOME/twg/assemblies/mapped/2021Big05/2021Big05_H2YGKDSX3_L2_mergebamalignment.bam \
I=$HOME/twg/assemblies/mapped/2021Big05/2021Big05_H3JFWDSX3_L1_mergebamalignment.bam \
O=/dev/stdout \
M=$HOME/twg/assemblies/mapped/2021Big05/metrics/2021Big05_markduplicates.txt \
MAX_FILE_HANDLES=1000 \
OPTICAL_DUPLICATE_PIXEL_DISTANCE=2500 \
COMPRESSION_LEVEL=0 \
QUIET=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2021Big05/logs/2021Big05_markduplicates.txt | 
java \
-Xmx10G \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
SortSam \
I=/dev/stdin \
O=$HOME/twg/assemblies/mapped/2021Big05/2021Big05_sortsam.bam \
SO=coordinate \
CREATE_INDEX=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2021Big05/logs/2021Big05_sortsam.txt

set -o pipefail

java \
-Xmx2G \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MarkDuplicates \
I=$HOME/twg/assemblies/mapped/2021Big06/2021Big06_H3JFWDSX3_L1_mergebamalignment.bam \
O=/dev/stdout \
M=$HOME/twg/assemblies/mapped/2021Big06/metrics/2021Big06_markduplicates.txt \
MAX_FILE_HANDLES=1000 \
OPTICAL_DUPLICATE_PIXEL_DISTANCE=2500 \
COMPRESSION_LEVEL=0 \
QUIET=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2021Big06/logs/2021Big06_markduplicates.txt | 
java \
-Xmx10G \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
SortSam \
I=/dev/stdin \
O=$HOME/twg/assemblies/mapped/2021Big06/2021Big06_sortsam.bam \
SO=coordinate \
CREATE_INDEX=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2021Big06/logs/2021Big06_sortsam.txt

