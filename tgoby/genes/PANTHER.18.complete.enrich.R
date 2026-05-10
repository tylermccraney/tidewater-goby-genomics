library(tidyverse)

Genes <- 
  readRDS(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/Genes.RDS")

group_by(Genes, ORF_type) |> count()

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

windows <- seq(1, 54200001, 100000)

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

filter(Genes, is.na(panes))

Genes <- 
  rowwise(Genes) |> mutate(windows=list(seq.int(from=window, length.out=panes, by=100000)))

gene.windows <- 
  unnest_longer(select(Genes, -window), windows, values_to="window")

saveRDS(object=gene.windows, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/gene.windows.RDS")
write_tsv(gene.windows, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/gene.windows.tsv")

window.genes <- 
  select(gene.windows, seqid, window, gene_id)
  
saveRDS(object=window.genes, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/window.genes.RDS")
write_tsv(window.genes, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/window.genes.tsv")

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

iHS2. <- 
  mutate(iHS, WINDOW=cut(POS, breaks=c(windows, 54300001), labels=windows, include.lowest=TRUE), START=as.character(WINDOW)|>as.double(), END=START+99999) |>
  group_by(CHROM, START, END, POP1=POP) |>
  summarise(N_SCORES=n(), MAX_SCORE=max(ABS_iHS), PROP_CRIT=sum(crit)/n()) |>
  ungroup()

nSL2. <- 
  mutate(nSL, WINDOW=cut(POS, breaks=c(windows, 54300001), labels=windows, include.lowest=TRUE), START=as.character(WINDOW)|>as.double(), END=START+99999) |>
  group_by(CHROM, START, END, POP1=POP) |>
  summarise(N_SCORES=n(), MAX_SCORE=max(ABS_nSL), PROP_CRIT=sum(crit)/n()) |>
  ungroup()

XPnSL2. <- 
  mutate(XPnSL, WINDOW=cut(pos, breaks=c(windows, 54300001), labels=windows, include.lowest=TRUE), START=as.character(WINDOW)|>as.double(), END=START+99999) |>
  group_by(CHROM=chr, START, END, samplesA, samplesB) |>
  summarise(N_SCORES=n(), MAX_SCORE=max(xpnsl_norm), MIN_SCORE=min(xpnsl_norm), PROP_CRIT1=sum(crit==1)/n(), PROP_CRIT2=abs(sum(crit==-1))/n()) |>
  ungroup()

iHS2.1 <- 
  filter(iHS2., N_SCORES>=10) |> 
  mutate(QUAN=cut_number(N_SCORES, n=10, labels=1:10), CANDIDATE=TRUE) |> 
  group_by(POP1, QUAN) |> 
  slice_max(PROP_CRIT, prop=0.01, with_ties=TRUE) |> 
  ungroup()

nSL2.1 <- 
  filter(nSL2., N_SCORES>=10) |> 
  mutate(QUAN=cut_number(N_SCORES, n=10, labels=1:10), CANDIDATE=TRUE) |> 
  group_by(POP1, QUAN) |> 
  slice_max(PROP_CRIT, prop=0.01, with_ties=TRUE) |> 
  ungroup()

XPnSL2.1 <- 
  filter(XPnSL2., N_SCORES>=10) |> 
  mutate(QUAN=cut_number(N_SCORES, n=10, labels=1:10), CANDIDATE=TRUE) |> 
  group_by(samplesA, samplesB, QUAN) |> 
  slice_max(PROP_CRIT1, prop=0.01, with_ties=TRUE) |> 
  ungroup()

window.genes$window <- as.double(window.genes$window)

distinct(window.genes, window)

iHS2. <- 
  left_join(x=iHS2., y=iHS2.1, by=join_by(CHROM, START, END, POP1, N_SCORES, MAX_SCORE, PROP_CRIT)) |>
  replace_na(list(CANDIDATE=FALSE)) |>
#  filter(N_SCORES>=10) |>
  left_join(y=window.genes, by=join_by(CHROM==seqid, START==window), relationship="many-to-many") |> 
  rename(STRG=gene_id) |>
  group_by(POP1, STRG) |>
  slice_max(MAX_SCORE, with_ties=FALSE) |>
  ungroup()

nSL2. <- 
  left_join(x=nSL2., y=nSL2.1, by=join_by(CHROM, START, END, POP1, N_SCORES, MAX_SCORE, PROP_CRIT)) |>
  replace_na(list(CANDIDATE=FALSE)) |>
#  filter(N_SCORES>=10) |>
  left_join(y=window.genes, by=join_by(CHROM==seqid, START==window), relationship="many-to-many") |> 
  rename(STRG=gene_id) |>
  group_by(POP1, STRG) |>
  slice_max(MAX_SCORE, with_ties=FALSE) |>
  ungroup()

XPnSL2. <- 
  left_join(x=XPnSL2., y=XPnSL2.1, by=join_by(CHROM, START, END, samplesA, samplesB, N_SCORES, MAX_SCORE, MIN_SCORE, PROP_CRIT1, PROP_CRIT2)) |>
  replace_na(list(CANDIDATE=FALSE)) |>
#  filter(N_SCORES>=10) |>
  left_join(y=window.genes, by=join_by(CHROM==seqid, START==window), relationship="many-to-many") |> 
  rename(STRG=gene_id) |>
  group_by(samplesA, samplesB, STRG) |>
  slice_max(MAX_SCORE, with_ties=FALSE) |>
  ungroup()

XPCLR <- 
  left_join(x=ungroup(XPCLR)|>select(-chrom, -tot, -id), y=window.genes, by=join_by(chr==seqid, start==window), relationship="many-to-many") |> 
  rename(STRG=gene_id) |>
  group_by(samplesA, samplesB, STRG) |>
  slice_max(xpclr_norm, with_ties=FALSE) |>
  ungroup()

filter(iHS2., CANDIDATE==TRUE) |> group_by(POP1) |> count()
filter(nSL2., CANDIDATE==TRUE) |> group_by(POP1) |> count()
filter(XPnSL2., CANDIDATE==TRUE) |> group_by(samplesA, samplesB) |> count()
filter(XPCLR, CANDIDATE==TRUE) |> group_by(samplesA, samplesB) |> count()

dat <- 
  bind_rows(
    select(iHS2., CHROM, START, POP1, STRG, MAX_SCORE, PROP_CRIT, N_SCORES, CANDIDATE)|>mutate(POP1=as.character(POP1), POP2=NA, STAT="iHS"),
    select(nSL2., CHROM, START, POP1, STRG, MAX_SCORE, PROP_CRIT, N_SCORES, CANDIDATE)|>mutate(POP1=as.character(POP1), POP2=NA, STAT="nSL"),
    select(XPnSL2., CHROM, START, POP1=samplesA, POP2=samplesB, STRG, MAX_SCORE, PROP_CRIT=PROP_CRIT1, N_SCORES, CANDIDATE)|>mutate(STAT="XP-nSL"),
    select(XPCLR, CHROM=chr, START=start, POP1=samplesA, POP2=samplesB, STRG, MAX_SCORE=xpclr_norm, N_SCORES=nSNPs, CANDIDATE)|>mutate(STAT="XP-CLR", PROP_CRIT=MAX_SCORE)) |>
  select(chr=CHROM, pos=START, stat=STAT, pop1=POP1, pop2=POP2, gene_id=STRG, score=MAX_SCORE, prop_crit=PROP_CRIT, n_snps=N_SCORES, candidate=CANDIDATE) |>
  left_join(y=select(Genes, gene_id, PANTHER_accession, PANTHER_family_name), by=join_by(gene_id))

unique(dat$stat);unique(dat$pop1);unique(dat$pop2)

dat$pop1 <- gsub(pattern="SantaBarbara", replacement="Santa Barbara", x=dat$pop1)
dat$pop1 <- gsub(pattern="NorteHumboldt", replacement="Del Norte-Humboldt", x=dat$pop1)
dat$pop2 <- gsub(pattern="SantaBarbara", replacement="Santa Barbara", x=dat$pop2)
dat$pop2 <- gsub(pattern="NorteHumboldt", replacement="Del Norte-Humboldt", x=dat$pop2)

unique(dat$stat);unique(dat$pop1);unique(dat$pop2)

dat <- 
  arrange(dat, stat, pop1, pop2, chr, pos) |>
  filter(!is.na(gene_id)) |>
  replace_na(list(candidate=FALSE))

saveRDS(object=dat, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/Candidate.Genes.RDS")
write_tsv(dat, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/Candidate.Genes.tsv")

dat

filter(dat, pop1=="Del Norte-Humboldt", stat=="iHS") |> 
  select(gene_id, PANTHER_accession, score) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/iHS_scores_NorteHumboldt", col_names=FALSE)

filter(dat, pop1=="Mendocino", stat=="iHS") |> 
  select(gene_id, PANTHER_accession, score) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/iHS_scores_Mendocino", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", stat=="iHS") |> 
  select(gene_id, PANTHER_accession, score) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/iHS_scores_SantaBarbara", col_names=FALSE)

#
filter(dat, pop1=="Del Norte-Humboldt", stat=="nSL") |> 
  select(gene_id, PANTHER_accession, score) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/nSL_scores_NorteHumboldt", col_names=FALSE)

filter(dat, pop1=="Mendocino", stat=="nSL") |> 
  select(gene_id, PANTHER_accession, score) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/nSL_scores_Mendocino", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", stat=="nSL") |> 
  select(gene_id, PANTHER_accession, score) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/nSL_scores_SantaBarbara", col_names=FALSE)

#
filter(dat, pop1=="Del Norte-Humboldt", pop2=="Mendocino", stat=="XP-nSL") |> 
  select(gene_id, PANTHER_accession, score) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-nSL_scores_NorteHumboldt_Mendocino", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", pop2=="Santa Barbara", stat=="XP-nSL") |> 
  select(gene_id, PANTHER_accession, score) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-nSL_scores_NorteHumboldt_SantaBarbara", col_names=FALSE)

filter(dat, pop1=="Mendocino", pop2=="Del Norte-Humboldt", stat=="XP-nSL") |> 
  select(gene_id, PANTHER_accession, score) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-nSL_scores_Mendocino_NorteHumboldt", col_names=FALSE)

filter(dat, pop1=="Mendocino", pop2=="Santa Barbara", stat=="XP-nSL") |> 
  select(gene_id, PANTHER_accession, score) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-nSL_scores_Mendocino_SantaBarbara", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", pop2=="Del Norte-Humboldt", stat=="XP-nSL") |> 
  select(gene_id, PANTHER_accession, score) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-nSL_scores_SantaBarbara_NorteHumboldt", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", pop2=="Mendocino", stat=="XP-nSL") |> 
  select(gene_id, PANTHER_accession, score) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-nSL_scores_SantaBarbara_Mendocino", col_names=FALSE)

#
filter(dat, pop1=="Del Norte-Humboldt", pop2=="Mendocino", stat=="XP-CLR") |> 
  select(gene_id, PANTHER_accession, score) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-CLR_scores_NorteHumboldt_Mendocino", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", pop2=="Santa Barbara", stat=="XP-CLR") |> 
  select(gene_id, PANTHER_accession, score) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-CLR_scores_NorteHumboldt_SantaBarbara", col_names=FALSE)

filter(dat, pop1=="Mendocino", pop2=="Del Norte-Humboldt", stat=="XP-CLR") |> 
  select(gene_id, PANTHER_accession, score) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-CLR_scores_Mendocino_NorteHumboldt", col_names=FALSE)

filter(dat, pop1=="Mendocino", pop2=="Santa Barbara", stat=="XP-CLR") |> 
  select(gene_id, PANTHER_accession, score) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-CLR_scores_Mendocino_SantaBarbara", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", pop2=="Del Norte-Humboldt", stat=="XP-CLR") |> 
  select(gene_id, PANTHER_accession, score) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-CLR_scores_SantaBarbara_NorteHumboldt", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", pop2=="Mendocino", stat=="XP-CLR") |> 
  select(gene_id, PANTHER_accession, score) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-CLR_scores_SantaBarbara_Mendocino", col_names=FALSE)

