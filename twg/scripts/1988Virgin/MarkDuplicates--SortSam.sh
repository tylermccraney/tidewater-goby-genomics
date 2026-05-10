#!/bin/bash

##set -o pipefail
##
##java \
##-Xmx2G \
##-XX:+UseParallelGC \
##-XX:ParallelGCThreads=2 \
##-jar \
##$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
##MarkDuplicates \
##I=$HOME/twg/assemblies/mapped/1988Virgin21/1988Virgin21_S224_L003_001_mergebamalignment.bam \
##O=/dev/stdout \
##M=$HOME/twg/assemblies/mapped/1988Virgin21/metrics/1988Virgin21_S224_L003_001_markduplicates.txt \
##MAX_FILE_HANDLES=1000 \
##OPTICAL_DUPLICATE_PIXEL_DISTANCE=2500 \
##COMPRESSION_LEVEL=0 \
##QUIET=true \
##TMP_DIR=$HOME/twg/tmp \
##USE_JDK_DEFLATER=true \
##USE_JDK_INFLATER=true \
##2> $HOME/twg/assemblies/mapped/1988Virgin21/logs/1988Virgin21_S224_L003_001_markduplicates.txt | 
##java \
##-Xmx10G \
##-XX:+UseParallelGC \
##-XX:ParallelGCThreads=2 \
##-jar \
##$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
##SortSam \
##I=/dev/stdin \
##O=$HOME/twg/assemblies/mapped/1988Virgin21/1988Virgin21_S224_L003_001_sortsam.bam \
##SO=coordinate \
##CREATE_INDEX=true \
##TMP_DIR=$HOME/twg/tmp \
##USE_JDK_DEFLATER=true \
##USE_JDK_INFLATER=true \
##2> $HOME/twg/assemblies/mapped/1988Virgin21/logs/1988Virgin21_S224_L003_001_sortsam.txt
##
##set -o pipefail
##
##java \
##-Xmx2G \
##-XX:+UseParallelGC \
##-XX:ParallelGCThreads=2 \
##-jar \
##$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
##MarkDuplicates \
##I=$HOME/twg/assemblies/mapped/1988Virgin24/1988Virgin24_S0_L001_001_mergebamalignment.bam \
##O=/dev/stdout \
##M=$HOME/twg/assemblies/mapped/1988Virgin24/metrics/1988Virgin24_S0_L001_001_markduplicates.txt \
##MAX_FILE_HANDLES=1000 \
##OPTICAL_DUPLICATE_PIXEL_DISTANCE=2500 \
##COMPRESSION_LEVEL=0 \
##QUIET=true \
##TMP_DIR=$HOME/twg/tmp \
##USE_JDK_DEFLATER=true \
##USE_JDK_INFLATER=true \
##2> $HOME/twg/assemblies/mapped/1988Virgin24/logs/1988Virgin24_S0_L001_001_markduplicates.txt | 
##java \
##-Xmx10G \
##-XX:+UseParallelGC \
##-XX:ParallelGCThreads=2 \
##-jar \
##$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
##SortSam \
##I=/dev/stdin \
##O=$HOME/twg/assemblies/mapped/1988Virgin24/1988Virgin24_S0_L001_001_sortsam.bam \
##SO=coordinate \
##CREATE_INDEX=true \
##TMP_DIR=$HOME/twg/tmp \
##USE_JDK_DEFLATER=true \
##USE_JDK_INFLATER=true \
##2> $HOME/twg/assemblies/mapped/1988Virgin24/logs/1988Virgin24_S0_L001_001_sortsam.txt

set -o pipefail

java \
-Xmx2G \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MarkDuplicates \
I=$HOME/twg/assemblies/mapped/1988Virgin26/1988Virgin26_S226_L003_001_mergebamalignment.bam \
O=/dev/stdout \
M=$HOME/twg/assemblies/mapped/1988Virgin26/metrics/1988Virgin26_S226_L003_001_markduplicates.txt \
MAX_FILE_HANDLES=1000 \
OPTICAL_DUPLICATE_PIXEL_DISTANCE=2500 \
COMPRESSION_LEVEL=0 \
QUIET=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/1988Virgin26/logs/1988Virgin26_S226_L003_001_markduplicates.txt | 
java \
-Xmx10G \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
SortSam \
I=/dev/stdin \
O=$HOME/twg/assemblies/mapped/1988Virgin26/1988Virgin26_S226_L003_001_sortsam.bam \
SO=coordinate \
CREATE_INDEX=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/1988Virgin26/logs/1988Virgin26_S226_L003_001_sortsam.txt

set -o pipefail

java \
-Xmx2G \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MarkDuplicates \
I=$HOME/twg/assemblies/mapped/1988Virgin28/1988Virgin28_S0_L001_001_mergebamalignment.bam \
O=/dev/stdout \
M=$HOME/twg/assemblies/mapped/1988Virgin28/metrics/1988Virgin28_S0_L001_001_markduplicates.txt \
MAX_FILE_HANDLES=1000 \
OPTICAL_DUPLICATE_PIXEL_DISTANCE=2500 \
COMPRESSION_LEVEL=0 \
QUIET=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/1988Virgin28/logs/1988Virgin28_S0_L001_001_markduplicates.txt | 
java \
-Xmx10G \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
SortSam \
I=/dev/stdin \
O=$HOME/twg/assemblies/mapped/1988Virgin28/1988Virgin28_S0_L001_001_sortsam.bam \
SO=coordinate \
CREATE_INDEX=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/1988Virgin28/logs/1988Virgin28_S0_L001_001_sortsam.txt

set -o pipefail

java \
-Xmx2G \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MarkDuplicates \
I=$HOME/twg/assemblies/mapped/1988Virgin30/1988Virgin30_S228_L003_001_mergebamalignment.bam \
O=/dev/stdout \
M=$HOME/twg/assemblies/mapped/1988Virgin30/metrics/1988Virgin30_S228_L003_001_markduplicates.txt \
MAX_FILE_HANDLES=1000 \
OPTICAL_DUPLICATE_PIXEL_DISTANCE=2500 \
COMPRESSION_LEVEL=0 \
QUIET=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/1988Virgin30/logs/1988Virgin30_S228_L003_001_markduplicates.txt | 
java \
-Xmx10G \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
SortSam \
I=/dev/stdin \
O=$HOME/twg/assemblies/mapped/1988Virgin30/1988Virgin30_S228_L003_001_sortsam.bam \
SO=coordinate \
CREATE_INDEX=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/1988Virgin30/logs/1988Virgin30_S228_L003_001_sortsam.txt

set -o pipefail

java \
-Xmx2G \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MarkDuplicates \
I=$HOME/twg/assemblies/mapped/1988Virgin31/1988Virgin31_S0_L001_001_mergebamalignment.bam \
O=/dev/stdout \
M=$HOME/twg/assemblies/mapped/1988Virgin31/metrics/1988Virgin31_S0_L001_001_markduplicates.txt \
MAX_FILE_HANDLES=1000 \
OPTICAL_DUPLICATE_PIXEL_DISTANCE=2500 \
COMPRESSION_LEVEL=0 \
QUIET=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/1988Virgin31/logs/1988Virgin31_S0_L001_001_markduplicates.txt | 
java \
-Xmx10G \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
SortSam \
I=/dev/stdin \
O=$HOME/twg/assemblies/mapped/1988Virgin31/1988Virgin31_S0_L001_001_sortsam.bam \
SO=coordinate \
CREATE_INDEX=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/1988Virgin31/logs/1988Virgin31_S0_L001_001_sortsam.txt
