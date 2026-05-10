#!/bin/bash

set -o pipefail

java \
-Xmx2G \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MarkDuplicates \
I=$HOME/twg/assemblies/mapped/2011Earl01/2011Earl01_HJLYTDSX2_L4_mergebamalignment.bam \
O=/dev/stdout \
M=$HOME/twg/assemblies/mapped/2011Earl01/metrics/2011Earl01_markduplicates.txt \
MAX_FILE_HANDLES=1000 \
OPTICAL_DUPLICATE_PIXEL_DISTANCE=2500 \
COMPRESSION_LEVEL=0 \
QUIET=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2011Earl01/logs/2011Earl01_markduplicates.txt | 
java \
-Xmx10G \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
SortSam \
I=/dev/stdin \
O=$HOME/twg/assemblies/mapped/2011Earl01/2011Earl01_sortsam.bam \
SO=coordinate \
CREATE_INDEX=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2011Earl01/logs/2011Earl01_sortsam.txt

set -o pipefail

java \
-Xmx2G \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MarkDuplicates \
I=$HOME/twg/assemblies/mapped/2011Earl02/2011Earl02_HJLYTDSX2_L4_mergebamalignment.bam \
O=/dev/stdout \
M=$HOME/twg/assemblies/mapped/2011Earl02/metrics/2011Earl02_markduplicates.txt \
MAX_FILE_HANDLES=1000 \
OPTICAL_DUPLICATE_PIXEL_DISTANCE=2500 \
COMPRESSION_LEVEL=0 \
QUIET=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2011Earl02/logs/2011Earl02_markduplicates.txt | 
java \
-Xmx10G \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
SortSam \
I=/dev/stdin \
O=$HOME/twg/assemblies/mapped/2011Earl02/2011Earl02_sortsam.bam \
SO=coordinate \
CREATE_INDEX=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2011Earl02/logs/2011Earl02_sortsam.txt

set -o pipefail

java \
-Xmx2G \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MarkDuplicates \
I=$HOME/twg/assemblies/mapped/2011Earl03/2011Earl03_HJLYTDSX2_L4_mergebamalignment.bam \
O=/dev/stdout \
M=$HOME/twg/assemblies/mapped/2011Earl03/metrics/2011Earl03_markduplicates.txt \
MAX_FILE_HANDLES=1000 \
OPTICAL_DUPLICATE_PIXEL_DISTANCE=2500 \
COMPRESSION_LEVEL=0 \
QUIET=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2011Earl03/logs/2011Earl03_markduplicates.txt | 
java \
-Xmx10G \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
SortSam \
I=/dev/stdin \
O=$HOME/twg/assemblies/mapped/2011Earl03/2011Earl03_sortsam.bam \
SO=coordinate \
CREATE_INDEX=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2011Earl03/logs/2011Earl03_sortsam.txt

set -o pipefail

java \
-Xmx2G \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MarkDuplicates \
I=$HOME/twg/assemblies/mapped/2011Earl04/2011Earl04_HJLYTDSX2_L4_mergebamalignment.bam \
O=/dev/stdout \
M=$HOME/twg/assemblies/mapped/2011Earl04/metrics/2011Earl04_markduplicates.txt \
MAX_FILE_HANDLES=1000 \
OPTICAL_DUPLICATE_PIXEL_DISTANCE=2500 \
COMPRESSION_LEVEL=0 \
QUIET=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2011Earl04/logs/2011Earl04_markduplicates.txt | 
java \
-Xmx10G \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
SortSam \
I=/dev/stdin \
O=$HOME/twg/assemblies/mapped/2011Earl04/2011Earl04_sortsam.bam \
SO=coordinate \
CREATE_INDEX=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2011Earl04/logs/2011Earl04_sortsam.txt

set -o pipefail

java \
-Xmx2G \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MarkDuplicates \
I=$HOME/twg/assemblies/mapped/2011Earl09/2011Earl09_H3JFWDSX3_L1_mergebamalignment.bam \
O=/dev/stdout \
M=$HOME/twg/assemblies/mapped/2011Earl09/metrics/2011Earl09_markduplicates.txt \
MAX_FILE_HANDLES=1000 \
OPTICAL_DUPLICATE_PIXEL_DISTANCE=2500 \
COMPRESSION_LEVEL=0 \
QUIET=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2011Earl09/logs/2011Earl09_markduplicates.txt | 
java \
-Xmx10G \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
SortSam \
I=/dev/stdin \
O=$HOME/twg/assemblies/mapped/2011Earl09/2011Earl09_sortsam.bam \
SO=coordinate \
CREATE_INDEX=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2011Earl09/logs/2011Earl09_sortsam.txt

set -o pipefail

java \
-Xmx2G \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MarkDuplicates \
I=$HOME/twg/assemblies/mapped/2011Earl10/2011Earl10_H3JFWDSX3_L1_mergebamalignment.bam \
O=/dev/stdout \
M=$HOME/twg/assemblies/mapped/2011Earl10/metrics/2011Earl10_markduplicates.txt \
MAX_FILE_HANDLES=1000 \
OPTICAL_DUPLICATE_PIXEL_DISTANCE=2500 \
COMPRESSION_LEVEL=0 \
QUIET=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2011Earl10/logs/2011Earl10_markduplicates.txt | 
java \
-Xmx10G \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
SortSam \
I=/dev/stdin \
O=$HOME/twg/assemblies/mapped/2011Earl10/2011Earl10_sortsam.bam \
SO=coordinate \
CREATE_INDEX=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2011Earl10/logs/2011Earl10_sortsam.txt

