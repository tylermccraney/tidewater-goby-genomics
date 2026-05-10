library(tidyverse)
library(slider)
library(ggthemes)

# data import
setwd(dir="/Volumes/Tigrigobius/tgoby/ihs/selscan/gmap/")

filename <- dir(pattern="*.ihs.out.\\d\\dbins.norm$")

dat <- 
  filename |> 
  map(
    \(filename) read_tsv(file=filename, col_names=c("locusID", "physicalPos", "freq", "ihh1", "ihh0", "iHS", "iHSnorm", "crit")) |> 
      mutate(test=gsub(".ihs.out.\\d\\dbins.norm", "", filename))) |>
  reduce(rbind)

dat <- 
  select(dat, -locusID, -ihh1, -ihh0, -iHS) |> 
  rename(POS=physicalPos, iHS=iHSnorm) |>
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

dot <- mutate(dot, ABS_iHS=abs(iHS))

dot <- group_by(dot, POP) |> mutate(RANK_ABS_iHS=percent_rank(ABS_iHS))

dot <- 
  left_join(
    x=dot, 
    y=filter(dot, RANK_ABS_iHS>=0.99)|>summarise(UPPER_ABS_iHS=min(ABS_iHS)), 
    by=join_by(POP)) |>
  ungroup() |>
  arrange(POP, CHROM, POS)

outliers <- filter(dot, RANK_ABS_iHS>=0.99)

write_tsv(outliers, file="outliers.p01.tsv")

#
windows <- seq(from=1, to=54300000, by=100000)

dot100 <- 
  mutate(
    dot, 
    WINDOW=cut(POS, breaks=windows, labels=windows[-543])) |> 
  group_by(POP, CHROM, WINDOW) |> 
  summarise(
    N_SCORES=n(), 
    N_OUTLIERS=sum(RANK_ABS_iHS>=0.99),
    PROP_OUTLIERS=N_OUTLIERS/N_SCORES,
    N_CRIT=sum(abs(crit)), 
    PROP_CRIT=sum(abs(crit))/N_SCORES, 
    MIN_SCORE=min(ABS_iHS), 
    MAX_SCORE=max(ABS_iHS), 
    MEAN_SCORE=mean(ABS_iHS), 
    SD_SCORE=sd(ABS_iHS)) |>
  filter(N_SCORES>=10) |>
  group_by(POP) |>
  mutate(
    RANK_PROP_OUTLIERS=percent_rank(PROP_OUTLIERS),
    RANK_PROP_CRIT=percent_rank(PROP_CRIT))

dot100 <- 
  left_join(
    x=dot100, 
    y=filter(dot100, RANK_PROP_CRIT>=0.99)|>summarise(UPPER_PROP_CRIT=min(PROP_CRIT)), 
    by=join_by(POP))

outliers100 <- 
  filter(dot100, RANK_PROP_CRIT>=0.99) |> 
  mutate(
    START=as.character(WINDOW)|>as.numeric(), 
    END=START+99999) |> 
  select(-WINDOW)

write_tsv(outliers100, file="outliers.PROP_CRIT.tsv")

brewpal2 <- read_tsv(file="../../../brewpal2.tab")
brewpal2x <- read_tsv(file="../../../brewpal2x.tab")
barplot(1:9, col=brewpal2x$COLORX)



dot100 <- mutate(dot100, WINDOW=as.character(WINDOW)|>as.numeric())

dot100 <- 
  dot100 |>
  group_by(CHROM) |> 
  reframe(chr_len=max(WINDOW, na.rm=TRUE)) |> 
  mutate(tot=cumsum(chr_len)-chr_len) |>
  select(-chr_len) |>
  left_join(dot100, ., by="CHROM") |>
  arrange(CHROM, WINDOW) |>
  mutate(BPcum=WINDOW+tot) |> 
  select(-tot) |> 
  arrange(POP, BPcum) |>
  filter(!is.na(WINDOW))

axisdf100 <- 
  dot100 |> 
  group_by(CHROM) |> 
  summarize(center=(max(BPcum)+min(BPcum))/2)


saveRDS(object=dot, file="iHS.RDS")
saveRDS(object=dot100, file="iHS.100Kb.RDS")



