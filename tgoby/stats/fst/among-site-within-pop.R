library(tidyverse)
library(RColorBrewer)
library(qvalue)
library(ggthemes)
library(ggvenn)

# no 2006 samples

# data import
setwd(dir="/Volumes/Tigrigobius/tgoby/stats/fst-perms/")

filename <- dir(pattern="*.100Kb-20Kb.windowed.weir.fst")

dat <- 
  filename |> 
  map(
    \(filename) read_tsv(file=filename) |> 
      mutate(test=gsub(".100Kb-20Kb.windowed.weir.fst", "", filename))) |>
  reduce(rbind)


dat <- 
  dat |>
  mutate(
    POP=str_split_i(string=test, pattern="_", i=1), 
    PERM=str_split_i(string=test, pattern="_", i=2) |> as.double()) |>
  select(-test)


setwd(dir="/Volumes/Tigrigobius/tgoby/stats/fst/")

dat <-
  bind_rows(
    dat,
    read_tsv(file="NorthCoast1.100Kb-20Kb.windowed.weir.fst") |> 
      mutate(
        POP="NorthCoast1", 
        PERM=0), 
    read_tsv(file="NorteHumboldt1.100Kb-20Kb.windowed.weir.fst") |> 
      mutate(
        POP="NorteHumboldt1", 
        PERM=0), 
    read_tsv(file="Mendocino1.100Kb-20Kb.windowed.weir.fst") |> 
      mutate(
        POP="Mendocino1", 
        PERM=0), 
    read_tsv(file="SantaBarbara.100Kb-20Kb.windowed.weir.fst") |> 
      mutate(
        POP="SantaBarbara", 
        PERM=0)) 

dat <- mutate(dat, WINDOW=paste0(gsub(pattern="\\.1$", replacement="", CHROM), ".", BIN_START))


NorthCoast <- 
  filter(dat, POP=="NorthCoast1") |> 
  arrange(WINDOW, PERM)

NorteHumboldt <- 
  filter(dat, POP=="NorteHumboldt1") |> 
  arrange(WINDOW, PERM)

Mendocino <- 
  filter(dat, POP=="Mendocino1") |> 
  arrange(WINDOW, PERM)

SantaBarbara <- 
  filter(dat, POP=="SantaBarbara") |> 
  arrange(WINDOW, PERM)


# empirical p values
# tidy matrix
matNorthCoast <- 
  pivot_wider(
    data=select(NorthCoast, WINDOW, PERM, WEIGHTED_FST), 
    names_from="PERM", 
    values_from="WEIGHTED_FST") |>
  column_to_rownames(var="WINDOW") |>
  filter(!is.na(`1`))

matNorteHumboldt <- 
  pivot_wider(
    data=select(NorteHumboldt, WINDOW, PERM, WEIGHTED_FST), 
    names_from="PERM", 
    values_from="WEIGHTED_FST") |>
  column_to_rownames(var="WINDOW") |>
  filter(!is.na(`1`))

matMendocino <- 
  pivot_wider(
    data=select(Mendocino, WINDOW, PERM, WEIGHTED_FST), 
    names_from="PERM", 
    values_from="WEIGHTED_FST") |>
  column_to_rownames(var="WINDOW") |>
  filter(!is.na(`1`))

matSantaBarbara <- 
  pivot_wider(
    data=select(SantaBarbara, WINDOW, PERM, WEIGHTED_FST),  
    names_from="PERM", 
    values_from="WEIGHTED_FST") |>
  column_to_rownames(var="WINDOW") |>
  filter(!is.na(`1`))


# p-values are calculated as the proportion of values from stat0 that are greater
# than or equal to that from stat
empPvals(
  stat=matNorthCoast[,1], 
  stat0=as.matrix(x=matNorthCoast[,2:101]), 
  pool=FALSE) |> 
  hist()

empPvals(
  stat=matNorthCoast[,1], 
  stat0=as.matrix(x=matNorthCoast[,2:101]), 
  pool=FALSE) -> 
  empPvalsNorthCoast

empPvals(
  stat=matNorteHumboldt[,1], 
  stat0=as.matrix(x=matNorteHumboldt[,2:101]), 
  pool=FALSE) |> 
  hist()

empPvals(
  stat=matNorteHumboldt[,1], 
  stat0=as.matrix(x=matNorteHumboldt[,2:101]), 
  pool=FALSE) -> 
  empPvalsNorteHumboldt