#
filter(dat, pop1=="Del Norte-Humboldt", stat=="iHS", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/iHS_NorteHumboldt_TOP", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", stat=="iHS", n_snps>=10) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/iHS_NorteHumboldt_REF", col_names=FALSE)

filter(dat, pop1=="Mendocino", stat=="iHS", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/iHS_Mendocino_TOP", col_names=FALSE)

filter(dat, pop1=="Mendocino", stat=="iHS", n_snps>=10) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/iHS_Mendocino_REF", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", stat=="iHS", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/iHS_SantaBarbara_TOP", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", stat=="iHS", n_snps>=10) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/iHS_SantaBarbara_REF", col_names=FALSE)

#
filter(dat, pop1=="Del Norte-Humboldt", stat=="nSL", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/nSL_NorteHumboldt_TOP", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", stat=="nSL", n_snps>=10) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/nSL_NorteHumboldt_REF", col_names=FALSE)

filter(dat, pop1=="Mendocino", stat=="nSL", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/nSL_Mendocino_TOP", col_names=FALSE)

filter(dat, pop1=="Mendocino", stat=="nSL", n_snps>=10) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/nSL_Mendocino_REF", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", stat=="nSL", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/nSL_SantaBarbara_TOP", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", stat=="nSL", n_snps>=10) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/nSL_SantaBarbara_REF", col_names=FALSE)

