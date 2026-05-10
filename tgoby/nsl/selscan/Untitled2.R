library(tidyverse)
library(slider)
library(ggthemes)

# data import
setwd(dir="/Volumes/Tigrigobius/tgoby/nsl/selscan/")

filename <- dir(pattern="*.nsl.out.\\d\\dbins.norm$")

dat <- 
  filename |> 
  map(
    \(filename) read_tsv(file=filename, col_names=c("locusID", "physicalPos", "freq", "sl1", "sl0", "nSL", "nSLnorm", "crit")) |> 
      mutate(test=gsub(".nsl.out.\\d\\dbins.norm", "", filename))) |>
  reduce(rbind)

dat <- 
  select(dat, -locusID, -sl1, -sl0, -nSL) |> 
  rename(POS=physicalPos, nSL=nSLnorm) |>
  mutate(CHROM=str_split_i(string=test, pattern="chr", i=2) |> as.numeric()) |> 
  mutate(test=str_split_i(string=test, pattern="\\.chr", i=1)) |> 
  rename(POP=test)


dot <- 
  dat |>
  group_by(CHROM) |> 
  summarise(chr_len=max(POS)) |> 
  mutate(tot=cumsum(chr_len)-chr_len) |>
  select(-chr_len) |>
  left_join(dat, ., by="CHROM") |>
  arrange(CHROM, POS) |>
  mutate(BPcum=POS+tot) |> select(-tot)

axisdf <- 
  dot |> 
  group_by(CHROM) |> 
  summarize(center=(max(BPcum)+min(BPcum))/2)

dot$POP <- 
  factor(
    dot$POP, 
    levels=c("NorteHumboldt", "Mendocino", "SantaBarbara"), 
    labels=c("Del Norte-Humboldt", "Mendocino", "Santa Barbara"), 
    ordered=TRUE)

dot <- mutate(dot, ABS_nSL=abs(nSL))

NorteHumboldt <- 
  filter(dot, POP=="Del Norte-Humboldt")

Mendocino <- 
  filter(dot, POP=="Mendocino")

SantaBarbara <- 
  filter(dot, POP=="Santa Barbara")

NorteHumboldt <- 
  mutate(NorteHumboldt, RANK_ABS_nSL=percent_rank(ABS_nSL))

Mendocino <- 
  mutate(Mendocino, RANK_ABS_nSL=percent_rank(ABS_nSL))

SantaBarbara <- 
  mutate(SantaBarbara, RANK_ABS_nSL=percent_rank(ABS_nSL))

#
windows <- seq(from=1, to=54300000, by=100000)

NorteHumboldt100 <- 
  mutate(
    NorteHumboldt, 
    WINDOW=cut(POS, breaks=windows, labels=windows[-543])) |> 
  group_by(CHROM, WINDOW) |> 
  summarise(
    N_SCORES=n(), 
    N_OUTLIERS=sum(RANK_ABS_nSL>=0.995),
    PROP_OUTLIERS=N_OUTLIERS/N_SCORES,
    PROP_CRIT=sum(abs(crit))/N_SCORES, 
    MIN_SCORE=min(ABS_nSL), 
    MAX_SCORE=max(ABS_nSL), 
    MEAN_SCORE=mean(ABS_nSL), 
    SD_SCORE=sd(ABS_nSL)) |>
  filter(N_SCORES>=10) |>
  ungroup() |>
  mutate(
    POP="Del Norte-Humboldt", 
    RANK_PROP_OUTLIERS=percent_rank(PROP_OUTLIERS),
    RANK_PROP_CRIT=percent_rank(PROP_CRIT))

hist(NorteHumboldt100$RANK_PROP_OUTLIERS, breaks = 100)

group_by(NorteHumboldt100, N_SCORES) |> summarise(N=n(), MAX_RANK_PROP_CRIT=max(RANK_PROP_CRIT))

Mendocino100 <- 
  mutate(Mendocino, WINDOW=cut(POS, breaks=windows, labels=windows[-543])) |> 
  group_by(CHROM, WINDOW) |> 
  summarise(
    N_SCORES=n(), 
    N_OUTLIERS=sum(RANK_ABS_nSL>=0.995),
    PROP_OUTLIERS=N_OUTLIERS/N_SCORES,
    PROP_CRIT=sum(abs(crit))/N_SCORES, 
    MIN_SCORE=min(ABS_nSL), 
    MAX_SCORE=max(ABS_nSL), 
    MEAN_SCORE=mean(ABS_nSL), 
    SD_SCORE=sd(ABS_nSL)) |>
  filter(N_SCORES>=10) |>
  ungroup() |>
  mutate(
    POP="Mendocino",
    RANK_PROP_OUTLIERS=percent_rank(PROP_OUTLIERS),
    RANK_PROP_CRIT=percent_rank(PROP_CRIT))