empPvals(
  stat=matMendocino[,1], 
  stat0=as.matrix(x=matMendocino[,2:101]), 
  pool=FALSE) |> 
  hist()

empPvals(
  stat=matMendocino[,1], 
  stat0=as.matrix(x=matMendocino[,2:101]), 
  pool=FALSE) -> 
  empPvalsMendocino

empPvals(
  stat=matSantaBarbara[,1], 
  stat0=as.matrix(x=matSantaBarbara[,2:101]), 
  pool=FALSE) |> 
  hist()

empPvals(
  stat=matSantaBarbara[,1], 
  stat0=as.matrix(x=matSantaBarbara[,2:101]), 
  pool=FALSE) -> 
  empPvalsSantaBarbara


# 
NorthCoast <- 
  left_join(
    x=NorthCoast, 
    y=data.frame(
      P=empPvalsNorthCoast, 
      P_ADJUSTED_FDR=p.adjust(p=empPvalsNorthCoast, method="fdr")) |> 
      rownames_to_column(var="WINDOW") |> 
      as_tibble(), 
    by="WINDOW")

NorteHumboldt <- 
  left_join(
    x=NorteHumboldt, 
    y=data.frame(
      P=empPvalsNorteHumboldt, 
      P_ADJUSTED_FDR=p.adjust(p=empPvalsNorteHumboldt, method="fdr")) |> 
      rownames_to_column(var="WINDOW") |> 
      as_tibble(), 
    by="WINDOW")

SantaBarbara <- 
  left_join(
    x=SantaBarbara, 
    y=data.frame(
      P=empPvalsSantaBarbara, 
      P_ADJUSTED_FDR=p.adjust(p=empPvalsSantaBarbara, method="fdr")) |> 
      rownames_to_column(var="WINDOW") |> 
      as_tibble(), 
    by="WINDOW")

Mendocino <- 
  left_join(
    x=Mendocino, 
    y=data.frame(
      P=empPvalsMendocino, 
      P_ADJUSTED_FDR=p.adjust(p=empPvalsMendocino, method="fdr")) |> 
      rownames_to_column(var="WINDOW") |> 
      as_tibble(), 
    by="WINDOW")

fst <- 
  bind_rows(
    NorthCoast,
    NorteHumboldt,
    Mendocino,
    SantaBarbara)

saveRDS(object=fst, file="among-site-within-pop.fst.perms.pvals.RDS")
fst <- readRDS(file="among-site-within-pop.fst.perms.pvals.RDS")
write_tsv(x=fst, file="among-site-within-pop.fst.perms.pvals.tab")

write_tsv(x=filter(fst, PERM==0), file="among-site-within-pop.fst.pvals.tab")

factor(NorthCoast$P_ADJUSTED_FDR) |> levels() |> sort() %>% .[1]
factor(NorteHumboldt$P_ADJUSTED_FDR) |> levels() |> sort() %>% .[1]
factor(Mendocino$P_ADJUSTED_FDR) |> levels() |> sort() %>% .[1]
factor(SantaBarbara$P_ADJUSTED_FDR) |> levels() |> sort() %>% .[1]


fst <- 
  mutate(
    fst, 
    CHROM=str_split_i(string=CHROM, pattern="\\.", i=1) |> 
      gsub(pattern="JAPEHO0100000", replacement="") |> 
      as.double())

dot <- 
  fst |>
  mutate(stop=BIN_END) |>
  group_by(CHROM) |> 
  summarise(chr_len=max(stop)) |> 
  mutate(tot=cumsum(chr_len)-chr_len) |>
  select(-chr_len) |>
  left_join(fst, ., by="CHROM") |>
  arrange(WINDOW) |>
  mutate(BPcum=BIN_START+tot) |> select(-tot)

axisdf <- 
  dot |> 
  group_by(CHROM) |> 
  summarize(center=(max(BPcum)+min(BPcum))/2)


dot$POP <- 
  factor(
    dot$POP, 
    levels=c("NorthCoast1", "NorteHumboldt1", "Mendocino1", "SantaBarbara"), 
    labels=c("Del Norte-Humboldt-Mendocino", "Del Norte-Humboldt", "Mendocino", "Santa Barbara"), 
    ordered=TRUE)


