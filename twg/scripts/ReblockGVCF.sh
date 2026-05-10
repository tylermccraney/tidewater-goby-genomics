#!/bin/bash

/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2006Big06/2006Big06_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2006Big06/2006Big06_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2006Big06/logs/2006Big06_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2006Big13/2006Big13_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2006Big13/2006Big13_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2006Big13/logs/2006Big13_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2006Big19/2006Big19_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2006Big19/2006Big19_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2006Big19/logs/2006Big19_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2006Big20/2006Big20_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2006Big20/2006Big20_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2006Big20/logs/2006Big20_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2006Big22/2006Big22_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2006Big22/2006Big22_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2006Big22/logs/2006Big22_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2006Big23/2006Big23_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2006Big23/2006Big23_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2006Big23/logs/2006Big23_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2006Pudding16/2006Pudding16_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2006Pudding16/2006Pudding16_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2006Pudding16/logs/2006Pudding16_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2006Pudding21/2006Pudding21_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2006Pudding21/2006Pudding21_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2006Pudding21/logs/2006Pudding21_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2006Pudding25/2006Pudding25_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2006Pudding25/2006Pudding25_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2006Pudding25/logs/2006Pudding25_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2006Pudding31/2006Pudding31_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2006Pudding31/2006Pudding31_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2006Pudding31/logs/2006Pudding31_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2006Pudding41/2006Pudding41_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2006Pudding41/2006Pudding41_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2006Pudding41/logs/2006Pudding41_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2006Pudding47/2006Pudding47_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2006Pudding47/2006Pudding47_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2006Pudding47/logs/2006Pudding47_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2006Stone03/2006Stone03_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2006Stone03/2006Stone03_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2006Stone03/logs/2006Stone03_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2006Stone09/2006Stone09_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2006Stone09/2006Stone09_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2006Stone09/logs/2006Stone09_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2006Stone30/2006Stone30_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2006Stone30/2006Stone30_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2006Stone30/logs/2006Stone30_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2006Stone31/2006Stone31_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2006Stone31/2006Stone31_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2006Stone31/logs/2006Stone31_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2006Stone32/2006Stone32_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2006Stone32/2006Stone32_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2006Stone32/logs/2006Stone32_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2006Stone37/2006Stone37_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2006Stone37/2006Stone37_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2006Stone37/logs/2006Stone37_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2006Virgin40/2006Virgin40_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2006Virgin40/2006Virgin40_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2006Virgin40/logs/2006Virgin40_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2006Virgin45/2006Virgin45_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2006Virgin45/2006Virgin45_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2006Virgin45/logs/2006Virgin45_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2006Virgin49/2006Virgin49_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2006Virgin49/2006Virgin49_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2006Virgin49/logs/2006Virgin49_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2006Virgin55/2006Virgin55_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2006Virgin55/2006Virgin55_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2006Virgin55/logs/2006Virgin55_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2006Virgin58/2006Virgin58_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2006Virgin58/2006Virgin58_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2006Virgin58/logs/2006Virgin58_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2006Virgin59/2006Virgin59_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2006Virgin59/2006Virgin59_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2006Virgin59/logs/2006Virgin59_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2009Arcata20/2009Arcata20_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2009Arcata20/2009Arcata20_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2009Arcata20/logs/2009Arcata20_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2009Arcata21/2009Arcata21_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2009Arcata21/2009Arcata21_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2009Arcata21/logs/2009Arcata21_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2011Earl01/2011Earl01_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2011Earl01/2011Earl01_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2011Earl01/logs/2011Earl01_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2011Earl02/2011Earl02_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2011Earl02/2011Earl02_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2011Earl02/logs/2011Earl02_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2011Earl03/2011Earl03_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2011Earl03/2011Earl03_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2011Earl03/logs/2011Earl03_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2011Earl04/2011Earl04_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2011Earl04/2011Earl04_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2011Earl04/logs/2011Earl04_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2011Earl09/2011Earl09_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2011Earl09/2011Earl09_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2011Earl09/logs/2011Earl09_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2011Earl10/2011Earl10_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2011Earl10/2011Earl10_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2011Earl10/logs/2011Earl10_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2011Tillas14/2011Tillas14_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2011Tillas14/2011Tillas14_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2011Tillas14/logs/2011Tillas14_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2011Tillas19/2011Tillas19_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2011Tillas19/2011Tillas19_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2011Tillas19/logs/2011Tillas19_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2011Tillas20/2011Tillas20_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2011Tillas20/2011Tillas20_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2011Tillas20/logs/2011Tillas20_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2011Tillas22/2011Tillas22_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2011Tillas22/2011Tillas22_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2011Tillas22/logs/2011Tillas22_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2011Tillas37/2011Tillas37_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2011Tillas37/2011Tillas37_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2011Tillas37/logs/2011Tillas37_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2011Tillas58/2011Tillas58_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2011Tillas58/2011Tillas58_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2011Tillas58/logs/2011Tillas58_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2014Burro04/2014Burro04_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2014Burro04/2014Burro04_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2014Burro04/logs/2014Burro04_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2014Burro13/2014Burro13_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2014Burro13/2014Burro13_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2014Burro13/logs/2014Burro13_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2014Burro15/2014Burro15_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2014Burro15/2014Burro15_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2014Burro15/logs/2014Burro15_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2014Burro16/2014Burro16_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2014Burro16/2014Burro16_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2014Burro16/logs/2014Burro16_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2014Burro19/2014Burro19_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2014Burro19/2014Burro19_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2014Burro19/logs/2014Burro19_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2014Burro20/2014Burro20_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2014Burro20/2014Burro20_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2014Burro20/logs/2014Burro20_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2014Paredon02/2014Paredon02_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2014Paredon02/2014Paredon02_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2014Paredon02/logs/2014Paredon02_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2014Paredon18/2014Paredon18_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2014Paredon18/2014Paredon18_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2014Paredon18/logs/2014Paredon18_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2014Paredon28/2014Paredon28_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2014Paredon28/2014Paredon28_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2014Paredon28/logs/2014Paredon28_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2014Paredon35/2014Paredon35_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2014Paredon35/2014Paredon35_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2014Paredon35/logs/2014Paredon35_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2014Paredon38/2014Paredon38_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2014Paredon38/2014Paredon38_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2014Paredon38/logs/2014Paredon38_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2014Paredon39/2014Paredon39_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2014Paredon39/2014Paredon39_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2014Paredon39/logs/2014Paredon39_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2017Antonio11/2017Antonio11_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2017Antonio11/2017Antonio11_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2017Antonio11/logs/2017Antonio11_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2017Antonio17/2017Antonio17_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2017Antonio17/2017Antonio17_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2017Antonio17/logs/2017Antonio17_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2017Antonio18/2017Antonio18_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2017Antonio18/2017Antonio18_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2017Antonio18/logs/2017Antonio18_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2017Antonio22/2017Antonio22_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2017Antonio22/2017Antonio22_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2017Antonio22/logs/2017Antonio22_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2017Antonio29/2017Antonio29_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2017Antonio29/2017Antonio29_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2017Antonio29/logs/2017Antonio29_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2017Antonio30/2017Antonio30_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2017Antonio30/2017Antonio30_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2017Antonio30/logs/2017Antonio30_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2017Ynez13/2017Ynez13_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2017Ynez13/2017Ynez13_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2017Ynez13/logs/2017Ynez13_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2017Ynez14/2017Ynez14_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2017Ynez14/2017Ynez14_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2017Ynez14/logs/2017Ynez14_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2017Ynez17/2017Ynez17_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2017Ynez17/2017Ynez17_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2017Ynez17/logs/2017Ynez17_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2017Ynez20/2017Ynez20_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2017Ynez20/2017Ynez20_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2017Ynez20/logs/2017Ynez20_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2017Ynez25/2017Ynez25_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2017Ynez25/2017Ynez25_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2017Ynez25/logs/2017Ynez25_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2017Ynez28/2017Ynez28_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2017Ynez28/2017Ynez28_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2017Ynez28/logs/2017Ynez28_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2021Big01/2021Big01_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2021Big01/2021Big01_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2021Big01/logs/2021Big01_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2021Big02/2021Big02_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2021Big02/2021Big02_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2021Big02/logs/2021Big02_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2021Big03/2021Big03_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2021Big03/2021Big03_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2021Big03/logs/2021Big03_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2021Big04/2021Big04_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2021Big04/2021Big04_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2021Big04/logs/2021Big04_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2021Big05/2021Big05_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2021Big05/2021Big05_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2021Big05/logs/2021Big05_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2021Big06/2021Big06_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2021Big06/2021Big06_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2021Big06/logs/2021Big06_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2021Pudding05/2021Pudding05_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2021Pudding05/2021Pudding05_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2021Pudding05/logs/2021Pudding05_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2021Pudding07/2021Pudding07_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2021Pudding07/2021Pudding07_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2021Pudding07/logs/2021Pudding07_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2021Pudding09/2021Pudding09_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2021Pudding09/2021Pudding09_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2021Pudding09/logs/2021Pudding09_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2021Pudding10/2021Pudding10_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2021Pudding10/2021Pudding10_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2021Pudding10/logs/2021Pudding10_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2021Pudding15/2021Pudding15_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2021Pudding15/2021Pudding15_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2021Pudding15/logs/2021Pudding15_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2021Pudding16/2021Pudding16_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2021Pudding16/2021Pudding16_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2021Pudding16/logs/2021Pudding16_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2021Stone01/2021Stone01_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2021Stone01/2021Stone01_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2021Stone01/logs/2021Stone01_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2021Stone02/2021Stone02_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2021Stone02/2021Stone02_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2021Stone02/logs/2021Stone02_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2021Stone04/2021Stone04_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2021Stone04/2021Stone04_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2021Stone04/logs/2021Stone04_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2021Stone05/2021Stone05_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2021Stone05/2021Stone05_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2021Stone05/logs/2021Stone05_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2021Stone07/2021Stone07_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2021Stone07/2021Stone07_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2021Stone07/logs/2021Stone07_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2021Stone08/2021Stone08_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2021Stone08/2021Stone08_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2021Stone08/logs/2021Stone08_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2021Virgin02/2021Virgin02_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2021Virgin02/2021Virgin02_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2021Virgin02/logs/2021Virgin02_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2021Virgin08/2021Virgin08_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2021Virgin08/2021Virgin08_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2021Virgin08/logs/2021Virgin08_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2021Virgin09/2021Virgin09_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2021Virgin09/2021Virgin09_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2021Virgin09/logs/2021Virgin09_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2021Virgin13/2021Virgin13_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2021Virgin13/2021Virgin13_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2021Virgin13/logs/2021Virgin13_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2021Virgin16/2021Virgin16_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2021Virgin16/2021Virgin16_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2021Virgin16/logs/2021Virgin16_reblock.g.vcf.txt \
& \
/home/instr1/apps/gatk/gatk \
--java-options "-Xmx3G -XX:+UseParallelGC -XX:ParallelGCThreads=1" \
ReblockGVCF \
--variant /home/instr1/twg/assemblies/mapped/2021Virgin17/2021Virgin17_haplotypecaller.g.vcf.gz \
--output /home/instr1/twg/assemblies/mapped/2021Virgin17/2021Virgin17_reblock.g.vcf.gz \
--reference /home/instr1/twg/assemblies/reference/fEucNew1.0/fEucNew1.0.p_ctg.fasta \
--keep-all-alts \
--tmp-dir /dev/shm/tmp \
--use-jdk-deflater \
--use-jdk-inflater \
2> /home/instr1/twg/assemblies/mapped/2021Virgin17/logs/2021Virgin17_reblock.g.vcf.txt
wait
