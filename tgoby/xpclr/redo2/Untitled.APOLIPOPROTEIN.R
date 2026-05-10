library(tidyverse)
library(ggthemes)
library(ggvenn)
library(gridExtra)

setwd(dir="/Volumes/Tigrigobius/tgoby/xpclr/redo2/")

filename <- dir(pattern="*.100Kb_19Mb-20Mb$")

xpclr <- 
  filename |> 
  map(
    \(filename) read_tsv(file=filename) |> 
      mutate(test=gsub(".100Kb_19Mb-20Mb", "", filename))) |> 
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

dot1 <- group_by(dot, samplesA, samplesB) |> mutate(rank=percent_rank(xpclr_norm))

dot1$samplesA <- 
  factor(
    dot1$samplesA, 
    ordered=TRUE, 
    levels=c(
      "NorteHumboldt", 
      "Mendocino",
      "SantaBarbara"),
    labels=c(
      "Del Norte-Humboldt", 
      "Mendocino",
      "Santa Barbara"))

dot1$samplesB <- 
  factor(
    dot1$samplesB, 
    ordered=TRUE, 
    levels=c(
      "NorteHumboldt", 
      "Mendocino",
      "SantaBarbara"),
    labels=c(
      "Del Norte\nHumboldt", 
      "Mendocino",
      "Santa\nBarbara"))


cuts <- readRDS(file="XP-CLR.RDS") |> distinct(samplesA, samplesB, upper99, upper999)

dot2 <- left_join(x=dot1, y=cuts, by=join_by(samplesA, samplesB))


brewpal2 <- read_tsv(file="../../brewpal2.tab")
brewpal2x <- read_tsv(file="../../brewpal2x.tab")
barplot(1:9, col=brewpal2x$COLORX)



write_tsv(filter(dot2, xpclr_norm>upper99)|>arrange(samplesA, samplesB, chr, start), file="outliers.99.APOLIPOPROTEIN.tsv")
write_tsv(filter(dot2, xpclr_norm>upper999)|>arrange(samplesA, samplesB, chr, start), file="outliers.999.APOLIPOPROTEIN.tsv")


gg1 <- 
  ggplot(dot2, aes(x=BPcum, y=xpclr_norm)) +
  geom_point(mapping=aes(color=as.factor(chr)), shape=1, size=1) +
  scale_color_manual(values=rep(brewpal2x$COLORX[1:2], times=11)) +
  geom_hline(aes(yintercept=upper99), color=brewpal2x$COLORX[4], linewidth=0.5, linetype="dashed") +
  geom_hline(aes(yintercept=upper999), color=brewpal2x$COLORX[4], linewidth=0.5, linetype="dotted") +
  scale_x_continuous(expand=expansion(mult=c(0.02, 0.02)), breaks = seq(from=19000000, to=20000000, by=200000), labels=seq(from=19, to=20, by=0.2)) +
  scale_y_continuous(expand=expansion(mult=c(0.05, 0.05)), breaks=seq(from=0, to=10, by=2)) +
  labs(
    tag="b)",
    x="JAPEHO010000013.1:19000000-20000000", 
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

ggsave(plot=gg1, filename="pairwise.100Kb_19Mb-20Mb.png", device=png, width=17, height=4, units="in", dpi=300)
ggsave(plot=gg1, filename="pairwise.100Kb_19Mb-20Mb.pdf", device=cairo_pdf, width=17, height=4, units="in")


gg2 <- 
  ggplot(filter(dot2, between(start, left=19500000, right=19700000)), aes(x=BPcum, y=xpclr_norm)) +
  geom_point(mapping=aes(color=as.factor(chr)), shape=1, size=1) +
  scale_color_manual(values=rep(brewpal2x$COLORX[1:2], times=11)) +
  geom_hline(aes(yintercept=upper99), color=brewpal2x$COLORX[4], linewidth=0.5, linetype="dashed") +
  geom_hline(aes(yintercept=upper999), color=brewpal2x$COLORX[4], linewidth=0.5, linetype="dotted") +
  scale_x_continuous(expand=expansion(mult=c(0.02, 0.02)), breaks=seq(from=19500000, to=19650000, by=50000), labels=paste0(seq(from=19.5, to=19.65, by=0.05), " Mb")) +
  scale_y_continuous(expand=expansion(mult=c(0.05, 0.05)), breaks=seq(from=0, to=10, by=2), labels=seq(from=0, to=10, by=2), limits=c(NA, 10)) +
  labs(
    tag="b)",
    x="Chromosome 13: 19500000-19700000", 
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
    axis.ticks.x=element_line(linewidth=0.25, colour="lightgrey"),
    axis.line=element_blank(),
    legend.position="none",
    panel.background=element_rect(linetype="blank"),
    panel.border=element_rect(linetype="blank"),
    panel.grid.major.y=element_line(colour="lightgray", linewidth=0.25),
    plot.background=element_rect(linetype="blank"))

ggsave(plot=gg2, filename="pairwise.100Kb_19.5Mb-19.7Mb.png", device=png, width=17, height=4, units="in", dpi=300)
ggsave(plot=gg2, filename="pairwise.100Kb_19.5Mb-19.7Mb.pdf", device=cairo_pdf, width=17, height=4, units="in")

# peak score at JAPEHO010000013.1_19607001_19707000













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
  labs(title="185 Outlier Windows (XP-CLR)", tag="b)") + 
  theme(plot.caption=element_text(size=13, hjust=0.5), plot.title=element_text(size=15, hjust=0.5), plot.tag=element_text(size=15))
gg.sets_xpclr

ggsave(plot=gg.sets_xpclr, filename="K3.windows.nonoverlapping.venn.png", bg="white", device=png, width=5, height=5, units="in", dpi=300)
ggsave(plot=gg.sets_xpclr, filename="K3.windows.nonoverlapping.venn.pdf", bg="white", device=cairo_pdf, width=5, height=5, units="in")

