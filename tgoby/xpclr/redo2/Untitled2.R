library(tidyverse)
library(ggthemes)
library(ggvenn)
library(gridExtra)

setwd(dir="/Volumes/Tigrigobius/tgoby/xpclr/redo2/")

filename <- dir(pattern="*.100Kb")

xpclr <- 
  filename |> 
  map(
    \(filename) read_tsv(file=filename) |> 
      mutate(test=gsub(".100Kb", "", filename))) |> 
  reduce(rbind) |>
  filter(!is.na(xpclr)) |>
  filter(!is.nan(xpclr)) |>
  filter(!is.infinite(xpclr))

xpclr <- 
  mutate(
    xpclr, 
    chr=str_split_i(string=test, pattern="_", i=3) |> 
      as.double(), 
    samplesA=str_split_i(string=test, pattern="_", i=1), 
    samplesB=str_split_i(string=test, pattern="_", i=2)) |>
  select(-test) |> 
  arrange(id)

dot <- 
  xpclr |> 
  group_by(chrom) |> 
  summarise(chr_len=max(stop)) |> 
  mutate(tot=cumsum(chr_len)-chr_len) |>
  select(-chr_len) |>
  left_join(xpclr, ., by=c("chrom"="chrom")) |>
  arrange(chrom, start) |>
  mutate(BPcum=start+tot)

axisdf <- 
  dot |> 
  group_by(chrom) |> 
  summarize(center=(max(BPcum)+min(BPcum))/2)


#
NorteHumboldt_Mendocino <- 
  filter(dot, samplesA=="NorteHumboldt", samplesB=="Mendocino")

Mendocino_NorteHumboldt <- 
  filter(dot, samplesA=="Mendocino", samplesB=="NorteHumboldt")

NorteHumboldt_SantaBarbara <- 
  filter(dot, samplesA=="NorteHumboldt", samplesB=="SantaBarbara")

Mendocino_SantaBarbara <- 
  filter(dot, samplesA=="Mendocino", samplesB=="SantaBarbara")

NorteHumboldtMendocino_SantaBarbara <- 
  filter(dot, samplesA=="NorteHumboldtMendocino", samplesB=="SantaBarbara")

SantaBarbara_NorteHumboldtMendocino <- 
  filter(dot, samplesA=="SantaBarbara", samplesB=="NorteHumboldtMendocino")

SantaBarbara_NorteHumboldt <- 
  filter(dot, samplesA=="SantaBarbara", samplesB=="NorteHumboldt")

SantaBarbara_Mendocino <- 
  filter(dot, samplesA=="SantaBarbara", samplesB=="Mendocino")


##
NorteHumboldt_Mendocino <- 
  mutate(
    NorteHumboldt_Mendocino,
    rank=percent_rank(xpclr_norm))

Mendocino_NorteHumboldt <- 
  mutate(
    Mendocino_NorteHumboldt,
    rank=percent_rank(xpclr_norm))

NorteHumboldt_SantaBarbara <- 
  mutate(
    NorteHumboldt_SantaBarbara,
    rank=percent_rank(xpclr_norm))

Mendocino_SantaBarbara <- 
  mutate(
    Mendocino_SantaBarbara,
    rank=percent_rank(xpclr_norm))

NorteHumboldtMendocino_SantaBarbara <- 
  mutate(
    NorteHumboldtMendocino_SantaBarbara,
    rank=percent_rank(xpclr_norm))

SantaBarbara_NorteHumboldtMendocino <- 
  mutate(
    SantaBarbara_NorteHumboldtMendocino,
    rank=percent_rank(xpclr_norm))

SantaBarbara_NorteHumboldt <- 
  mutate(
    SantaBarbara_NorteHumboldt,
    rank=percent_rank(xpclr_norm))

SantaBarbara_Mendocino <- 
  mutate(
    SantaBarbara_Mendocino,
    rank=percent_rank(xpclr_norm))

