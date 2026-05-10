#!/bin/bash

set -o pipefail

java \
-Xmx2G \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MarkDuplicates \
I=$HOME/twg/assemblies/mapped/2017Ynez13/2017Ynez13_HW7NGDSX2_L3_mergebamalignment.bam \
O=/dev/stdout \
M=$HOME/twg/assemblies/mapped/2017Ynez13/metrics/2017Ynez13_markduplicates.txt \
MAX_FILE_HANDLES=1000 \
OPTICAL_DUPLICATE_PIXEL_DISTANCE=2500 \
COMPRESSION_LEVEL=0 \
QUIET=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2017Ynez13/logs/2017Ynez13_markduplicates.txt | 
java \
-Xmx10G \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
SortSam \
I=/dev/stdin \
O=$HOME/twg/assemblies/mapped/2017Ynez13/2017Ynez13_sortsam.bam \
SO=coordinate \
CREATE_INDEX=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2017Ynez13/logs/2017Ynez13_sortsam.txt

set -o pipefail

java \
-Xmx2G \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MarkDuplicates \
I=$HOME/twg/assemblies/mapped/2017Ynez14/2017Ynez14_HW7NGDSX2_L3_mergebamalignment.bam \
O=/dev/stdout \
M=$HOME/twg/assemblies/mapped/2017Ynez14/metrics/2017Ynez14_markduplicates.txt \
MAX_FILE_HANDLES=1000 \
OPTICAL_DUPLICATE_PIXEL_DISTANCE=2500 \
COMPRESSION_LEVEL=0 \
QUIET=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2017Ynez14/logs/2017Ynez14_markduplicates.txt | 
java \
-Xmx10G \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
SortSam \
I=/dev/stdin \
O=$HOME/twg/assemblies/mapped/2017Ynez14/2017Ynez14_sortsam.bam \
SO=coordinate \
CREATE_INDEX=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2017Ynez14/logs/2017Ynez14_sortsam.txt

set -o pipefail

java \
-Xmx2G \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MarkDuplicates \
I=$HOME/twg/assemblies/mapped/2017Ynez17/2017Ynez17_HW7NGDSX2_L3_mergebamalignment.bam \
O=/dev/stdout \
M=$HOME/twg/assemblies/mapped/2017Ynez17/metrics/2017Ynez17_markduplicates.txt \
MAX_FILE_HANDLES=1000 \
OPTICAL_DUPLICATE_PIXEL_DISTANCE=2500 \
COMPRESSION_LEVEL=0 \
QUIET=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2017Ynez17/logs/2017Ynez17_markduplicates.txt | 
java \
-Xmx10G \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
SortSam \
I=/dev/stdin \
O=$HOME/twg/assemblies/mapped/2017Ynez17/2017Ynez17_sortsam.bam \
SO=coordinate \
CREATE_INDEX=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2017Ynez17/logs/2017Ynez17_sortsam.txt

set -o pipefail

java \
-Xmx2G \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MarkDuplicates \
I=$HOME/twg/assemblies/mapped/2017Ynez20/2017Ynez20_HVWW2DSX2_L1_mergebamalignment.bam \
I=$HOME/twg/assemblies/mapped/2017Ynez20/2017Ynez20_HW7NGDSX2_L3_mergebamalignment.bam \
O=/dev/stdout \
M=$HOME/twg/assemblies/mapped/2017Ynez20/metrics/2017Ynez20_markduplicates.txt \
MAX_FILE_HANDLES=1000 \
OPTICAL_DUPLICATE_PIXEL_DISTANCE=2500 \
COMPRESSION_LEVEL=0 \
QUIET=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2017Ynez20/logs/2017Ynez20_markduplicates.txt | 
java \
-Xmx10G \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
SortSam \
I=/dev/stdin \
O=$HOME/twg/assemblies/mapped/2017Ynez20/2017Ynez20_sortsam.bam \
SO=coordinate \
CREATE_INDEX=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2017Ynez20/logs/2017Ynez20_sortsam.txt

set -o pipefail

java \
-Xmx2G \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MarkDuplicates \
I=$HOME/twg/assemblies/mapped/2017Ynez25/2017Ynez25_HW7NGDSX2_L2_mergebamalignment.bam \
O=/dev/stdout \
M=$HOME/twg/assemblies/mapped/2017Ynez25/metrics/2017Ynez25_markduplicates.txt \
MAX_FILE_HANDLES=1000 \
OPTICAL_DUPLICATE_PIXEL_DISTANCE=2500 \
COMPRESSION_LEVEL=0 \
QUIET=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2017Ynez25/logs/2017Ynez25_markduplicates.txt | 
java \
-Xmx10G \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
SortSam \
I=/dev/stdin \
O=$HOME/twg/assemblies/mapped/2017Ynez25/2017Ynez25_sortsam.bam \
SO=coordinate \
CREATE_INDEX=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2017Ynez25/logs/2017Ynez25_sortsam.txt

set -o pipefail

java \
-Xmx2G \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MarkDuplicates \
I=$HOME/twg/assemblies/mapped/2017Ynez28/2017Ynez28_HW7NGDSX2_L2_mergebamalignment.bam \
O=/dev/stdout \
M=$HOME/twg/assemblies/mapped/2017Ynez28/metrics/2017Ynez28_markduplicates.txt \
MAX_FILE_HANDLES=1000 \
OPTICAL_DUPLICATE_PIXEL_DISTANCE=2500 \
COMPRESSION_LEVEL=0 \
QUIET=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2017Ynez28/logs/2017Ynez28_markduplicates.txt | 
java \
-Xmx10G \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
SortSam \
I=/dev/stdin \
O=$HOME/twg/assemblies/mapped/2017Ynez28/2017Ynez28_sortsam.bam \
SO=coordinate \
CREATE_INDEX=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2017Ynez28/logs/2017Ynez28_sortsam.txt