brewpal2 <- read_tsv(file="../../brewpal2.tab")
brewpal2x <- read_tsv(file="../../brewpal2x.tab")
barplot(1:9, col=brewpal2x$COLORX)

#
NorthCoast0 <- 
  filter(
    dot, 
    POP=="Del Norte-Humboldt-Mendocino", 
    PERM==0, 
    N_VARIANTS>=10) |> 
  mutate(RANK=cume_dist(WEIGHTED_FST))

NorteHumboldt0 <- 
  filter(
    dot,
    POP=="Del Norte-Humboldt", 
    PERM==0, 
    N_VARIANTS>=10) |> 
  mutate(RANK=cume_dist(WEIGHTED_FST))

Mendocino0 <- 
  filter(
    dot,
    POP=="Mendocino", 
    PERM==0, 
    N_VARIANTS>=10) |> 
  mutate(RANK=cume_dist(WEIGHTED_FST))

SantaBarbara0 <- 
  filter(
    dot,
    POP=="Santa Barbara", 
    PERM==0, 
    N_VARIANTS>=10) |> 
  mutate(RANK=cume_dist(WEIGHTED_FST))


NorthCoast0 <- 
  mutate(
    NorthCoast0, 
    UPPER=min(filter(NorthCoast0, RANK>=0.9995)$WEIGHTED_FST), 
    LOWER=max(filter(NorthCoast0, RANK<=0.0005)$WEIGHTED_FST))

NorteHumboldt0 <- 
  mutate(
    NorteHumboldt0, 
    UPPER=min(filter(NorteHumboldt0, RANK>=0.9995)$WEIGHTED_FST), 
    LOWER=max(filter(NorteHumboldt0, RANK<=0.0005)$WEIGHTED_FST))

Mendocino0 <- 
  mutate(
    Mendocino0, 
    UPPER=min(filter(Mendocino0, RANK>=0.9995)$WEIGHTED_FST), 
    LOWER=max(filter(Mendocino0, RANK<=0.0005)$WEIGHTED_FST))

SantaBarbara0 <- 
  mutate(
    SantaBarbara0, 
    UPPER=min(filter(SantaBarbara0, RANK>=0.9995)$WEIGHTED_FST), 
    LOWER=max(filter(SantaBarbara0, RANK<=0.0005)$WEIGHTED_FST))


dot1 <- 
  bind_rows(
    NorthCoast0,
    NorteHumboldt0,
    Mendocino0,
    SantaBarbara0,
    .id="X")

dot1$X <- 
  factor(
    dot1$X, 
    ordered=TRUE, 
    labels=c(
      "Del Norte-Humboldt-Mendocino", 
      "Del Norte-Humboldt", 
      "Mendocino", 
      "Santa Barbara"))

#dot1 <- readRDS(file="among-site-within-pop.FST.100Kb-20Kb.RDS")

g <- 
  ggplot(
    data=filter(dot1, X!="Del Norte-Humboldt-Mendocino")|>mutate(REJECT=factor(P==0.01)), 
    mapping=aes(x=WEIGHTED_FST, fill=REJECT)) + 
  geom_histogram(bins=20, linewidth=0.5, color="black") +
  scale_fill_manual(
    values=c("white", "lightgrey"), 
    labels=c(expression(italic(p) > 0.01), expression(italic(p) <= 0.01)), 
    breaks=c(FALSE, TRUE)) +
  facet_wrap(facets=vars(X), ncol=1, nrow=3, scales="fixed") +
  geom_vline(aes(xintercept=UPPER), color=brewpal2x$COLORX[4], linewidth=0.5, linetype="dashed") +
#  geom_vline(aes(xintercept=LOWER), color=brewpal2x$COLORX[4], linewidth=0.5, linetype="dashed") +
  theme_base(base_size=10)+
  labs(x=expression(italic(F)[ST]), y="Frequency", size=10, tag="c)") +
  scale_x_continuous(n.breaks=8) +
  scale_y_continuous(expand=expansion(mult=c(0.005, 0.05))) +
  theme(
    axis.text=element_text(size=10), 
    legend.title=element_blank(),
    axis.line.y.left=element_line(),
    axis.ticks=element_line(),
    axis.ticks.length=unit(1, units="mm"),
    legend.key.height=unit(2, units="mm"), 
    legend.key.width=unit(3.5, units="mm"),
    legend.position="right",
    panel.background=element_rect(linetype="blank"),
    panel.border=element_rect(linetype="blank"),
    plot.background=element_rect(linetype="blank"),
    strip.text=element_text(size=10, hjust=1)) 

