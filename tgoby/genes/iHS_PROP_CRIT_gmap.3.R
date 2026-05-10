library(tidyverse)
library(ggvenn)
library(gridExtra)

gene.gff3 <- readRDS(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.0/gene.gff3.RDS")
#gene.gff3 <- select(gene.gff3, -start, -end) |> rename(start=prostart, end=proend) |> arrange(seqid, start)

iHS <- read_tsv(file="/Volumes/Tigrigobius/tgoby/iHS/selscan/gmap/outliers.PROP_CRIT.tab", col_types="nnnnnnnnnncnnnncnn")

iHS <- filter(iHS, RANK_PROP_CRIT==1)

genes.within.regions <- 
  bind_rows(
    filter(gene.gff3, seqid==iHS$CHROM[1], start>=iHS$START[1] & end<=iHS$END[1]) |> mutate(iHS_start=iHS$START[1], iHS_end=iHS$END[1], iHS_pop=iHS$POP[1]),
    filter(gene.gff3, seqid==iHS$CHROM[2], start>=iHS$START[2] & end<=iHS$END[2]) |> mutate(iHS_start=iHS$START[2], iHS_end=iHS$END[2], iHS_pop=iHS$POP[2]),
    filter(gene.gff3, seqid==iHS$CHROM[3], start>=iHS$START[3] & end<=iHS$END[3]) |> mutate(iHS_start=iHS$START[3], iHS_end=iHS$END[3], iHS_pop=iHS$POP[3]),
    .id="outlier")
genes.within.regions

genes.starting.in.regions <- 
  bind_rows(
    filter(gene.gff3, seqid==iHS$CHROM[1], between(start, left=iHS$START[1], right=iHS$END[1])) |> mutate(iHS_start=iHS$START[1], iHS_end=iHS$END[1], iHS_pop=iHS$POP[1]),
    filter(gene.gff3, seqid==iHS$CHROM[2], between(start, left=iHS$START[2], right=iHS$END[2])) |> mutate(iHS_start=iHS$START[2], iHS_end=iHS$END[2], iHS_pop=iHS$POP[2]),
    filter(gene.gff3, seqid==iHS$CHROM[3], between(start, left=iHS$START[3], right=iHS$END[3])) |> mutate(iHS_start=iHS$START[3], iHS_end=iHS$END[3], iHS_pop=iHS$POP[3]),
    .id="outlier")
genes.starting.in.regions

genes.ending.in.regions <- 
  bind_rows(
    filter(gene.gff3, seqid==iHS$CHROM[1], between(end, left=iHS$START[1], right=iHS$END[1])) |> mutate(iHS_start=iHS$START[1], iHS_end=iHS$END[1], iHS_pop=iHS$POP[1]),
    filter(gene.gff3, seqid==iHS$CHROM[2], between(end, left=iHS$START[2], right=iHS$END[2])) |> mutate(iHS_start=iHS$START[2], iHS_end=iHS$END[2], iHS_pop=iHS$POP[2]),
    filter(gene.gff3, seqid==iHS$CHROM[3], between(end, left=iHS$START[3], right=iHS$END[3])) |> mutate(iHS_start=iHS$START[3], iHS_end=iHS$END[3], iHS_pop=iHS$POP[3]),
    .id="outlier")
genes.ending.in.regions

genes.across.regions <- 
  bind_rows(
    filter(gene.gff3, seqid==iHS$CHROM[1], start<=iHS$START[1] & end>=iHS$END[1]) |> mutate(iHS_start=iHS$START[1], iHS_end=iHS$END[1], iHS_pop=iHS$POP[1]),
    filter(gene.gff3, seqid==iHS$CHROM[2], start<=iHS$START[2] & end>=iHS$END[2]) |> mutate(iHS_start=iHS$START[2], iHS_end=iHS$END[2], iHS_pop=iHS$POP[2]),
    filter(gene.gff3, seqid==iHS$CHROM[3], start<=iHS$START[3] & end>=iHS$END[3]) |> mutate(iHS_start=iHS$START[3], iHS_end=iHS$END[3], iHS_pop=iHS$POP[3]),
    .id="outlier")
genes.across.regions

gene.hits.regions <- 
  bind_rows(genes.within.regions, genes.starting.in.regions, genes.ending.in.regions, genes.across.regions) |> 
  distinct(id, PANTHER_accession, iHS_pop, .keep_all=TRUE)

gene.hits.regions <- 
  rename(gene.hits.regions, region=outlier, chrom=seqid) |>
  arrange(chrom, start, iHS_pop)
  
gene.hits.regions <- mutate(gene.hits.regions, loc=paste0(chrom, ":", start, "–", end))
  
write_tsv(x=gene.hits.regions, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.3/iHS.gmap_PROP_CRIT.gene.hits.regions.tab")

saveRDS(object=gene.hits.regions, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.3/iHS.gmap_PROP_CRIT.gene.hits.regions.RDS")
