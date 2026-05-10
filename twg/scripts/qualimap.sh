#!/bin/bash

source activate gatk

#qualimap \
#bamqc -nt 40 \
#-bam /home/instr1/twg/assemblies/mapped/2006Big13/2006Big13_HY3NLDSX2_L3_mergebamalignment.bam \
#-outdir /home/instr1/twg/assemblies/mapped/2006Big13/graphics \
#--java-mem-size=4G

qualimap \
bamqc -nt 40 \
-bam /home/instr1/twg/assemblies/mapped/2006Big19/2006Big19_HY3NLDSX2_L3_mergebamalignment.bam \
-outdir /home/instr1/twg/assemblies/mapped/2006Big19/graphics \
--java-mem-size=4G

qualimap \
bamqc -nt 40 \
-bam /home/instr1/twg/assemblies/mapped/2006Big20/2006Big20_HY3NLDSX2_L3_mergebamalignment.bam \
-outdir /home/instr1/twg/assemblies/mapped/2006Big20/graphics \
--java-mem-size=4G

qualimap \
bamqc -nt 40 \
-bam /home/instr1/twg/assemblies/mapped/2006Pudding16/2006Pudding16_HJLYTDSX2_L4_mergebamalignment.bam \
-outdir /home/instr1/twg/assemblies/mapped/2006Pudding16/graphics \
--java-mem-size=4G

qualimap \
bamqc -nt 40 \
-bam /home/instr1/twg/assemblies/mapped/2006Pudding21/2006Pudding21_HJLYTDSX2_L1_mergebamalignment.bam \
-outdir /home/instr1/twg/assemblies/mapped/2006Pudding21/graphics \
--java-mem-size=4G

qualimap \
bamqc -nt 40 \
-bam /home/instr1/twg/assemblies/mapped/2006Stone03/2006Stone03_HJLYTDSX2_L4_mergebamalignment.bam \
-outdir /home/instr1/twg/assemblies/mapped/2006Stone03/graphics \
--java-mem-size=4G

qualimap \
bamqc -nt 40 \
-bam /home/instr1/twg/assemblies/mapped/2006Stone09/2006Stone09_HJLYTDSX2_L4_mergebamalignment.bam \
-outdir /home/instr1/twg/assemblies/mapped/2006Stone09/graphics \
--java-mem-size=4G

qualimap \
bamqc -nt 40 \
-bam /home/instr1/twg/assemblies/mapped/2006Virgin40/2006Virgin40_HVWV2DSX2_L2_mergebamalignment.bam \
-outdir /home/instr1/twg/assemblies/mapped/2006Virgin40/graphics \
--java-mem-size=4G

qualimap \
bamqc -nt 40 \
-bam /home/instr1/twg/assemblies/mapped/2006Virgin45/2006Virgin45_HVWV2DSX2_L2_mergebamalignment.bam \
-outdir /home/instr1/twg/assemblies/mapped/2006Virgin45/graphics \
--java-mem-size=4G

qualimap \
bamqc -nt 40 \
-bam /home/instr1/twg/assemblies/mapped/2009Arcata20/2009Arcata20_H3JFWDSX3_L1_mergebamalignment.bam \
-outdir /home/instr1/twg/assemblies/mapped/2009Arcata20/graphics \
--java-mem-size=4G

qualimap \
bamqc -nt 40 \
-bam /home/instr1/twg/assemblies/mapped/2011Earl01/2011Earl01_HJLYTDSX2_L4_mergebamalignment.bam \
-outdir /home/instr1/twg/assemblies/mapped/2011Earl01/graphics \
--java-mem-size=4G

qualimap \
bamqc -nt 40 \
-bam /home/instr1/twg/assemblies/mapped/2011Earl02/2011Earl02_HJLYTDSX2_L4_mergebamalignment.bam \
-outdir /home/instr1/twg/assemblies/mapped/2011Earl02/graphics \
--java-mem-size=4G

