library(tidyverse)

Genes <- 
  readRDS(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/Genes.RDS")

group_by(Genes, ORF_type) |> count()

genes <- 
  Genes |>
  select(-type, -prostart, -proend, -attributes, -name)

genes <- 
  pivot_longer(genes, cols=2:3, names_to="feature", values_to="pos")

#
iHS2 <- readRDS(file="/Volumes/Tigrigobius/tgoby/ihs/selscan/gmap/iHS.100Kb.RDS")
nSL2 <- readRDS(file="/Volumes/Tigrigobius/tgoby/nsl/selscan/nSL.100Kb.RDS")
XPCLR <- readRDS(file="/Volumes/Tigrigobius/tgoby/windows/XP-CLR.RDS")
XPnSL2 <- readRDS(file="/Volumes/Tigrigobius/tgoby/xpnsl/selscan/XP-nSL.100Kb.RDS")

group_by(XPnSL2, samplesA, samplesB, PERCENTILE1, PERCENTILE2) |> count() |> print(n=100)

windows <- seq(1, 54200001, 100000)

genes <- 
  mutate(genes, window=cut(pos, breaks=c(windows, 54300001), labels=windows, include.lowest=TRUE))

summary(genes)

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

filter(Genes, is.na(panes))

Genes <- 
  rowwise(Genes) |> mutate(windows=list(seq.int(from=window, length.out=panes, by=100000)))

gene.windows <- 
  unnest_longer(select(Genes, -window), windows, values_to="window")

saveRDS(object=gene.windows, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/gene.windows.RDS")
write_tsv(gene.windows, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/gene.windows.tsv")

window.genes <- 
  select(gene.windows, seqid, window, gene_id)
  
saveRDS(object=window.genes, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/window.genes.RDS")
write_tsv(window.genes, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/window.genes.tsv")

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


#
iHS2. <- 
  mutate(iHS, WINDOW=cut(POS, breaks=windows, labels=windows[-543], include.lowest=TRUE, right=FALSE), START=as.character(WINDOW)|>as.double(), END=START+100000) |>
  filter(!is.na(WINDOW)|!is.na(START)|!is.na(END)) |>
  group_by(POP1=POP, CHROM, WINDOW, START, END) |>
  summarise(N_SCORES=n(), MAX_SCORE=max(ABS_iHS), PROP_CRIT=sum(crit)/n()) |>
  ungroup() |>
  filter(N_SCORES>=10)

anti_join(x=iHS2, y=iHS2., by=join_by(CHROM, START, END, N_SCORES, POP==POP1))|>print(n=100)
anti_join(x=iHS2., y=iHS2, by=join_by(CHROM, START, END, N_SCORES, POP1==POP))|>print(n=100)

summary(iHS2); summary(iHS2.)

nSL2. <- 
  mutate(nSL, WINDOW=cut(POS, breaks=windows[-542:-543], labels=windows[-541:-543], include.lowest=TRUE, right=FALSE), START=as.character(WINDOW)|>as.double(), END=START+100000) |>
  filter(!is.na(WINDOW)|!is.na(START)|!is.na(END)) |>
  group_by(POP1=POP, CHROM, WINDOW, START, END) |>
  summarise(N_SCORES=n(), MAX_SCORE=max(ABS_nSL), PROP_CRIT=sum(crit)/n()) |>
  ungroup() |>
  filter(N_SCORES>=10)

anti_join(x=nSL2, y=nSL2., by=join_by(CHROM, START, END, N_SCORES, POP==POP1))|>print(n=100)
anti_join(x=nSL2., y=nSL2, by=join_by(CHROM, START, END, N_SCORES, POP1==POP))|>print(n=100)

summary(nSL2); summary(nSL2.)

XPnSL2. <- 
  mutate(XPnSL, WINDOW=cut(pos, breaks=windows, labels=windows[-543], include.lowest=TRUE, right=FALSE), START=as.character(WINDOW)|>as.double(), END=START+100000) |>
  filter(!is.na(WINDOW)|!is.na(START)|!is.na(END)) |>
  group_by(samplesA, samplesB, CHROM=chr, WINDOW, START, END) |>
  summarise(N_SCORES=n(), MAX_SCORE=max(xpnsl_norm), MIN_SCORE=min(xpnsl_norm), PROP_CRIT1=sum(crit==1)/n(), PROP_CRIT2=sum(crit==-1)/n()) |>
  ungroup() |>
  filter(N_SCORES>=10)

anti_join(x=XPnSL2, y=XPnSL2., by=join_by(chr==CHROM, START, END, N_SCORES, samplesA, samplesB))|>print(n=100)
anti_join(x=XPnSL2., y=XPnSL2, by=join_by(CHROM==chr, START, END, N_SCORES, samplesA, samplesB))|>print(n=120)

summary(XPnSL2); summary(XPnSL2.)

#
iHS2.1 <- 
  group_by(iHS2., POP1) |> 
  mutate(QUAN=cut_number(N_SCORES, n=10, labels=1:10, right=FALSE), CANDIDATE=TRUE) |> 
  group_by(POP1, QUAN) |> 
  slice_max(PROP_CRIT, prop=0.01, with_ties=TRUE) |> 
  ungroup() |>
  select(-WINDOW)

group_by(iHS2.1, POP1)|>count()
filter(iHS2, PERCENTILE==1)|>group_by(POP)|>count()

nSL2.1 <- 
  group_by(nSL2., POP1) |> 
  mutate(QUAN=cut_number(N_SCORES, n=10, labels=1:10, right=FALSE), CANDIDATE=TRUE) |> 
  group_by(POP1, QUAN) |> 
  slice_max(PROP_CRIT, prop=0.01, with_ties=TRUE) |> 
  ungroup() |>
  select(-WINDOW)


group_by(nSL2.1, POP1)|>count()
filter(nSL2, PERCENTILE==1)|>group_by(POP)|>count()

XPnSL2.1.pos <- 
  group_by(XPnSL2., samplesA, samplesB) |> 
  mutate(QUAN=cut_number(N_SCORES, n=10, labels=1:10, right=FALSE), CANDIDATE1=TRUE) |> 
  group_by(samplesA, samplesB, QUAN) |> 
  slice_max(PROP_CRIT1, prop=0.01, with_ties=TRUE) |> 
  ungroup() |>
  select(-WINDOW)


filter(XPnSL2, PERCENTILE1==1)|>group_by(samplesA, samplesB)|>count()
group_by(XPnSL2.1.pos, samplesA, samplesB)|>count()


XPnSL2.1.neg <- 
  group_by(XPnSL2., samplesA, samplesB) |> 
  mutate(QUAN=cut_number(N_SCORES, n=10, labels=1:10, right=FALSE), CANDIDATE2=TRUE) |> 
  group_by(samplesA, samplesB, QUAN) |> 
  slice_max(PROP_CRIT2, prop=0.01, with_ties=TRUE) |> 
  ungroup() |>
  select(-WINDOW)


filter(XPnSL2, PERCENTILE2==1)|>group_by(samplesA, samplesB)|>count()
group_by(XPnSL2.1.neg, samplesA, samplesB)|>count()


#################################################################################################################################################
# prep results with quantiles for plotting outlier distributions
#################################################################################################################################################
iHS2.q <- 
  group_by(iHS2., POP1) |> 
  mutate(QUAN=cut_number(N_SCORES, n=10, labels=1:10, right=FALSE), STAT="iHS") |> 
  ungroup() |>
  left_join(y=iHS2.1, by=join_by(CHROM, START, END, POP1, N_SCORES, MAX_SCORE, PROP_CRIT, QUAN)) |>
  replace_na(list(CANDIDATE=FALSE)) |>
  select(-WINDOW)


nSL2.q <- 
  group_by(nSL2., POP1) |> 
  mutate(QUAN=cut_number(N_SCORES, n=10, labels=1:10, right=FALSE), STAT="nSL") |> 
  ungroup() |>
  left_join(y=nSL2.1, by=join_by(CHROM, START, END, POP1, N_SCORES, MAX_SCORE, PROP_CRIT, QUAN)) |>
  replace_na(list(CANDIDATE=FALSE)) |>
  select(-WINDOW)


XPnSL2.q <- 
  group_by(XPnSL2., samplesA, samplesB) |> 
  mutate(QUAN=cut_number(N_SCORES, n=10, labels=1:10, right=FALSE), STAT="XP-nSL") |> 
  ungroup() |>
  left_join(y=XPnSL2.1.pos, by=join_by(CHROM, START, END, samplesA, samplesB, N_SCORES, MAX_SCORE, MIN_SCORE, PROP_CRIT1, PROP_CRIT2, QUAN)) |>
  left_join(y=XPnSL2.1.neg, by=join_by(CHROM, START, END, samplesA, samplesB, N_SCORES, MAX_SCORE, MIN_SCORE, PROP_CRIT1, PROP_CRIT2, QUAN)) |>
  replace_na(list(CANDIDATE1=FALSE, CANDIDATE2=FALSE)) |>
  select(-WINDOW)


summary(iHS2.q)
summary(nSL2.q)
summary(XPnSL2.q)


##saveRDS(object=iHS2.q, file="/Volumes/Tigrigobius/tgoby/windows/iHS.RDS")
##saveRDS(object=nSL2.q, file="/Volumes/Tigrigobius/tgoby/windows/nSL.RDS")
##saveRDS(object=XPnSL2.q, file="/Volumes/Tigrigobius/tgoby/windows/XP-nSL.RDS")

#################################################################################################################################################

window.genes$window <- as.double(window.genes$window)

distinct(window.genes, window)

# removing windows with no genes, some of which are CANDIDATE

iHS2.2 <- 
  left_join(x=select(iHS2.q, -STAT), y=window.genes, by=join_by(CHROM==seqid, START==window), relationship="many-to-many") |> 
  rename(STRG=gene_id) |>
  filter(!is.na(STRG)) |>
  group_by(POP1, STRG) |>
  slice_max(MAX_SCORE, with_ties=FALSE) |>
  ungroup()

nSL2.2 <- 
  left_join(x=select(nSL2.q, -STAT), y=window.genes, by=join_by(CHROM==seqid, START==window), relationship="many-to-many") |> 
  rename(STRG=gene_id) |>
  filter(!is.na(STRG)) |>
  group_by(POP1, STRG) |>
  slice_max(MAX_SCORE, with_ties=FALSE) |>
  ungroup()

XPnSL2.pos2 <- 
  left_join(x=select(XPnSL2.q, -STAT), y=window.genes, by=join_by(CHROM==seqid, START==window), relationship="many-to-many") |> 
  rename(STRG=gene_id) |>
  filter(!is.na(STRG)) |>
  group_by(samplesA, samplesB, STRG) |>
  slice_max(MAX_SCORE, with_ties=FALSE) |>
  ungroup()

XPnSL2.neg2 <- 
  left_join(x=select(XPnSL2.q, -STAT), y=window.genes, by=join_by(CHROM==seqid, START==window), relationship="many-to-many") |> 
  rename(STRG=gene_id) |>
  filter(!is.na(STRG)) |>
  group_by(samplesA, samplesB, STRG) |>
  slice_min(MIN_SCORE, with_ties=FALSE) |>
  ungroup()


XPCLR.2 <- 
  left_join(x=ungroup(XPCLR)|>select(-chrom, -tot, -id, -STAT), y=window.genes, by=join_by(chr==seqid, start==window), relationship="many-to-many") |> 
  rename(STRG=gene_id) |>
  filter(!is.na(STRG)) |>
  group_by(samplesA, samplesB, STRG) |>
  slice_max(xpclr_norm, with_ties=FALSE) |>
  ungroup()

filter(iHS2.2, CANDIDATE==TRUE) |> group_by(POP1) |> count()
filter(nSL2.2, CANDIDATE==TRUE) |> group_by(POP1) |> count()
filter(XPnSL2.pos2, CANDIDATE1==TRUE) |> group_by(samplesA, samplesB) |> count()
filter(XPnSL2.neg2, CANDIDATE2==TRUE) |> group_by(samplesA, samplesB) |> count()
filter(XPCLR.2, CANDIDATE==TRUE) |> group_by(samplesA, samplesB) |> count()

dat <- 
  bind_rows(
    select(iHS2.2, CHROM, START, POP1, STRG, MAX_SCORE, PROP_CRIT, N_SCORES, CANDIDATE, QUAN)|>mutate(POP1=as.character(POP1), POP2=NA, STAT="iHS"),
    select(nSL2.2, CHROM, START, POP1, STRG, MAX_SCORE, PROP_CRIT, N_SCORES, CANDIDATE, QUAN)|>mutate(POP1=as.character(POP1), POP2=NA, STAT="nSL"),
    select(XPnSL2.pos2, CHROM, START, POP1=samplesA, POP2=samplesB, STRG, MAX_SCORE, PROP_CRIT=PROP_CRIT1, N_SCORES, CANDIDATE=CANDIDATE1, QUAN)|>mutate(STAT="XP-nSL"),
#    select(XPnSL2.neg2, CHROM, START, POP1=samplesB, POP2=samplesA, STRG, MAX_SCORE=MIN_SCORE, PROP_CRIT=PROP_CRIT2, N_SCORES, CANDIDATE=CANDIDATE2, QUAN)|>mutate(MAX_SCORE=MAX_SCORE*-1, STAT="-XP-nSL"),
    select(XPCLR.2, CHROM=chr, START=start, POP1=samplesA, POP2=samplesB, STRG, MAX_SCORE=xpclr_norm, N_SCORES=nSNPs, CANDIDATE, QUAN)|>mutate(STAT="XP-CLR", PROP_CRIT=MAX_SCORE)) |>
  select(chr=CHROM, pos=START, stat=STAT, pop1=POP1, pop2=POP2, gene_id=STRG, score=MAX_SCORE, prop_crit=PROP_CRIT, n_snps=N_SCORES, candidate=CANDIDATE, bin=QUAN) |>
  left_join(y=select(Genes, gene_id, PANTHER_accession, PANTHER_family_name), by=join_by(gene_id))

unique(dat$stat);unique(dat$pop1);unique(dat$pop2)

dat$pop1 <- gsub(pattern="SantaBarbara", replacement="Santa Barbara", x=dat$pop1)
dat$pop1 <- gsub(pattern="NorteHumboldt", replacement="Del Norte-Humboldt", x=dat$pop1)
dat$pop2 <- gsub(pattern="SantaBarbara", replacement="Santa Barbara", x=dat$pop2)
dat$pop2 <- gsub(pattern="NorteHumboldt", replacement="Del Norte-Humboldt", x=dat$pop2)

unique(dat$stat);unique(dat$pop1);unique(dat$pop2)

saveRDS(object=dat, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/Candidate.Genes.RDS")
write_tsv(dat, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/Candidate.Genes.tsv")


filter(dat, pop1=="Del Norte-Humboldt", stat=="iHS") |> 
  select(gene_id, PANTHER_accession, score) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/iHS_scores_NorteHumboldt", col_names=FALSE)

filter(dat, pop1=="Mendocino", stat=="iHS") |> 
  select(gene_id, PANTHER_accession, score) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/iHS_scores_Mendocino", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", stat=="iHS") |> 
  select(gene_id, PANTHER_accession, score) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/iHS_scores_SantaBarbara", col_names=FALSE)

#
filter(dat, pop1=="Del Norte-Humboldt", stat=="nSL") |> 
  select(gene_id, PANTHER_accession, score) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/nSL_scores_NorteHumboldt", col_names=FALSE)

filter(dat, pop1=="Mendocino", stat=="nSL") |> 
  select(gene_id, PANTHER_accession, score) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/nSL_scores_Mendocino", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", stat=="nSL") |> 
  select(gene_id, PANTHER_accession, score) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/nSL_scores_SantaBarbara", col_names=FALSE)


#
filter(dat, pop1=="Del Norte-Humboldt", pop2=="Mendocino", stat=="XP-nSL") |> 
  select(gene_id, PANTHER_accession, score) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/XP-nSL_scores_NorteHumboldt_Mendocino", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", pop2=="Santa Barbara", stat=="XP-nSL") |> 
  select(gene_id, PANTHER_accession, score) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/XP-nSL_scores_NorteHumboldt_SantaBarbara", col_names=FALSE)

filter(dat, pop1=="Mendocino", pop2=="Del Norte-Humboldt", stat=="XP-nSL") |> 
  select(gene_id, PANTHER_accession, score) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/XP-nSL_scores_Mendocino_NorteHumboldt", col_names=FALSE)

filter(dat, pop1=="Mendocino", pop2=="Santa Barbara", stat=="XP-nSL") |> 
  select(gene_id, PANTHER_accession, score) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/XP-nSL_scores_Mendocino_SantaBarbara", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", pop2=="Del Norte-Humboldt", stat=="XP-nSL") |> 
  select(gene_id, PANTHER_accession, score) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/XP-nSL_scores_SantaBarbara_NorteHumboldt", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", pop2=="Mendocino", stat=="XP-nSL") |> 
  select(gene_id, PANTHER_accession, score) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/XP-nSL_scores_SantaBarbara_Mendocino", col_names=FALSE)

## #
## filter(dat, pop1=="Del Norte-Humboldt", pop2=="Mendocino", stat=="-XP-nSL") |> 
##   select(gene_id, PANTHER_accession, score) |> 
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/-XP-nSL_scores_NorteHumboldt_Mendocino", col_names=FALSE)

## filter(dat, pop1=="Del Norte-Humboldt", pop2=="Santa Barbara", stat=="-XP-nSL") |> 
##   select(gene_id, PANTHER_accession, score) |> 
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/-XP-nSL_scores_NorteHumboldt_SantaBarbara", col_names=FALSE)

## filter(dat, pop1=="Mendocino", pop2=="Del Norte-Humboldt", stat=="-XP-nSL") |> 
##   select(gene_id, PANTHER_accession, score) |> 
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/-XP-nSL_scores_Mendocino_NorteHumboldt", col_names=FALSE)

## filter(dat, pop1=="Mendocino", pop2=="Santa Barbara", stat=="-XP-nSL") |> 
##   select(gene_id, PANTHER_accession, score) |> 
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/-XP-nSL_scores_Mendocino_SantaBarbara", col_names=FALSE)

## filter(dat, pop1=="Santa Barbara", pop2=="Del Norte-Humboldt", stat=="-XP-nSL") |> 
##   select(gene_id, PANTHER_accession, score) |> 
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/-XP-nSL_scores_SantaBarbara_NorteHumboldt", col_names=FALSE)

## filter(dat, pop1=="Santa Barbara", pop2=="Mendocino", stat=="-XP-nSL") |> 
##   select(gene_id, PANTHER_accession, score) |> 
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/-XP-nSL_scores_SantaBarbara_Mendocino", col_names=FALSE)

#
filter(dat, pop1=="Del Norte-Humboldt", pop2=="Mendocino", stat=="XP-CLR") |> 
  select(gene_id, PANTHER_accession, score) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/XP-CLR_scores_NorteHumboldt_Mendocino", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", pop2=="Santa Barbara", stat=="XP-CLR") |> 
  select(gene_id, PANTHER_accession, score) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/XP-CLR_scores_NorteHumboldt_SantaBarbara", col_names=FALSE)

filter(dat, pop1=="Mendocino", pop2=="Del Norte-Humboldt", stat=="XP-CLR") |> 
  select(gene_id, PANTHER_accession, score) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/XP-CLR_scores_Mendocino_NorteHumboldt", col_names=FALSE)

filter(dat, pop1=="Mendocino", pop2=="Santa Barbara", stat=="XP-CLR") |> 
  select(gene_id, PANTHER_accession, score) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/XP-CLR_scores_Mendocino_SantaBarbara", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", pop2=="Del Norte-Humboldt", stat=="XP-CLR") |> 
  select(gene_id, PANTHER_accession, score) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/XP-CLR_scores_SantaBarbara_NorteHumboldt", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", pop2=="Mendocino", stat=="XP-CLR") |> 
  select(gene_id, PANTHER_accession, score) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/XP-CLR_scores_SantaBarbara_Mendocino", col_names=FALSE)

