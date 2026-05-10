library(tidyverse)

read.counts <- 
  bind_cols(
    read_tsv(file = "/Volumes/Tigrigobius/tgoby/report/index.tab", col_names = "X1"),
    read_tsv(file = "/Volumes/Tigrigobius/tgoby/report/count.tab", col_names = "X2"))

read.counts <- read.counts[-33:-35,]

group_by(read.counts, X1) |> summarise(X3=sum(X2)) |> arrange(desc(X3)) |> print(n = 102) |> pull(X3) |> sd()

