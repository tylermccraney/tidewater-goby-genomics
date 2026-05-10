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
##I=$HOME/twg/assemblies/mapped/2009Arcata01/2009Arcata01_S0_L001_001_mergebamalignment.bam \
##O=/dev/stdout \
##M=$HOME/twg/assemblies/mapped/2009Arcata01/metrics/2009Arcata01_S0_L001_001_markduplicates.txt \
##MAX_FILE_HANDLES=1000 \
##OPTICAL_DUPLICATE_PIXEL_DISTANCE=2500 \
##COMPRESSION_LEVEL=0 \
##QUIET=true \
##TMP_DIR=$HOME/twg/tmp \
##USE_JDK_DEFLATER=true \
##USE_JDK_INFLATER=true \
##2> $HOME/twg/assemblies/mapped/2009Arcata01/logs/2009Arcata01_S0_L001_001_markduplicates.txt | 
##java \
##-Xmx10G \
##-XX:+UseParallelGC \
##-XX:ParallelGCThreads=2 \
##-jar \
##$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
##SortSam \
##I=/dev/stdin \
##O=$HOME/twg/assemblies/mapped/2009Arcata01/2009Arcata01_S0_L001_001_sortsam.bam \
##SO=coordinate \
##CREATE_INDEX=true \
##TMP_DIR=$HOME/twg/tmp \
##USE_JDK_DEFLATER=true \
##USE_JDK_INFLATER=true \
##2> $HOME/twg/assemblies/mapped/2009Arcata01/logs/2009Arcata01_S0_L001_001_sortsam.txt
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
##I=$HOME/twg/assemblies/mapped/2009Arcata02/2009Arcata02_S231_L003_001_mergebamalignment.bam \
##O=/dev/stdout \
##M=$HOME/twg/assemblies/mapped/2009Arcata02/metrics/2009Arcata02_S231_L003_001_markduplicates.txt \
##MAX_FILE_HANDLES=1000 \
##OPTICAL_DUPLICATE_PIXEL_DISTANCE=2500 \
##COMPRESSION_LEVEL=0 \
##QUIET=true \
##TMP_DIR=$HOME/twg/tmp \
##USE_JDK_DEFLATER=true \
##USE_JDK_INFLATER=true \
##2> $HOME/twg/assemblies/mapped/2009Arcata02/logs/2009Arcata02_S231_L003_001_markduplicates.txt | 
##java \
##-Xmx10G \
##-XX:+UseParallelGC \
##-XX:ParallelGCThreads=2 \
##-jar \
##$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
##SortSam \
##I=/dev/stdin \
##O=$HOME/twg/assemblies/mapped/2009Arcata02/2009Arcata02_S231_L003_001_sortsam.bam \
##SO=coordinate \
##CREATE_INDEX=true \
##TMP_DIR=$HOME/twg/tmp \
##USE_JDK_DEFLATER=true \
##USE_JDK_INFLATER=true \
##2> $HOME/twg/assemblies/mapped/2009Arcata02/logs/2009Arcata02_S231_L003_001_sortsam.txt

set -o pipefail

java \
-Xmx2G \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MarkDuplicates \
I=$HOME/twg/assemblies/mapped/2009Arcata03/2009Arcata03_S0_L001_001_mergebamalignment.bam \
O=/dev/stdout \
M=$HOME/twg/assemblies/mapped/2009Arcata03/metrics/2009Arcata03_S0_L001_001_markduplicates.txt \
MAX_FILE_HANDLES=1000 \
OPTICAL_DUPLICATE_PIXEL_DISTANCE=2500 \
COMPRESSION_LEVEL=0 \
QUIET=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2009Arcata03/logs/2009Arcata03_S0_L001_001_markduplicates.txt | 
java \
-Xmx10G \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
SortSam \
I=/dev/stdin \
O=$HOME/twg/assemblies/mapped/2009Arcata03/2009Arcata03_S0_L001_001_sortsam.bam \
SO=coordinate \
CREATE_INDEX=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2009Arcata03/logs/2009Arcata03_S0_L001_001_sortsam.txt

set -o pipefail

java \
-Xmx2G \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MarkDuplicates \
I=$HOME/twg/assemblies/mapped/2009Arcata04/2009Arcata04_S0_L001_001_mergebamalignment.bam \
O=/dev/stdout \
M=$HOME/twg/assemblies/mapped/2009Arcata04/metrics/2009Arcata04_S0_L001_001_markduplicates.txt \
MAX_FILE_HANDLES=1000 \
OPTICAL_DUPLICATE_PIXEL_DISTANCE=2500 \
COMPRESSION_LEVEL=0 \
QUIET=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2009Arcata04/logs/2009Arcata04_S0_L001_001_markduplicates.txt | 
java \
-Xmx10G \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
SortSam \
I=/dev/stdin \
O=$HOME/twg/assemblies/mapped/2009Arcata04/2009Arcata04_S0_L001_001_sortsam.bam \
SO=coordinate \
CREATE_INDEX=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2009Arcata04/logs/2009Arcata04_S0_L001_001_sortsam.txt

set -o pipefail