NorteHumboldt_Mendocino <- mutate(NorteHumboldt_Mendocino, upper=min(filter(NorteHumboldt_Mendocino, rank>=0.995)$xpclr_norm))
Mendocino_NorteHumboldt <- mutate(Mendocino_NorteHumboldt, upper=min(filter(Mendocino_NorteHumboldt, rank>=0.995)$xpclr_norm))
NorteHumboldt_SantaBarbara <- mutate(NorteHumboldt_SantaBarbara, upper=min(filter(NorteHumboldt_SantaBarbara, rank>=0.995)$xpclr_norm))
Mendocino_SantaBarbara <- mutate(Mendocino_SantaBarbara, upper=min(filter(Mendocino_SantaBarbara, rank>=0.995)$xpclr_norm))
SantaBarbara_NorteHumboldtMendocino <- mutate(SantaBarbara_NorteHumboldtMendocino, upper=min(filter(SantaBarbara_NorteHumboldtMendocino, rank>=0.995)$xpclr_norm))
NorteHumboldtMendocino_SantaBarbara <- mutate(NorteHumboldtMendocino_SantaBarbara, upper=min(filter(NorteHumboldtMendocino_SantaBarbara, rank>=0.995)$xpclr_norm))
SantaBarbara_NorteHumboldt <- mutate(SantaBarbara_NorteHumboldt, upper=min(filter(SantaBarbara_NorteHumboldt, rank>=0.995)$xpclr_norm))
SantaBarbara_Mendocino <- mutate(SantaBarbara_Mendocino, upper=min(filter(SantaBarbara_Mendocino, rank>=0.995)$xpclr_norm))

summary(NorteHumboldt_Mendocino)
summary(Mendocino_NorteHumboldt)
summary(NorteHumboldt_SantaBarbara)
summary(Mendocino_SantaBarbara)
summary(NorteHumboldtMendocino_SantaBarbara)
summary(SantaBarbara_NorteHumboldtMendocino)
summary(SantaBarbara_NorteHumboldt)
summary(SantaBarbara_Mendocino)

## Racimo (2016)
## If one is interested in selective sweeps
## that took place before two populations a and b split from each
## other, one would have to run XP-CLR separately on each population, 
## with a third outgroup population c that split from the
## ancestor of a and b tABC generations ago (with tABC > tAB).
## Then, one would need to check that the signal of selection
## appears in both tests. This may miss important information
## about correlated allele frequency changes shared by a and b,
## but not by c, limiting the power to detect ancient events.

## get intersecting outliers of NorteHumboldt_SantaBarbara and Mendocino_SantaBarbara

NorteHumboldt_SantaBarbara
Mendocino_SantaBarbara

# plot paired observations
png(filename="NorteHumboldt_SantaBarbara_vs_Mendocino_SantaBarbara.2.png", width=6, height=5, units="in", res=300)
plot(y=NorteHumboldt_SantaBarbara$xpclr_norm, x=Mendocino_SantaBarbara$xpclr_norm, ylab="Del Norte-Humboldt (Santa Barbara)", xlab="Mendocino (Santa Barbara)")
abline(h=NorteHumboldt_SantaBarbara$upper[1], v=Mendocino_SantaBarbara$upper[1], lty=2, col="#E7298A")
dev.off()

SantaBarbara_NorteHumboldtMendocino

SantaBarbara_NorteHumboldt_Mendocino <- 
  inner_join(
    x=SantaBarbara_NorteHumboldt, 
    y=SantaBarbara_Mendocino, 
    by=join_by(chrom, tot, id, start, stop, chr, samplesA, BPcum), 
    suffix=c("_NorHum", "_Mendo"))
SantaBarbara_NorteHumboldt_Mendocino

png(filename="SantaBarbara_NorteHumboldt_vs_SantaBarbara_Mendocino.2.png", width=6, height=5, units="in", res=300)
plot(y=SantaBarbara_NorteHumboldt_Mendocino$xpclr_norm_NorHum, x=SantaBarbara_NorteHumboldt_Mendocino$xpclr_norm_Mendo, ylab="Santa Barbara (Del Norte-Humboldt)", xlab="Santa Barbara (Mendocino)")
abline(h=SantaBarbara_NorteHumboldt_Mendocino$upper_NorHum[1], v=SantaBarbara_NorteHumboldt_Mendocino$upper_Mendo[1], lty=2, col="#E7298A")
dev.off()

