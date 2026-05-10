library(tidyverse)

genome.gff3 <- 
  read_tsv(
    file="/Volumes/Tigrigobius/twg/rnaseq/transdecoder/transcripts.fasta.transdecoder.genome.chrom.gff3", 
    col_names=c("seqid", "source", "type", "start", "end", "score", "strand", "phase", "attributes"), 
    na=".")

genome.gff3 <- filter(genome.gff3, seqid%in%1:22)

gene.gff3 <- 
  filter(genome.gff3, type%in%c("gene", "mRNA")) |> 
  arrange(seqid, start, type)

gene.gff3 <- 
  mutate(
    gene.gff3, 
    ORF_type=str_extract(string=attributes, pattern="type:\\w+") %>% gsub(pattern="type:", replacement="", x=.),
    gene_id=str_extract(string=attributes, pattern="(STRG.\\d+)\\^", group=1), 
    mRNA_id=str_extract(string=attributes, pattern="STRG.\\d+\\.\\d+.p\\d+"), 
    UniProtKB=str_extract(string=attributes, pattern="sp\\|\\w+") %>% gsub(pattern="sp\\|", replacement="", x=.),
    name=str_extract(string=attributes, pattern="sp\\|\\w+\\|\\w+") %>% gsub(pattern="sp\\|\\w+\\|", replacement="", x=.),
    gene=str_extract(string=attributes, pattern="sp\\|\\w+\\|\\w+") %>% gsub(pattern="sp\\|\\w+\\|", replacement="", x=.) %>% str_split_i(pattern="_", i=1),
    organism=str_extract(string=attributes, pattern="sp\\|\\w+\\|\\w+") %>% gsub(pattern="sp\\|\\w+\\|", replacement="", x=.) %>% str_split_i(pattern="_", i=2),
    Pfam=str_extract_all(string=attributes, pattern="PF\\d+.\\d+") %>% map(unique),
    length=end-start) |>
  select(-source, -score, -phase) |>
  relocate(length, .after=end)
gene.gff3

mRNAs <- filter(gene.gff3, type=="mRNA")
Genes <- filter(gene.gff3, type=="gene")

panther18 <- 
  read_tsv(
    file="/Volumes/Tigrigobius/twg/rnaseq/transdecoder/transcripts.fasta.transdecoder.pep.split.pantherScore/pantherScore.tab", 
    col_names=c("id", "PANTHER_accession", "PANTHER_family_name", "HMM_evalue_score", "HMM_bit_score", "protein_align_range")) |> 
  arrange(id, PANTHER_accession) |>
  mutate(
    PTHR=str_extract(PANTHER_accession, pattern="PTHR(\\d{5})", group=1), 
    SF=str_extract(PANTHER_accession, pattern="SF(\\d+)", group=1)) |>
  relocate(PTHR, SF, .after=PANTHER_accession)
panther18

distinct(panther18, id)

anti_join(x=mRNAs, y=panther18, by=join_by(mRNA_id==id))

anti_join(x=panther18, y=mRNAs, by=join_by(id==mRNA_id))


mRNAs <- 
  left_join(x=mRNAs, y=panther18, by=join_by(mRNA_id==id)) |> arrange(mRNA_id, PANTHER_accession)

distinct(mRNAs, gene_id)

mRNAs <- 
  group_by(mRNAs, mRNA_id) |> slice_tail(n=1) |> ungroup()

nohits <- 
  filter(mRNAs, is.na(PANTHER_accession)) |> mutate(PANTHER_accession="NOHIT", PTHR="NOHIT", SF="NOHIT")

mRNAs <- 
  filter(mRNAs, !is.na(PANTHER_accession))

distinct(nohits, mRNA_id)

mRNAs <- 
  bind_rows(mRNAs, nohits) |> arrange(seqid, start, mRNA_id)

# find single best PANTHER_accession per mRNA
mRNAs1 <- 
  group_by(mRNAs, gene_id) |> 
  slice_min(HMM_evalue_score, with_ties=TRUE) |> 
  slice_max(HMM_bit_score, with_ties=FALSE)

# attach best PANTHER_accessions to genes
Genes <- 
  inner_join(
    x=select(Genes, -mRNA_id), 
    y=select(mRNAs1, seqid, gene_id, mRNA_id, PANTHER_accession, PANTHER_family_name, HMM_evalue_score, HMM_bit_score, protein_align_range), 
    by=join_by(seqid, gene_id)) |>
  arrange(seqid, start)
  
filter(Genes, PANTHER_accession=="NOHIT")

