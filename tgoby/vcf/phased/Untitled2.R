library(tidyverse)

d1 <- read_tsv(file="TillasEarl.kept.sites")
d2 <- read_tsv(file="BigStone.kept.sites")
d3 <- read_tsv(file="Virgin.kept.sites")
d4 <- read_tsv(file="Pudding.kept.sites")
d5 <- read_tsv(file="AntonioYnez.kept.sites")
d6 <- read_tsv(file="BurroParedon.kept.sites")

d1d2 <- inner_join(x=d1, y=d2) |> arrange(CHROM, POS)
d3d4 <- inner_join(x=d3, y=d4) |> arrange(CHROM, POS)
d5d6 <- inner_join(x=d5, y=d6) |> arrange(CHROM, POS)

d1d2d3d4 <- inner_join(x=d1d2, y=d3d4) |> arrange(CHROM, POS)
d1d2d3d4d5d6 <- inner_join(x=d1d2d3d4, y=d5d6) |> arrange(CHROM, POS)

write_tsv(d1d2d3d4d5d6, file="6pop.common.kept.sites")