SantaBarbara100 <- 
  mutate(SantaBarbara, WINDOW=cut(POS, breaks=windows, labels=windows[-543])) |> 
  group_by(CHROM, WINDOW) |> 
  summarise(
    N_SCORES=n(), 
    N_OUTLIERS=sum(RANK_ABS_nSL>=0.995),
    PROP_OUTLIERS=N_OUTLIERS/N_SCORES,
    PROP_CRIT=sum(abs(crit))/N_SCORES, 
    MIN_SCORE=min(ABS_nSL), 
    MAX_SCORE=max(ABS_nSL), 
    MEAN_SCORE=mean(ABS_nSL), 
    SD_SCORE=sd(ABS_nSL)) |>
  filter(N_SCORES>=10) |>
  ungroup() |>
  mutate(
    POP="Santa Barbara",
    RANK_PROP_OUTLIERS=percent_rank(PROP_OUTLIERS),
    RANK_PROP_CRIT=percent_rank(PROP_CRIT))


brewpal2 <- read_tsv(file="../../brewpal2.tab")
brewpal2x <- read_tsv(file="../../brewpal2x.tab")
barplot(1:9, col=brewpal2x$COLORX)

# top 1% of |nSL| considered outliers
NorteHumboldt <- 
  mutate(
    NorteHumboldt, 
    UPPER_ABS_nSL=min(filter(NorteHumboldt, RANK_ABS_nSL>=0.995)$ABS_nSL))

SantaBarbara <- 
  mutate(
    SantaBarbara, 
    UPPER_ABS_nSL=min(filter(SantaBarbara, RANK_ABS_nSL>=0.995)$ABS_nSL))

Mendocino <- 
  mutate(
    Mendocino, 
    UPPER_ABS_nSL=min(filter(Mendocino, RANK_ABS_nSL>=0.995)$ABS_nSL))

filter(Mendocino, crit==1)|>pull(ABS_nSL)|>min()

NorteHumboldt100 <- 
  mutate(
    NorteHumboldt100, 
    UPPER_PROP_OUTLIERS=min(filter(NorteHumboldt100, RANK_PROP_OUTLIERS>=0.995)$PROP_OUTLIERS),
    UPPER_PROP_CRIT=min(filter(NorteHumboldt100, RANK_PROP_CRIT>=0.995)$PROP_CRIT, na.rm=TRUE))

SantaBarbara100 <- 
  mutate(
    SantaBarbara100, 
    UPPER_PROP_OUTLIERS=min(filter(SantaBarbara100, RANK_PROP_OUTLIERS>=0.995)$PROP_OUTLIERS),
    UPPER_PROP_CRIT=min(filter(SantaBarbara100, RANK_PROP_CRIT>=0.995)$PROP_CRIT, na.rm=TRUE))


Mendocino100 <- 
  mutate(
    Mendocino100, 
    UPPER_PROP_OUTLIERS=min(filter(Mendocino100, RANK_PROP_OUTLIERS>=0.995)$PROP_OUTLIERS),
    UPPER_PROP_CRIT=min(filter(Mendocino100, RANK_PROP_CRIT>=0.995)$PROP_CRIT, na.rm=TRUE))



dot1 <- bind_rows(NorteHumboldt100, Mendocino100, SantaBarbara100) |> mutate(WINDOW=as.character(WINDOW)|>as.numeric())

dot1 <- 
  dot1 |>
  group_by(CHROM) |> 
  reframe(chr_len=max(WINDOW, na.rm=TRUE)) |> 
  mutate(tot=cumsum(chr_len)-chr_len) |>
  select(-chr_len) |>
  left_join(dot1, ., by="CHROM") |>
  arrange(CHROM, WINDOW) |>
  mutate(BPcum=WINDOW+tot) |> 
  select(-tot) |> 
  arrange(BPcum) |>
  filter(!is.na(WINDOW))

axisdf1 <- 
  dot1 |> 
  group_by(CHROM) |> 
  summarize(center=(max(BPcum)+min(BPcum))/2)


saveRDS(object=dot1, file="nSL.100Kb.2.RDS")

dot1



summary(dot1)

gg <- 
  ggplot(dot1, aes(x=BPcum, y=PROP_CRIT)) +
  geom_point(aes(color=as.factor(CHROM)), shape=1, size=1) +
  scale_color_manual(values=rep(brewpal2x$COLORX[1:2], times=11)) +
  geom_hline(aes(yintercept=UPPER_PROP_CRIT), color=brewpal2x$COLORX[4], linewidth=0.5, linetype="dashed") +
  scale_x_continuous(
    expand=expansion(mult=c(0.005, 0.005)),
    label=1:22,
    breaks=axisdf1$center) +
  scale_y_continuous(n.breaks=7) +
  labs(
    tag="a)",
    x="Chromosome", 
    y="Proportion |nSL| > 2") +
  theme_base(base_size=10) +
  facet_wrap(facets=vars(POP), ncol=1, nrow=3, scales="fixed") +
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