#
filter(dat, pop1=="Del Norte-Humboldt", stat=="iHS", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/iHS_NorteHumboldt_TOP", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", stat=="iHS") |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/iHS_NorteHumboldt_REF", col_names=FALSE)

filter(dat, pop1=="Mendocino", stat=="iHS", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/iHS_Mendocino_TOP", col_names=FALSE)

filter(dat, pop1=="Mendocino", stat=="iHS") |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/iHS_Mendocino_REF", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", stat=="iHS", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/iHS_SantaBarbara_TOP", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", stat=="iHS") |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/iHS_SantaBarbara_REF", col_names=FALSE)

#
filter(dat, pop1=="Del Norte-Humboldt", stat=="nSL", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/nSL_NorteHumboldt_TOP", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", stat=="nSL") |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/nSL_NorteHumboldt_REF", col_names=FALSE)

filter(dat, pop1=="Mendocino", stat=="nSL", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/nSL_Mendocino_TOP", col_names=FALSE)

filter(dat, pop1=="Mendocino", stat=="nSL") |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/nSL_Mendocino_REF", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", stat=="nSL", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/nSL_SantaBarbara_TOP", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", stat=="nSL") |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/nSL_SantaBarbara_REF", col_names=FALSE)

#
filter(dat, pop1=="Del Norte-Humboldt", pop2=="Mendocino", stat=="XP-nSL", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/XP-nSL_NorteHumboldt_Mendocino_TOP", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", pop2=="Mendocino", stat=="XP-nSL") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/XP-nSL_NorteHumboldt_Mendocino_REF", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", pop2=="Santa Barbara", stat=="XP-nSL", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/XP-nSL_NorteHumboldt_SantaBarbara_TOP", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", pop2=="Santa Barbara", stat=="XP-nSL") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/XP-nSL_NorteHumboldt_SantaBarbara_REF", col_names=FALSE)