outliers.13 <- filter(NorteHumboldt_SantaBarbara, rank>=0.995)
outliers.23 <- filter(Mendocino_SantaBarbara, rank>=0.995)

union(outliers.13$id, outliers.23$id)
intersect(outliers.13$id, outliers.23$id)|>length()
setdiff(outliers.13$id, outliers.23$id)|>length()
setdiff(outliers.23$id, outliers.13$id)|>length()

# 
outliers.13 <- 
  group_by(outliers.13, chr) |> 
  mutate(`next`=lead(start)-start, new=`next`>100001) |> 
  select(xpclr_norm, chr, start, stop, `next`, new)

outliers.23 <- 
  group_by(outliers.23, chr) |> 
  mutate(`next`=lead(start)-start, new=`next`>100001) |> 
  select(xpclr_norm, chr, start, stop, `next`, new)

summary(outliers.13)
summary(outliers.23)

outliers.13$new[is.na(outliers.13$new)] <- TRUE
outliers.23$new[is.na(outliers.23$new)] <- TRUE

#write_tsv(relocate(mutate(ungroup(outliers.13), row=1:nrow(outliers.13)), row), file="outliers.p01.13.tsv")
#write_tsv(relocate(mutate(ungroup(outliers.23), row=1:nrow(outliers.23)), row), file="outliers.p01.23.tsv")


## get intersecting outliers of SantaBarbara_NorteHumboldt and SantaBarbara_Mendocino
SantaBarbara_NorteHumboldt
SantaBarbara_Mendocino

outliers.31 <- filter(SantaBarbara_NorteHumboldt, rank>=0.995)
outliers.32 <- filter(SantaBarbara_Mendocino, rank>=0.995)

union(outliers.31$id, outliers.32$id)
intersect(outliers.31$id, outliers.32$id)
setdiff(outliers.31$id, outliers.32$id)
setdiff(outliers.32$id, outliers.31$id)

# 
outliers.31 <- 
  group_by(outliers.31, chr) |> 
  mutate(`next`=lead(start)-start, new=`next`>100001) |> 
  select(xpclr_norm, chr, start, stop, `next`, new)

outliers.32 <- 
  group_by(outliers.32, chr) |> 
  mutate(`next`=lead(start)-start, new=`next`>100001) |> 
  select(xpclr_norm, chr, start, stop, `next`, new)

summary(outliers.31)
summary(outliers.32)

outliers.31$new[is.na(outliers.31$new)] <- TRUE
outliers.32$new[is.na(outliers.32$new)] <- TRUE

#write_tsv(relocate(mutate(ungroup(outliers.31), row=1:nrow(outliers.31)), row), file="outliers.p_0.001.31.tsv")
#write_tsv(relocate(mutate(ungroup(outliers.32), row=1:nrow(outliers.32)), row), file="outliers.p_0.001.32.tsv")

brewpal2 <- read_tsv(file="../../brewpal2.tab")
brewpal2x <- read_tsv(file="../../brewpal2x.tab")
barplot(1:9, col=brewpal2x$COLORX)


ggplot(Mendocino_NorteHumboldt, aes(x=BPcum, y=xpclr_norm)) +
  geom_point(mapping=aes(color=as.factor(chr)), shape=1, size=1) +
  scale_color_manual(values=rep(brewpal2x$COLORX[1:2], times=11)) +
  geom_hline(aes(yintercept=upper), color=brewpal2x$COLORX[4], linewidth=0.5, linetype="dashed") +
  scale_x_continuous(
    expand=expansion(mult=c(0.005, 0.005)),
    label=1:22,
    breaks=axisdf$center) +
  scale_y_continuous(expand=expansion(mult=c(0.005, 0.05)), n.breaks=6) +
  labs(
    tag="a)",
    x="Chromosome", 
    y="XP-CLR") +
  theme_base(base_size=10) +
