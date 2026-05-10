library(tidyverse)
library(ggthemes)
library(ggvenn)
library(gridExtra)
library(ggrepel)

setwd(dir="/Volumes/Tigrigobius/tgoby/xpnsl/selscan/")

brewpal2 <- read_tsv(file="../../brewpal2.tab")

brewpal2x <- read_tsv(file="../../brewpal2x.tab")

filename <- dir(pattern="*.xpnsl.out.norm$")

xpnsl <- 
  filename |> 
  map(
    \(filename) read_tsv(file=filename) |> 
      mutate(test=gsub(".xpnsl.out.norm", "", filename))) |> 
  reduce(rbind) 

xpnsl <- 
  mutate(
    xpnsl, 
    chr=str_extract(string=test, pattern="\\.chr(\\d\\d)", group=1) |> as.double(), 
    samplesA=str_split_i(string=test, pattern="_", i=1), 
    samplesB=str_split_i(string=test, pattern="_", i=2) |> gsub(pattern="\\.chr\\d+", replacement="")) |>
  select(-id) |> 
  arrange(chr, pos, samplesA, samplesB) |>
  relocate(chr, .before=pos) |>
  rename(xpnsl_norm=normxpehh)

dot <- 
  xpnsl |> 
  group_by(chr) |> 
  summarise(chr_len=max(pos)) |> 
  mutate(tot=cumsum(chr_len)-chr_len) |>
  select(-chr_len) |>
  left_join(xpnsl, ., by=c("chr"="chr")) |>
  arrange(chr, pos, samplesA, samplesB) |>
  mutate(BPcum=pos+tot) |>
  relocate(BPcum, .before=gpos) |>
  select(-tot)

axisdf <- 
  dot |> 
  group_by(chr) |> 
  summarize(center=(max(BPcum)+min(BPcum))/2)

#

## dot <- filter(dot, xpnsl>0)

dot <- 
  group_by(dot, samplesA, samplesB) |> mutate(rank=percent_rank(xpnsl_norm)) |> ungroup()

dot <- 
  left_join(
    x=dot, 
    y=group_by(dot, samplesA, samplesB)|>filter(rank>0.99)|>summarise(upper99=min(xpnsl_norm)), 
    by=join_by(samplesA, samplesB)) |>
  left_join(
    y=group_by(dot, samplesA, samplesB)|>filter(rank>0.999)|>summarise(upper999=min(xpnsl_norm)), 
    by=join_by(samplesA, samplesB))

outliers99 <- filter(dot, rank>0.99)
outliers999 <- filter(dot, rank>0.999)

write_tsv(outliers99, file="outliers99.tab")
write_tsv(outliers999, file="outliers999.tab")

saveRDS(outliers99, "outliers99.RDS")

group_by(dot, samplesA, samplesB, crit) |> count()

saveRDS(object=dot, file="XP-nSL.RDS")

dot <- 
  mutate(
    dot, 
    POP=factor(
      samplesA, 
      ordered=TRUE, 
      labels=c("Del Norte-Humboldt", "Mendocino", "Santa Barbara"), 
      levels=c("NorteHumboldt", "Mendocino", "SantaBarbara")))


dot <- 
  mutate(
    dot, 
    POP=factor(
      samplesA, 
      ordered=TRUE, 
      labels=c("Del Norte-Humboldt", "Mendocino", "Santa Barbara"), 
      levels=c("NorteHumboldt", "Mendocino", "SantaBarbara")),
    samplesA=factor(
      samplesA, 
      ordered=TRUE, 
      labels=c("Del Norte-Humboldt", "Mendocino", "Santa Barbara"), 
      levels=c("NorteHumboldt", "Mendocino", "SantaBarbara")),
    samplesB=factor(
      samplesB, 
      ordered=TRUE, 
      labels=c("Del Norte\nHumboldt", "Mendocino", "Santa\nBarbara"), 
      levels=c("NorteHumboldt", "Mendocino", "SantaBarbara")))

#


gg <- 
  ggplot(dot, aes(x=BPcum, y=xpnsl_norm)) +
  geom_point(mapping=aes(color=as.factor(chr)), shape=1, size=1) +
  scale_color_manual(values=rep(brewpal2x$COLORX[1:2], times=11)) +
  geom_hline(aes(yintercept=upper99), color=brewpal2x$COLORX[4], linewidth=0.5, linetype="dashed") +
#  geom_hline(aes(yintercept=upper999), color=brewpal2x$COLORX[4], linewidth=0.5, linetype="dotted") +
#  geom_text(hjust=0, vjust=0, size=2, fontface="italic", position=position_jitter(width=0, height=0.5)) +
#  geom_text_repel(size=2, fontface="italic", max.overlaps=30, min.segment.length=0, segment.size=0.2) +
  scale_x_continuous(
    expand=expansion(mult=c(0.005, 0.005)),
    label=1:22,
    breaks=axisdf$center) +
  scale_y_continuous(expand=expansion(mult=c(0.05, 0.05)), n.breaks=7) +
  labs(
    tag="a)",
    x="Chromosome", 
    y="XP-nSL") +
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

ggsave(plot=gg, filename="pairwise.png", device=png, width=17, height=4, units="in", dpi=300)
ggsave(plot=gg, filename="pairwise.pdf", device=cairo_pdf, width=17, height=4, units="in")


#
library(ggvenn)
library(gridExtra)

outliers99 <- mutate(outliers99, id=paste0(chr, ":", pos))

sets_XPnSL <- 
  list(
    `Del Norte-Humboldt`=filter(outliers99, samplesA=="NorteHumboldt")|>pull(id),
    Mendocino=filter(outliers99, samplesA=="Mendocino")|>pull(id),
    `Santa Barbara`=filter(outliers99, samplesA=="SantaBarbara")|>pull(id))