#
filter(dat, pop1=="Del Norte-Humboldt", pop2=="Mendocino", stat=="XP-nSL", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-nSL_NorteHumboldt_Mendocino_TOP", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", pop2=="Mendocino", stat=="XP-nSL", n_snps>=10) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-nSL_NorteHumboldt_Mendocino_REF", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", pop2=="Santa Barbara", stat=="XP-nSL", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-nSL_NorteHumboldt_SantaBarbara_TOP", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", pop2=="Santa Barbara", stat=="XP-nSL", n_snps>=10) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-nSL_NorteHumboldt_SantaBarbara_REF", col_names=FALSE)

filter(dat, pop1=="Mendocino", pop2=="Del Norte-Humboldt", stat=="XP-nSL", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-nSL_Mendocino_NorteHumboldt_TOP", col_names=FALSE)

filter(dat, pop1=="Mendocino", pop2=="Del Norte-Humboldt", stat=="XP-nSL", n_snps>=10) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-nSL_Mendocino_NorteHumboldt_REF", col_names=FALSE)

filter(dat, pop1=="Mendocino", pop2=="Santa Barbara", stat=="XP-nSL", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-nSL_Mendocino_SantaBarbara_TOP", col_names=FALSE)

filter(dat, pop1=="Mendocino", pop2=="Santa Barbara", stat=="XP-nSL", n_snps>=10) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-nSL_Mendocino_SantaBarbara_REF", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", pop2=="Del Norte-Humboldt", stat=="XP-nSL", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-nSL_SantaBarbara_NorteHumboldt_TOP", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", pop2=="Del Norte-Humboldt", stat=="XP-nSL", n_snps>=10) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-nSL_SantaBarbara_NorteHumboldt_REF", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", pop2=="Mendocino", stat=="XP-nSL", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-nSL_SantaBarbara_Mendocino_TOP", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", pop2=="Mendocino", stat=="XP-nSL", n_snps>=10) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-nSL_SantaBarbara_Mendocino_REF", col_names=FALSE)