ggsave(plot=gg, filename="PROP_CRIT.2.png", device=png, width=8, height=4, units="in", dpi=300)
ggsave(plot=gg, filename="PROP_CRIT.2.pdf", device=cairo_pdf, width=8, height=4, units="in")


gg <- 
  ggplot(dot1, aes(x=BPcum, y=PROP_OUTLIERS)) +
  geom_point(aes(color=as.factor(CHROM)), shape=1, size=1) +
  scale_color_manual(values=rep(brewpal2x$COLORX[1:2], times=11)) +
  geom_hline(aes(yintercept=UPPER_PROP_OUTLIERS), color=brewpal2x$COLORX[4], linewidth=0.5, linetype="dashed") +
  scale_x_continuous(
    expand=expansion(mult=c(0.005, 0.005)),
    label=1:22,
    breaks=axisdf1$center) +
  scale_y_continuous(n.breaks=6) +
  labs(
    tag="a)",
    x="Chromosome", 
    y="Proportion of outlier nSL") +
  theme_base(base_size=10) +
  facet_wrap(facets=vars(POP), ncol=1, nrow=3, scales="fixed") +
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

ggsave(plot=gg, filename="PROP_OUTLIERS.2.png", device=png, width=8, height=4, units="in", dpi=300)
ggsave(plot=gg, filename="PROP_OUTLIERS.2.pdf", device=cairo_pdf, width=8, height=4, units="in")


dot <- bind_rows(NorteHumboldt, Mendocino, SantaBarbara)

gg <- 
  ggplot(dot, aes(x=BPcum, y=ABS_nSL)) +
  geom_point(aes(color=as.factor(CHROM)), shape=1, size=1) +
  scale_color_manual(values=rep(brewpal2x$COLORX[1:2], times=11)) +
  geom_hline(aes(yintercept=UPPER_ABS_nSL), color=brewpal2x$COLORX[4], linewidth=0.5, linetype="dashed") +
  scale_x_continuous(
    expand=expansion(mult=c(0.005, 0.005)),
    label=1:22,
    breaks=axisdf$center) +
  scale_y_continuous(n.breaks=6) +
  labs(
    tag="a)",
    x="Chromosome", 
    y="|nSL|") +
  theme_base(base_size=10) +
  facet_wrap(facets=vars(POP), ncol=1, nrow=3, scales="fixed") +
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

ggsave(plot=gg, filename="ABS_nSL.2.png", device=png, width=8, height=4, units="in", dpi=300)
ggsave(plot=gg, filename="ABS_nSL.2.pdf", device=cairo_pdf, width=8, height=4, units="in")


#
outliers.1 <- filter(NorteHumboldt, RANK_ABS_nSL>=0.995) |> arrange(CHROM, POS) |> mutate(id=paste(CHROM, POS, sep=":"))
outliers.2 <- filter(Mendocino, RANK_ABS_nSL>=0.995) |> arrange(CHROM, POS) |> mutate(id=paste(CHROM, POS, sep=":"))
outliers.3 <- filter(SantaBarbara, RANK_ABS_nSL>=0.995) |> arrange(CHROM, POS) |> mutate(id=paste(CHROM, POS, sep=":"))

intersect(outliers.1$id, outliers.2$id)
intersect(outliers.2$id, outliers.3$id)
intersect(outliers.1$id, outliers.3$id)

#
library(ggvenn)
library(gridExtra)

sets_nSL <- 
  list(
    `Del Norte-Humboldt`=pull(outliers.1, id),
    Mendocino=pull(outliers.2, id),
    `Santa Barbara`=pull(outliers.3, id))

unique(c(sets_nSL[[1]], sets_nSL[[2]], sets_nSL[[3]])) |> length()

str(sets_nSL)