unique(c(sets_XPnSL[[1]], sets_XPnSL[[2]], sets_XPnSL[[3]])) |> length()

str(sets_XPnSL)

gg.sets_XPnSL <- 
  ggvenn(
    data=sets_XPnSL, 
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
  labs(title="30,970 Candidate Sites (XP-nSL)", tag="c)") + 
  theme(plot.caption=element_text(size=13, hjust=0.5), plot.title=element_text(size=15, hjust=0.5), plot.tag=element_text(size=15))
gg.sets_XPnSL

ggsave(plot=gg.sets_XPnSL, filename="XP-nSL.SNPs.venn.png", bg="white", device=png, width=5, height=5, units="in", dpi=300)
ggsave(plot=gg.sets_XPnSL, filename="XP-nSL.SNPs.venn.pdf", bg="white", device=cairo_pdf, width=5, height=5, units="in")

################################################
## end
################################################



















gg100 <- 
  ggplot(dot100, aes(x=BPcum, y=PROP_CRIT)) +
  geom_point(mapping=aes(color=as.factor(CHROM)), shape=1, size=1) +
  scale_color_manual(values=rep(brewpal2x$COLORX[1:2], times=11)) +
  geom_hline(aes(yintercept=UPPER99_PROP_CRIT), color=brewpal2x$COLORX[4], linewidth=0.5, linetype="dashed") +
  geom_hline(aes(yintercept=UPPER999_PROP_CRIT), color=brewpal2x$COLORX[4], linewidth=0.5, linetype="dotted") +
  scale_x_continuous(
    expand=expansion(mult=c(0.005, 0.005)),
    label=1:22,
    breaks=axisdf1$center) +
  scale_y_continuous(expand=expansion(mult=c(0.05, 0.15)), n.breaks=7) +
  labs(
    tag="b)",
    x="Chromosome", 
    y="Proportion |XP-nSL| > 2") +
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

ggsave(plot=gg100, filename="pairwise.100Kb.png", device=png, width=17, height=4, units="in", dpi=300)
ggsave(plot=gg100, filename="pairwise.100Kb.pdf", device=cairo_pdf, width=17, height=4, units="in")

#
mutate(dot1, WINDOW=cut(pos, breaks=windows, labels=windows[-543])) |> 
  group_by(samplesA, samplesB, chr, WINDOW) |> 
  summarise(
    N_SCORES=n(), 
    MIN_SCORE=min(abs_xpnsl_norm), 
    MAX_SCORE=max(abs_xpnsl_norm)) |>
  ungroup() |> 
  filter(MAX_SCORE>4) |> 
  arrange(samplesA, samplesB, chr, WINDOW) |> 
  write_tsv(file="MAX_SCORE_4+.tsv")

peaks <- 
  read_tsv(file="MAX_SCORE_4+.tsv") |> 
  filter(PEAK==TRUE) |> 
  group_by(samplesA, samplesB) |> 
  slice_max(MAX_SCORE, n=10) |> 
  arrange(samplesA, samplesB, chr, WINDOW) |>
  select(samplesA, samplesB, chr, WINDOW, MAX_SCORE)

mutate(dot1, WINDOW=cut(pos, breaks=windows, labels=windows[-543])) |> 
  group_by(samplesA, samplesB, chr, WINDOW) |> 
  summarise(
    N_SCORES=n(), 
    MIN_SCORE=min(abs_xpnsl_norm), 
    MAX_SCORE=max(abs_xpnsl_norm)) |>
  ungroup() |> 
  filter(MAX_SCORE>3.5) |> 
  arrange(samplesA, samplesB, chr, WINDOW) |> 
  write_tsv(file="MAX_SCORE_3.5+.tsv")

peaks2 <- 
  read_tsv(file="MAX_SCORE_3.5+.tsv") |> 
  filter(PEAK==TRUE) |> 
  group_by(samplesA, samplesB) |> 
  slice_max(MAX_SCORE, n=10) |> 
  arrange(samplesA, samplesB, chr, WINDOW) |>
  select(samplesA, samplesB, chr, WINDOW, MAX_SCORE)

peaks <- bind_rows(peaks, peaks2) |> distinct() |> arrange(samplesA, samplesB, chr, WINDOW)

peaks10 <- 
  left_join(x=peaks, y=dot1, by=c("samplesA", "samplesB", "chr", "MAX_SCORE"="abs_xpnsl_norm")) |> 
  select(samplesA, samplesB, chr, pos, xpnsl_norm)

write_tsv(peaks10, file="peaks10.tab")


###########################################################################################################













gg <- 
  ggplot(dot100, aes(x=BPcum, y=PROP_CRIT)) +
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
    y="Proportion |XP-nSL| > 2") +
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





gg1 <- 
  ggplot(filter(dot1, rank>0.99), aes(x=BPcum, y=abs_xpnsl_norm)) +
  geom_point(aes(color=as.factor(chr)), shape=1, size=1) +
  scale_color_manual(values=rep(brewpal2x$COLORX[1:2], times=11)) +
#  geom_hline(aes(yintercept=upper), color=brewpal2x$COLORX[4], linewidth=0.5, linetype="dashed") +
  scale_x_continuous(
    expand=expansion(mult=c(0.005, 0.005)),
    label=1:22,
    breaks=axisdf$center) +
  scale_y_continuous(n.breaks=5) +
  labs(
    tag="a)",
    x="Chromosome", 
    y="|XP-nSL|") +
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

ggsave(plot=gg1, filename="ABS_XP-nSL.png", device=png, width=8, height=4, units="in", dpi=300)
ggsave(plot=gg1, filename="ABS_XP-nSL.pdf", device=cairo_pdf, width=8, height=4, units="in")


