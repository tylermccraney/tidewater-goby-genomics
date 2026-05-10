library(tidyverse)

dat <- read_tsv(file="/Users/bimaculata/Downloads/attributes (3).tsv")

dat <- filter(dat, !collection_date%in% c("2009-05-27", "1988-10-24"))

sampsizes <- group_by(dat, isolation_source, collection_date) |> count()

dat <- group_by(dat, isolation_source, collection_date) |> distinct(collection_date, .keep_all=TRUE) |> select(accession, collection_date, geo_loc_name, isolation_source, lat_lon)

dat <- left_join(dat, sampsizes)

dat$geo_loc_name <- gsub(pattern="USA: California, ", replacement="", dat$geo_loc_name) |> gsub(pattern=" County", replacement="")

dat <- rename(dat, County=geo_loc_name, Site=isolation_source)

write_tsv(dat, file="/Volumes/Tigrigobius/tgoby/report/samples.tab")

ldepth <- read_tsv(file="/Volumes/Tigrigobius/tgoby/stats/depth/snps.recode.ldepth.mean")
mean(ldepth$MEAN_DEPTH)

idepth <- read_tsv(file="/Volumes/Tigrigobius/tgoby/stats/depth/snps.recode.idepth")

idepth <- mutate(idepth, POP=str_extract(string=INDV, pattern="\\d{4}(\\w+)\\d{2}", group=1))
group_by(idepth, POP) |> summarise(X=mean(MEAN_DEPTH)|>round()) |> arrange(X)

mean(idepth$MEAN_DEPTH) |> round()
sd(idepth$MEAN_DEPTH) |> round()
min(idepth$MEAN_DEPTH) |> round()
max(idepth$MEAN_DEPTH) |> round()

read_csv(file="/Volumes/Tigrigobius/tgoby/stats/phase/phase-switch-errors-pop-chrom.csv")

