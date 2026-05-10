library(tidyverse)

Genes <- 
  readRDS(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/Genes.RDS")

genes <- 
  filter(Genes, ORF_type=="complete") |>
  select(-type, -prostart, -proend, -attributes, -name)

genes <- 
  pivot_longer(genes, cols=2:3, names_to="feature", values_to="pos")

#
iHS2 <- readRDS(file="/Volumes/Tigrigobius/tgoby/ihs/selscan/gmap/iHS.100Kb.RDS")
nSL2 <- readRDS(file="/Volumes/Tigrigobius/tgoby/nsl/selscan/nSL.100Kb.RDS")
XPCLR <- readRDS(file="/Volumes/Tigrigobius/tgoby/xpclr/redo2/XP-CLR.RDS")
XPnSL2 <- readRDS(file="/Volumes/Tigrigobius/tgoby/xpnsl/selscan/XP-nSL.100Kb.RDS")

windows <- unique(c(iHS2$START, nSL2$START, XPnSL2$START, XPCLR$start)) |> sort()

genes <- 
  mutate(genes, window=cut(pos, breaks=c(windows, 54300001), labels=windows, include.lowest=TRUE))

group_by(genes, seqid, window, feature) |> summarise(n=n()) |> arrange(seqid, window, feature)

filter(genes, is.na(window))

ngenes <-
  group_by(genes, gene_id, window) |> 
  summarise(n=n()) |> 
  filter(n==1) |> 
  arrange(gene_id, window) |> 
  mutate(window=as.character(window)|>as.numeric(), panes=(lead(window)-window+100000)/100000) |>
  filter(!is.na(panes)) |>
  arrange(desc(panes)) |>
  select(-n) |>
  ungroup()
ngenes

ngenes$window <- factor(ngenes$window, levels=windows)

genes <- left_join(genes, ngenes)

genes <- 
  replace_na(data=genes, replace=list(panes=1))

genes <- 
  mutate(genes, window=as.integer(as.character(window)))

filter(genes, feature=="start")

Genes <- 
  left_join(
    x=Genes, 
    y=genes, 
    by=join_by(seqid, length, distance, overlapping, strand, ORF_type, gene_id, UniProtKB, gene, organism, mRNA_id, PANTHER_accession, PANTHER_family_name)) |> 
  select(-feature, -pos) |>
  filter(!is.na(window)) |>
  distinct(gene_id, .keep_all=TRUE)

Genes <- 
  rowwise(Genes) |> mutate(windows=list(seq.int(from=window, length.out=panes, by=100000)))

gene.windows <- 
  unnest_longer(select(Genes, -window), windows, values_to="window")

saveRDS(object=gene.windows, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/gene.windows.RDS")
write_tsv(gene.windows, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/gene.windows.tsv")

distinct(gene.windows, gene_id)

gene.windows <- 
  group_by(gene.windows, seqid, window) |> mutate(genes=list(gene_id))

window.genes <- 
  unnest_longer(select(gene.windows, seqid, window, genes), genes, values_to="gene_id") |> 
  ungroup()

window.genes <- 
  distinct(window.genes)

saveRDS(object=window.genes, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/window.genes.RDS")
write_tsv(window.genes, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/window.genes.tsv")

iHS2 <- 
  inner_join(x=window.genes, y=iHS2, by=join_by(seqid==CHROM, window==START), relationship="many-to-many") |> 
  rename(CHROM=seqid, START=window, STRG=gene_id)

nSL2 <- 
  inner_join(x=window.genes, y=nSL2, by=join_by(seqid==CHROM, window==START), relationship="many-to-many") |> 
  rename(CHROM=seqid, START=window, STRG=gene_id)

XPCLR <- 
  inner_join(x=window.genes, y=ungroup(XPCLR)|>select(-chrom, -tot, -id), by=join_by(seqid==chr, window==start), relationship="many-to-many") |> 
  rename(chr=seqid, start=window, STRG=gene_id)

XPnSL2 <- 
  inner_join(x=window.genes, y=XPnSL2, by=join_by(seqid==chr, window==START), relationship="many-to-many") |> 
  rename(CHROM=seqid, START=window, STRG=gene_id)

#
iHS2 <- 
  group_by(iHS2, STRG, POP) |> 
  slice_max(PROP_CRIT, with_ties=TRUE) |> 
  slice_max(MAX_SCORE, with_ties=FALSE) |> 
  arrange(CHROM, START, STRG, POP) |>
  ungroup()

nSL2 <- 
  group_by(nSL2, STRG, POP) |> 
  slice_max(PROP_CRIT, with_ties=TRUE) |> 
  slice_max(MAX_SCORE, with_ties=FALSE) |> 
  arrange(CHROM, START, STRG, POP) |>
  ungroup()

XPnSL2 <- 
  group_by(XPnSL2, STRG, samplesA, samplesB) |> 
  slice_max(PROP_CRIT1, with_ties=TRUE) |> 
  slice_max(MAX_SCORE, with_ties=FALSE) |> 
  arrange(CHROM, START, STRG, samplesA, samplesB) |>
  ungroup()

XPCLR <- 
  group_by(XPCLR, STRG, samplesA, samplesB) |> 
  slice_max(xpclr_norm, with_ties=TRUE) |> 
  slice_max(sel_coef, with_ties=FALSE) |> 
  arrange(chr, start, STRG, samplesA, samplesB) |>
  ungroup()

ggplot(nSL2, aes(x=N_SCORES, y=PROP_CRIT)) + geom_point(shape=1) + geom_smooth(method="lm")
ggplot(XPCLR, aes(x=sel_coef, y=xpclr_norm)) + geom_point(shape=1) + geom_smooth(method="lm")
cor.test(XPCLR$nSNPs, XPCLR$xpclr_norm, method="spearman")
cor.test(iHS2$N_SCORES, iHS2$PROP_CRIT, method="spearman")

iHS2 <- 
  group_by(iHS2, POP) |> 
  mutate(QUAN=cut(N_SCORES, breaks=quantile(iHS2$N_SCORES, probs=seq(0, 1, 0.1)), labels=as.character(1:10), include.lowest=TRUE)) |> 
  ungroup()

iHS2 <- 
  left_join(
    x=iHS2, 
    y=group_by(iHS2, POP, QUAN)|>slice_max(PROP_CRIT, prop=0.01)|>ungroup()|>mutate(CANDIDATE=TRUE), 
    by=join_by(CHROM, START, STRG, END, N_SCORES, PROP_CRIT, PERCENTILE, MAX_SCORE, POP, BPcum, QUAN))

iHS2 <- 
  replace_na(data=iHS2, replace=list(CANDIDATE=FALSE))

nSL2 <- 
  group_by(nSL2, POP) |> 
  mutate(QUAN=cut(N_SCORES, breaks=quantile(nSL2$N_SCORES, probs=seq(0, 1, 0.1)), labels=as.character(1:10), include.lowest=TRUE)) |> 
  ungroup()

nSL2 <- 
  left_join(
    x=nSL2, 
    y=group_by(nSL2, POP, QUAN)|>slice_max(PROP_CRIT, prop=0.01)|>ungroup()|>mutate(CANDIDATE=TRUE), 
    by=join_by(CHROM, START, STRG, END, N_SCORES, PROP_CRIT, PERCENTILE, MAX_SCORE, POP, BPcum, QUAN))

nSL2 <- 
  replace_na(data=nSL2, replace=list(CANDIDATE=FALSE))

XPnSL2 <- 
  group_by(XPnSL2, samplesA, samplesB) |> 
  mutate(QUAN=cut(N_SCORES, breaks=quantile(XPnSL2$N_SCORES, probs=seq(0, 1, 0.1)), labels=as.character(1:10), include.lowest=TRUE)) |> 
  ungroup()

XPnSL2 <- 
  left_join(
    x=XPnSL2, 
    y=group_by(XPnSL2, samplesA, samplesB, QUAN)|>slice_max(PROP_CRIT1, prop=0.01)|>ungroup()|>mutate(CANDIDATE=TRUE),
    by=join_by(CHROM, START, STRG, END, N_SCORES, PROP_CRIT1, PROP_CRIT2, PERCENTILE1, PERCENTILE2, MAX_SCORE, MIN_SCORE, samplesA, samplesB, BPcum, POP, QUAN))

XPnSL2 <- 
  replace_na(data=XPnSL2, replace=list(CANDIDATE=FALSE))

XPCLR <- 
  group_by(XPCLR, samplesA, samplesB) |> 
  mutate(QUAN=cut(nSNPs, breaks=quantile(XPCLR$nSNPs, probs=seq(0, 1, 0.1)), labels=as.character(1:10), include.lowest=TRUE)) |> 
  ungroup()

XPCLR <- 
  left_join(
    x=XPCLR, 
    y=group_by(XPCLR, samplesA, samplesB, QUAN)|>slice_max(xpclr_norm, prop=0.01)|>ungroup()|>mutate(CANDIDATE=TRUE), 
    by=join_by(chr, start, STRG, stop, pos_start, pos_stop, modelL, nullL, sel_coef, nSNPs, nSNPs_avail, xpclr, xpclr_norm, samplesA, samplesB, BPcum, rank, upper99, upper999, QUAN))

XPCLR <- 
  replace_na(data=XPCLR, replace=list(CANDIDATE=FALSE))

########################

# import genome scan results
iHS <- 
  readRDS(file="/Volumes/Tigrigobius/tgoby/ihs/selscan/gmap/iHS.RDS") |> 
  arrange(POP, CHROM, POS)

nSL <- 
  readRDS(file="/Volumes/Tigrigobius/tgoby/nsl/selscan/nSL.RDS") |> 
  arrange(POP, CHROM, POS)

XPnSL <- 
  readRDS(file="/Volumes/Tigrigobius/tgoby/xpnsl/selscan/XP-nSL.RDS") |> 
  arrange(samplesA, samplesB, chr, pos)

## group_by(iHS, POP) |> filter(CHROM==Genes$seqid[1], between(POS, left=Genes$start[1], right=Genes$end[1]))
##
## cc <- 1:20475
##
## iHSg <- 
##   cc |> 
##   map(
##     \(cc) filter(iHS, CHROM==Genes$seqid[cc], between(POS, left=Genes$start[cc], right=Genes$end[cc])) |>
##       mutate(STRG=Genes$gene_id[cc])) |>
##   reduce(rbind)
##
## distinct(iHSg, STRG)
##
## saveRDS(object=iHSg, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/iHS.site.genes.RDS")
## write_tsv(iHSg, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/iHS.site.genes.tab")
##
## nSLg <- 
##   cc |> 
##   map(
##     \(cc) filter(nSL, CHROM==Genes$seqid[cc], between(POS, left=Genes$start[cc], right=Genes$end[cc])) |>
##       mutate(STRG=Genes$gene_id[cc])) |>
##   reduce(rbind)
##
## distinct(nSLg, STRG)
##
## saveRDS(object=nSLg, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/nSL.site.genes.RDS")
## write_tsv(nSLg, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/nSL.site.genes.tab")
##
## XPnSLg <- 
##   cc |> 
##   map(
##     \(cc) filter(XPnSL, chr==Genes$seqid[cc], between(pos, left=Genes$start[cc], right=Genes$end[cc])) |>
##       mutate(STRG=Genes$gene_id[cc])) |>
##   reduce(rbind)
##
## distinct(XPnSLg, STRG)
##
## saveRDS(object=XPnSLg, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-nSL.site.genes.RDS")
## write_tsv(XPnSLg, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-nSL.site.genes.tab")

iHSg <- readRDS(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/iHS.site.genes.RDS")
nSLg <- readRDS(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/nSL.site.genes.RDS")
XPnSLg <- readRDS(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-nSL.site.genes.RDS")

iHSg <- filter(iHSg, STRG%in%Genes$gene_id)
nSLg <- filter(nSLg, STRG%in%Genes$gene_id)
XPnSLg <- filter(XPnSLg, STRG%in%Genes$gene_id)


iHSg <- 
  group_by(iHSg, POP, STRG)|>slice_max(ABS_iHS, with_ties=FALSE)|>ungroup()

iHSg <- 
  left_join(
    x=iHSg, 
    y=group_by(iHSg, POP)|>slice_max(ABS_iHS, prop=0.01, with_ties=TRUE)|>mutate(CANDIDATE=TRUE)|>ungroup(), 
    by=join_by(CHROM, POS, freq, iHS, crit, POP, BPcum, ABS_iHS, RANK_ABS_iHS, UPPER_ABS_iHS_99, UPPER_ABS_iHS_999, STRG)) |>
  arrange(POP, CHROM, POS)

iHSg <- 
  replace_na(data=iHSg, replace=list(CANDIDATE=FALSE))

nSLg <- 
  group_by(nSLg, POP, STRG)|>slice_max(ABS_nSL, with_ties=FALSE)|>ungroup()

nSLg <- 
  left_join(
    x=nSLg, 
    y=group_by(nSLg, POP)|>slice_max(ABS_nSL, prop=0.01, with_ties=TRUE)|>mutate(CANDIDATE=TRUE)|>ungroup(), 
    by=join_by(CHROM, POS, freq, nSL, crit, POP, BPcum, ABS_nSL, RANK_ABS_nSL, UPPER_ABS_nSL_99, UPPER_ABS_nSL_999, STRG)) |>
  arrange(POP, CHROM, POS)

nSLg <- 
  replace_na(data=nSLg, replace=list(CANDIDATE=FALSE))

XPnSLg <- 
  group_by(XPnSLg, samplesA, samplesB, STRG)|>slice_max(xpnsl_norm, with_ties=FALSE)|>ungroup()

XPnSLg <- 
  left_join(
    x=XPnSLg, 
    y=group_by(XPnSLg, samplesA, samplesB)|>slice_max(xpnsl_norm, prop=0.01, with_ties=TRUE)|>mutate(CANDIDATE=TRUE)|>ungroup(),
    by=join_by(chr, pos, BPcum, gpos, p1, sL1, p2, sL2, xpnsl, xpnsl_norm, crit, samplesA, samplesB, rank, upper99, upper999, POP, STRG)) |>
  arrange(samplesA, samplesB, chr, pos)

XPnSLg <- 
  replace_na(data=XPnSLg, replace=list(CANDIDATE=FALSE))

dat <- 
  bind_rows(
    select(iHSg, CHROM, POS, POP1=POP, STRG, SCORE=ABS_iHS, CANDIDATE)|>mutate(POP1=as.character(POP1), POP2=NA, STAT="iHS", N_SCORES=1, QUAN=NA),
    select(iHS2, CHROM, POS=START, POP1=POP, STRG, SCORE=PROP_CRIT, N_SCORES, QUAN, CANDIDATE)|>mutate(POP1=as.character(POP1), POP2=NA, STAT="iHS2"),
    select(nSLg, CHROM, POS, POP1=POP, STRG, SCORE=ABS_nSL, CANDIDATE)|>mutate(POP1=as.character(POP1), POP2=NA, STAT="nSL", N_SCORES=1, QUAN=NA),
    select(nSL2, CHROM, POS=START, POP1=POP, STRG, SCORE=PROP_CRIT, N_SCORES, QUAN, CANDIDATE)|>mutate(POP1=as.character(POP1), POP2=NA, STAT="nSL2"),
    select(XPnSLg, CHROM=chr, POS=pos, POP1=samplesA, POP2=samplesB, STRG, SCORE=xpnsl_norm, CANDIDATE)|>mutate(STAT="XP-nSL", N_SCORES=1, QUAN=NA),
    select(XPnSL2, CHROM, POS=START, POP1=samplesA, POP2=samplesB, STRG, SCORE=PROP_CRIT1, N_SCORES, QUAN, CANDIDATE)|>mutate(STAT="XP-nSL2"),
    select(XPCLR, CHROM=chr, POS=start, POP1=samplesA, POP2=samplesB, STRG, SCORE=xpclr_norm, N_SCORES=nSNPs, QUAN, CANDIDATE)|>mutate(STAT="XP-CLR")) |>
  select(chr=CHROM, pos=POS, stat=STAT, pop1=POP1, pop2=POP2, gene_id=STRG, score=SCORE, n_snps=N_SCORES, n_snps_quantile=QUAN, candidate=CANDIDATE) |>
  left_join(y=select(Genes, gene_id, PANTHER_accession, PANTHER_family_name), by=join_by(gene_id))

unique(dat$stat);unique(dat$pop1);unique(dat$pop2)

dat$pop1 <- gsub(pattern="SantaBarbara", replacement="Santa Barbara", x=dat$pop1)
dat$pop1 <- gsub(pattern="NorteHumboldt$", replacement="Del Norte-Humboldt", x=dat$pop1)
dat$pop2 <- gsub(pattern="SantaBarbara", replacement="Santa Barbara", x=dat$pop2)
dat$pop2 <- gsub(pattern="NorteHumboldt$", replacement="Del Norte-Humboldt", x=dat$pop2)
dat$pop2 <- gsub(pattern="NorteHumboldtMendocino", replacement="Del Norte-Humboldt-Mendocino", x=dat$pop2)
dat$pop2 <- gsub(pattern="Santa\nBarbara", replacement="Santa Barbara", x=dat$pop2)
dat$pop2 <- gsub(pattern="Del Norte\nHumboldt$", replacement="Del Norte-Humboldt", x=dat$pop2)

unique(dat$stat);unique(dat$pop1);unique(dat$pop2)

dat <- 
  arrange(dat, stat, pop1, pop2, chr, pos)

saveRDS(object=dat, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/Candidate.Genes.RDS")
write_tsv(dat, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/Candidate.Genes.tsv")

dat

filter(dat, pop1=="Del Norte-Humboldt", stat=="iHS", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/iHS_NorteHumboldt", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", stat=="iHS") |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/iHS_NorteHumboldt_REF", col_names=FALSE)

filter(dat, pop1=="Mendocino", stat=="iHS", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/iHS_Mendocino", col_names=FALSE)

filter(dat, pop1=="Mendocino", stat=="iHS") |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/iHS_Mendocino_REF", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", stat=="iHS", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/iHS_SantaBarbara", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", stat=="iHS") |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/iHS_SantaBarbara_REF", col_names=FALSE)

#
filter(dat, pop1=="Del Norte-Humboldt", stat=="iHS2", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/iHS2_NorteHumboldt", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", stat=="iHS2") |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/iHS2_NorteHumboldt_REF", col_names=FALSE)

filter(dat, pop1=="Mendocino", stat=="iHS2", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/iHS2_Mendocino", col_names=FALSE)

filter(dat, pop1=="Mendocino", stat=="iHS2") |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/iHS2_Mendocino_REF", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", stat=="iHS2", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/iHS2_SantaBarbara", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", stat=="iHS2") |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/iHS2_SantaBarbara_REF", col_names=FALSE)

#
filter(dat, pop1=="Del Norte-Humboldt", stat=="nSL", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/nSL_NorteHumboldt", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", stat=="nSL") |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/nSL_NorteHumboldt_REF", col_names=FALSE)

filter(dat, pop1=="Mendocino", stat=="nSL", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/nSL_Mendocino", col_names=FALSE)

filter(dat, pop1=="Mendocino", stat=="nSL") |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/nSL_Mendocino_REF", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", stat=="nSL", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/nSL_SantaBarbara", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", stat=="nSL") |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/nSL_SantaBarbara_REF", col_names=FALSE)

#
filter(dat, pop1=="Del Norte-Humboldt", stat=="nSL2", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/nSL2_NorteHumboldt", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", stat=="nSL2") |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/nSL2_NorteHumboldt_REF", col_names=FALSE)

filter(dat, pop1=="Mendocino", stat=="nSL2", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/nSL2_Mendocino", col_names=FALSE)

filter(dat, pop1=="Mendocino", stat=="nSL2") |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/nSL2_Mendocino_REF", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", stat=="nSL2", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/nSL2_SantaBarbara", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", stat=="nSL2") |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/nSL2_SantaBarbara_REF", col_names=FALSE)

#
filter(dat, pop1=="Del Norte-Humboldt", pop2=="Mendocino", stat=="XP-nSL", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-nSL_NorteHumboldt_Mendocino", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", pop2=="Mendocino", stat=="XP-nSL") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-nSL_NorteHumboldt_Mendocino_REF", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", pop2=="Santa Barbara", stat=="XP-nSL", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-nSL_NorteHumboldt_SantaBarbara", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", pop2=="Santa Barbara", stat=="XP-nSL") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-nSL_NorteHumboldt_SantaBarbara_REF", col_names=FALSE)

filter(dat, pop1=="Mendocino", pop2=="Del Norte-Humboldt", stat=="XP-nSL", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-nSL_Mendocino_NorteHumboldt", col_names=FALSE)

filter(dat, pop1=="Mendocino", pop2=="Del Norte-Humboldt", stat=="XP-nSL") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-nSL_Mendocino_NorteHumboldt_REF", col_names=FALSE)

filter(dat, pop1=="Mendocino", pop2=="Santa Barbara", stat=="XP-nSL", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-nSL_Mendocino_SantaBarbara", col_names=FALSE)

filter(dat, pop1=="Mendocino", pop2=="Santa Barbara", stat=="XP-nSL") |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-nSL_Mendocino_SantaBarbara_REF", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", pop2=="Del Norte-Humboldt", stat=="XP-nSL", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-nSL_SantaBarbara_NorteHumboldt", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", pop2=="Del Norte-Humboldt", stat=="XP-nSL") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-nSL_SantaBarbara_NorteHumboldt_REF", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", pop2=="Mendocino", stat=="XP-nSL", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-nSL_SantaBarbara_Mendocino", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", pop2=="Mendocino", stat=="XP-nSL") |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-nSL_SantaBarbara_Mendocino_REF", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", stat=="XP-nSL", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-nSL_NorteHumboldt", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", stat=="XP-nSL") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-nSL_NorteHumboldt_REF", col_names=FALSE)

filter(dat, pop1=="Mendocino", stat=="XP-nSL", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-nSL_Mendocino", col_names=FALSE)

filter(dat, pop1=="Mendocino", stat=="XP-nSL") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-nSL_Mendocino_REF", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", stat=="XP-nSL", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-nSL_SantaBarbara", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", stat=="XP-nSL") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-nSL_SantaBarbara_REF", col_names=FALSE)

#
filter(dat, pop1=="Del Norte-Humboldt", pop2=="Mendocino", stat=="XP-nSL2", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-nSL2_NorteHumboldt_Mendocino", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", pop2=="Mendocino", stat=="XP-nSL2") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-nSL2_NorteHumboldt_Mendocino_REF", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", pop2=="Santa Barbara", stat=="XP-nSL2", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-nSL2_NorteHumboldt_SantaBarbara", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", pop2=="Santa Barbara", stat=="XP-nSL2") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-nSL2_NorteHumboldt_SantaBarbara_REF", col_names=FALSE)

filter(dat, pop1=="Mendocino", pop2=="Del Norte-Humboldt", stat=="XP-nSL2", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-nSL2_Mendocino_NorteHumboldt", col_names=FALSE)

filter(dat, pop1=="Mendocino", pop2=="Del Norte-Humboldt", stat=="XP-nSL2") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-nSL2_Mendocino_NorteHumboldt_REF", col_names=FALSE)

filter(dat, pop1=="Mendocino", pop2=="Santa Barbara", stat=="XP-nSL2", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-nSL2_Mendocino_SantaBarbara", col_names=FALSE)

filter(dat, pop1=="Mendocino", pop2=="Santa Barbara", stat=="XP-nSL2") |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-nSL2_Mendocino_SantaBarbara_REF", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", pop2=="Del Norte-Humboldt", stat=="XP-nSL2", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-nSL2_SantaBarbara_NorteHumboldt", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", pop2=="Del Norte-Humboldt", stat=="XP-nSL2") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-nSL2_SantaBarbara_NorteHumboldt_REF", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", pop2=="Mendocino", stat=="XP-nSL2", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-nSL2_SantaBarbara_Mendocino", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", pop2=="Mendocino", stat=="XP-nSL2") |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-nSL2_SantaBarbara_Mendocino_REF", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", stat=="XP-nSL2", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-nSL2_NorteHumboldt", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", stat=="XP-nSL2") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-nSL2_NorteHumboldt_REF", col_names=FALSE)

filter(dat, pop1=="Mendocino", stat=="XP-nSL2", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-nSL2_Mendocino", col_names=FALSE)

filter(dat, pop1=="Mendocino", stat=="XP-nSL2") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-nSL2_Mendocino_REF", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", stat=="XP-nSL2", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-nSL2_SantaBarbara", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", stat=="XP-nSL2") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-nSL2_SantaBarbara_REF", col_names=FALSE)

#
filter(dat, pop1=="Del Norte-Humboldt", pop2=="Mendocino", stat=="XP-CLR", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-CLR_NorteHumboldt_Mendocino", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", pop2=="Mendocino", stat=="XP-CLR") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-CLR_NorteHumboldt_Mendocino_REF", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", pop2=="Santa Barbara", stat=="XP-CLR", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-CLR_NorteHumboldt_SantaBarbara", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", pop2=="Santa Barbara", stat=="XP-CLR") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-CLR_NorteHumboldt_SantaBarbara_REF", col_names=FALSE)

filter(dat, pop1=="Mendocino", pop2=="Del Norte-Humboldt", stat=="XP-CLR", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-CLR_Mendocino_NorteHumboldt", col_names=FALSE)

filter(dat, pop1=="Mendocino", pop2=="Del Norte-Humboldt", stat=="XP-CLR") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-CLR_Mendocino_NorteHumboldt_REF", col_names=FALSE)

filter(dat, pop1=="Mendocino", pop2=="Santa Barbara", stat=="XP-CLR", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-CLR_Mendocino_SantaBarbara", col_names=FALSE)

filter(dat, pop1=="Mendocino", pop2=="Santa Barbara", stat=="XP-CLR") |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-CLR_Mendocino_SantaBarbara_REF", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", pop2=="Del Norte-Humboldt", stat=="XP-CLR", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-CLR_SantaBarbara_NorteHumboldt", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", pop2=="Del Norte-Humboldt", stat=="XP-CLR") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-CLR_SantaBarbara_NorteHumboldt_REF", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", pop2=="Mendocino", stat=="XP-CLR", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-CLR_SantaBarbara_Mendocino", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", pop2=="Mendocino", stat=="XP-CLR") |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-CLR_SantaBarbara_Mendocino_REF", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", stat=="XP-CLR", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-CLR_NorteHumboldt", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", stat=="XP-CLR") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-CLR_NorteHumboldt_REF", col_names=FALSE)

filter(dat, pop1=="Mendocino", stat=="XP-CLR", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-CLR_Mendocino", col_names=FALSE)

filter(dat, pop1=="Mendocino", stat=="XP-CLR") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-CLR_Mendocino_REF", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", stat=="XP-CLR", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-CLR_SantaBarbara", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", stat=="XP-CLR") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-CLR_SantaBarbara_REF", col_names=FALSE)

##
filter(dat, pop1=="Del Norte-Humboldt", stat%in%c("iHS", "nSL", "XP-nSL"), candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/iHS_nSL_XP-nSL_NorteHumboldt", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", stat%in%c("iHS", "nSL", "XP-nSL")) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/iHS_nSL_XP-nSL_NorteHumboldt_REF", col_names=FALSE)

filter(dat, pop1=="Mendocino", stat%in%c("iHS", "nSL", "XP-nSL"), candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/iHS_nSL_XP-nSL_Mendocino", col_names=FALSE)

filter(dat, pop1=="Mendocino", stat%in%c("iHS", "nSL", "XP-nSL")) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/iHS_nSL_XP-nSL_Mendocino_REF", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", stat%in%c("iHS", "nSL", "XP-nSL"), candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/iHS_nSL_XP-nSL_SantaBarbara", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", stat%in%c("iHS", "nSL", "XP-nSL")) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/iHS_nSL_XP-nSL_SantaBarbara_REF", col_names=FALSE)

##
filter(dat, pop1=="Del Norte-Humboldt", stat%in%c("iHS2", "nSL2", "XP-nSL2", "XP-CLR"), candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/iHS2_nSL2_XP-nSL2_XP-CLR_NorteHumboldt", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", stat%in%c("iHS2", "nSL2", "XP-nSL2", "XP-CLR")) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/iHS2_nSL2_XP-nSL2_XP-CLR_NorteHumboldt_REF", col_names=FALSE)

filter(dat, pop1=="Mendocino", stat%in%c("iHS2", "nSL2", "XP-nSL2", "XP-CLR"), candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/iHS2_nSL2_XP-nSL2_XP-CLR_Mendocino", col_names=FALSE)

filter(dat, pop1=="Mendocino", stat%in%c("iHS2", "nSL2", "XP-nSL2", "XP-CLR")) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/iHS2_nSL2_XP-nSL2_XP-CLR_Mendocino_REF", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", stat%in%c("iHS2", "nSL2", "XP-nSL2", "XP-CLR"), candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/iHS2_nSL2_XP-nSL2_XP-CLR_SantaBarbara", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", stat%in%c("iHS2", "nSL2", "XP-nSL2", "XP-CLR")) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/iHS2_nSL2_XP-nSL2_XP-CLR_SantaBarbara_REF", col_names=FALSE)

##
filter(dat, pop1=="Del Norte-Humboldt", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/NorteHumboldt", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/NorteHumboldt_REF", col_names=FALSE)

filter(dat, pop1=="Mendocino", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/Mendocino", col_names=FALSE)

filter(dat, pop1=="Mendocino") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/Mendocino_REF", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/SantaBarbara", col_names=FALSE)

filter(dat, pop1=="Santa Barbara") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/SantaBarbara_REF", col_names=FALSE)

## top 10 candidate genes
#top10 <- 
  filter(dat, candidate==TRUE) |> 
  group_by(stat, pop1, pop2) |> 
  slice_max(score, n=10, with_ties=TRUE) |> 
  arrange(chr, pos, stat, pop1, pop2) |>
#  ungroup()
  group_by(PANTHER_family_name) |> 
  count(sort=TRUE)
  
##
filter(top10, pop1=="Del Norte-Humboldt", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/top10_NorteHumboldt", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/top10_NorteHumboldt_REF", col_names=FALSE)

filter(top10, pop1=="Mendocino", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/top10_Mendocino", col_names=FALSE)

filter(dat, pop1=="Mendocino") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/top10_Mendocino_REF", col_names=FALSE)

filter(top10, pop1=="Santa Barbara", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/top10_SantaBarbara", col_names=FALSE)

filter(dat, pop1=="Santa Barbara") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/top10_SantaBarbara_REF", col_names=FALSE)















info <- read_tsv(file="/Volumes/Tigrigobius/tgoby/vcfR/exons/info.tab")

info <- mutate(info, CHROM=str_extract(string=CHROM, pattern="JAPEHO010+(\\d+)\\.1", group=1)|>as.numeric())

group_by(info, ANNOTATION) |> count()

semi_join(x=info, y=Genes, by=join_by(CHROM==seqid, ID==mRNA_id))

filter(info, CHROM==13, between(POS, left=14000001, right=18000000)) |> view()

muts <-
  bind_rows(
    left_join(x=iHS, y=info, by=join_by(CHROM, POS), relationship="many-to-many"),
    left_join(x=nSL, y=info, by=join_by(CHROM, POS), relationship="many-to-many"),
    inner_join(x=XPnSL, y=info, by=c("chr"="CHROM", "mRNA_id"="ID", "xpnsl_pos"="POS")) |> select(CHROM=chrom, POS=xpnsl_pos, REF, ALT, START_exon=START, END_exon=END, ANNOTATION, ANNOTATION_IMPACT, ORF_type, ID=mRNA_id, GENE=gene, PANTHER_accession, PANTHER_family_name, SCORE=xpnsl_norm, POP=xpnsl_pop, OG=xpnsl_og, LOC=loc) |> mutate(STAT="XP-nSL")) |>
  arrange(CHROM, POS, POP, OG, STAT) |>
  relocate(OG, STAT, .after=POP)
muts





#####################################
## EDA
#####################################

genome.gff3
Genes.conservative1$mRNA_id

CDS <- 
  filter(genome.gff3, type=="CDS") |>
  mutate(
    mRNA_id=str_extract(group=1, string=attributes, pattern="Parent=(STRG.\\d+\\.\\d+.p\\d+)")) |>
  select(-source, -score, -attributes)

CDS <- filter(CDS, mRNA_id%in%Genes.conservative1$mRNA_id) |> arrange(seqid, start)

group_by(CDS, seqid) |> mutate(length=end-start, tostart=lead(start)-end) |> arrange(length)

##seqid	source	type	start	end	score	strand	phase	attributes
CDS <- 
  mutate(CDS, attributes=paste0("Parent=", mRNA_id), source=".", score=".") |> 
  select(-mRNA_id) |> 
  relocate(seqid, source, type, start, end, score, strand, phase, attributes)

CDS$seqid <- factor(CDS$seqid, labels=c(paste0("JAPEHO01000000", 1:9, ".1"), paste0("JAPEHO0100000", 10:22, ".1")))

CDS <- rename(CDS, `##seqid`=seqid)

write_tsv(CDS, file="../vcfR/exons/cds.gff")



genome.gff3$seqid <- factor(genome.gff3$seqid, labels=c(paste0("JAPEHO01000000", 1:9, ".1"), paste0("JAPEHO0100000", 10:22, ".1")))

write_tsv(genome.gff3, file="genome.gff3", na=".", col_names=FALSE)

system("ls")

system(command="gff3_gene_to_gtf_format.pl /Volumes/Tigrigobius/tgoby/genes/genome.gff3 /Volumes/Tigrigobius/twg/assemblies/reference/fEucNew1.0.hap1/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna > /Volumes/Tigrigobius/tgoby/genes/genome.gtf")


gtf <- 
  mutate(
    genome.gff3, 
    ID=str_extract(group=1, string=attributes, pattern="ID=(.+);"),
    Parent=str_extract(group=1, string=attributes, pattern="Parent=(STRG.\\d+\\.*\\d*.p*\\d*)"), 
    Name=str_extract(string=attributes, pattern="Name=\"(ORF type:\\w+)", group=1))

filter(gtf, Name=="ORF type:complete") |> arrange(seqid, start) |> view()

gtf <- filter(gtf, mRNA_id%in%Genes.conservative1$mRNA_id) |> arrange(seqid, start)