#  facet_wrap(facets=vars(X), ncol=1, nrow=3, scales="fixed") +
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



## summarize outliers by objective pop (i.e., each w/ 2 reference pops)
NorteHumboldt_Mendocino
NorteHumboldt_SantaBarbara

Mendocino_NorteHumboldt
Mendocino_SantaBarbara

SantaBarbara_NorteHumboldt
SantaBarbara_Mendocino

outliers.1 <- filter(NorteHumboldt_Mendocino, rank>=0.995) |> bind_rows(filter(NorteHumboldt_SantaBarbara, rank>=0.995)) |> arrange(samplesB, chr, start, stop)
outliers.2 <- filter(Mendocino_NorteHumboldt, rank>=0.995) |> bind_rows(filter(Mendocino_SantaBarbara, rank>=0.995)) |> arrange(samplesB, chr, start, stop)
outliers.3 <- filter(SantaBarbara_NorteHumboldt, rank>=0.995) |> bind_rows(filter(SantaBarbara_Mendocino, rank>=0.995)) |> arrange(samplesB, chr, start, stop)
outliers.4 <- filter(SantaBarbara_NorteHumboldtMendocino, rank>=0.995) |> arrange(samplesB, chr, start, stop)

intersect(outliers.1$id, outliers.2$id)
intersect(outliers.2$id, outliers.3$id)
intersect(outliers.1$id, outliers.3$id)
intersect(outliers.3$id, outliers.4$id)

# 
outliers.1 <- 
  group_by(outliers.1, samplesB, chr) |> 
  mutate(`next`=lead(start)-start, new=`next`>100000) |> 
  select(xpclr_norm, samplesA, samplesB, chr, start, stop, `next`, new)

outliers.2 <- 
  group_by(outliers.2, samplesB, chr) |> 
  mutate(`next`=lead(start)-start, new=`next`>100000) |> 
  select(xpclr_norm, samplesA, samplesB, chr, start, stop, `next`, new)

outliers.3 <- 
  group_by(outliers.3, samplesB, chr) |> 
  mutate(`next`=lead(start)-start, new=`next`>100000) |> 
  select(xpclr_norm, samplesA, samplesB, chr, start, stop, `next`, new)

outliers.4 <- 
  group_by(outliers.4, samplesB, chr) |> 
  mutate(`next`=lead(start)-start, new=`next`>100000) |> 
  select(xpclr_norm, samplesA, samplesB, chr, start, stop, `next`, new)


summary(outliers.1)
summary(outliers.2)
summary(outliers.3)
summary(outliers.4)

outliers.1$new[is.na(outliers.1$new)] <- TRUE
outliers.2$new[is.na(outliers.2$new)] <- TRUE
outliers.3$new[is.na(outliers.3$new)] <- TRUE
outliers.4$new[is.na(outliers.4$new)] <- TRUE

outliers.1 <- relocate(mutate(ungroup(outliers.1), row=1:nrow(outliers.1)), row)
outliers.2 <- relocate(mutate(ungroup(outliers.2), row=1:nrow(outliers.2)), row)
outliers.3 <- relocate(mutate(ungroup(outliers.3), row=1:nrow(outliers.3)), row)
outliers.4 <- relocate(mutate(ungroup(outliers.4), row=1:nrow(outliers.4)), row)

outliers.1 <- 
  bind_rows(
    filter(outliers.1, new==TRUE) |> arrange(row) |> mutate(outlier=seq_along(along.with=row)), 
    filter(outliers.1, new==FALSE) |> mutate(outlier=NA)) |>
  arrange(desc(row))

outliers.2 <- 
  bind_rows(
    filter(outliers.2, new==TRUE) |> arrange(row) |> mutate(outlier=seq_along(along.with=row)), 
    filter(outliers.2, new==FALSE) |> mutate(outlier=NA)) |>
  arrange(desc(row))