#
filter(dat, pop1=="Del Norte-Humboldt", pop2=="Mendocino", stat=="XP-CLR", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-CLR_NorteHumboldt_Mendocino_TOP", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", pop2=="Mendocino", stat=="XP-CLR", n_snps>=10) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-CLR_NorteHumboldt_Mendocino_REF", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", pop2=="Santa Barbara", stat=="XP-CLR", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-CLR_NorteHumboldt_SantaBarbara_TOP", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", pop2=="Santa Barbara", stat=="XP-CLR", n_snps>=10) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-CLR_NorteHumboldt_SantaBarbara_REF", col_names=FALSE)

filter(dat, pop1=="Mendocino", pop2=="Del Norte-Humboldt", stat=="XP-CLR", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-CLR_Mendocino_NorteHumboldt_TOP", col_names=FALSE)

filter(dat, pop1=="Mendocino", pop2=="Del Norte-Humboldt", stat=="XP-CLR", n_snps>=10) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-CLR_Mendocino_NorteHumboldt_REF", col_names=FALSE)

filter(dat, pop1=="Mendocino", pop2=="Santa Barbara", stat=="XP-CLR", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-CLR_Mendocino_SantaBarbara_TOP", col_names=FALSE)

filter(dat, pop1=="Mendocino", pop2=="Santa Barbara", stat=="XP-CLR", n_snps>=10) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-CLR_Mendocino_SantaBarbara_REF", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", pop2=="Del Norte-Humboldt", stat=="XP-CLR", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-CLR_SantaBarbara_NorteHumboldt_TOP", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", pop2=="Del Norte-Humboldt", stat=="XP-CLR", n_snps>=10) |> 
  select(gene_id, PANTHER_accession) |>
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-CLR_SantaBarbara_NorteHumboldt_REF", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", pop2=="Mendocino", stat=="XP-CLR", candidate==TRUE) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-CLR_SantaBarbara_Mendocino_TOP", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", pop2=="Mendocino", stat=="XP-CLR", n_snps>=10) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/XP-CLR_SantaBarbara_Mendocino_REF", col_names=FALSE)

