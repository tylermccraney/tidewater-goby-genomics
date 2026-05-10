library(tidyverse)

d1 <- read_tsv(file="DelNorte.kept.sites")
d2 <- read_tsv(file="Humboldt.kept.sites")
d3 <- read_tsv(file="Mendocino.kept.sites")
d4 <- read_tsv(file="NorthSantaBarbara.kept.sites")
d5 <- read_tsv(file="SouthSantaBarbara.kept.sites")

d1d2 <- inner_join(x=d1, y=d2) |> arrange(`#CHROM`, POS)
d3d4 <- inner_join(x=d3, y=d4) |> arrange(`#CHROM`, POS)

d1d2d3d4 <- inner_join(x=d1d2, y=d3d4) |> arrange(`#CHROM`, POS)

d1d2d3d4d5 <- inner_join(x=d1d2d3d4, y=d5) |> arrange(`#CHROM`, POS)

write_tsv(d1d2d3d4d5, file="DelNorte_Humboldt_Mendocino_NorthSantaBarbara_SouthSantaBarbara.common.sites")