filter(dat, pop1=="Mendocino", pop2=="Del Norte-Humboldt", stat=="XP-nSL", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/XP-nSL_Mendocino_NorteHumboldt_TOP", col_names=FALSE)

filter(dat, pop1=="Mendocino", pop2=="Del Norte-Humboldt", stat=="XP-nSL") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/XP-nSL_Mendocino_NorteHumboldt_REF", col_names=FALSE)

filter(dat, pop1=="Mendocino", pop2=="Santa Barbara", stat=="XP-nSL", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/XP-nSL_Mendocino_SantaBarbara_TOP", col_names=FALSE)

filter(dat, pop1=="Mendocino", pop2=="Santa Barbara", stat=="XP-nSL") |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/XP-nSL_Mendocino_SantaBarbara_REF", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", pop2=="Del Norte-Humboldt", stat=="XP-nSL", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/XP-nSL_SantaBarbara_NorteHumboldt_TOP", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", pop2=="Del Norte-Humboldt", stat=="XP-nSL") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/XP-nSL_SantaBarbara_NorteHumboldt_REF", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", pop2=="Mendocino", stat=="XP-nSL", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/XP-nSL_SantaBarbara_Mendocino_TOP", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", pop2=="Mendocino", stat=="XP-nSL") |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/XP-nSL_SantaBarbara_Mendocino_REF", col_names=FALSE)


## #
## filter(dat, pop1=="Del Norte-Humboldt", pop2=="Mendocino", stat=="-XP-nSL", candidate==TRUE) |> 
##   select(gene_id, PANTHER_accession) |>
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/-XP-nSL_NorteHumboldt_Mendocino_TOP", col_names=FALSE)

## filter(dat, pop1=="Del Norte-Humboldt", pop2=="Mendocino", stat=="-XP-nSL") |> 
##   select(gene_id, PANTHER_accession) |>
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/-XP-nSL_NorteHumboldt_Mendocino_REF", col_names=FALSE)

## filter(dat, pop1=="Del Norte-Humboldt", pop2=="Santa Barbara", stat=="-XP-nSL", candidate==TRUE) |> 
##   select(gene_id, PANTHER_accession) |>
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/-XP-nSL_NorteHumboldt_SantaBarbara_TOP", col_names=FALSE)

## filter(dat, pop1=="Del Norte-Humboldt", pop2=="Santa Barbara", stat=="-XP-nSL") |> 
##   select(gene_id, PANTHER_accession) |>
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/-XP-nSL_NorteHumboldt_SantaBarbara_REF", col_names=FALSE)