filter(dat, candidate==TRUE) |> group_by(stat, pop1, pop2) |> summarise(n(), min(score), min(prop_crit, na.rm=TRUE), max(score), max(prop_crit, na.rm=TRUE)) 

filter(dat, candidate==TRUE) |> group_by(pop1, PANTHER_family_name) |> count(sort=TRUE) |> filter(!is.na(PANTHER_family_name))

top10 <- 
  filter(dat, candidate==TRUE) |> group_by(stat, pop1, pop2) |> slice_max(prop_crit, n=10, with_ties=TRUE)

top10 <- 
  arrange(top10, stat, pop1, pop2, chr, pos, PANTHER_family_name) |> ungroup()

#
filter(top10, pop1=="Del Norte-Humboldt") |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/NorteHumboldt_TOP10", col_names=FALSE)

filter(dat, pop1=="Del Norte-Humboldt", n_snps>=10) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/NorteHumboldt_REF", col_names=FALSE)

filter(top10, pop1=="Mendocino") |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/Mendocino_TOP10", col_names=FALSE)

filter(dat, pop1=="Mendocino", n_snps>=10) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/Mendocino_REF", col_names=FALSE)

filter(top10, pop1=="Santa Barbara") |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/SantaBarbara_TOP10", col_names=FALSE)

filter(dat, pop1=="Santa Barbara", n_snps>=10) |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/SantaBarbara_REF", col_names=FALSE)




##
library(ggvenn)

brewpal2 <- read_tsv(file="../brewpal2.tab")
brewpal2x <- read_tsv(file="../brewpal2x.tab")
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
  labs(title="450 Candidate Genes (iHS)", tag="(c)") + 
  theme(plot.caption=element_text(size=13, hjust=0.5), plot.title=element_text(size=15, hjust=0.5), plot.tag=element_text(size=15))
gg.sets_iHS

ggsave(plot=gg.sets_iHS, filename="pairwise.venn.iHS.png", bg="white", device=png, width=5, height=5, units="in", dpi=300)
ggsave(plot=gg.sets_iHS, filename="pairwise.venn.iHS.pdf", bg="white", device=cairo_pdf, width=5, height=5, units="in")


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
  labs(title="413 Candidate Genes (nSL)", tag="(c)") + 
  theme(plot.caption=element_text(size=13, hjust=0.5), plot.title=element_text(size=15, hjust=0.5), plot.tag=element_text(size=15))
gg.sets_nSL

ggsave(plot=gg.sets_nSL, filename="pairwise.venn.nSL.png", bg="white", device=png, width=5, height=5, units="in", dpi=300)
ggsave(plot=gg.sets_nSL, filename="pairwise.venn.nSL.pdf", bg="white", device=cairo_pdf, width=5, height=5, units="in")


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
  labs(title="754 Candidate Genes (XP-nSL)", tag="(c)") + 
  theme(plot.caption=element_text(size=13, hjust=0.5), plot.title=element_text(size=15, hjust=0.5), plot.tag=element_text(size=15))
gg.sets_XPnSL

ggsave(plot=gg.sets_XPnSL, filename="pairwise.venn.XPnSL.png", bg="white", device=png, width=5, height=5, units="in", dpi=300)
ggsave(plot=gg.sets_XPnSL, filename="pairwise.venn.XPnSL.pdf", bg="white", device=cairo_pdf, width=5, height=5, units="in")

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
  labs(title="561 Candidate Genes (XP-CLR)", tag="(c)") + 
  theme(plot.caption=element_text(size=13, hjust=0.5), plot.title=element_text(size=15, hjust=0.5), plot.tag=element_text(size=15))
