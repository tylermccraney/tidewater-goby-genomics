library(tidyverse)
library(ggvenn)
library(gridExtra)

gene.gff3 <- readRDS(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.0/gene.gff3.RDS")
#gene.gff3 <- select(gene.gff3, -start, -end) |> rename(start=prostart, end=proend) |> arrange(seqid, start)

xpclr <- 
  read_tsv(file="/Volumes/Tigrigobius/tgoby/xpclr/redo2/outliers.tsv") |> 
  rename(CHROM=chr, START=start, END=stop, POP=samplesA, OG=samplesB) |>
  group_by(POP, OG) |> 
  slice_max(xpclr_norm, n=1) |> 
  arrange(POP, OG, BPcum) |>
  select(-chrom, -tot, -id, -modelL, -nullL, -sel_coef, -nSNPs_avail, -xpclr)

genes.within.regions <- 
  bind_rows(
    filter(gene.gff3, seqid==xpclr$CHROM[1], start>=xpclr$START[1] & end<=xpclr$END[1]) |> mutate(xpclr_start=xpclr$START[1], xpclr_end=xpclr$END[1], xpclr_pop=xpclr$POP[1], xpclr_og=xpclr$OG[1], xpclr_norm=xpclr$xpclr_norm[1]),
    filter(gene.gff3, seqid==xpclr$CHROM[2], start>=xpclr$START[2] & end<=xpclr$END[2]) |> mutate(xpclr_start=xpclr$START[2], xpclr_end=xpclr$END[2], xpclr_pop=xpclr$POP[2], xpclr_og=xpclr$OG[2], xpclr_norm=xpclr$xpclr_norm[2]),
    filter(gene.gff3, seqid==xpclr$CHROM[3], start>=xpclr$START[3] & end<=xpclr$END[3]) |> mutate(xpclr_start=xpclr$START[3], xpclr_end=xpclr$END[3], xpclr_pop=xpclr$POP[3], xpclr_og=xpclr$OG[3], xpclr_norm=xpclr$xpclr_norm[3]),
    filter(gene.gff3, seqid==xpclr$CHROM[4], start>=xpclr$START[4] & end<=xpclr$END[4]) |> mutate(xpclr_start=xpclr$START[4], xpclr_end=xpclr$END[4], xpclr_pop=xpclr$POP[4], xpclr_og=xpclr$OG[4], xpclr_norm=xpclr$xpclr_norm[4]),
    filter(gene.gff3, seqid==xpclr$CHROM[5], start>=xpclr$START[5] & end<=xpclr$END[5]) |> mutate(xpclr_start=xpclr$START[5], xpclr_end=xpclr$END[5], xpclr_pop=xpclr$POP[5], xpclr_og=xpclr$OG[5], xpclr_norm=xpclr$xpclr_norm[5]),
    filter(gene.gff3, seqid==xpclr$CHROM[6], start>=xpclr$START[6] & end<=xpclr$END[6]) |> mutate(xpclr_start=xpclr$START[6], xpclr_end=xpclr$END[6], xpclr_pop=xpclr$POP[6], xpclr_og=xpclr$OG[6], xpclr_norm=xpclr$xpclr_norm[6]),
    .id="outlier")
genes.within.regions


genes.starting.in.regions <- 
  bind_rows(
    filter(gene.gff3, seqid==xpclr$CHROM[1], between(start, left=xpclr$START[1], right=xpclr$END[1])) |> mutate(xpclr_start=xpclr$START[1], xpclr_end=xpclr$END[1], xpclr_pop=xpclr$POP[1], xpclr_og=xpclr$OG[1], xpclr_norm=xpclr$xpclr_norm[1]),
    filter(gene.gff3, seqid==xpclr$CHROM[2], between(start, left=xpclr$START[2], right=xpclr$END[2])) |> mutate(xpclr_start=xpclr$START[2], xpclr_end=xpclr$END[2], xpclr_pop=xpclr$POP[2], xpclr_og=xpclr$OG[2], xpclr_norm=xpclr$xpclr_norm[2]),
    filter(gene.gff3, seqid==xpclr$CHROM[3], between(start, left=xpclr$START[3], right=xpclr$END[3])) |> mutate(xpclr_start=xpclr$START[3], xpclr_end=xpclr$END[3], xpclr_pop=xpclr$POP[3], xpclr_og=xpclr$OG[3], xpclr_norm=xpclr$xpclr_norm[3]),
    filter(gene.gff3, seqid==xpclr$CHROM[4], between(start, left=xpclr$START[4], right=xpclr$END[4])) |> mutate(xpclr_start=xpclr$START[4], xpclr_end=xpclr$END[4], xpclr_pop=xpclr$POP[4], xpclr_og=xpclr$OG[4], xpclr_norm=xpclr$xpclr_norm[4]),
    filter(gene.gff3, seqid==xpclr$CHROM[5], between(start, left=xpclr$START[5], right=xpclr$END[5])) |> mutate(xpclr_start=xpclr$START[5], xpclr_end=xpclr$END[5], xpclr_pop=xpclr$POP[5], xpclr_og=xpclr$OG[5], xpclr_norm=xpclr$xpclr_norm[5]),
    filter(gene.gff3, seqid==xpclr$CHROM[6], between(start, left=xpclr$START[6], right=xpclr$END[6])) |> mutate(xpclr_start=xpclr$START[6], xpclr_end=xpclr$END[6], xpclr_pop=xpclr$POP[6], xpclr_og=xpclr$OG[6], xpclr_norm=xpclr$xpclr_norm[6]),
    .id="outlier")
genes.starting.in.regions

genes.ending.in.regions <- 
  bind_rows(
    filter(gene.gff3, seqid==xpclr$CHROM[1], between(end, left=xpclr$START[1], right=xpclr$END[1])) |> mutate(xpclr_start=xpclr$START[1], xpclr_end=xpclr$END[1], xpclr_pop=xpclr$POP[1], xpclr_og=xpclr$OG[1], xpclr_norm=xpclr$xpclr_norm[1]),
    filter(gene.gff3, seqid==xpclr$CHROM[2], between(end, left=xpclr$START[2], right=xpclr$END[2])) |> mutate(xpclr_start=xpclr$START[2], xpclr_end=xpclr$END[2], xpclr_pop=xpclr$POP[2], xpclr_og=xpclr$OG[2], xpclr_norm=xpclr$xpclr_norm[2]),
    filter(gene.gff3, seqid==xpclr$CHROM[3], between(end, left=xpclr$START[3], right=xpclr$END[3])) |> mutate(xpclr_start=xpclr$START[3], xpclr_end=xpclr$END[3], xpclr_pop=xpclr$POP[3], xpclr_og=xpclr$OG[3], xpclr_norm=xpclr$xpclr_norm[3]),
    filter(gene.gff3, seqid==xpclr$CHROM[4], between(end, left=xpclr$START[4], right=xpclr$END[4])) |> mutate(xpclr_start=xpclr$START[4], xpclr_end=xpclr$END[4], xpclr_pop=xpclr$POP[4], xpclr_og=xpclr$OG[4], xpclr_norm=xpclr$xpclr_norm[4]),
    filter(gene.gff3, seqid==xpclr$CHROM[5], between(end, left=xpclr$START[5], right=xpclr$END[5])) |> mutate(xpclr_start=xpclr$START[5], xpclr_end=xpclr$END[5], xpclr_pop=xpclr$POP[5], xpclr_og=xpclr$OG[5], xpclr_norm=xpclr$xpclr_norm[5]),
    filter(gene.gff3, seqid==xpclr$CHROM[6], between(end, left=xpclr$START[6], right=xpclr$END[6])) |> mutate(xpclr_start=xpclr$START[6], xpclr_end=xpclr$END[6], xpclr_pop=xpclr$POP[6], xpclr_og=xpclr$OG[6], xpclr_norm=xpclr$xpclr_norm[6]),
    .id="outlier")
genes.ending.in.regions

genes.across.regions <- 
  bind_rows(
    filter(gene.gff3, seqid==xpclr$CHROM[1], start<=xpclr$START[1] & end>=xpclr$END[1]) |> mutate(xpclr_start=xpclr$START[1], xpclr_end=xpclr$END[1], xpclr_pop=xpclr$POP[1], xpclr_og=xpclr$OG[1], xpclr_norm=xpclr$xpclr_norm[1]),
    filter(gene.gff3, seqid==xpclr$CHROM[2], start<=xpclr$START[2] & end>=xpclr$END[2]) |> mutate(xpclr_start=xpclr$START[2], xpclr_end=xpclr$END[2], xpclr_pop=xpclr$POP[2], xpclr_og=xpclr$OG[2], xpclr_norm=xpclr$xpclr_norm[2]),
    filter(gene.gff3, seqid==xpclr$CHROM[3], start<=xpclr$START[3] & end>=xpclr$END[3]) |> mutate(xpclr_start=xpclr$START[3], xpclr_end=xpclr$END[3], xpclr_pop=xpclr$POP[3], xpclr_og=xpclr$OG[3], xpclr_norm=xpclr$xpclr_norm[3]),
    filter(gene.gff3, seqid==xpclr$CHROM[4], start<=xpclr$START[4] & end>=xpclr$END[4]) |> mutate(xpclr_start=xpclr$START[4], xpclr_end=xpclr$END[4], xpclr_pop=xpclr$POP[4], xpclr_og=xpclr$OG[4], xpclr_norm=xpclr$xpclr_norm[4]),
    filter(gene.gff3, seqid==xpclr$CHROM[5], start<=xpclr$START[5] & end>=xpclr$END[5]) |> mutate(xpclr_start=xpclr$START[5], xpclr_end=xpclr$END[5], xpclr_pop=xpclr$POP[5], xpclr_og=xpclr$OG[5], xpclr_norm=xpclr$xpclr_norm[5]),
    filter(gene.gff3, seqid==xpclr$CHROM[6], start<=xpclr$START[6] & end>=xpclr$END[6]) |> mutate(xpclr_start=xpclr$START[6], xpclr_end=xpclr$END[6], xpclr_pop=xpclr$POP[6], xpclr_og=xpclr$OG[6], xpclr_norm=xpclr$xpclr_norm[6]),
    .id="outlier")
genes.across.regions

gene.hits.regions <- 
  bind_rows(genes.within.regions, genes.starting.in.regions, genes.ending.in.regions, genes.across.regions) |> 
  distinct(id, PANTHER_accession, xpclr_pop, xpclr_og, .keep_all=TRUE)

gene.hits.regions <- 
  rename(gene.hits.regions, region=outlier, chrom=seqid) |>
  arrange(region, chrom, start)

gene.hits.regions <- mutate(gene.hits.regions, loc=paste0(chrom, ":", start, "–", end))

write_tsv(x=gene.hits.regions, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.3/XP-CLR.maf.gene.hits.regions.tab")

saveRDS(object=gene.hits.regions, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.3/XP-CLR.maf.gene.hits.regions.RDS")