## filter(dat, pop1=="Mendocino", pop2=="Del Norte-Humboldt", stat=="-XP-nSL", candidate==TRUE) |> 
##   select(gene_id, PANTHER_accession) |>
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/-XP-nSL_Mendocino_NorteHumboldt_TOP", col_names=FALSE)

## filter(dat, pop1=="Mendocino", pop2=="Del Norte-Humboldt", stat=="-XP-nSL") |> 
##   select(gene_id, PANTHER_accession) |>
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/-XP-nSL_Mendocino_NorteHumboldt_REF", col_names=FALSE)

## filter(dat, pop1=="Mendocino", pop2=="Santa Barbara", stat=="-XP-nSL", candidate==TRUE) |> 
##   select(gene_id, PANTHER_accession) |> 
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/-XP-nSL_Mendocino_SantaBarbara_TOP", col_names=FALSE)

## filter(dat, pop1=="Mendocino", pop2=="Santa Barbara", stat=="-XP-nSL") |> 
##   select(gene_id, PANTHER_accession) |> 
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/-XP-nSL_Mendocino_SantaBarbara_REF", col_names=FALSE)

## filter(dat, pop1=="Santa Barbara", pop2=="Del Norte-Humboldt", stat=="-XP-nSL", candidate==TRUE) |> 
##   select(gene_id, PANTHER_accession) |>
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/-XP-nSL_SantaBarbara_NorteHumboldt_TOP", col_names=FALSE)

## filter(dat, pop1=="Santa Barbara", pop2=="Del Norte-Humboldt", stat=="-XP-nSL") |> 
##   select(gene_id, PANTHER_accession) |>
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/-XP-nSL_SantaBarbara_NorteHumboldt_REF", col_names=FALSE)

## filter(dat, pop1=="Santa Barbara", pop2=="Mendocino", stat=="-XP-nSL", candidate==TRUE) |> 
##   select(gene_id, PANTHER_accession) |> 
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/-XP-nSL_SantaBarbara_Mendocino_TOP", col_names=FALSE)

## filter(dat, pop1=="Santa Barbara", pop2=="Mendocino", stat=="-XP-nSL") |> 
##   select(gene_id, PANTHER_accession) |> 
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/-XP-nSL_SantaBarbara_Mendocino_REF", col_names=FALSE)


## #
## filter(dat, pop1=="Del Norte-Humboldt", pop2=="Mendocino", stat%in%c("XP-nSL", "-XP-nSL"), candidate==TRUE) |> 
##   select(gene_id, PANTHER_accession) |>
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/--XP-nSL_NorteHumboldt_Mendocino_TOP", col_names=FALSE)

## filter(dat, pop1=="Del Norte-Humboldt", pop2=="Mendocino", stat%in%c("XP-nSL", "-XP-nSL")) |> 
##   select(gene_id, PANTHER_accession) |>
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/--XP-nSL_NorteHumboldt_Mendocino_REF", col_names=FALSE)

## filter(dat, pop1=="Del Norte-Humboldt", pop2=="Santa Barbara", stat%in%c("XP-nSL", "-XP-nSL"), candidate==TRUE) |> 
##   select(gene_id, PANTHER_accession) |>
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/--XP-nSL_NorteHumboldt_SantaBarbara_TOP", col_names=FALSE)

## filter(dat, pop1=="Del Norte-Humboldt", pop2=="Santa Barbara", stat%in%c("XP-nSL", "-XP-nSL")) |> 
##   select(gene_id, PANTHER_accession) |>
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/--XP-nSL_NorteHumboldt_SantaBarbara_REF", col_names=FALSE)

## filter(dat, pop1=="Mendocino", pop2=="Del Norte-Humboldt", stat%in%c("XP-nSL", "-XP-nSL"), candidate==TRUE) |> 
##   select(gene_id, PANTHER_accession) |>
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/--XP-nSL_Mendocino_NorteHumboldt_TOP", col_names=FALSE)

## filter(dat, pop1=="Mendocino", pop2=="Del Norte-Humboldt", stat%in%c("XP-nSL", "-XP-nSL")) |> 
##   select(gene_id, PANTHER_accession) |>
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/--XP-nSL_Mendocino_NorteHumboldt_REF", col_names=FALSE)

## filter(dat, pop1=="Mendocino", pop2=="Santa Barbara", stat%in%c("XP-nSL", "-XP-nSL"), candidate==TRUE) |> 
##   select(gene_id, PANTHER_accession) |> 
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/--XP-nSL_Mendocino_SantaBarbara_TOP", col_names=FALSE)

## filter(dat, pop1=="Mendocino", pop2=="Santa Barbara", stat%in%c("XP-nSL", "-XP-nSL")) |> 
##   select(gene_id, PANTHER_accession) |> 
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/--XP-nSL_Mendocino_SantaBarbara_REF", col_names=FALSE)

## filter(dat, pop1=="Santa Barbara", pop2=="Del Norte-Humboldt", stat%in%c("XP-nSL", "-XP-nSL"), candidate==TRUE) |> 
##   select(gene_id, PANTHER_accession) |>
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/--XP-nSL_SantaBarbara_NorteHumboldt_TOP", col_names=FALSE)

## filter(dat, pop1=="Santa Barbara", pop2=="Del Norte-Humboldt", stat%in%c("XP-nSL", "-XP-nSL")) |> 
##   select(gene_id, PANTHER_accession) |>
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/--XP-nSL_SantaBarbara_NorteHumboldt_REF", col_names=FALSE)

## filter(dat, pop1=="Santa Barbara", pop2=="Mendocino", stat%in%c("XP-nSL", "-XP-nSL"), candidate==TRUE) |> 
##   select(gene_id, PANTHER_accession) |> 
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/--XP-nSL_SantaBarbara_Mendocino_TOP", col_names=FALSE)

## filter(dat, pop1=="Santa Barbara", pop2=="Mendocino", stat%in%c("XP-nSL", "-XP-nSL")) |> 
##   select(gene_id, PANTHER_accession) |> 
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/--XP-nSL_SantaBarbara_Mendocino_REF", col_names=FALSE)


#
filter(dat, pop1=="Del Norte-Humboldt", pop2=="Mendocino", stat=="XP-CLR", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/XP-CLR_NorteHumboldt_Mendocino_TOP", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", pop2=="Mendocino", stat=="XP-CLR") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/XP-CLR_NorteHumboldt_Mendocino_REF", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", pop2=="Santa Barbara", stat=="XP-CLR", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/XP-CLR_NorteHumboldt_SantaBarbara_TOP", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", pop2=="Santa Barbara", stat=="XP-CLR") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/XP-CLR_NorteHumboldt_SantaBarbara_REF", col_names=FALSE)

filter(dat, pop1=="Mendocino", pop2=="Del Norte-Humboldt", stat=="XP-CLR", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/XP-CLR_Mendocino_NorteHumboldt_TOP", col_names=FALSE)

filter(dat, pop1=="Mendocino", pop2=="Del Norte-Humboldt", stat=="XP-CLR") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/XP-CLR_Mendocino_NorteHumboldt_REF", col_names=FALSE)

filter(dat, pop1=="Mendocino", pop2=="Santa Barbara", stat=="XP-CLR", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/XP-CLR_Mendocino_SantaBarbara_TOP", col_names=FALSE)

filter(dat, pop1=="Mendocino", pop2=="Santa Barbara", stat=="XP-CLR") |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/XP-CLR_Mendocino_SantaBarbara_REF", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", pop2=="Del Norte-Humboldt", stat=="XP-CLR", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/XP-CLR_SantaBarbara_NorteHumboldt_TOP", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", pop2=="Del Norte-Humboldt", stat=="XP-CLR") |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/XP-CLR_SantaBarbara_NorteHumboldt_REF", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", pop2=="Mendocino", stat=="XP-CLR", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/XP-CLR_SantaBarbara_Mendocino_TOP", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", pop2=="Mendocino", stat=="XP-CLR") |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/XP-CLR_SantaBarbara_Mendocino_REF", col_names=FALSE)

filter(dat, candidate==TRUE, stat!="-XP-nSL") |> group_by(stat, pop1, pop2) |> summarise(n_candidates=n(), min_score=min(score), max_score=max(score), min_prop_crit=min(prop_crit), max_prop_crit=max(prop_crit)) |> print(n=100)

