library(tidyverse)
library(ggthemes)
library(ggvenn)
library(gridExtra)

setwd(dir="/Volumes/Tigrigobius/tgoby/xpclr/redo2/")

filename <- dir(pattern="*.100Kb$")

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

dot1 <- 
  group_by(dot, samplesA, samplesB) |> mutate(rank=percent_rank(xpclr_norm))

dot1 <- 
  left_join(
    x=dot1, 
    y=filter(dot1, rank>0.99)|>summarise(upper99=min(xpclr_norm))) |>
  left_join(
    y=filter(dot1, rank>0.999)|>summarise(upper999=min(xpclr_norm)))




brewpal2 <- read_tsv(file="../../brewpal2.tab")
brewpal2x <- read_tsv(file="../../brewpal2x.tab")
barplot(1:9, col=brewpal2x$COLORX)



dot2 <- filter(dot1, samplesA!="NorteHumboldtMendocino", samplesB!="NorteHumboldtMendocino")

outliers <- filter(dot2, rank>0.99)|>arrange(samplesA, samplesB, chr, start)

dotO <- 
  group_by(dot2, samplesA, samplesB) |> 
  mutate(QUAN=cut_number(nSNPs, n=10, labels=1:10, right=FALSE), CANDIDATE=TRUE) |> 
  group_by(samplesA, samplesB, QUAN) |> 
  slice_max(xpclr_norm, prop=0.01, with_ties=TRUE) |> 
  ungroup()

dotO.q <- 
  group_by(dot2, samplesA, samplesB) |> 
  mutate(QUAN=cut_number(nSNPs, n=10, labels=1:10, right=FALSE), STAT="XP-CLR") |> 
  ungroup() |>
  left_join(y=dotO, by=join_by(chrom, tot, id, start, stop, pos_start, pos_stop, modelL, nullL, sel_coef, nSNPs, nSNPs_avail, xpclr, xpclr_norm, chr, samplesA, samplesB, BPcum, rank, upper99, upper999, QUAN)) |>
  replace_na(list(CANDIDATE=FALSE))

summary(dotO.q)

saveRDS(object=dotO.q, file="/Volumes/Tigrigobius/tgoby/windows/XP-CLR.RDS")





dotO.q$samplesA <- 
  factor(
    dotO.q$samplesA, 
    ordered=TRUE, 
    levels=c(
      "NorteHumboldt", 
      "Mendocino",
      "SantaBarbara"),
    labels=c(
      "Del Norte-Humboldt", 
      "Mendocino",
      "Santa Barbara"))

dotO.q$samplesB <- 
  factor(
    dotO.q$samplesB, 
    ordered=TRUE, 
    levels=c(
      "NorteHumboldt", 
      "Mendocino",
      "SantaBarbara"),
    labels=c(
      "Del Norte\nHumboldt", 
      "Mendocino",
      "Santa\nBarbara"))



gg1 <- 
  ggplot(filter(dotO.q, xpclr>0), aes(x=BPcum, y=xpclr_norm)) +
  geom_point(mapping=aes(color=as.factor(chr)), shape=1, size=1) +
  geom_point(data=filter(dotO.q, xpclr>0, CANDIDATE==TRUE), mapping=aes(x=BPcum, y=xpclr_norm, color=factor(chr, levels=1:22, labels=23:44)), shape=1, size=1) +
  scale_color_manual(values=c(rep(brewpal2x$COLORX[7:8], times=11), rep(brewpal2x$COLORX[4:5], times=11))) +
#  geom_hline(aes(yintercept=upper99), color=brewpal2x$COLORX[4], linewidth=0.5, linetype="dashed") +
#  geom_hline(aes(yintercept=upper999), color=brewpal2x$COLORX[4], linewidth=0.5, linetype="dotted") +
  scale_x_continuous(
    expand=expansion(mult=c(0.005, 0.005)),
    label=1:22,
    breaks=axisdf$center) +
  scale_y_continuous(expand=expansion(mult=c(0.05, 0.05)), n.breaks=7) +
  labs(
    tag="(b)",
    x="Chromosome", 
    y="XP-CLR") +
  theme_base(base_size=10) +
  facet_grid(cols=vars(samplesA), rows=vars(samplesB), scales="fixed") +
  theme(
    strip.text.y=element_text(angle=0),
    strip.text=element_text(size=10, hjust=0.5),
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

ggsave(plot=gg1, filename="pairwise.png", device=png, width=17, height=4, units="in", dpi=320)
ggsave(plot=gg1, filename="pairwise.pdf", device=cairo_pdf, width=17, height=4, units="in")