outliers.3 <- 
  bind_rows(
    filter(outliers.3, new==TRUE) |> arrange(row) |> mutate(outlier=seq_along(along.with=row)), 
    filter(outliers.3, new==FALSE) |> mutate(outlier=NA)) |>
  arrange(desc(row))

outliers.4 <- 
  bind_rows(
    filter(outliers.4, new==TRUE) |> arrange(row) |> mutate(outlier=seq_along(along.with=row)), 
    filter(outliers.4, new==FALSE) |> mutate(outlier=NA)) |>
  arrange(desc(row))


write_tsv(outliers.1, file="outliers.p01.NorteHumboldt.nonoverlapping.2.tsv")
write_tsv(outliers.2, file="outliers.p01.Mendocino.nonoverlapping.2.tsv")
write_tsv(outliers.3, file="outliers.p01.SantaBarbara.nonoverlapping.2.tsv")
write_tsv(outliers.4, file="outliers.p01.SantaBarbara_NorteHumboldtMendocino.nonoverlapping.2.tsv")

outliers.1234 <- 
  bind_rows(outliers.1, outliers.2, outliers.3, outliers.4) |> 
  arrange(samplesA, samplesB, chr, start) |> 
  select(-row, -outlier)

outliers.1234 <- relocate(mutate(outliers.1234, row=seq_along(along.with=chr)), row)

outliers.1234 <- 
  bind_rows(
    filter(outliers.1234, new==TRUE) |> arrange(row) |> mutate(outlier=seq_along(along.with=row)), 
    filter(outliers.1234, new==FALSE) |> mutate(outlier=NA)) |>
  arrange(desc(row))

write_tsv(outliers.1234, file="outliers.p01.nonoverlapping.2.tsv", na="")

# manual verification of outlier intervals with spreadsheets

outliers.1234 <- read_tsv(file="outliers.p01.nonoverlapping.2.tsv") |> arrange(row)

OUTSsummary <- group_by(outliers.1234, outlier) |> count(name="n", sort=TRUE)

OUTSsummary2 <- group_by(OUTSsummary, n) |> count(name="n_n", sort=TRUE)

OUTS <- left_join(outliers.1234, OUTSsummary, by="outlier")

OUTS <- group_by(OUTS, outlier) |> mutate(begin=min(start), end=max(stop), length=(end-begin)+1)

OUTS <- slice_max(.data=OUTS, xpclr_norm)

OUTS <- select(OUTS, xpclr_norm, samplesA, samplesB, chr, start, stop, outlier, n_windows=n, begin, end, length)

write_tsv(OUTS, file="outliers.p01.intervals.nonoverlapping.2.tab")

NorteHumboldt <- 
  bind_rows(
    left_join(
      x=NorteHumboldt_Mendocino, 
      y=filter(OUTS, samplesA=="NorteHumboldt", samplesB=="Mendocino"), 
      by=join_by(xpclr_norm, samplesA, samplesB, chr, start, stop)),
    left_join(
      x=NorteHumboldt_SantaBarbara, 
      y=filter(OUTS, samplesA=="NorteHumboldt", samplesB=="SantaBarbara"), 
      by=join_by(xpclr_norm, samplesA, samplesB, chr, start, stop)))

Mendocino <- 
  bind_rows(
    left_join(
      x=Mendocino_NorteHumboldt, 
      y=filter(OUTS, samplesA=="Mendocino", samplesB=="NorteHumboldt"), 
      by=join_by(xpclr_norm, samplesA, samplesB, chr, start, stop)),
    left_join(
      x=Mendocino_SantaBarbara, 
      y=filter(OUTS, samplesA=="Mendocino", samplesB=="SantaBarbara"), 
      by=join_by(xpclr_norm, samplesA, samplesB, chr, start, stop)))

SantaBarbara <- 
  bind_rows(
    left_join(
      x=SantaBarbara_NorteHumboldt, 
      y=filter(OUTS, samplesA=="SantaBarbara", samplesB=="NorteHumboldt"), 
      by=join_by(xpclr_norm, samplesA, samplesB, chr, start, stop)),
    left_join(
      x=SantaBarbara_Mendocino, 
      y=filter(OUTS, samplesA=="SantaBarbara", samplesB=="Mendocino"), 
      by=join_by(xpclr_norm, samplesA, samplesB, chr, start, stop)))