filter(dat, candidate==TRUE, stat!="-XP-nSL") |> group_by(pop1, PANTHER_family_name) |> count(sort=TRUE) |> filter(!is.na(PANTHER_family_name))

top10 <- 
  filter(dat, candidate==TRUE, stat!="-XP-nSL") |> group_by(stat, pop1, pop2) |> slice_max(prop_crit, n=10, with_ties=TRUE)

top10 <- 
  arrange(top10, chr, pos, pop1, pop2, stat, PANTHER_family_name) |> ungroup()

group_by(top10, stat, pop1, pop2)|>count()|>print(n=100)

#
filter(top10, pop1=="Del Norte-Humboldt") |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/NorteHumboldt_TOP10", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt") |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/NorteHumboldt_REF", col_names=FALSE)

filter(top10, pop1=="Mendocino") |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/Mendocino_TOP10", col_names=FALSE)

filter(dat, pop1=="Mendocino") |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/Mendocino_REF", col_names=FALSE)

filter(top10, pop1=="Santa Barbara") |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/SantaBarbara_TOP10", col_names=FALSE)

filter(dat, pop1=="Santa Barbara") |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/SantaBarbara_REF", col_names=FALSE)


## ggplot(filter(dat, stat%in%c("XP-nSL", "-XP-nSL")), aes(x=score, fill = as.factor(stat))) + geom_histogram() + facet_grid(rows = vars(pop2), cols = vars(pop1))

##
library(ggvenn)

brewpal2 <- read_tsv(file="/Volumes/Tigrigobius/tgoby/brewpal2.tab")
brewpal2x <- read_tsv(file="/Volumes/Tigrigobius/tgoby/brewpal2x.tab")
barplot(1:9, col=brewpal2x$COLORX)

sets_iHS <- 
  list(
    `Del Norte-Humboldt`=filter(dat, pop1=="Del Norte-Humboldt", stat=="iHS", candidate==TRUE)|>pull(gene_id),
    Mendocino=filter(dat, pop1=="Mendocino", stat=="iHS", candidate==TRUE)|>pull(gene_id),
    `Santa Barbara`=filter(dat, pop1=="Santa Barbara", stat=="iHS", candidate==TRUE)|>pull(gene_id))

sets_nSL <- 
  list(
    `Del Norte-Humboldt`=filter(dat, pop1=="Del Norte-Humboldt", stat=="nSL", candidate==TRUE)|>pull(gene_id),
    Mendocino=filter(dat, pop1=="Mendocino", stat=="nSL", candidate==TRUE)|>pull(gene_id),
    `Santa Barbara`=filter(dat, pop1=="Santa Barbara", stat=="nSL", candidate==TRUE)|>pull(gene_id))

sets_XPnSL <- 
  list(
    `Del Norte-Humboldt`=filter(dat, pop1=="Del Norte-Humboldt", stat=="XP-nSL", candidate==TRUE)|>pull(gene_id),
    Mendocino=filter(dat, pop1=="Mendocino", stat=="XP-nSL", candidate==TRUE)|>pull(gene_id),
    `Santa Barbara`=filter(dat, pop1=="Santa Barbara", stat=="XP-nSL", candidate==TRUE)|>pull(gene_id))

`sets_-XPnSL` <- 
  list(
    `Del Norte-Humboldt`=filter(dat, pop1=="Del Norte-Humboldt", stat=="-XP-nSL", candidate==TRUE)|>pull(gene_id),
    Mendocino=filter(dat, pop1=="Mendocino", stat=="-XP-nSL", candidate==TRUE)|>pull(gene_id),
    `Santa Barbara`=filter(dat, pop1=="Santa Barbara", stat=="-XP-nSL", candidate==TRUE)|>pull(gene_id))

sets_both_XPnSL <- 
  list(
    `Del Norte-Humboldt`=filter(dat, pop1=="Del Norte-Humboldt", stat%in%c("XP-nSL", "-XP-nSL"), candidate==TRUE)|>pull(gene_id)|>unique(),
    Mendocino=filter(dat, pop1=="Mendocino", stat%in%c("XP-nSL", "-XP-nSL"), candidate==TRUE)|>pull(gene_id)|>unique(),
    `Santa Barbara`=filter(dat, pop1=="Santa Barbara", stat%in%c("XP-nSL", "-XP-nSL"), candidate==TRUE)|>pull(gene_id)|>unique())

sets_XPCLR <- 
  list(
    `Del Norte-Humboldt`=filter(dat, pop1=="Del Norte-Humboldt", stat=="XP-CLR", candidate==TRUE)|>pull(gene_id),
    Mendocino=filter(dat, pop1=="Mendocino", stat=="XP-CLR", candidate==TRUE)|>pull(gene_id),
    `Santa Barbara`=filter(dat, pop1=="Santa Barbara", stat=="XP-CLR", candidate==TRUE)|>pull(gene_id))

##
unique(c(sets_iHS[[1]], sets_iHS[[2]], sets_iHS[[3]])) |> length()

str(sets_iHS)

gg.sets_iHS <- 
  ggvenn(
    data=sets_iHS, 
    digits=0,
    stroke_size=0.5, 
    set_name_size=4.5,
    text_size=4,
    fill_color=rep("white", 3), 
    fill_alpha=1,
    stroke_color=c(rep(x=brewpal2$COLOR1[8], times=100), rep(x=brewpal2$COLOR1[6], times=100), rep(x=brewpal2$COLOR1[4], times=100)), 
    stroke_alpha=1,
    auto_scale=FALSE) + 
  labs(title="671 Candidate Genes (iHS)", tag="(d)") + 
  theme(plot.caption=element_text(size=13, hjust=0.5), plot.title=element_text(size=15, hjust=0.5), plot.tag=element_text(size=15))
gg.sets_iHS

ggsave(plot=gg.sets_iHS, filename="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/pairwise.venn.iHS.png", bg="white", device=png, width=5, height=5, units="in", dpi=320)
ggsave(plot=gg.sets_iHS, filename="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/pairwise.venn.iHS.pdf", bg="white", device=cairo_pdf, width=5, height=5, units="in")


unique(c(sets_nSL[[1]], sets_nSL[[2]], sets_nSL[[3]])) |> length()

str(sets_nSL)

gg.sets_nSL <- 
  ggvenn(
    data=sets_nSL, 
    digits=0,
    stroke_size=0.5, 
    set_name_size=4.5,
    text_size=4,
    fill_color=rep("white", 3), 
    fill_alpha=1,
    stroke_color=c(rep(x=brewpal2$COLOR1[8], times=100), rep(x=brewpal2$COLOR1[6], times=100), rep(x=brewpal2$COLOR1[4], times=100)), 
    stroke_alpha=1,
    auto_scale=FALSE) + 
  labs(title="648 Candidate Genes (nSL)", tag="(d)") + 
  theme(plot.caption=element_text(size=13, hjust=0.5), plot.title=element_text(size=15, hjust=0.5), plot.tag=element_text(size=15))
gg.sets_nSL

ggsave(plot=gg.sets_nSL, filename="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/pairwise.venn.nSL.png", bg="white", device=png, width=5, height=5, units="in", dpi=320)
ggsave(plot=gg.sets_nSL, filename="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/pairwise.venn.nSL.pdf", bg="white", device=cairo_pdf, width=5, height=5, units="in")


unique(c(sets_XPnSL[[1]], sets_XPnSL[[2]], sets_XPnSL[[3]])) |> length()

str(sets_XPnSL)

gg.sets_XPnSL <- 
  ggvenn(
    data=sets_XPnSL, 
    digits=0,
    stroke_size=0.5, 
    set_name_size=4.5,
    text_size=4,
    fill_color=rep("white", 3), 
    fill_alpha=1,
    stroke_color=c(rep(x=brewpal2$COLOR1[8], times=100), rep(x=brewpal2$COLOR1[6], times=100), rep(x=brewpal2$COLOR1[4], times=100)), 
    stroke_alpha=1,
    auto_scale=FALSE) + 
  labs(title="1,161 Candidate Genes (XP-nSL)", tag="(d)") + 
  theme(plot.caption=element_text(size=13, hjust=0.5), plot.title=element_text(size=15, hjust=0.5), plot.tag=element_text(size=15))