gg.sets_nSL <- 
  ggvenn(
    data=sets_nSL, 
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
  labs(title="4,718 Outlier SNPs (nSL)", tag="b)") + 
  theme(plot.caption=element_text(size=13, hjust=0.5), plot.title=element_text(size=15, hjust=0.5), plot.tag=element_text(size=15))
gg.sets_nSL

ggsave(plot=gg.sets_nSL, filename="ABS_nSL.SNPs.venn.2.png", bg="white", device=png, width=5, height=5, units="in", dpi=300)
ggsave(plot=gg.sets_nSL, filename="ABS_nSL.SNPs.venn.2.pdf", bg="white", device=cairo_pdf, width=5, height=5, units="in")




# 
outliers.1 <- 
  group_by(outliers.1, CHROM) |> 
  mutate(`next`=lead(POS)-POS, new=`next`>100000) |> 
  select(ABS_nSL, POP, CHROM, POS, id, `next`, new)

outliers.2 <- 
  group_by(outliers.2, CHROM) |> 
  mutate(`next`=lead(POS)-POS, new=`next`>100000) |> 
  select(ABS_nSL, POP, CHROM, POS, id, `next`, new)

outliers.3 <- 
  group_by(outliers.3, CHROM) |> 
  mutate(`next`=lead(POS)-POS, new=`next`>100000) |> 
  select(ABS_nSL, POP, CHROM, POS, id, `next`, new)

summary(outliers.1)
summary(outliers.2)
summary(outliers.3)

outliers.1$new[is.na(outliers.1$new)] <- TRUE
outliers.2$new[is.na(outliers.2$new)] <- TRUE
outliers.3$new[is.na(outliers.3$new)] <- TRUE

outliers.1 <- relocate(mutate(ungroup(outliers.1), row=1:nrow(outliers.1)), row)
outliers.2 <- relocate(mutate(ungroup(outliers.2), row=1:nrow(outliers.2)), row)
outliers.3 <- relocate(mutate(ungroup(outliers.3), row=1:nrow(outliers.3)), row)

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


outliers.123 <- 
  bind_rows(outliers.1, outliers.2, outliers.3) |> 
  arrange(POP, CHROM, POS) |> 
  select(-row, -outlier)

outliers.123 <- relocate(mutate(outliers.123, row=seq_along(along.with=CHROM)), row)

outliers.123 <- 
  bind_rows(
    filter(outliers.123, new==TRUE) |> arrange(row) |> mutate(outlier=seq_along(along.with=row)), 
    filter(outliers.123, new==FALSE) |> mutate(outlier=NA)) |>
  arrange(desc(row))

outliers.123 <- arrange(outliers.123, row)

write_tsv(outliers.123, file="outliers.p01.2.tsv")



# windows
outliers.1 <- filter(NorteHumboldt100, RANK_PROP_CRIT>=0.995) |> arrange(CHROM, WINDOW) |> mutate(id=paste(CHROM, WINDOW, sep=":"))
outliers.2 <- filter(Mendocino100, RANK_PROP_CRIT>=0.995) |> arrange(CHROM, WINDOW) |> mutate(id=paste(CHROM, WINDOW, sep=":"))
outliers.3 <- filter(SantaBarbara100, RANK_PROP_CRIT>=0.995) |> arrange(CHROM, WINDOW) |> mutate(id=paste(CHROM, WINDOW, sep=":"))

intersect(outliers.1$id, outliers.2$id)
intersect(outliers.2$id, outliers.3$id)
intersect(outliers.1$id, outliers.3$id)

#
sets_nSL <- 
  list(
    `Del Norte-Humboldt`=pull(outliers.1, id),
    Mendocino=pull(outliers.2, id),
    `Santa Barbara`=pull(outliers.3, id))

unique(c(sets_nSL[[1]], sets_nSL[[2]], sets_nSL[[3]])) |> length()

str(sets_nSL)

gg.sets_nSL <- 
  ggvenn(
    data=sets_nSL, 
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
  labs(title="112 Outlier Windows (nSL)", tag="b)") + 
  theme(plot.caption=element_text(size=13, hjust=0.5), plot.title=element_text(size=15, hjust=0.5), plot.tag=element_text(size=15))
gg.sets_nSL

ggsave(plot=gg.sets_nSL, filename="PROP_CRIT.venn.2.png", bg="white", device=png, width=5, height=5, units="in", dpi=300)
ggsave(plot=gg.sets_nSL, filename="PROP_CRIT.venn.2.pdf", bg="white", device=cairo_pdf, width=5, height=5, units="in")




# 
outliers.1 <- 
  group_by(outliers.1, CHROM) |> 
  mutate(START=as.character(WINDOW)|>as.numeric(), END=START+99999)

outliers.2 <- 
  group_by(outliers.2, CHROM) |> 
  mutate(START=as.character(WINDOW)|>as.numeric(), END=START+99999)

outliers.3 <- 
  group_by(outliers.3, CHROM) |> 
  mutate(START=as.character(WINDOW)|>as.numeric(), END=START+99999)

summary(outliers.1)
summary(outliers.2)
summary(outliers.3)


outliers.123 <- 
  bind_rows(outliers.1, outliers.2, outliers.3) |> 
  arrange(POP, CHROM, START)

write_tsv(outliers.123, file="outliers.PROP_CRIT.2.tab")
