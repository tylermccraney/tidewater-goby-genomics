library(tidyverse)
library(ggvenn)
library(gridExtra)

gene.gff3 <- readRDS(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.0/gene.gff3.RDS")
#gene.gff3 <- select(gene.gff3, -start, -end) |> rename(start=prostart, end=proend) |> arrange(seqid, start)

nSL <- read_tsv(file="/Volumes/Tigrigobius/tgoby/nsl/selscan/outliers.PROP_CRIT.tsv")

nSL <- filter(nSL, RANK_PROP_CRIT==1)

genes.within.regions <- 
  bind_rows(
    filter(gene.gff3, seqid==nSL$CHROM[1], start>=nSL$START[1] & end<=nSL$END[1]) |> mutate(nSL_start=nSL$START[1], nSL_end=nSL$END[1], nSL_pop=nSL$POP[1]),
    filter(gene.gff3, seqid==nSL$CHROM[2], start>=nSL$START[2] & end<=nSL$END[2]) |> mutate(nSL_start=nSL$START[2], nSL_end=nSL$END[2], nSL_pop=nSL$POP[2]),
    filter(gene.gff3, seqid==nSL$CHROM[3], start>=nSL$START[3] & end<=nSL$END[3]) |> mutate(nSL_start=nSL$START[3], nSL_end=nSL$END[3], nSL_pop=nSL$POP[3]),
    .id="outlier")
genes.within.regions


genes.starting.in.regions <- 
  bind_rows(
    filter(gene.gff3, seqid==nSL$CHROM[1], between(start, left=nSL$START[1], right=nSL$END[1])) |> mutate(nSL_start=nSL$START[1], nSL_end=nSL$END[1], nSL_pop=nSL$POP[1]),
    filter(gene.gff3, seqid==nSL$CHROM[2], between(start, left=nSL$START[2], right=nSL$END[2])) |> mutate(nSL_start=nSL$START[2], nSL_end=nSL$END[2], nSL_pop=nSL$POP[2]),
    filter(gene.gff3, seqid==nSL$CHROM[3], between(start, left=nSL$START[3], right=nSL$END[3])) |> mutate(nSL_start=nSL$START[3], nSL_end=nSL$END[3], nSL_pop=nSL$POP[3]),
    .id="outlier")
genes.starting.in.regions

genes.ending.in.regions <- 
  bind_rows(
    filter(gene.gff3, seqid==nSL$CHROM[1], between(end, left=nSL$START[1], right=nSL$END[1])) |> mutate(nSL_start=nSL$START[1], nSL_end=nSL$END[1], nSL_pop=nSL$POP[1]),
    filter(gene.gff3, seqid==nSL$CHROM[2], between(end, left=nSL$START[2], right=nSL$END[2])) |> mutate(nSL_start=nSL$START[2], nSL_end=nSL$END[2], nSL_pop=nSL$POP[2]),
    filter(gene.gff3, seqid==nSL$CHROM[3], between(end, left=nSL$START[3], right=nSL$END[3])) |> mutate(nSL_start=nSL$START[3], nSL_end=nSL$END[3], nSL_pop=nSL$POP[3]),
    .id="outlier")
genes.ending.in.regions

genes.across.regions <- 
  bind_rows(
    filter(gene.gff3, seqid==nSL$CHROM[1], start<=nSL$START[1] & end>=nSL$END[1]) |> mutate(nSL_start=nSL$START[1], nSL_end=nSL$END[1], nSL_pop=nSL$POP[1]),
    filter(gene.gff3, seqid==nSL$CHROM[2], start<=nSL$START[2] & end>=nSL$END[2]) |> mutate(nSL_start=nSL$START[2], nSL_end=nSL$END[2], nSL_pop=nSL$POP[2]),
    filter(gene.gff3, seqid==nSL$CHROM[3], start<=nSL$START[3] & end>=nSL$END[3]) |> mutate(nSL_start=nSL$START[3], nSL_end=nSL$END[3], nSL_pop=nSL$POP[3]),
    .id="outlier")
genes.across.regions

gene.hits.regions <- 
  bind_rows(genes.within.regions, genes.starting.in.regions, genes.ending.in.regions, genes.across.regions) |> 
  distinct(id, PANTHER_accession, nSL_pop, .keep_all=TRUE)

gene.hits.regions <- 
  rename(gene.hits.regions, region=outlier, chrom=seqid) |>
  arrange(chrom, start, nSL_pop)
  
gene.hits.regions <- mutate(gene.hits.regions, loc=paste0(chrom, ":", start, "–", end))
  
write_tsv(x=gene.hits.regions, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.3/nSL_PROP_CRIT.gene.hits.regions.tab")

saveRDS(object=gene.hits.regions, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.3/nSL_PROP_CRIT.gene.hits.regions.RDS")

