#!/bin/bash

##for i in {0000..0039}
##do
##bayescenv \
##$HOME/twg/popgen/bayescenv/snps/interval.$i.snps.recode.txt \
##-env $HOME/twg/popgen/bayescenv/env/ANN_PRCP_NORMAL_SCALED.txt \
##-o interval.$i.snps \
##-threads 8 \
##-out_pilot \
##-out_freq \
##&
##done
##wait

##for i in {0000..0039}
##do
##bayescenv \
##$HOME/twg/popgen/bayescenv/snps/interval.$i.snps.recode.txt \
##-env $HOME/twg/popgen/bayescenv/env/ANN_TAVG_NORMAL_SCALED.txt \
##-o interval.$i.snps \
##-threads 8 \
##-out_pilot \
##-out_freq \
##&
##done
##wait

for i in {0000..0039}
do
bayescenv \
$HOME/twg/popgen/bayescenv/snps.100p/interval.$i.snps.100p.recode.txt \
-env $HOME/twg/popgen/bayescenv/env/MonthlyClimateData1981-2010/ANN_PRCP_NORMAL_SCALED.txt \
-o $HOME/twg/popgen/bayescenv/precipitation.100p/interval.$i.snps.100p \
-threads 8 \
-out_pilot \
-out_freq \
&
done
wait

for i in {0000..0039}
do
bayescenv \
$HOME/twg/popgen/bayescenv/snps.100p/interval.$i.snps.100p.recode.txt \
-env $HOME/twg/popgen/bayescenv/env/MonthlyClimateData1981-2010/ANN_TAVG_NORMAL_SCALED.txt \
-o $HOME/twg/popgen/bayescenv/temperature.100p/interval.$i.snps.100p \
-threads 8 \
-out_pilot \
-out_freq \
&
done
wait