## characterize promoter regions
Genes <- 
  bind_rows(
    filter(Genes, strand=="+") |> mutate(prostart=start-1000) |> relocate(prostart, .before=start), 
    filter(Genes, strand=="-") |> mutate(proend=end+1000)) |> 
  arrange(seqid, start) |> 
  relocate(proend, .before=length)

Genes <- 
  mutate(
    Genes, 
    prostart=ifelse(test=is.na(prostart), yes=start, no=prostart), 
    proend=ifelse(test=is.na(proend), yes=end, no=proend))

Genes <- 
  arrange(Genes, seqid, start) |> 
  group_by(seqid) |> 
  mutate(distance=lead(start)-end) |> 
  relocate(distance, .after=length) |>
  ungroup()

## -E-values can be used as a reference for relatedness also as below:
##  -closely related: if the score is better than E-23 (very likely to be a correct functional assignment)  

closely_related <- filter(Genes, HMM_evalue_score<=1.0e-23)

##  -related : if the score is better than E-11, but worse than E-23 (molecular function likely to be the correct but biological process/pathway less certain) 

related <- filter(Genes, between(HMM_evalue_score, left=1.0e-23, right=1.0e-11))

##  -distantly related : if the score is better than E-3, but worse than E-11 (protein is evolutionarily related but function may have diverged) 

distantly_related <- filter(Genes, HMM_evalue_score>1.0e-11)

not_related <- filter(Genes, is.na(HMM_evalue_score))

## conservative dataset- count distantly and not related as NOHIT

Genes.conservative1 <- 
  bind_rows(closely_related, related, mutate(distantly_related, PANTHER_accession="NOHIT"), not_related) |> arrange(seqid, start)

#Genes.conservative2 <- bind_rows(closely_related, mutate(related, PANTHER_accession="NOHIT"), mutate(distantly_related, PANTHER_accession="NOHIT"), not_related) |> arrange(id)

arrange(Genes.conservative1, seqid, start) |> summarize(mean(length, na.rm=TRUE), sum(length, na.rm=TRUE), mean(distance, na.rm=TRUE))

Genes <- 
  arrange(Genes, seqid, start) |> mutate(overlapping=distance<0) |> relocate(overlapping, .before=strand)

Genes.conservative1 <- 
  arrange(Genes.conservative1, seqid, start) |> mutate(overlapping=distance<0) |> relocate(overlapping, .before=strand)

Genes$overlapping[is.na(Genes$overlapping)] <- FALSE
Genes.conservative1$overlapping[is.na(Genes.conservative1$overlapping)] <- FALSE

group_by(Genes.conservative1, overlapping, ORF_type) |> summarise(n())

mutate(select(Genes, -Pfam, -HMM_evalue_score, -HMM_bit_score, -protein_align_range), gene_id=gsub(pattern="\\.", replacement="", gene_id)) |> 
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/Genes.tsv")