gg.sets_XPnSL

ggsave(plot=gg.sets_XPnSL, filename="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/pairwise.venn.XPnSL.png", bg="white", device=png, width=5, height=5, units="in", dpi=320)
ggsave(plot=gg.sets_XPnSL, filename="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/pairwise.venn.XPnSL.pdf", bg="white", device=cairo_pdf, width=5, height=5, units="in")




unique(c(sets_XPCLR[[1]], sets_XPCLR[[2]], sets_XPCLR[[3]])) |> length()

str(sets_XPCLR)

gg.sets_XPCLR <- 
  ggvenn(
    data=sets_XPCLR, 
    digits=0,
    stroke_size=0.5, 
    set_name_size=4.5,
    text_size=4,
    fill_color=rep("white", 3), 
    fill_alpha=1,
    stroke_color=c(rep(x=brewpal2$COLOR1[8], times=100), rep(x=brewpal2$COLOR1[6], times=100), rep(x=brewpal2$COLOR1[4], times=100)), 
    stroke_alpha=1,
    auto_scale=FALSE) + 
  labs(title="925 Candidate Genes (XP-CLR)", tag="(d)") + 
  theme(plot.caption=element_text(size=13, hjust=0.5), plot.title=element_text(size=15, hjust=0.5), plot.tag=element_text(size=15))
gg.sets_XPCLR

ggsave(plot=gg.sets_XPCLR, filename="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/pairwise.venn.XPCLR.png", bg="white", device=png, width=5, height=5, units="in", dpi=320)
ggsave(plot=gg.sets_XPCLR, filename="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/pairwise.venn.XPCLR.pdf", bg="white", device=cairo_pdf, width=5, height=5, units="in")









# find intersecting candidate regions
canre <- 
  filter(dat, candidate==TRUE) |>
  mutate(region=paste0(chr, "_", pos)) 

NorteHumboldt <- 
  list(
    iHS=filter(canre, pop1=="Del Norte-Humboldt", stat=="iHS")|>pull(region),
    nSL=filter(canre, pop1=="Del Norte-Humboldt", stat=="nSL")|>pull(region),
    `XP-nSL`=filter(canre, pop1=="Del Norte-Humboldt", stat=="XP-nSL")|>pull(region),
#    `-XP-nSL`=filter(canre, pop1=="Del Norte-Humboldt", stat=="-XP-nSL")|>pull(region),
    `XP-CLR`=filter(canre, pop1=="Del Norte-Humboldt", stat=="XP-CLR")|>pull(region))

Mendocino <- 
  list(
    iHS=filter(canre, pop1=="Mendocino", stat=="iHS")|>pull(region),
    nSL=filter(canre, pop1=="Mendocino", stat=="nSL")|>pull(region),
    `XP-nSL`=filter(canre, pop1=="Mendocino", stat=="XP-nSL")|>pull(region),
#    `-XP-nSL`=filter(canre, pop1=="Mendocino", stat=="-XP-nSL")|>pull(region),
    `XP-CLR`=filter(canre, pop1=="Mendocino", stat=="XP-CLR")|>pull(region))

SantaBarbara <- 
  list(
    iHS=filter(canre, pop1=="Santa Barbara", stat=="iHS")|>pull(region),
    nSL=filter(canre, pop1=="Santa Barbara", stat=="nSL")|>pull(region),
    `XP-nSL`=filter(canre, pop1=="Santa Barbara", stat=="XP-nSL")|>pull(region),
#    `-XP-nSL`=filter(canre, pop1=="Santa Barbara", stat=="-XP-nSL")|>pull(region),
    `XP-CLR`=filter(canre, pop1=="Santa Barbara", stat=="XP-CLR")|>pull(region))

SetsNorteHumboldt <- 
  c(intersect(NorteHumboldt$iHS, NorteHumboldt$nSL), intersect(NorteHumboldt$iHS, NorteHumboldt$`XP-nSL`), intersect(NorteHumboldt$iHS, NorteHumboldt$`XP-CLR`),
    intersect(NorteHumboldt$nSL, NorteHumboldt$`XP-nSL`), intersect(NorteHumboldt$nSL, NorteHumboldt$`XP-CLR`),
    intersect(NorteHumboldt$`XP-nSL`, NorteHumboldt$`XP-CLR`)) |>
  unique() |>
  sort()

SetsMendocino <- 
  c(intersect(Mendocino$iHS, Mendocino$nSL), intersect(Mendocino$iHS, Mendocino$`XP-nSL`), intersect(Mendocino$iHS, Mendocino$`XP-CLR`),
    intersect(Mendocino$nSL, Mendocino$`XP-nSL`), intersect(Mendocino$nSL, Mendocino$`XP-CLR`),
    intersect(Mendocino$`XP-nSL`, Mendocino$`XP-CLR`)) |>
  unique() |>
  sort()

SetsSantaBarbara <- 
  c(intersect(SantaBarbara$iHS, SantaBarbara$nSL), intersect(SantaBarbara$iHS, SantaBarbara$`XP-nSL`), intersect(SantaBarbara$iHS, SantaBarbara$`XP-CLR`),
    intersect(SantaBarbara$nSL, SantaBarbara$`XP-nSL`), intersect(SantaBarbara$nSL, SantaBarbara$`XP-CLR`),
    intersect(SantaBarbara$`XP-nSL`, SantaBarbara$`XP-CLR`)) |>
  unique() |>
  sort()

RegsNorteHumboldt <- 
  left_join(
    x=tibble(region=SetsNorteHumboldt), 
    y=bind_rows(
#      filter(canre, pop1=="Del Norte-Humboldt", stat=="XP-nSL"),
#      filter(canre, pop1=="Del Norte-Humboldt", stat=="-XP-nSL")|>mutate(stat="XP-nSL"),
      filter(canre, pop1=="Del Norte-Humboldt", stat%in%c("iHS", "nSL", "XP-nSL", "XP-CLR"))) |> 
      distinct(chr, pos, stat, pop2, pop1, gene_id, PANTHER_accession, PANTHER_family_name, region, .keep_all=TRUE))

RegsMendocino <- 
  left_join(
    x=tibble(region=SetsMendocino), 
    y=bind_rows(
#      filter(canre, pop1=="Mendocino", stat=="XP-nSL"),
#      filter(canre, pop1=="Mendocino", stat=="-XP-nSL")|>mutate(stat="XP-nSL"),
      filter(canre, pop1=="Mendocino", stat%in%c("iHS", "nSL", "XP-nSL", "XP-CLR"))) |> 
      distinct(chr, pos, stat, pop2, pop1, gene_id, PANTHER_accession, PANTHER_family_name, region, .keep_all=TRUE))

RegsSantaBarbara <- 
  left_join(
    x=tibble(region=SetsSantaBarbara), 
    y=bind_rows(
#      filter(canre, pop1=="Santa Barbara", stat=="XP-nSL"),
#      filter(canre, pop1=="Santa Barbara", stat=="-XP-nSL")|>mutate(stat="XP-nSL"),
      filter(canre, pop1=="Santa Barbara", stat%in%c("iHS", "nSL", "XP-nSL", "XP-CLR"))) |> 
      distinct(chr, pos, stat, pop2, pop1, gene_id, PANTHER_accession, PANTHER_family_name, region, .keep_all=TRUE))

distinct(RegsNorteHumboldt, gene_id, PANTHER_accession, .keep_all=TRUE)
distinct(RegsMendocino, gene_id, PANTHER_accession, .keep_all=TRUE)
distinct(RegsSantaBarbara, gene_id, PANTHER_accession, .keep_all=TRUE)

# test intersecting candidates w/ full reference lists
RegsNorteHumboldt |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/NorteHumboldt_SETS", col_names=FALSE)

RegsMendocino |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/Mendocino_SETS", col_names=FALSE)

RegsSantaBarbara |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/SantaBarbara_SETS", col_names=FALSE)

Regs <- 
  bind_rows(RegsNorteHumboldt, RegsMendocino, RegsSantaBarbara) |>
  select(-chr, -pos, -n_snps, -candidate) |>
  left_join(select(Genes, gene_id, UniProtKB, gene))