ggsave(plot=g, filename="among-site-within-pop.FST.100Kb-20Kb.png", device=png, width=4, height=5, units="in", dpi=300)

ggsave(plot=g, filename="among-site-within-pop.FST.100Kb-20Kb.pdf", device=cairo_pdf, width=4, height=5, units="in")

saveRDS(object=dot1, file="among-site-within-pop.FST.100Kb-20Kb.RDS")

g2 <- 
  ggplot(
    data=filter(dot1, X%in%c("Del Norte-Humboldt-Mendocino", "Santa Barbara"))|>mutate(REJECT=factor(P==0.01)), 
    mapping=aes(x=WEIGHTED_FST, fill=REJECT)) + 
  geom_histogram(bins=20, linewidth=0.5, color="black") +
  scale_fill_manual(
    values=c("white", "lightgrey"), 
    labels=c(expression(italic(p) > 0.01), expression(italic(p) <= 0.01)), 
    breaks=c(FALSE, TRUE)) +
  facet_wrap(facets=vars(X), ncol=1, nrow=2, scales="fixed") +
  geom_vline(aes(xintercept=UPPER), color=brewpal2x$COLORX[4], linewidth=0.5, linetype="dashed") +
#  geom_vline(aes(xintercept=LOWER), color=brewpal2x$COLORX[4], linewidth=0.5, linetype="dashed") +
  theme_base(base_size=10)+
  labs(
    tag="d)",
    x=expression(italic(F)[ST]), 
    y="Frequency", size=10) +
  scale_x_continuous(n.breaks=8) +
  scale_y_continuous(expand=expansion(mult=c(0.005, 0.05))) +
  theme(
    axis.text=element_text(size=10), 
    legend.title=element_blank(),
    axis.line.y.left=element_line(),
    axis.ticks=element_line(),
    axis.ticks.length=unit(1, units="mm"),
    legend.key.height=unit(2, units="mm"), 
    legend.key.width=unit(3.5, units="mm"),
    legend.position="right",
    panel.background=element_rect(linetype="blank"),
    panel.border=element_rect(linetype="blank"),
    plot.background=element_rect(linetype="blank"),
    strip.text=element_text(size=10, hjust=1)) 

ggsave(plot=g2, filename="among-site-within-pop.FST.100Kb-20Kb.2.png", device=png, width=4, height=5*0.67, units="in", dpi=300)

ggsave(plot=g2, filename="among-site-within-pop.FST.100Kb-20Kb.2.pdf", device=cairo_pdf, width=4, height=5*0.67, units="in")

##
gg <- 
  ggplot(filter(dot1, X!="Del Norte-Humboldt-Mendocino"), aes(x=BPcum, y=WEIGHTED_FST)) +
#  geom_step(mapping=aes(color=as.factor(CHROM), group=as.factor(CHROM)), linewidth=0.5) +
  geom_point(aes(color=as.factor(CHROM)), shape=20, size=1) +
  scale_color_manual(values=rep(brewpal2x$COLORX[1:2], times=11)) +
  geom_hline(aes(yintercept=UPPER), color=brewpal2x$COLORX[4], linewidth=0.5, linetype="dashed") +
#  geom_hline(aes(yintercept=LOWER), color=brewpal2x$COLORX[4], linewidth=0.5, linetype="dashed") +
  scale_x_continuous(
    expand=expansion(mult=c(0.005, 0.005)),
    label=1:22,
    breaks=axisdf$center) +
  scale_y_continuous(expand=expansion(mult=c(0.05, 0.05)), n.breaks=7) +
  labs(
    tag="a)",
    x="Chromosome", 
    y=expression(italic(F)[ST])) +
  theme_base(base_size=10) +
  facet_wrap(facets=vars(X), ncol=1, nrow=3, scales="fixed") +
  theme(
    strip.text=element_text(size=10, hjust=1),
    axis.title=element_text(size=10),
    axis.text=element_text(size=10),
    axis.ticks.y=element_line(linewidth=0.25, colour="lightgrey"),
    axis.ticks.length.y=unit(x=1, units="mm"),
    axis.ticks.x=element_blank(),
    axis.line=element_blank(),
    legend.position="none",
    panel.background=element_rect(linetype="blank"),
    panel.border=element_rect(linetype="blank"),
    panel.grid.major.y=element_line(colour="lightgray", linewidth=0.25),
    plot.background=element_rect(linetype="blank"))


