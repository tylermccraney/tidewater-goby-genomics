library(tidyverse)

setwd(dir="/Volumes/Tigrigobius/tgoby/vcfR/exons/info/")

filename <- dir(pattern="*.INFO")

dat <- 
  filename |> 
  map(
    \(filename) read_tsv(file=filename, col_types="cnccccc", na="?") |> 
      mutate(test=gsub(pattern=".INFO", replacement="", filename, fixed=TRUE))) |> 
  reduce(rbind)

dat <- 
  mutate(
    dat, 
    START=str_split_i(string=test, pattern="_", i=2) |> as.double(), 
    END=str_split_i(string=test, pattern="_", i=3) |> as.double(),
    ID=str_split_i(string=test, pattern="_", i=4)) |>
  select(-test) |> 
  arrange(CHROM, POS)

#dat <- read_tsv(file="info.tab", na="?") |> arrange(CHROM, POS)

dat <- 
  mutate(
    dat, 
    ALLELE=str_split_i(string=ANN, pattern="\\|", i=1), 
    ANNOTATION=str_split_i(string=ANN, pattern="\\|", i=2),
    ANNOTATION_IMPACT=str_split_i(string=ANN, pattern="\\|", i=3))

saveRDS(object=dat, file="../info.RDS")

write_tsv(dat, file="../info.tab", na="")

dat <- readRDS(file="../info.RDS")

unique(dat$ANNOTATION) |> sort()

group_by(dat, ANNOTATION_IMPACT) |> summarise(n=n())

filter(dat, ANNOTATION_IMPACT=="LOW") |> distinct(ANNOTATION)

gen <- readRDS(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.0/gene.gff3.RDS")

da1 <- left_join(x=dat, y=gen, by = c("ID"="mRNA_id"))




apo <- 
  filter(gen, grepl(pattern="lipopro", PANTHER_family_name, ignore.case=TRUE)) |> 
  distinct(id) |> 
  arrange(id) |> 
  filter(!is.na(id)) |> 
  mutate(id=gsub("STRG", "STRG.", id)|>paste0("^")) |> 
  pull()

for(ii in apo){filter(dat, grepl(pattern=apo[ii], ANN, ignore.case=FALSE, fixed=TRUE))}

filter(dat, grepl(pattern=apo[1], ANN, ignore.case=FALSE, fixed=TRUE))
filter(dat, grepl(pattern=apo[2], ANN, ignore.case=FALSE, fixed=TRUE))
filter(dat, grepl(pattern=apo[3], ANN, ignore.case=FALSE, fixed=TRUE))
filter(dat, grepl(pattern=apo[4], ANN, ignore.case=FALSE, fixed=TRUE))
filter(dat, grepl(pattern=apo[5], ANN, ignore.case=FALSE, fixed=TRUE))
filter(dat, grepl(pattern=apo[6], ANN, ignore.case=FALSE, fixed=TRUE))
filter(dat, grepl(pattern=apo[7], ANN, ignore.case=FALSE, fixed=TRUE))
filter(dat, grepl(pattern=apo[8], ANN, ignore.case=FALSE, fixed=TRUE))
filter(dat, grepl(pattern=apo[9], ANN, ignore.case=FALSE, fixed=TRUE))
filter(dat, grepl(pattern=apo[10], ANN, ignore.case=FALSE, fixed=TRUE))
filter(dat, grepl(pattern=apo[11], ANN, ignore.case=FALSE, fixed=TRUE))
filter(dat, grepl(pattern=apo[12], ANN, ignore.case=FALSE, fixed=TRUE))
filter(dat, grepl(pattern=apo[13], ANN, ignore.case=FALSE, fixed=TRUE))
filter(dat, grepl(pattern=apo[14], ANN, ignore.case=FALSE, fixed=TRUE))
filter(dat, grepl(pattern=apo[15], ANN, ignore.case=FALSE, fixed=TRUE))
filter(dat, grepl(pattern=apo[16], ANN, ignore.case=FALSE, fixed=TRUE))
filter(dat, grepl(pattern=apo[17], ANN, ignore.case=FALSE, fixed=TRUE))
filter(dat, grepl(pattern=apo[18], ANN, ignore.case=FALSE, fixed=TRUE))
filter(dat, grepl(pattern=apo[19], ANN, ignore.case=FALSE, fixed=TRUE))
filter(dat, grepl(pattern=apo[20], ANN, ignore.case=FALSE, fixed=TRUE))
filter(dat, grepl(pattern=apo[21], ANN, ignore.case=FALSE, fixed=TRUE))
filter(dat, grepl(pattern=apo[22], ANN, ignore.case=FALSE, fixed=TRUE))
filter(dat, grepl(pattern=apo[23], ANN, ignore.case=FALSE, fixed=TRUE))
filter(dat, grepl(pattern=apo[24], ANN, ignore.case=FALSE, fixed=TRUE))
filter(dat, grepl(pattern=apo[25], ANN, ignore.case=FALSE, fixed=TRUE))
filter(dat, grepl(pattern=apo[26], ANN, ignore.case=FALSE, fixed=TRUE))
filter(dat, grepl(pattern=apo[27], ANN, ignore.case=FALSE, fixed=TRUE))
filter(dat, grepl(pattern=apo[28], ANN, ignore.case=FALSE, fixed=TRUE))
filter(dat, grepl(pattern=apo[29], ANN, ignore.case=FALSE, fixed=TRUE))
filter(dat, grepl(pattern=apo[30], ANN, ignore.case=FALSE, fixed=TRUE))
filter(dat, grepl(pattern=apo[31], ANN, ignore.case=FALSE, fixed=TRUE))
filter(dat, grepl(pattern=apo[32], ANN, ignore.case=FALSE, fixed=TRUE))
filter(dat, grepl(pattern=apo[33], ANN, ignore.case=FALSE, fixed=TRUE))
filter(dat, grepl(pattern=apo[34], ANN, ignore.case=FALSE, fixed=TRUE))
filter(dat, grepl(pattern=apo[35], ANN, ignore.case=FALSE, fixed=TRUE)) |> print(n=100)
filter(dat, grepl(pattern=apo[36], ANN, ignore.case=FALSE, fixed=TRUE)) |> print(n=100)
filter(dat, grepl(pattern=apo[37], ANN, ignore.case=FALSE, fixed=TRUE)) |> print(n=100)
filter(dat, grepl(pattern=apo[38], ANN, ignore.case=FALSE, fixed=TRUE))
filter(dat, grepl(pattern=apo[39], ANN, ignore.case=FALSE, fixed=TRUE))
filter(dat, grepl(pattern=apo[40], ANN, ignore.case=FALSE, fixed=TRUE))

filter(dat, grepl(pattern="STRG.8634^", ANN, ignore.case=FALSE, fixed=TRUE))

apo[c(8, 15, 16, 36, 37, 40)]

filter(dat, grepl(pattern=apo[8], ANN, ignore.case=FALSE, fixed=TRUE))
filter(dat, grepl(pattern=apo[15], ANN, ignore.case=FALSE, fixed=TRUE))
filter(dat, grepl(pattern=apo[16], ANN, ignore.case=FALSE, fixed=TRUE))
filter(dat, grepl(pattern=apo[36], ANN, ignore.case=FALSE, fixed=TRUE)) |> print(n=100)
filter(dat, grepl(pattern=apo[37], ANN, ignore.case=FALSE, fixed=TRUE)) |> print(n=100)
filter(dat, grepl(pattern=apo[40], ANN, ignore.case=FALSE, fixed=TRUE))