write_tsv(Regs, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/Intersect.Candidate.Genes.tsv", na="")

Regs <- 
  group_by(Regs, region, pop1) |> nest()

Regs <- 
  unnest_wider(Regs, col=data)

Regs <- 
  rowwise(Regs) |> 
  mutate(
    stat=list(unique(stat)),
    pop2=list(unique(pop2)),
    gene_id=list(unique(gene_id)),
    score=list(unique(score)),
    prop_crit=list(unique(prop_crit)),
    PANTHER_accession=list(unique(PANTHER_accession)),
    PANTHER_family_name=list(unique(PANTHER_family_name)),
    UniProtKB=list(unique(UniProtKB)),
    gene=list(unique(gene)))

Regs <- 
  left_join(
    x=select(Regs, 1:2, stat)|>unnest_wider(stat, names_sep="."), 
    y=select(Regs, 1:2, pop2)|>unnest_wider(pop2, names_sep=".")) |>
  left_join(
    y=select(Regs, 1:2, gene_id)|>unnest_wider(gene_id, names_sep=".")) |>
  left_join(
    y=select(Regs, 1:2, score)|>unnest_wider(score, names_sep=".")) |>
  left_join(
    y=select(Regs, 1:2, prop_crit)|>unnest_wider(prop_crit, names_sep=".")) |>
  left_join(
    y=select(Regs, 1:2, PANTHER_accession)|>unnest_wider(PANTHER_accession, names_sep=".")) |>
  left_join(
    y=select(Regs, 1:2, PANTHER_family_name)|>unnest_wider(PANTHER_family_name, names_sep=".")) |>
  left_join(
    y=select(Regs, 1:2, UniProtKB)|>unnest_wider(UniProtKB, names_sep=".")) |>
  left_join(
    y=select(Regs, 1:2, gene)|>unnest_wider(gene, names_sep=".")) |>
  separate(col=region, into=c("chr", "start"), sep="_", convert=TRUE) |>
  mutate(end=start+99999, region=paste0("chr", chr, ":", start, "-", end)) |>
  relocate(end, region, .after=start) |>
  arrange(pop1, chr, start)
Regs

write_tsv(Regs, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/Intersect.Candidate.Genes.wide.tsv", na="")


## try cand regions instead of genes
XPCLR.q <- ungroup(XPCLR)|>select(-chrom, -tot, -id, -STAT)

dat0 <- 
  bind_rows(
    select(iHS2.q, CHROM, START, POP1, MAX_SCORE, PROP_CRIT, N_SCORES, CANDIDATE, QUAN)|>mutate(POP1=as.character(POP1), POP2=NA, STAT="iHS"),
    select(nSL2.q, CHROM, START, POP1, MAX_SCORE, PROP_CRIT, N_SCORES, CANDIDATE, QUAN)|>mutate(POP1=as.character(POP1), POP2=NA, STAT="nSL"),
    select(XPnSL2.q, CHROM, START, POP1=samplesA, POP2=samplesB, MAX_SCORE, PROP_CRIT=PROP_CRIT1, N_SCORES, CANDIDATE=CANDIDATE1, QUAN)|>mutate(STAT="XP-nSL"),
#    select(XPnSL2.neg2, CHROM, START, POP1=samplesB, POP2=samplesA, MAX_SCORE=MIN_SCORE, PROP_CRIT=PROP_CRIT2, N_SCORES, CANDIDATE=CANDIDATE2, QUAN)|>mutate(MAX_SCORE=MAX_SCORE*-1, STAT="-XP-nSL"),
    select(XPCLR.q, CHROM=chr, START=start, POP1=samplesA, POP2=samplesB, MAX_SCORE=xpclr_norm, N_SCORES=nSNPs, CANDIDATE, QUAN)|>mutate(STAT="XP-CLR", PROP_CRIT=MAX_SCORE)) |>
  select(chr=CHROM, pos=START, stat=STAT, pop1=POP1, pop2=POP2, score=MAX_SCORE, prop_crit=PROP_CRIT, n_snps=N_SCORES, candidate=CANDIDATE, bin=QUAN)

unique(dat0$stat);unique(dat0$pop1);unique(dat0$pop2)

dat0$pop1 <- gsub(pattern="SantaBarbara", replacement="Santa Barbara", x=dat0$pop1)
dat0$pop1 <- gsub(pattern="NorteHumboldt", replacement="Del Norte-Humboldt", x=dat0$pop1)
dat0$pop2 <- gsub(pattern="SantaBarbara", replacement="Santa Barbara", x=dat0$pop2)
dat0$pop2 <- gsub(pattern="NorteHumboldt", replacement="Del Norte-Humboldt", x=dat0$pop2)

unique(dat0$stat);unique(dat0$pop1);unique(dat0$pop2)

saveRDS(object=dat0, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/Candidate.Regions.RDS")
write_tsv(dat0, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/Candidate.Regions.tsv")


canre <- 
  filter(dat0, candidate==TRUE) |>
  mutate(region=paste0(chr, "_", pos)) 

NorteHumboldt <- 
  list(
    iHS=filter(canre, pop1=="Del Norte-Humboldt", stat=="iHS")|>pull(region),
    nSL=filter(canre, pop1=="Del Norte-Humboldt", stat=="nSL")|>pull(region),
    `XP-nSL`=filter(canre, pop1=="Del Norte-Humboldt", stat=="XP-nSL")|>pull(region),
#    `-XP-nSL`=filter(canre, pop1=="Del Norte-Humboldt", stat=="-XP-nSL")|>pull(region),
    `XP-CLR`=filter(canre, pop1=="Del Norte-Humboldt", stat=="XP-CLR")|>pull(region))

Mendocino <- 
  list(
    iHS=filter(canre, pop1=="Mendocino", stat=="iHS")|>pull(region),
    nSL=filter(canre, pop1=="Mendocino", stat=="nSL")|>pull(region),
    `XP-nSL`=filter(canre, pop1=="Mendocino", stat=="XP-nSL")|>pull(region),
#    `-XP-nSL`=filter(canre, pop1=="Mendocino", stat=="-XP-nSL")|>pull(region),
    `XP-CLR`=filter(canre, pop1=="Mendocino", stat=="XP-CLR")|>pull(region))

SantaBarbara <- 
  list(
    iHS=filter(canre, pop1=="Santa Barbara", stat=="iHS")|>pull(region),
    nSL=filter(canre, pop1=="Santa Barbara", stat=="nSL")|>pull(region),
    `XP-nSL`=filter(canre, pop1=="Santa Barbara", stat=="XP-nSL")|>pull(region),
#    `-XP-nSL`=filter(canre, pop1=="Santa Barbara", stat=="-XP-nSL")|>pull(region),
    `XP-CLR`=filter(canre, pop1=="Santa Barbara", stat=="XP-CLR")|>pull(region))

SetsNorteHumboldt <- 
  c(intersect(NorteHumboldt$iHS, NorteHumboldt$nSL), intersect(NorteHumboldt$iHS, NorteHumboldt$`XP-nSL`), intersect(NorteHumboldt$iHS, NorteHumboldt$`XP-CLR`),
    intersect(NorteHumboldt$nSL, NorteHumboldt$`XP-nSL`), intersect(NorteHumboldt$nSL, NorteHumboldt$`XP-CLR`),
    intersect(NorteHumboldt$`XP-nSL`, NorteHumboldt$`XP-CLR`)) |>
  unique() |>
  sort()

SetsMendocino <- 
  c(intersect(Mendocino$iHS, Mendocino$nSL), intersect(Mendocino$iHS, Mendocino$`XP-nSL`), intersect(Mendocino$iHS, Mendocino$`XP-CLR`),
    intersect(Mendocino$nSL, Mendocino$`XP-nSL`), intersect(Mendocino$nSL, Mendocino$`XP-CLR`),
    intersect(Mendocino$`XP-nSL`, Mendocino$`XP-CLR`)) |>
  unique() |>
  sort()

SetsSantaBarbara <- 
  c(intersect(SantaBarbara$iHS, SantaBarbara$nSL), intersect(SantaBarbara$iHS, SantaBarbara$`XP-nSL`), intersect(SantaBarbara$iHS, SantaBarbara$`XP-CLR`),
    intersect(SantaBarbara$nSL, SantaBarbara$`XP-nSL`), intersect(SantaBarbara$nSL, SantaBarbara$`XP-CLR`),
    intersect(SantaBarbara$`XP-nSL`, SantaBarbara$`XP-CLR`)) |>
  unique() |>
  sort()

RegsNorteHumboldt <- 
  left_join(
    x=tibble(region=SetsNorteHumboldt), 
    y=bind_rows(
      filter(canre, pop1=="Del Norte-Humboldt", stat%in%c("iHS", "nSL", "XP-nSL", "XP-CLR"))) |> 
      distinct(chr, pos, stat, pop2, pop1, region, .keep_all=TRUE))

RegsMendocino <- 
  left_join(
    x=tibble(region=SetsMendocino), 
    y=bind_rows(
      filter(canre, pop1=="Mendocino", stat%in%c("iHS", "nSL", "XP-nSL", "XP-CLR"))) |> 
      distinct(chr, pos, stat, pop2, pop1, region, .keep_all=TRUE))

RegsSantaBarbara <- 
  left_join(
    x=tibble(region=SetsSantaBarbara), 
    y=bind_rows(
      filter(canre, pop1=="Santa Barbara", stat%in%c("iHS", "nSL", "XP-nSL", "XP-CLR"))) |> 
      distinct(chr, pos, stat, pop2, pop1, region, .keep_all=TRUE))

distinct(RegsNorteHumboldt, region, .keep_all=TRUE)
distinct(RegsMendocino, region, .keep_all=TRUE)
distinct(RegsSantaBarbara, region, .keep_all=TRUE)


Regs0 <- 
  bind_rows(RegsNorteHumboldt, RegsMendocino, RegsSantaBarbara) |>
  select(-chr, -pos)

write_tsv(Regs0, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/Intersect.Candidate.Regions.tsv", na="")

Regs0 <- 
  group_by(Regs0, region, pop1) |> nest()

Regs0 <- 
  unnest_wider(Regs0, col=data)

Regs0 <- 
  rowwise(Regs0) |> 
  mutate(
    stat=list(unique(stat)),
    pop2=list(unique(pop2)),
    score=list(unique(score)),
    prop_crit=list(unique(prop_crit)))

Regs0 <- 
  left_join(
    x=select(Regs0, 1:2, stat)|>unnest_wider(stat, names_sep="."), 
    y=select(Regs0, 1:2, pop2)|>unnest_wider(pop2, names_sep=".")) |>
  left_join(
    y=select(Regs0, 1:2, score)|>unnest_wider(score, names_sep=".")) |>
  left_join(
    y=select(Regs0, 1:2, prop_crit)|>unnest_wider(prop_crit, names_sep=".")) |>
  separate(col=region, into=c("chr", "start"), sep="_", convert=TRUE) |>
  mutate(end=start+99999, region=paste0("chr", chr, ":", start, "-", end)) |>
  relocate(end, region, .after=start) |>
  arrange(pop1, chr, start)
Regs0

write_tsv(Regs0, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/Intersect.Candidate.Regions.wide.tsv", na="")

comboRegs <- full_join(x=Regs, y=Regs0) |> arrange(pop1, chr, start)

write_tsv(comboRegs, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/Intersect.Candidate.Regions.Combo.wide.tsv", na="")


# stopped 10/16/2024

# check Hsp70
PC00027 <- read_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/scrap/PC00027.tsv")
XPnSL_scores_NorteHumboldt_SantaBarbara <- 
  read_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/XP-nSL_scores_NorteHumboldt_SantaBarbara", col_names=FALSE)
XPnSL_scores_NorteHumboldt_Mendocino <- 
  read_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/XP-nSL_scores_NorteHumboldt_Mendocino", col_names=FALSE)
XPnSL_scores_Mendocino_NorteHumboldt <- 
  read_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/XP-nSL_scores_Mendocino_NorteHumboldt", col_names=FALSE)
XPnSL_scores_Mendocino_SantaBarbara <- 
  read_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/XP-nSL_scores_Mendocino_SantaBarbara", col_names=FALSE)
XPnSL_scores_SantaBarbara_NorteHumboldt <- 
  read_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/XP-nSL_scores_SantaBarbara_NorteHumboldt", col_names=FALSE)
XPnSL_scores_SantaBarbara_Mendocino <- 
  read_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/XP-nSL_scores_SantaBarbara_Mendocino", col_names=FALSE)

left_join(PC00027, XPnSL_scores_NorteHumboldt_SantaBarbara, by=join_by(PC00027==X1))|>summarise(sum(X3))
left_join(PC00027, XPnSL_scores_NorteHumboldt_Mendocino, by=join_by(PC00027==X1))|>summarise(sum(X3))
left_join(PC00027, XPnSL_scores_Mendocino_NorteHumboldt, by=join_by(PC00027==X1))|>summarise(sum(X3))
left_join(PC00027, XPnSL_scores_Mendocino_SantaBarbara, by=join_by(PC00027==X1))|>summarise(sum(X3))
left_join(PC00027, XPnSL_scores_SantaBarbara_NorteHumboldt, by=join_by(PC00027==X1))|>summarise(sum(X3))
left_join(PC00027, XPnSL_scores_SantaBarbara_Mendocino, by=join_by(PC00027==X1))|>summarise(sum(X3))


# prepare table of top10 +/- adjacent candidate windows (from top 1%)
candi <- 
  left_join(x=filter(dat, candidate==TRUE), y=mutate(top10, top10=TRUE)) |> 
  arrange(stat, pop1, pop2, chr, pos, PANTHER_family_name) |>
  distinct()

view(candi)

#write_tsv(candi, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/Top.10.Candidate.Genes.tsv")


candi <- read_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/Top.10.Candidate.Genes.tsv")
saveRDS(object=candi, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/Top.10.Candidate.Genes.RDS")

candi <- 
  left_join(select(candi, -n_snps), select(Genes, gene_id, UniProtKB, gene)) |>
  replace_na(list(top10=FALSE, add=FALSE)) |>
  rename(start=pos)
 
nesti <- 
  group_by(filter(candi, add==TRUE)|>select(-add, -candidate), chr, start) |> nest()

nesti <- 
  unnest_wider(nesti, col=data)

nesti <- 
  rowwise(nesti) |> 
  mutate(
    stat=list(unique(stat)),
    pop1=list(unique(pop1)),
    pop2=list(unique(pop2)),
    gene_id=list(unique(gene_id)),
    score=list(unique(score)),
    prop_crit=list(unique(prop_crit)),
    PANTHER_accession=list(unique(PANTHER_accession)),
    PANTHER_family_name=list(unique(PANTHER_family_name)),
    top10=list(unique(top10)),
    UniProtKB=list(unique(UniProtKB)),
    gene=list(unique(gene)),
    end=start+99999) |>
  arrange(chr, start) |>
  relocate(end, .after=start)

unesti <- 
  left_join(
    x=select(nesti, 1:3, stat)|>unnest_wider(stat, names_sep="."), 
    y=select(nesti, 1:3, pop1)|>unnest_wider(pop1, names_sep=".")) |>
  left_join(
    y=select(nesti, 1:3, pop2)|>unnest_wider(pop2, names_sep=".")) |>
  left_join(
    y=select(nesti, 1:3, gene_id)|>unnest_wider(gene_id, names_sep=".")) |>
  left_join(
    y=select(nesti, 1:3, score)|>unnest_wider(score, names_sep=".")) |>
  left_join(
    y=select(nesti, 1:3, prop_crit)|>unnest_wider(prop_crit, names_sep=".")) |>
  left_join(
    y=select(nesti, 1:3, PANTHER_accession)|>unnest_wider(PANTHER_accession, names_sep=".")) |>
  left_join(
    y=select(nesti, 1:3, PANTHER_family_name)|>unnest_wider(PANTHER_family_name, names_sep=".")) |>
  left_join(
    y=select(nesti, 1:3, top10)|>unnest_wider(top10, names_sep=".")) |>
  left_join(
    y=select(nesti, 1:3, UniProtKB)|>unnest_wider(UniProtKB, names_sep=".")) |>
  left_join(
    y=select(nesti, 1:3, gene)|>unnest_wider(gene, names_sep="."))
unesti

write_tsv(unesti, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.redo/Top.10.Candidate.Genes.wide.tsv", na="")