ggsave(plot=gg, filename="among-site-within-pop.K3.100Kb-20Kb.png", device=png, width=8, height=5, units="in", dpi=300)

ggsave(plot=gg, filename="among-site-within-pop.K3.100Kb-20Kb.pdf", device=cairo_pdf, width=8, height=5, units="in")


##
gg2 <- 
  ggplot(filter(dot1, X%in%c("Del Norte-Humboldt-Mendocino", "Santa Barbara")), aes(x=BPcum, y=WEIGHTED_FST)) +
#  geom_step(mapping=aes(color=as.factor(CHROM), group=as.factor(CHROM)), linewidth=0.5) +
  geom_point(aes(color=as.factor(CHROM)), shape=20, size=1) +
  scale_color_manual(values=rep(brewpal2x$COLORX[1:2], times=11)) +
  geom_hline(aes(yintercept=UPPER), color=brewpal2x$COLORX[4], linewidth=0.5, linetype="dashed") +
#  geom_hline(aes(yintercept=LOWER), color=brewpal2x$COLORX[4], linewidth=0.5, linetype="dashed") +
  scale_x_continuous(
    expand=expansion(mult=c(0.005, 0.005)),
    label=1:22,
    breaks=axisdf$center) +
  scale_y_continuous(expand=expansion(mult=c(0.05, 0.05)), n.breaks=7) +
  labs(
    tag="b)",
    x="Chromosome", 
    y=expression(italic(F)[ST])) +
  theme_base(base_size=10) +
  facet_wrap(facets=vars(X), ncol=1, nrow=3, scales="fixed") +
  theme(
    strip.text=element_text(size=10, hjust=1),
    axis.title=element_text(size=10),
    axis.text=element_text(size=10),
    axis.ticks.y=element_line(linewidth=0.25, colour="lightgrey"),
    axis.ticks.length.y=unit(x=1, units="mm"),
    axis.ticks.x=element_blank(),
    axis.line=element_blank(),
    legend.position="none",
    panel.background=element_rect(linetype="blank"),
    panel.border=element_rect(linetype="blank"),
    panel.grid.major.y=element_line(colour="lightgray", linewidth=0.25),
    plot.background=element_rect(linetype="blank"))


ggsave(plot=gg2, filename="among-site-within-pop.K3.100Kb-20Kb.2.png", device=png, width=8, height=5*0.67, units="in", dpi=300)

ggsave(plot=gg2, filename="among-site-within-pop.K3.100Kb-20Kb.2.pdf", device=cairo_pdf, width=8, height=5*0.67, units="in")










outliers.1 <- filter(NorteHumboldt0, RANK<=0.0005) |> mutate(POS=FALSE, NEG=TRUE) |> bind_rows(filter(NorteHumboldt0, RANK>=0.9995) |> mutate(POS=TRUE, NEG=FALSE)) |> arrange(CHROM, BIN_START, BIN_END)
outliers.2 <- filter(Mendocino0, RANK<=0.0005)  |> mutate(POS=FALSE, NEG=TRUE)|> bind_rows(filter(Mendocino0, RANK>=0.9995) |> mutate(POS=TRUE, NEG=FALSE))  |> arrange(CHROM, BIN_START, BIN_END)
outliers.3 <- filter(SantaBarbara0, RANK<=0.0005)  |> mutate(POS=FALSE, NEG=TRUE)|> bind_rows(filter(SantaBarbara0, RANK>=0.9995) |> mutate(POS=TRUE, NEG=FALSE)) |> arrange(CHROM, BIN_START, BIN_END)


# 
outliers.1 <- 
  group_by(outliers.1, NEG, POS, CHROM) |> 
  mutate(NEXT=lead(BIN_START)-BIN_START, NEW=NEXT>100000) |> 
  select(CHROM, BIN_START, BIN_END, NEXT, NEW) |>
  arrange(POS, NEG, CHROM, BIN_START, BIN_END)

outliers.2 <- 
  group_by(outliers.2, NEG, POS, CHROM) |> 
  mutate(NEXT=lead(BIN_START)-BIN_START, NEW=NEXT>100000) |> 
  select(CHROM, BIN_START, BIN_END, NEXT, NEW) |>
  arrange(POS, NEG, CHROM, BIN_START, BIN_END)