gg.sets_XPCLR

ggsave(plot=gg.sets_XPCLR, filename="pairwise.venn.XPCLR.png", bg="white", device=png, width=5, height=5, units="in", dpi=300)
ggsave(plot=gg.sets_XPCLR, filename="pairwise.venn.XPCLR.pdf", bg="white", device=cairo_pdf, width=5, height=5, units="in")









# find intersecting candidate regions
canre <- 
  filter(dat, candidate==TRUE) |>
  mutate(region=paste0(chr, "_", pos)) 

NorteHumboldt <- 
  list(
    iHS=filter(canre, pop1=="Del Norte-Humboldt", stat=="iHS")|>pull(region),
    nSL=filter(canre, pop1=="Del Norte-Humboldt", stat=="nSL")|>pull(region),
    `XP-nSL`=filter(canre, pop1=="Del Norte-Humboldt", stat=="XP-nSL")|>pull(region),
    `XP-CLR`=filter(canre, pop1=="Del Norte-Humboldt", stat=="XP-CLR")|>pull(region))

Mendocino <- 
  list(
    iHS=filter(canre, pop1=="Mendocino", stat=="iHS")|>pull(region),
    nSL=filter(canre, pop1=="Mendocino", stat=="nSL")|>pull(region),
    `XP-nSL`=filter(canre, pop1=="Mendocino", stat=="XP-nSL")|>pull(region),
    `XP-CLR`=filter(canre, pop1=="Mendocino", stat=="XP-CLR")|>pull(region))

SantaBarbara <- 
  list(
    iHS=filter(canre, pop1=="Santa Barbara", stat=="iHS")|>pull(region),
    nSL=filter(canre, pop1=="Santa Barbara", stat=="nSL")|>pull(region),
    `XP-nSL`=filter(canre, pop1=="Santa Barbara", stat=="XP-nSL")|>pull(region),
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
  left_join(x=tibble(region=SetsNorteHumboldt), y=filter(canre, pop1=="Del Norte-Humboldt"))

RegsMendocino <- 
  left_join(x=tibble(region=SetsMendocino), y=filter(canre, pop1=="Mendocino"))

RegsSantaBarbara <- 
  left_join(x=tibble(region=SetsSantaBarbara), y=filter(canre, pop1=="Santa Barbara"))

distinct(RegsNorteHumboldt, gene_id, PANTHER_accession, .keep_all=TRUE)
distinct(RegsMendocino, gene_id, PANTHER_accession, .keep_all=TRUE)
distinct(RegsSantaBarbara, gene_id, PANTHER_accession, .keep_all=TRUE)

# test intersecting candidates w/ full reference lists
RegsNorteHumboldt |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/NorteHumboldt_SETS", col_names=FALSE)

RegsMendocino |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/Mendocino_SETS", col_names=FALSE)

RegsSantaBarbara |> 
  select(gene_id, PANTHER_accession) |> 
  distinct() |>
  write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/SantaBarbara_SETS", col_names=FALSE)

Regs <- 
  bind_rows(RegsNorteHumboldt, RegsMendocino, RegsSantaBarbara) |>
  select(-chr, -pos, -n_snps, -candidate) |>
  left_join(select(Genes, gene_id, UniProtKB, gene))

write_tsv(Regs, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/Intersect.Candidate.Genes.tsv", na="")

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

write_tsv(Regs, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/Intersect.Candidate.Genes.wide.tsv", na="")

# prepare table of top10 +/- adjacent candidate windows (from top 1%)
candi <- 
  left_join(x=filter(dat, candidate==TRUE), y=mutate(top10, top10=TRUE)) |> 
  arrange(stat, pop1, pop2, chr, pos, PANTHER_family_name) |>
  distinct()

view(candi)

#write_tsv(candi, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/Top.10.Candidate.Genes.tsv")
candi <- read_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/Top.10.Candidate.Genes.tsv")
saveRDS(object=candi, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/Top.10.Candidate.Genes.RDS")

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

write_tsv(unesti, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete/Top.10.Candidate.Genes.wide.tsv", na="")