gg <- 
  ggplot(dot100, aes(x=BPcum, y=PROP_CRIT)) +
  geom_point(aes(color=as.factor(CHROM)), shape=1, size=1) +
  scale_color_manual(values=rep(brewpal2x$COLORX[1:2], times=11)) +
  geom_hline(aes(yintercept=UPPER_PROP_CRIT), color=brewpal2x$COLORX[4], linewidth=0.5, linetype="dashed") +
  scale_x_continuous(
    expand=expansion(mult=c(0.005, 0.005)),
    label=1:22,
    breaks=axisdf100$center) +
  scale_y_continuous(n.breaks=7) +
  labs(
    tag="a)",
    x="Chromosome", 
    y="Proportion |iHS| > 2") +
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

ggsave(plot=gg, filename="PROP_CRIT.png", device=png, width=8, height=4, units="in", dpi=300)
ggsave(plot=gg, filename="PROP_CRIT.pdf", device=cairo_pdf, width=8, height=4, units="in")


gg <- 
  ggplot(dot100, aes(x=BPcum, y=PROP_OUTLIERS)) +
  geom_point(aes(color=as.factor(CHROM)), shape=1, size=1) +
  scale_color_manual(values=rep(brewpal2x$COLORX[1:2], times=11)) +
#  geom_hline(aes(yintercept=UPPER_PROP_OUTLIERS), color=brewpal2x$COLORX[4], linewidth=0.5, linetype="dashed") +
  scale_x_continuous(
    expand=expansion(mult=c(0.005, 0.005)),
    label=1:22,
    breaks=axisdf100$center) +
  scale_y_continuous(n.breaks=6) +
  labs(
    tag="a)",
    x="Chromosome", 
    y="Proportion of outlier iHS") +
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

ggsave(plot=gg, filename="PROP_OUTLIERS.png", device=png, width=8, height=4, units="in", dpi=300)
ggsave(plot=gg, filename="PROP_OUTLIERS.pdf", device=cairo_pdf, width=8, height=4, units="in")


gg <- 
  ggplot(dot, aes(x=BPcum, y=ABS_iHS)) +
  geom_point(aes(color=as.factor(CHROM)), shape=1, size=1) +
  scale_color_manual(values=rep(brewpal2x$COLORX[1:2], times=11)) +
  geom_hline(aes(yintercept=UPPER_ABS_iHS), color=brewpal2x$COLORX[4], linewidth=0.5, linetype="dashed") +
  scale_x_continuous(
    expand=expansion(mult=c(0.005, 0.005)),
    label=1:22,
    breaks=axisdf$center) +
  scale_y_continuous(n.breaks=6) +
  labs(
    tag="a)",
    x="Chromosome", 
    y="|iHS|") +
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

ggsave(plot=gg, filename="ABS_iHS.png", device=png, width=8, height=4, units="in", dpi=300)
ggsave(plot=gg, filename="ABS_iHS.pdf", device=cairo_pdf, width=8, height=4, units="in")



mutate(dot, WINDOW=cut(POS, breaks=windows, labels=windows[-543])) |> 
  group_by(POP, CHROM, WINDOW) |> 
  summarise(
    N_SCORES=n(), 
    MIN_SCORE=min(ABS_iHS), 
    MAX_SCORE=max(ABS_iHS)) |>
  ungroup() |> 
  filter(MAX_SCORE>7) |> 
  arrange(POP, CHROM, WINDOW) |> 
  write_tsv(file="MAX_SCORE_7+.tsv")

peaks <- 
  read_tsv(file="MAX_SCORE_7+.tsv") |> 
  filter(PEAK==TRUE) |> 
  group_by(POP) |> 
  slice_max(MAX_SCORE, n=10) |> 
  arrange(POP, CHROM, WINDOW) |>
  select(POP, CHROM, MAX_SCORE)

peaks10 <- left_join(x=peaks, y=dot, by=c("POP", "CHROM", "MAX_SCORE"="ABS_iHS")) |> select(POP, CHROM, POS, iHS)

write_tsv(peaks10, file="peaks10.tab")

