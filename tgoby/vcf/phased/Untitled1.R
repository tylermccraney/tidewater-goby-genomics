library(tidyverse)

d1 <- read_tsv(file="NorteHumboldt.mac.kept.sites")
d2 <- read_tsv(file="Mendocino.mac.kept.sites")
d3 <- read_tsv(file="SantaBarbara.mac.kept.sites")

d1d2 <- full_join(x=d1, y=d2) |> arrange(`#CHROM`, POS)
d1d3 <- full_join(x=d1, y=d3) |> arrange(`#CHROM`, POS)
d2d3 <- full_join(x=d2, y=d3) |> arrange(`#CHROM`, POS)

d1d2d3 <- full_join(x=d1d2, y=d3) |> arrange(`#CHROM`, POS)

write_tsv(d1d2, file="NorteHumboldt_Mendocino.mac.kept.sites")
write_tsv(d1d3, file="NorteHumboldt_SantaBarbara.mac.kept.sites")
write_tsv(d2d3, file="Mendocino_SantaBarbara.mac.kept.sites")

write_tsv(d1d2d3, file="NorteHumboldt_Mendocino_SantaBarbara.mac.kept.sites")