outliers.3 <- 
  group_by(outliers.3, NEG, POS, CHROM) |> 
  mutate(NEXT=lead(BIN_START)-BIN_START, NEW=NEXT>100000) |> 
  select(CHROM, BIN_START, BIN_END, NEXT, NEW) |>
  arrange(POS, NEG, CHROM, BIN_START, BIN_END)



summary(outliers.1)
summary(outliers.2)
summary(outliers.3)

outliers.1$NEW[is.na(outliers.1$NEW)] <- TRUE
outliers.2$NEW[is.na(outliers.2$NEW)] <- TRUE
outliers.3$NEW[is.na(outliers.3$NEW)] <- TRUE

outliers.1 <- filter(outliers.1, POS==TRUE) |> ungroup() |> select(-NEG, -POS)
outliers.2 <- filter(outliers.2, POS==TRUE) |> ungroup() |> select(-NEG, -POS)
outliers.3 <- filter(outliers.3, POS==TRUE) |> ungroup() |> select(-NEG, -POS)

write_tsv(relocate(mutate(ungroup(outliers.1), ROW=1:nrow(outliers.1)), ROW), file="outliers.p_0.001.NorteHumboldt.tsv")
write_tsv(relocate(mutate(ungroup(outliers.2), ROW=1:nrow(outliers.2)), ROW), file="outliers.p_0.001.Mendocino.tsv")
write_tsv(relocate(mutate(ungroup(outliers.3), ROW=1:nrow(outliers.3)), ROW), file="outliers.p_0.001.SantaBarbara.tsv")


# stopped 05/16/2024

Dneg <- read_tsv(file="K3.neg.outlier-sets.lumped.100kb.tab")

group_by(Dneg, POP) |> summarise(n=n())

Dneg <- 
  list(
    `Del Norte-Humboldt`=filter(Dneg, POP=="Del Norte-Humboldt")|>pull(LOCUS),
    `Mendocino`=filter(Dneg, POP=="Mendocino")|>pull(LOCUS),
    `Santa Barbara`=filter(Dneg, POP=="Santa Barbara")|>pull(LOCUS))

ggDneg <- 
  ggvenn(
    data=Dneg, 
    digits=0,
    stroke_size=0.5, 
    set_name_size=4.5,
    text_size=3,
    fill_color=brewpal2$COLOR1[c(8,6,4)], 
    fill_alpha=0.67,
    stroke_color=rep(x=brewpal2$COLOR1[c(8,6,4)], times=100), 
    stroke_alpha=0.67, 
    auto_scale=FALSE) + 
  labs(tag="b)")
ggDneg

ggsave(plot=ggDneg, filename="K3.neg.outlier-sets.lumped.100kb.venn.png", bg="white", device=png, width=5, height=5, units="in", dpi=300)
ggsave(plot=ggDneg, filename="K3.neg.outlier-sets.lumped.100kb.venn.pdf", device=cairo_pdf, width=5, height=5, units="in")



##
Dpos <- read_tsv(file="K3.pos.outlier-sets.lumped.100kb.tab")

group_by(Dpos, POP) |> summarise(n=n())

Dpos <- 
  list(
    `Del Norte-Humboldt`=filter(Dpos, POP=="Del Norte-Humboldt")|>pull(LOCUS),
    `Mendocino`=filter(Dpos, POP=="Mendocino")|>pull(LOCUS),
    `Santa Barbara`=filter(Dpos, POP=="Santa Barbara")|>pull(LOCUS))

ggDpos <- 
  ggvenn(
    data=Dpos, 
    digits=0,
    stroke_size=0.5, 
    set_name_size=4.5,
    text_size=3,
    fill_color=brewpal2$COLOR1[c(8,6,4)], 
    fill_alpha=0.67,
    stroke_color=rep(x=brewpal2$COLOR1[c(8,6,4)], times=100), 
    stroke_alpha=0.67, 
    auto_scale=FALSE) + 
  labs(tag="c)")
ggDpos

ggsave(plot=ggDpos, filename="K3.pos.outlier-sets.lumped.100kb.venn.png", bg="white", device=png, width=5, height=5, units="in", dpi=300)
ggsave(plot=ggDpos, filename="K3.pos.outlier-sets.lumped.100kb.venn.pdf", device=cairo_pdf, width=5, height=5, units="in")

