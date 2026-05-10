library(tidyverse)

iHS <- read_tsv(file="/Volumes/Tigrigobius/tgoby/ihs/iHS.outliers.p01.intervals.tab")
D <- read_tsv(file="/Volumes/Tigrigobius/tgoby/stats/D/outliers.p01.intervals.tab")
xpnsl <- read_tsv(file="/Volumes/Tigrigobius/tgoby/xpnsl/phased/outliers.p01.intervals.tab")
xpclr <- read_tsv(file="/Volumes/Tigrigobius/tgoby/xpclr/redo/outliers.p01.intervals.tab") |> filter(samplesB!="NorteHumboldtMendocino")

group_by(D, TEST) |> summarise(N=n(), MIN_LENGTH=min(LENGTH), MAX_LENGTH=max(LENGTH), AVG_LENGTH=mean(LENGTH), SD_LENGTH=sd(LENGTH)) |> arrange(desc(N))
group_by(iHS, POP) |> summarise(N=n(), MIN_LENGTH=min(LENGTH), MAX_LENGTH=max(LENGTH), AVG_LENGTH=mean(LENGTH), SD_LENGTH=sd(LENGTH), MIN_N_SNPS=min(N_SNPS), MAX_N_SNPS=max(N_SNPS), AVG_N_SNPS=mean(N_SNPS), SD_N_SNPS=sd(N_SNPS))
group_by(xpclr, samplesA) |> summarise(N=n(), MIN_LENGTH=min(length), MAX_LENGTH=max(length), AVG_LENGTH=mean(length), SD_LENGTH=sd(length)) |> arrange(desc(N))
group_by(xpnsl, samplesA) |> summarise(N=n(), MIN_LENGTH=min(length), MAX_LENGTH=max(length), AVG_LENGTH=mean(length), SD_LENGTH=sd(length), MIN_N_SNPS=min(n_snps), MAX_N_SNPS=max(n_snps), AVG_N_SNPS=mean(n_snps), SD_N_SNPS=sd(n_snps))

