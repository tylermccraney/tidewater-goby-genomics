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

write_tsv(outliers, file="outliers.tsv")

saveRDS(outliers, "outliers.RDS")

write_tsv(filter(dot2, rank>0.999)|>arrange(samplesA, samplesB, chr, start), file="outliers999.tsv")


dotO <- 
  group_by(dot2, samplesA, samplesB) |> 
  mutate(QUAN=cut_number(nSNPs, n=10, labels=1:10), CANDIDATE=TRUE) |> 
  group_by(samplesA, samplesB, QUAN) |> 
  slice_max(xpclr_norm, prop=0.01, with_ties=TRUE) |> 
  ungroup()

dot2 <- 
  left_join(x=dot2, y=dotO) |>
  ungroup()

dot2 <- 
  replace_na(dot2, list(CANDIDATE=FALSE))

saveRDS(dot2, "XP-CLR.RDS")
dot2 <- readRDS("XP-CLR.RDS")


dot2$samplesA <- 
  factor(
    dot2$samplesA, 
    ordered=TRUE, 
    levels=c(
      "NorteHumboldt", 
      "Mendocino",
      "SantaBarbara"),
    labels=c(
      "Del Norte-Humboldt", 
      "Mendocino",
      "Santa Barbara"))

dot2$samplesB <- 
  factor(
    dot2$samplesB, 
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
  ggplot(filter(dot2, xpclr>0), aes(x=BPcum, y=xpclr_norm)) +
  geom_point(mapping=aes(color=as.factor(chr)), shape=21, size=1, alpha=0.33) +
  geom_point(data=filter(dot2, xpclr>0, CANDIDATE==TRUE), mapping=aes(x=BPcum, y=xpclr_norm, color=as.factor(chr), fill=as.factor(chr)), shape=21, size=1) +
  scale_color_manual(values=rep(brewpal2x$COLORX[1:2], times=11), aesthetics=c("colour", "fill")) +
#  geom_hline(aes(yintercept=upper99), color=brewpal2x$COLORX[4], linewidth=0.5, linetype="dashed") +
#  geom_hline(aes(yintercept=upper999), color=brewpal2x$COLORX[4], linewidth=0.5, linetype="dotted") +
  scale_x_continuous(
    expand=expansion(mult=c(0.005, 0.005)),
    label=1:22,
    breaks=axisdf$center) +
  scale_y_continuous(expand=expansion(mult=c(0.05, 0.05)), n.breaks=7) +
  labs(
    tag="(a)",
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

ggsave(plot=gg1, filename="pairwise.png", device=png, width=17, height=4, units="in", dpi=300)
ggsave(plot=gg1, filename="pairwise.pdf", device=cairo_pdf, width=17, height=4, units="in")


sets_xpclr <- 
  list(
    `Del Norte-Humboldt`=mutate(filter(dot2, rank>0.99), id=paste0(chr, ":", start, "-", as.integer(stop))) |> filter(samplesA=="Del Norte-Humboldt") |> pull(id),
    Mendocino=mutate(filter(dot2, rank>0.99), id=paste0(chr, ":", start, "-", as.integer(stop))) |> filter(samplesA=="Mendocino") |> pull(id),
    `Santa Barbara`=mutate(filter(dot2, rank>0.99), id=paste0(chr, ":", start, "-", as.integer(stop))) |> filter(samplesA=="Santa Barbara") |> pull(id))

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
    stroke_color=c(rep(x=brewpal2$COLOR1[8], times=100), rep(x=brewpal2$COLOR1[6], times=100), rep(x=brewpal2$COLOR1[4], times=100)), 
    stroke_alpha=1,
#    stroke_alpha=0.67,
    auto_scale=FALSE) + 
  labs(title="396 Candidate Regions (XP-CLR)", tag="(b)") + 
  theme(plot.caption=element_text(size=13, hjust=0.5), plot.title=element_text(size=15, hjust=0.5), plot.tag=element_text(size=15))
gg.sets_xpclr

ggsave(plot=gg.sets_xpclr, filename="pairwise.venn.png", bg="white", device=png, width=5, height=5, units="in", dpi=300)
ggsave(plot=gg.sets_xpclr, filename="pairwise.venn.pdf", bg="white", device=cairo_pdf, width=5, height=5, units="in")