K3.outliers <- 
  bind_rows(
    list(
      NorteHumboldt |> filter(samplesA=="NorteHumboldt", samplesB=="SantaBarbara"), 
      Mendocino |> filter(samplesA=="Mendocino", samplesB=="SantaBarbara"), 
      SantaBarbara |> filter(samplesA=="SantaBarbara", samplesB=="Mendocino")), 
    .id="X")

K3.outliers$X <- 
  factor(
    K3.outliers$X, 
    ordered=TRUE, 
    labels=c(
      "Del Norte-Humboldt", 
      "Mendocino",
      "Santa Barbara"))


K3.outliers <- arrange(K3.outliers, X, samplesB, BPcum)

#K3.outliers <- filter(K3.outliers, xpclr_norm>=upper)


gg1 <- 
  ggplot(K3.outliers, aes(x=BPcum, y=xpclr_norm)) +
  geom_point(mapping=aes(color=as.factor(chr)), shape=1, size=1) +
  scale_color_manual(values=rep(brewpal2x$COLORX[1:2], times=11)) +
  geom_hline(aes(yintercept=upper), color=brewpal2x$COLORX[4], linewidth=0.5, linetype="dashed") +
  scale_x_continuous(
    expand=expansion(mult=c(0.005, 0.005)),
    label=1:22,
    breaks=axisdf$center) +
  scale_y_continuous(expand=expansion(mult=c(0.005, 0.05)), n.breaks=6) +
  labs(
    tag="a)",
    x="Chromosome", 
    y="XP-CLR") +
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

ggsave(plot=gg1, filename="K3.nonoverlapping.2.png", device=png, width=8, height=4, units="in", dpi=300)
ggsave(plot=gg1, filename="K3.nonoverlapping.2.pdf", device=cairo_pdf, width=8, height=4, units="in")

sets_xpclr <- 
  list(
    `Del Norte-Humboldt`=mutate(outliers.1, id=paste(chr, start, sep=":")) |> filter(samplesA=="NorteHumboldt", samplesB=="SantaBarbara") |> pull(id),
    Mendocino=mutate(outliers.2, id=paste(chr, start, sep=":")) |> filter(samplesA=="Mendocino", samplesB=="SantaBarbara") |> pull(id),
    `Santa Barbara`=mutate(outliers.3, id=paste(chr, start, sep=":")) |> filter(samplesA=="SantaBarbara", samplesB=="Mendocino") |> pull(id))

unique(c(sets_xpclr[[1]], sets_xpclr[[2]], sets_xpclr[[3]])) |> length()

str(sets_xpclr)

gg.sets_xpclr <- 
  ggvenn(
    data=sets_xpclr, 
    digits=0,
    stroke_size=0.5, 
    set_name_size=4.5,
    text_size=4,
#    fill_color=brewpal2$COLOR1[c(8,6,4)], 
    fill_color=rep("white", 3), 
    fill_alpha=1,
    stroke_color=rep(x=brewpal2$COLOR1[c(8,6,4)], times=100), 
    stroke_alpha=1,
#    stroke_alpha=0.67,
    auto_scale=FALSE) + 
  labs(title="97 Outlier Windows (XP-CLR)", tag="b)") + 
  theme(plot.caption=element_text(size=13, hjust=0.5), plot.title=element_text(size=15, hjust=0.5), plot.tag=element_text(size=15))
gg.sets_xpclr

ggsave(plot=gg.sets_xpclr, filename="K3.windows.nonoverlapping.venn.2.png", bg="white", device=png, width=5, height=5, units="in", dpi=300)
ggsave(plot=gg.sets_xpclr, filename="K3.windows.nonoverlapping.venn.2.pdf", bg="white", device=cairo_pdf, width=5, height=5, units="in")

