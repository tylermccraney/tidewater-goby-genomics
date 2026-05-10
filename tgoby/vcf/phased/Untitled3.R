library(tidyverse)

d1 <- read_tsv(file="NorteHumboldt.mac.kept.sites")
d2 <- read_tsv(file="Mendocino.mac.kept.sites")
d3 <- read_tsv(file="SantaBarbara.mac.kept.sites")

d1d2 <- inner_join(x=d1, y=d2) |> arrange(`#CHROM`, POS)
d1d3 <- inner_join(x=d1, y=d3) |> arrange(`#CHROM`, POS)
d2d3 <- inner_join(x=d2, y=d3) |> arrange(`#CHROM`, POS)

d1d2d3 <- inner_join(x=d1d2, y=d3) |> arrange(`#CHROM`, POS)

write_tsv(d1d2d3, file="NorteHumboldt_Mendocino_SantaBarbara.mac.common.sites")

dd1 <- read_tsv(file="NorteHumboldt.kept.sites")
dd2 <- read_tsv(file="Mendocino.kept.sites")
dd3 <- read_tsv(file="SantaBarbara.kept.sites")

dd1dd2 <- inner_join(x=dd1, y=dd2) |> arrange(CHROM, POS)
dd1dd3 <- inner_join(x=dd1, y=dd3) |> arrange(CHROM, POS)
dd2dd3 <- inner_join(x=dd2, y=dd3) |> arrange(CHROM, POS)

dd1dd2dd3 <- inner_join(x=dd1dd2, y=dd3) |> arrange(CHROM, POS)

write_tsv(dd1dd2dd3, file="NorteHumboldt_Mendocino_SantaBarbara.common.sites")