qualimap \
bamqc -nt 40 \
-bam /home/instr1/twg/assemblies/mapped/2011Tillas14/2011Tillas14_HVWV2DSX2_L2_mergebamalignment.bam \
-outdir /home/instr1/twg/assemblies/mapped/2011Tillas14/graphics \
--java-mem-size=4G

qualimap \
bamqc -nt 40 \
-bam /home/instr1/twg/assemblies/mapped/2011Tillas19/2011Tillas19_HVWV2DSX2_L2_mergebamalignment.bam \
-outdir /home/instr1/twg/assemblies/mapped/2011Tillas19/graphics \
--java-mem-size=4G

qualimap \
bamqc -nt 40 \
-bam /home/instr1/twg/assemblies/mapped/2014Burro04/2014Burro04_HJLYTDSX2_L4_mergebamalignment.bam \
-outdir /home/instr1/twg/assemblies/mapped/2014Burro04/graphics \
--java-mem-size=4G

qualimap \
bamqc -nt 40 \
-bam /home/instr1/twg/assemblies/mapped/2014Burro13/2014Burro13_HW7NGDSX2_L4_mergebamalignment.bam \
-outdir /home/instr1/twg/assemblies/mapped/2014Burro13/graphics \
--java-mem-size=4G

qualimap \
bamqc -nt 40 \
-bam /home/instr1/twg/assemblies/mapped/2014Paredon02/2014Paredon02_HJLYTDSX2_L1_mergebamalignment.bam \
-outdir /home/instr1/twg/assemblies/mapped/2014Paredon02/graphics \
--java-mem-size=4G

qualimap \
bamqc -nt 40 \
-bam /home/instr1/twg/assemblies/mapped/2014Paredon18/2014Paredon18_HVWVVDSX2_L3_mergebamalignment.bam \
-outdir /home/instr1/twg/assemblies/mapped/2014Paredon18/graphics \
--java-mem-size=4G

qualimap \
bamqc -nt 40 \
-bam /home/instr1/twg/assemblies/mapped/2017Antonio17/2017Antonio17_HW7NGDSX2_L3_mergebamalignment.bam \
-outdir /home/instr1/twg/assemblies/mapped/2017Antonio17/graphics \
--java-mem-size=4G

qualimap \
bamqc -nt 40 \
-bam /home/instr1/twg/assemblies/mapped/2017Ynez13/2017Ynez13_HW7NGDSX2_L3_mergebamalignment.bam \
-outdir /home/instr1/twg/assemblies/mapped/2017Ynez13/graphics \
--java-mem-size=4G

qualimap \
bamqc -nt 40 \
-bam /home/instr1/twg/assemblies/mapped/2017Ynez14/2017Ynez14_HW7NGDSX2_L3_mergebamalignment.bam \
-outdir /home/instr1/twg/assemblies/mapped/2017Ynez14/graphics \
--java-mem-size=4G

qualimap \
bamqc -nt 40 \
-bam /home/instr1/twg/assemblies/mapped/2021Big01/2021Big01_H3JFWDSX3_L1_mergebamalignment.bam \
-outdir /home/instr1/twg/assemblies/mapped/2021Big01/graphics \
--java-mem-size=4G

qualimap \
bamqc -nt 40 \
-bam /home/instr1/twg/assemblies/mapped/2021Virgin02/2021Virgin02_HW7NGDSX2_L2_mergebamalignment.bam \
-outdir /home/instr1/twg/assemblies/mapped/2021Virgin02/graphics \
--java-mem-size=4G

qualimap \
bamqc -nt 40 \
-bam /home/instr1/twg/assemblies/mapped/2021Virgin08/2021Virgin08_HW7NGDSX2_L2_mergebamalignment.bam \
-outdir /home/instr1/twg/assemblies/mapped/2021Virgin08/graphics \
--java-mem-size=4G