mutate(select(Genes, -Pfam, -HMM_evalue_score, -HMM_bit_score, -protein_align_range), gene_id=gsub(pattern="\\.", replacement="", gene_id)) |> 
  saveRDS(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/Genes.RDS")

filter(Genes, is.na(UniProtKB), is.na(PANTHER_family_name)) |> group_by(ORF_type, overlapping) |> count()

genes <- 
  mutate(select(Genes, -type, -prostart, -proend, -attributes, -name, -Pfam, -HMM_evalue_score, -HMM_bit_score, -protein_align_range), gene_id=gsub(pattern="\\.", replacement="", gene_id))

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

ngenes <-
  group_by(genes, gene_id, window) |> 
  summarise(n=n()) |> 
  filter(n==1) |> 
  arrange(gene_id, window) |> 
  mutate(window=as.character(window)|>as.numeric(), panes=(lead(window)-window+100000)/100000) |>
  filter(!is.na(panes)) |>
  arrange(desc(panes)) |>
  select(-n) |>
  ungroup() |>
  mutate(window=as.factor(window))
ngenes

genes <- left_join(genes, ngenes)

genes <- mutate(genes, panes=if_else(condition=is.na(panes), true=1, false=panes))

genes <- mutate(genes, window=as.integer(as.character(window)))

filter(genes, feature=="start")

Genes <- 
  mutate(Genes, gene_id=gsub(pattern="\\.", replacement="", gene_id))

Genes <- 
  left_join(
    x=Genes, 
    y=genes, 
    by=join_by(seqid, length, distance, overlapping, strand, ORF_type, gene_id, UniProtKB, gene, organism, mRNA_id, PANTHER_accession, PANTHER_family_name)) |> 
  select(-feature, -pos)

Genes <- 
  distinct(Genes, gene_id, .keep_all=TRUE)

Genes <- 
  rowwise(Genes) |> mutate(windows=list(seq.int(from=window, length.out=panes, by=100000)))

gene.windows <- 
  unnest_longer(select(Genes, -window), windows, values_to="window")

saveRDS(object=gene.windows, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/gene.windows.RDS")
write_tsv(gene.windows, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/gene.windows.tsv")

distinct(gene.windows, gene_id)

gene.windows <- 
  group_by(gene.windows, seqid, window) |> mutate(genes=list(gene_id))

window.genes <- 
  unnest_longer(select(gene.windows, seqid, window, genes), genes, values_to="gene_id") |> 
  ungroup()

window.genes <- 
  distinct(window.genes)

saveRDS(object=window.genes, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/window.genes.RDS")
write_tsv(window.genes, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/window.genes.tsv")

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
## saveRDS(object=iHSg, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/iHS.site.genes.RDS")
## write_tsv(iHSg, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/iHS.site.genes.tab")
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
## saveRDS(object=nSLg, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/nSL.site.genes.RDS")
## write_tsv(nSLg, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/nSL.site.genes.tab")
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
## saveRDS(object=XPnSLg, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-nSL.site.genes.RDS")
## write_tsv(XPnSLg, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-nSL.site.genes.tab")

iHSg <- readRDS(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/iHS.site.genes.RDS")
nSLg <- readRDS(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/nSL.site.genes.RDS")
XPnSLg <- readRDS(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-nSL.site.genes.RDS")

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

saveRDS(object=dat, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/Candidate.Genes.RDS")
write_tsv(dat, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/Candidate.Genes.tsv")

dat

filter(dat, pop1=="Del Norte-Humboldt", stat=="iHS", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/iHS_NorteHumboldt", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", stat=="iHS") |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/iHS_NorteHumboldt_REF", col_names=FALSE)

filter(dat, pop1=="Mendocino", stat=="iHS", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/iHS_Mendocino", col_names=FALSE)

filter(dat, pop1=="Mendocino", stat=="iHS") |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/iHS_Mendocino_REF", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", stat=="iHS", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/iHS_SantaBarbara", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", stat=="iHS") |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/iHS_SantaBarbara_REF", col_names=FALSE)

#
filter(dat, pop1=="Del Norte-Humboldt", stat=="iHS2", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/iHS2_NorteHumboldt", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", stat=="iHS2") |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/iHS2_NorteHumboldt_REF", col_names=FALSE)

filter(dat, pop1=="Mendocino", stat=="iHS2", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/iHS2_Mendocino", col_names=FALSE)

filter(dat, pop1=="Mendocino", stat=="iHS2") |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/iHS2_Mendocino_REF", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", stat=="iHS2", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/iHS2_SantaBarbara", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", stat=="iHS2") |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/iHS2_SantaBarbara_REF", col_names=FALSE)

#
filter(dat, pop1=="Del Norte-Humboldt", stat=="nSL", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/nSL_NorteHumboldt", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", stat=="nSL") |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/nSL_NorteHumboldt_REF", col_names=FALSE)

filter(dat, pop1=="Mendocino", stat=="nSL", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/nSL_Mendocino", col_names=FALSE)

filter(dat, pop1=="Mendocino", stat=="nSL") |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/nSL_Mendocino_REF", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", stat=="nSL", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/nSL_SantaBarbara", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", stat=="nSL") |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/nSL_SantaBarbara_REF", col_names=FALSE)

#
filter(dat, pop1=="Del Norte-Humboldt", stat=="nSL2", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/nSL2_NorteHumboldt", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", stat=="nSL2") |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/nSL2_NorteHumboldt_REF", col_names=FALSE)

filter(dat, pop1=="Mendocino", stat=="nSL2", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/nSL2_Mendocino", col_names=FALSE)

filter(dat, pop1=="Mendocino", stat=="nSL2") |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/nSL2_Mendocino_REF", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", stat=="nSL2", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/nSL2_SantaBarbara", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", stat=="nSL2") |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/nSL2_SantaBarbara_REF", col_names=FALSE)

#
filter(dat, pop1=="Del Norte-Humboldt", pop2=="Mendocino", stat=="XP-nSL", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-nSL_NorteHumboldt_Mendocino", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", pop2=="Mendocino", stat=="XP-nSL") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-nSL_NorteHumboldt_Mendocino_REF", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", pop2=="Santa Barbara", stat=="XP-nSL", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-nSL_NorteHumboldt_SantaBarbara", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", pop2=="Santa Barbara", stat=="XP-nSL") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-nSL_NorteHumboldt_SantaBarbara_REF", col_names=FALSE)

filter(dat, pop1=="Mendocino", pop2=="Del Norte-Humboldt", stat=="XP-nSL", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-nSL_Mendocino_NorteHumboldt", col_names=FALSE)

filter(dat, pop1=="Mendocino", pop2=="Del Norte-Humboldt", stat=="XP-nSL") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-nSL_Mendocino_NorteHumboldt_REF", col_names=FALSE)

filter(dat, pop1=="Mendocino", pop2=="Santa Barbara", stat=="XP-nSL", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-nSL_Mendocino_SantaBarbara", col_names=FALSE)

filter(dat, pop1=="Mendocino", pop2=="Santa Barbara", stat=="XP-nSL") |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-nSL_Mendocino_SantaBarbara_REF", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", pop2=="Del Norte-Humboldt", stat=="XP-nSL", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-nSL_SantaBarbara_NorteHumboldt", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", pop2=="Del Norte-Humboldt", stat=="XP-nSL") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-nSL_SantaBarbara_NorteHumboldt_REF", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", pop2=="Mendocino", stat=="XP-nSL", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-nSL_SantaBarbara_Mendocino", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", pop2=="Mendocino", stat=="XP-nSL") |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-nSL_SantaBarbara_Mendocino_REF", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", stat=="XP-nSL", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-nSL_NorteHumboldt", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", stat=="XP-nSL") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-nSL_NorteHumboldt_REF", col_names=FALSE)

filter(dat, pop1=="Mendocino", stat=="XP-nSL", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-nSL_Mendocino", col_names=FALSE)

filter(dat, pop1=="Mendocino", stat=="XP-nSL") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-nSL_Mendocino_REF", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", stat=="XP-nSL", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-nSL_SantaBarbara", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", stat=="XP-nSL") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-nSL_SantaBarbara_REF", col_names=FALSE)

#
filter(dat, pop1=="Del Norte-Humboldt", pop2=="Mendocino", stat=="XP-nSL2", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-nSL2_NorteHumboldt_Mendocino", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", pop2=="Mendocino", stat=="XP-nSL2") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-nSL2_NorteHumboldt_Mendocino_REF", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", pop2=="Santa Barbara", stat=="XP-nSL2", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-nSL2_NorteHumboldt_SantaBarbara", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", pop2=="Santa Barbara", stat=="XP-nSL2") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-nSL2_NorteHumboldt_SantaBarbara_REF", col_names=FALSE)

filter(dat, pop1=="Mendocino", pop2=="Del Norte-Humboldt", stat=="XP-nSL2", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-nSL2_Mendocino_NorteHumboldt", col_names=FALSE)

filter(dat, pop1=="Mendocino", pop2=="Del Norte-Humboldt", stat=="XP-nSL2") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-nSL2_Mendocino_NorteHumboldt_REF", col_names=FALSE)

filter(dat, pop1=="Mendocino", pop2=="Santa Barbara", stat=="XP-nSL2", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-nSL2_Mendocino_SantaBarbara", col_names=FALSE)

filter(dat, pop1=="Mendocino", pop2=="Santa Barbara", stat=="XP-nSL2") |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-nSL2_Mendocino_SantaBarbara_REF", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", pop2=="Del Norte-Humboldt", stat=="XP-nSL2", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-nSL2_SantaBarbara_NorteHumboldt", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", pop2=="Del Norte-Humboldt", stat=="XP-nSL2") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-nSL2_SantaBarbara_NorteHumboldt_REF", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", pop2=="Mendocino", stat=="XP-nSL2", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-nSL2_SantaBarbara_Mendocino", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", pop2=="Mendocino", stat=="XP-nSL2") |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-nSL2_SantaBarbara_Mendocino_REF", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", stat=="XP-nSL2", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-nSL2_NorteHumboldt", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", stat=="XP-nSL2") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-nSL2_NorteHumboldt_REF", col_names=FALSE)

filter(dat, pop1=="Mendocino", stat=="XP-nSL2", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-nSL2_Mendocino", col_names=FALSE)

filter(dat, pop1=="Mendocino", stat=="XP-nSL2") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-nSL2_Mendocino_REF", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", stat=="XP-nSL2", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-nSL2_SantaBarbara", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", stat=="XP-nSL2") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-nSL2_SantaBarbara_REF", col_names=FALSE)

#
filter(dat, pop1=="Del Norte-Humboldt", pop2=="Mendocino", stat=="XP-CLR", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-CLR_NorteHumboldt_Mendocino", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", pop2=="Mendocino", stat=="XP-CLR") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-CLR_NorteHumboldt_Mendocino_REF", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", pop2=="Santa Barbara", stat=="XP-CLR", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-CLR_NorteHumboldt_SantaBarbara", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", pop2=="Santa Barbara", stat=="XP-CLR") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-CLR_NorteHumboldt_SantaBarbara_REF", col_names=FALSE)

filter(dat, pop1=="Mendocino", pop2=="Del Norte-Humboldt", stat=="XP-CLR", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-CLR_Mendocino_NorteHumboldt", col_names=FALSE)

filter(dat, pop1=="Mendocino", pop2=="Del Norte-Humboldt", stat=="XP-CLR") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-CLR_Mendocino_NorteHumboldt_REF", col_names=FALSE)

filter(dat, pop1=="Mendocino", pop2=="Santa Barbara", stat=="XP-CLR", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-CLR_Mendocino_SantaBarbara", col_names=FALSE)

filter(dat, pop1=="Mendocino", pop2=="Santa Barbara", stat=="XP-CLR") |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-CLR_Mendocino_SantaBarbara_REF", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", pop2=="Del Norte-Humboldt", stat=="XP-CLR", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-CLR_SantaBarbara_NorteHumboldt", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", pop2=="Del Norte-Humboldt", stat=="XP-CLR") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-CLR_SantaBarbara_NorteHumboldt_REF", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", pop2=="Mendocino", stat=="XP-CLR", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-CLR_SantaBarbara_Mendocino", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", pop2=="Mendocino", stat=="XP-CLR") |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-CLR_SantaBarbara_Mendocino_REF", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", stat=="XP-CLR", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-CLR_NorteHumboldt", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", stat=="XP-CLR") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-CLR_NorteHumboldt_REF", col_names=FALSE)

filter(dat, pop1=="Mendocino", stat=="XP-CLR", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-CLR_Mendocino", col_names=FALSE)

filter(dat, pop1=="Mendocino", stat=="XP-CLR") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-CLR_Mendocino_REF", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", stat=="XP-CLR", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-CLR_SantaBarbara", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", stat=="XP-CLR") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-CLR_SantaBarbara_REF", col_names=FALSE)

##
filter(dat, pop1=="Del Norte-Humboldt", stat%in%c("iHS", "nSL", "XP-nSL"), candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/iHS_nSL_XP-nSL_NorteHumboldt", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", stat%in%c("iHS", "nSL", "XP-nSL")) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/iHS_nSL_XP-nSL_NorteHumboldt_REF", col_names=FALSE)

filter(dat, pop1=="Mendocino", stat%in%c("iHS", "nSL", "XP-nSL"), candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/iHS_nSL_XP-nSL_Mendocino", col_names=FALSE)

filter(dat, pop1=="Mendocino", stat%in%c("iHS", "nSL", "XP-nSL")) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/iHS_nSL_XP-nSL_Mendocino_REF", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", stat%in%c("iHS", "nSL", "XP-nSL"), candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/iHS_nSL_XP-nSL_SantaBarbara", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", stat%in%c("iHS", "nSL", "XP-nSL")) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/iHS_nSL_XP-nSL_SantaBarbara_REF", col_names=FALSE)

##
filter(dat, pop1=="Del Norte-Humboldt", stat%in%c("iHS2", "nSL2", "XP-nSL2", "XP-CLR"), candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/iHS2_nSL2_XP-nSL2_XP-CLR_NorteHumboldt", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", stat%in%c("iHS2", "nSL2", "XP-nSL2", "XP-CLR")) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/iHS2_nSL2_XP-nSL2_XP-CLR_NorteHumboldt_REF", col_names=FALSE)

filter(dat, pop1=="Mendocino", stat%in%c("iHS2", "nSL2", "XP-nSL2", "XP-CLR"), candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/iHS2_nSL2_XP-nSL2_XP-CLR_Mendocino", col_names=FALSE)

filter(dat, pop1=="Mendocino", stat%in%c("iHS2", "nSL2", "XP-nSL2", "XP-CLR")) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/iHS2_nSL2_XP-nSL2_XP-CLR_Mendocino_REF", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", stat%in%c("iHS2", "nSL2", "XP-nSL2", "XP-CLR"), candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/iHS2_nSL2_XP-nSL2_XP-CLR_SantaBarbara", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", stat%in%c("iHS2", "nSL2", "XP-nSL2", "XP-CLR")) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/iHS2_nSL2_XP-nSL2_XP-CLR_SantaBarbara_REF", col_names=FALSE)

##
filter(dat, pop1=="Del Norte-Humboldt", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/NorteHumboldt", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/NorteHumboldt_REF", col_names=FALSE)

filter(dat, pop1=="Mendocino", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/Mendocino", col_names=FALSE)

filter(dat, pop1=="Mendocino") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/Mendocino_REF", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/SantaBarbara", col_names=FALSE)

filter(dat, pop1=="Santa Barbara") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/SantaBarbara_REF", col_names=FALSE)

## top 10 candidate genes
filter(dat, candidate==TRUE) |> 
#  group_by(stat, pop1, pop2) |> 
#  slice_max(score, n=10) |> 
#  arrange(chr, pos, stat, pop1, pop2) |> 
#  print(n=1000) |>
  group_by(PANTHER_accession) |> 
  count(sort=TRUE)
  















info <- read_tsv(file="/Volumes/Tigrigobius/tgoby/vcfR/exons/info.tab")

info <- mutate(info, CHROM=str_extract(string=CHROM, pattern="JAPEHO010+(\\d+)\\.1", group=1)|>as.numeric())

group_by(info, ANNOTATION) |> count()

semi_join(x=info, y=Genes, by=join_by(CHROM==seqid, ID==mRNA_id))

## NEED TO REDO "genes.gff" TO INCLUDE ALL TRANSCRIPTS





iHS <- 
  full_join(
    x=iHS, 
    y=pivot_longer(Genes, cols=4:5, names_to="feature", values_to="pos"), 
    by=join_by(CHROM==seqid, POS==pos)) |> 
  arrange(POP, CHROM, POS)

nSL <- 
  full_join(
    x=nSL, 
    y=pivot_longer(Genes, cols=4:5, names_to="feature", values_to="pos"), 
    by=join_by(CHROM==seqid, POS==pos)) |> 
  arrange(POP, CHROM, POS)


XPnSL <- 
  full_join(
    x=XPnSL, 
    y=pivot_longer(Genes, cols=4:5, names_to="feature", values_to="pos"), 
    by=join_by(chr==seqid, pos)) |> 
  arrange(samplesA, samplesB, chr, pos)











iHSa <- 
  inner_join(x=iHS, y=info, by=join_by(CHROM, POS), relationship="many-to-many")

nSLa <- 
  inner_join(x=nSL, y=info, by=join_by(CHROM, POS), relationship="many-to-many")

XPnSLa <- 
  inner_join(x=XPnSL, y=info, by=join_by(chr==CHROM, pos==POS), relationship="many-to-many")

mutate(iHSa, ranka=percent_rank(ABS_iHS)) |> filter(ranka>0.99) |> view()

filter(info, CHROM==13, between(POS, left=14000001, right=18000000)) |> view()

muts <-
  bind_rows(
    left_join(x=iHS, y=info, by=join_by(CHROM, POS), relationship="many-to-many"),
    left_join(x=nSL, y=info, by=join_by(CHROM, POS), relationship="many-to-many"),
    inner_join(x=XPnSL, y=info, by=c("chr"="CHROM", "mRNA_id"="ID", "xpnsl_pos"="POS")) |> select(CHROM=chrom, POS=xpnsl_pos, REF, ALT, START_exon=START, END_exon=END, ANNOTATION, ANNOTATION_IMPACT, ORF_type, ID=mRNA_id, GENE=gene, PANTHER_accession, PANTHER_family_name, SCORE=xpnsl_norm, POP=xpnsl_pop, OG=xpnsl_og, LOC=loc) |> mutate(STAT="XP-nSL")) |>
  arrange(CHROM, POS, POP, OG, STAT) |>
  relocate(OG, STAT, .after=POP)
muts


















## filter(genes2c, pop1=="Del Norte-Humboldt", pop2=="Mendocino", stat=="XP-nSL") |> 
##   select(id, PANTHER_accession) |>
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-nSL_NorteHumboldt_Mendocino", col_names=FALSE)

## filter(genes2c, pop1=="Mendocino", pop2=="Del Norte-Humboldt", stat=="XP-nSL") |> 
##   select(id, PANTHER_accession) |>
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-nSL_Mendocino_NorteHumboldt", col_names=FALSE)

## filter(genes2c, pop1=="Del Norte-Humboldt", pop2=="Santa Barbara", stat=="XP-nSL") |> 
##   select(id, PANTHER_accession) |>
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-nSL_NorteHumboldt_SantaBarbara", col_names=FALSE)

## filter(genes2c, pop1=="Santa Barbara", pop2=="Del Norte-Humboldt", stat=="XP-nSL") |> 
##   select(id, PANTHER_accession) |>
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-nSL_SantaBarbara_NorteHumboldt", col_names=FALSE)

## filter(genes2c, pop1=="Mendocino", pop2=="Santa Barbara", stat=="XP-nSL") |> 
##   select(id, PANTHER_accession) |> 
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-nSL_Mendocino_SantaBarbara", col_names=FALSE)

## filter(genes2c, pop1=="Santa Barbara", pop2=="Mendocino", stat=="XP-nSL") |> 
##   select(id, PANTHER_accession) |> 
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-nSL_SantaBarbara_Mendocino", col_names=FALSE)

#
#
## filter(genes2c, pop1=="Del Norte-Humboldt", stat=="XP-nSL") |> 
##   select(id, PANTHER_accession) |>
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-nSL_NorteHumboldt", col_names=FALSE)

## filter(genes2c, pop1=="Mendocino", stat=="XP-nSL") |> 
##   select(id, PANTHER_accession) |>
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-nSL_Mendocino", col_names=FALSE)

## filter(genes2c, pop1=="Santa Barbara", stat=="XP-nSL") |> 
##   select(id, PANTHER_accession) |>
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-nSL_SantaBarbara", col_names=FALSE)
#filter(genes2c, pop1=="Del Norte-Humboldt", pop2=="Santa Barbara", stat=="XP-CLR") |> 
#  select(id, PANTHER_accession) |>
#  inner_join(y=filter(genes2c, pop1=="Mendocino", pop2=="Santa Barbara", stat=="XP-CLR") |> select(id, PANTHER_accession)) |>
#  distinct() |>
#  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-CLR_NorteHumboldtMendocino_SantaBarbara", col_names=FALSE)
#
## filter(genes2c, pop1=="Del Norte-Humboldt", stat=="nSL") |> 
##   select(id, PANTHER_accession) |> 
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/nSL_NorteHumboldt", col_names=FALSE)

## filter(genes2c, pop1=="Mendocino", stat=="nSL") |> 
##   select(id, PANTHER_accession) |> 
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/nSL_Mendocino", col_names=FALSE)

## filter(genes2c, pop1=="Santa Barbara", stat=="nSL") |> 
##   select(id, PANTHER_accession) |> 
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/nSL_SantaBarbara", col_names=FALSE)
## filter(genes2c, pop1=="Del Norte-Humboldt", stat=="iHS") |> 
##   select(id, PANTHER_accession) |> 
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/iHS_NorteHumboldt", col_names=FALSE)

## filter(genes2c, pop1=="Mendocino", stat=="iHS") |> 
##   select(id, PANTHER_accession) |> 
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/iHS_Mendocino", col_names=FALSE)

## filter(genes2c, pop1=="Santa Barbara", stat=="iHS") |> 
##   select(id, PANTHER_accession) |> 
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/iHS_SantaBarbara", col_names=FALSE)
#
## filter(genes2c, pop1=="Del Norte-Humboldt", stat%in%c("nSL", "nSL2")) |> 
##   select(id, PANTHER_accession) |>
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/nSL_nSL2_NorteHumboldt", col_names=FALSE)

## filter(genes2c, pop1=="Mendocino", stat%in%c("nSL", "nSL2")) |> 
##   select(id, PANTHER_accession) |>
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/nSL_nSL2_Mendocino", col_names=FALSE)

## filter(genes2c, pop1=="Santa Barbara", stat%in%c("nSL", "nSL2")) |> 
##   select(id, PANTHER_accession) |>
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/nSL_nSL2_SantaBarbara", col_names=FALSE)


## filter(genes2c, pop1=="Del Norte-Humboldt", stat%in%c("iHS", "iHS2")) |> 
##   select(id, PANTHER_accession) |>
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/iHS_iHS2_NorteHumboldt", col_names=FALSE)

## filter(genes2c, pop1=="Mendocino", stat%in%c("iHS", "iHS2")) |> 
##   select(id, PANTHER_accession) |>
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/iHS_iHS2_Mendocino", col_names=FALSE)

## filter(genes2c, pop1=="Santa Barbara", stat%in%c("iHS", "iHS2")) |> 
##   select(id, PANTHER_accession) |>
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/iHS_iHS2_SantaBarbara", col_names=FALSE)


## filter(genes2c, pop1=="Del Norte-Humboldt", stat%in%c("iHS", "nSL")) |> 
##   select(id, PANTHER_accession) |>
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/iHS_nSL_NorteHumboldt", col_names=FALSE)

## filter(genes2c, pop1=="Mendocino", stat%in%c("iHS", "nSL")) |> 
##   select(id, PANTHER_accession) |>
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/iHS_nSL_Mendocino", col_names=FALSE)

## filter(genes2c, pop1=="Santa Barbara", stat%in%c("iHS", "nSL")) |> 
##   select(id, PANTHER_accession) |>
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/iHS_nSL_SantaBarbara", col_names=FALSE)

## filter(genes2c, pop1=="Del Norte-Humboldt", stat%in%c("iHS2", "nSL2")) |> 
##   select(id, PANTHER_accession) |>
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/iHS2_nSL2_NorteHumboldt", col_names=FALSE)

## filter(genes2c, pop1=="Mendocino", stat%in%c("iHS2", "nSL2")) |> 
##   select(id, PANTHER_accession) |>
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/iHS2_nSL2_Mendocino", col_names=FALSE)

## filter(genes2c, pop1=="Santa Barbara", stat%in%c("iHS2", "nSL2")) |> 
##   select(id, PANTHER_accession) |>
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/iHS2_nSL2_SantaBarbara", col_names=FALSE)

## filter(genes2c, pop1=="Del Norte-Humboldt", pop2=="Mendocino", stat%in%c("XP-nSL", "XP-nSL2")) |> 
##   select(id, PANTHER_accession) |>
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-nSL_XP-nSL2_NorteHumboldt_Mendocino", col_names=FALSE)

## filter(genes2c, pop1=="Mendocino", pop2=="Del Norte-Humboldt", stat%in%c("XP-nSL", "XP-nSL2")) |> 
##   select(id, PANTHER_accession) |>
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-nSL_XP-nSL2_Mendocino_NorteHumboldt", col_names=FALSE)

## filter(genes2c, pop1=="Del Norte-Humboldt", pop2=="Santa Barbara", stat%in%c("XP-nSL", "XP-nSL2")) |> 
##   select(id, PANTHER_accession) |>
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-nSL_XP-nSL2_NorteHumboldt_SantaBarbara", col_names=FALSE)

## filter(genes2c, pop1=="Santa Barbara", pop2=="Del Norte-Humboldt", stat%in%c("XP-nSL", "XP-nSL2")) |> 
##   select(id, PANTHER_accession) |>
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-nSL_XP-nSL2_SantaBarbara_NorteHumboldt", col_names=FALSE)

## filter(genes2c, pop1=="Mendocino", pop2=="Santa Barbara", stat%in%c("XP-nSL", "XP-nSL2")) |> 
##   select(id, PANTHER_accession) |> 
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-nSL_XP-nSL2_Mendocino_SantaBarbara", col_names=FALSE)

## filter(genes2c, pop1=="Santa Barbara", pop2=="Mendocino", stat%in%c("XP-nSL", "XP-nSL2")) |> 
##   select(id, PANTHER_accession) |> 
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/XP-nSL_XP-nSL2_SantaBarbara_Mendocino", col_names=FALSE)



## filter(genes2c, pop1=="Del Norte-Humboldt") |> 
##   select(id, PANTHER_accession) |>
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/NorteHumboldt", col_names=FALSE)

## filter(genes2c, pop1=="Mendocino") |> 
##   select(id, PANTHER_accession) |>
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/Mendocino", col_names=FALSE)

## filter(genes2c, pop1=="Santa Barbara") |> 
##   select(id, PANTHER_accession) |>
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/SantaBarbara", col_names=FALSE)


## ##
## filter(genes2c, pop1=="Del Norte-Humboldt", stat%in%c("iHS", "nSL", "XP-nSL")) |> 
##   select(id, PANTHER_accession) |>
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/iHS_nSL_XP-nSL_NorteHumboldt", col_names=FALSE)

## filter(genes2c, pop1=="Mendocino", stat%in%c("iHS", "nSL", "XP-nSL")) |> 
##   select(id, PANTHER_accession) |>
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/iHS_nSL_XP-nSL_Mendocino", col_names=FALSE)

## filter(genes2c, pop1=="Santa Barbara", stat%in%c("iHS", "nSL", "XP-nSL")) |> 
##   select(id, PANTHER_accession) |>
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/iHS_nSL_XP-nSL_SantaBarbara", col_names=FALSE)








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
