#!/bin/bash

gatk \
--java-options "-Xms10G -Xmx10G -XX:+UseParallelGC -XX:ParallelGCThreads=2" \
GenomicsDBImport \
--batch-size 50 \
--genomicsdb-workspace-path /home/wtm3/twg/variants/GenomicsDB \
--intervals /home/wtm3/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.interval_list \
--merge-contigs-into-num-partitions 50 \
--merge-input-intervals true \
--sample-name-map /home/wtm3/twg/scripts/sample_map.txt \
--tmp-dir /home/wtm3/twg/tmp \
2> /home/wtm3/twg/variants/logs/GenomicsDBImport.log

