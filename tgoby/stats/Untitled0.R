library(tidyverse)

setwd(dir="/Volumes/Tigrigobius/tgoby/stats/")

D <- read_tsv(file="D/D.populations.tab")


fst <- 
  bind_rows(
    read_tsv(file="fst/NorteHumboldt1.1250159.100Kb.windowed.weir.fst") |> mutate(POP="Del Norte-Humboldt"),
    read_tsv(file="fst/Mendocino1.1250159.100Kb.windowed.weir.fst") |> mutate(POP="Mendocino"),
    read_tsv(file="fst/SantaBarbara.1250159.100Kb.windowed.weir.fst") |> mutate(POP="Santa Barbara")) |>
  mutate(CHROM=str_extract(string=CHROM, pattern="JAPEHO0100000(\\d\\d)\\.1", group=1)|> as.double())
fst

dat <- inner_join(x=D, y=fst, by=join_by(CHROM, BIN_START, POP))

filter(dat, TEST=="2014Paredon") |> ggplot(mapping=aes(x=WEIGHTED_FST, y=TajimaD)) + geom_point()

ggplot(
  data=inner_join(
    x=filter(dat, TEST=="2006Pudding"), 
    y=filter(dat, TEST=="2021Pudding"), 
    by=join_by(CHROM, BIN_START, BPcum, POP, BIN_END, N_VARIANTS, WEIGHTED_FST, MEAN_FST)), 
  mapping=aes(x=TajimaD.x, y=TajimaD.y)) + geom_point()