java \
-Xmx2G \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MarkDuplicates \
I=$HOME/twg/assemblies/mapped/2009Arcata05/2009Arcata05_S234_L003_001_mergebamalignment.bam \
O=/dev/stdout \
M=$HOME/twg/assemblies/mapped/2009Arcata05/metrics/2009Arcata05_S234_L003_001_markduplicates.txt \
MAX_FILE_HANDLES=1000 \
OPTICAL_DUPLICATE_PIXEL_DISTANCE=2500 \
COMPRESSION_LEVEL=0 \
QUIET=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2009Arcata05/logs/2009Arcata05_S234_L003_001_markduplicates.txt | 
java \
-Xmx10G \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
SortSam \
I=/dev/stdin \
O=$HOME/twg/assemblies/mapped/2009Arcata05/2009Arcata05_S234_L003_001_sortsam.bam \
SO=coordinate \
CREATE_INDEX=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2009Arcata05/logs/2009Arcata05_S234_L003_001_sortsam.txt

set -o pipefail

java \
-Xmx2G \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MarkDuplicates \
I=$HOME/twg/assemblies/mapped/2009Arcata06/2009Arcata06_S0_L001_001_mergebamalignment.bam \
O=/dev/stdout \
M=$HOME/twg/assemblies/mapped/2009Arcata06/metrics/2009Arcata06_S0_L001_001_markduplicates.txt \
MAX_FILE_HANDLES=1000 \
OPTICAL_DUPLICATE_PIXEL_DISTANCE=2500 \
COMPRESSION_LEVEL=0 \
QUIET=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2009Arcata06/logs/2009Arcata06_S0_L001_001_markduplicates.txt | 
java \
-Xmx10G \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
SortSam \
I=/dev/stdin \
O=$HOME/twg/assemblies/mapped/2009Arcata06/2009Arcata06_S0_L001_001_sortsam.bam \
SO=coordinate \
CREATE_INDEX=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2009Arcata06/logs/2009Arcata06_S0_L001_001_sortsam.txt

set -o pipefail

java \
-Xmx2G \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
MarkDuplicates \
I=$HOME/twg/assemblies/mapped/2009Arcata20/2009Arcata20_H3JFWDSX3_L1_mergebamalignment.bam \
O=/dev/stdout \
M=$HOME/twg/assemblies/mapped/2009Arcata20/metrics/2009Arcata20_markduplicates.txt \
MAX_FILE_HANDLES=1000 \
OPTICAL_DUPLICATE_PIXEL_DISTANCE=2500 \
COMPRESSION_LEVEL=0 \
QUIET=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2009Arcata20/logs/2009Arcata20_markduplicates.txt | 
java \
-Xmx10G \
-XX:+UseParallelGC \
-XX:ParallelGCThreads=2 \
-jar \
$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
SortSam \
I=/dev/stdin \
O=$HOME/twg/assemblies/mapped/2009Arcata20/2009Arcata20_sortsam.bam \
SO=coordinate \
CREATE_INDEX=true \
TMP_DIR=$HOME/twg/tmp \
USE_JDK_DEFLATER=true \
USE_JDK_INFLATER=true \
2> $HOME/twg/assemblies/mapped/2009Arcata20/logs/2009Arcata20_sortsam.txt

##set -o pipefail
##
##java \
##-Xmx2G \
##-XX:+UseParallelGC \
##-XX:ParallelGCThreads=2 \
##-jar \
##$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
##MarkDuplicates \
##I=$HOME/twg/assemblies/mapped/2009Arcata21/2009Arcata21_HG5M3DSX3_L2_mergebamalignment.bam \
##I=$HOME/twg/assemblies/mapped/2009Arcata21/2009Arcata21_HG5NCDSX3_L1_mergebamalignment.bam \
##O=/dev/stdout \
##M=$HOME/twg/assemblies/mapped/2009Arcata21/metrics/2009Arcata21_markduplicates.txt \
##MAX_FILE_HANDLES=1000 \
##OPTICAL_DUPLICATE_PIXEL_DISTANCE=2500 \
##COMPRESSION_LEVEL=0 \
##QUIET=true \
##TMP_DIR=$HOME/twg/tmp \
##USE_JDK_DEFLATER=true \
##USE_JDK_INFLATER=true \
##2> $HOME/twg/assemblies/mapped/2009Arcata21/logs/2009Arcata21_markduplicates.txt | 
##java \
##-Xmx10G \
##-XX:+UseParallelGC \
##-XX:ParallelGCThreads=2 \
##-jar \
##$HOME/apps/gatk-4.4.0.0-21-g7415882-SNAPSHOT/gatk-package-4.4.0.0-21-g7415882-SNAPSHOT-local.jar \
##SortSam \
##I=/dev/stdin \
##O=$HOME/twg/assemblies/mapped/2009Arcata21/2009Arcata21_sortsam.bam \
##SO=coordinate \
##CREATE_INDEX=true \
##TMP_DIR=$HOME/twg/tmp \
##USE_JDK_DEFLATER=true \
##USE_JDK_INFLATER=true \
##2> $HOME/twg/assemblies/mapped/2009Arcata21/logs/2009Arcata21_sortsam.txt
