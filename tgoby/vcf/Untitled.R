library(tidyverse)

filename <- dir(pattern="*.removed.sites")

dat <- filename |> map(\(filename) read_tsv(file=filename)) |> reduce(rbind)

dat <- arrange(dat, CHROM, POS) |> distinct(CHROM, POS)

write_tsv(dat, file="snps_hwe_pop.removed.sites")
