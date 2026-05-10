#!/bin/bash

busco \
-c 16 \
-i /home/wtm3/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna \
-l actinopterygii_odb10 \
-m genome \
-o busco \
--out_path /home/wtm3/twg/assemblies/reference/fEucNew1.0.hap1

busco \
-c 16 \
-i /home/wtm3/twg/assemblies/reference/fEucNew1.0.hap2/GCA_026437355.1_fEucNew1.0.hap2_genomic.fna \
-l actinopterygii_odb10 \
-m genome \
-o busco \
--out_path /home/wtm3/twg/assemblies/reference/fEucNew1.0.hap2
