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

dot <- mutate(dot, ABS_nSL=abs(nSL))

dot <- group_by(dot, POP) |> mutate(RANK_ABS_nSL=percent_rank(ABS_nSL)) |> ungroup()

#dot <- 
#  left_join(
#    x=dot, 
#    y=filter(dot, RANK_ABS_nSL>0.99)|>summarise(UPPER_ABS_nSL_99=min(ABS_nSL)), 
#    by=join_by(POP)) |>
#  left_join(
#    y=filter(dot, RANK_ABS_nSL>0.999)|>summarise(UPPER_ABS_nSL_999=min(ABS_nSL)), 
#    by=join_by(POP)) |>
#  ungroup() |>
#  arrange(POP, CHROM, POS)

outliers <- filter(dot, RANK_ABS_nSL>0.99)

write_tsv(outliers, file="outliers.p01.tsv")

saveRDS(outliers, "outliers.p01.RDS")

saveRDS(dot, "nSL.RDS")
write_tsv(dot, file="nSL.tsv")

brewpal2 <- read_tsv(file="../../brewpal2.tab")
brewpal2x <- read_tsv(file="../../brewpal2x.tab")
barplot(1:9, col=brewpal2x$COLORX)



dot$POP <- 
  factor(
    dot$POP, 
    levels=c("NorteHumboldt", "Mendocino", "SantaBarbara"), 
    labels=c("Del Norte-Humboldt", "Mendocino", "Santa Barbara"), 
    ordered=TRUE)



gg <- 
  ggplot(dot, aes(x=BPcum, y=ABS_nSL)) +
  geom_point(aes(color=as.factor(CHROM)), shape=1, size=1) +
  scale_color_manual(values=rep(brewpal2x$COLORX[1:2], times=11)) +
  geom_hline(aes(yintercept=UPPER_ABS_nSL_99), color=brewpal2x$COLORX[4], linewidth=0.5, linetype="dashed") +
#  geom_hline(aes(yintercept=UPPER_ABS_nSL_999), color=brewpal2x$COLORX[4], linewidth=0.5, linetype="dotted") +
  scale_x_continuous(
    expand=expansion(mult=c(0.005, 0.005)),
    label=1:22,
    breaks=axisdf$center) +
  scale_y_continuous(n.breaks=6) +
  labs(
    tag="a)",
    x="Chromosome", 
    y="nSL") +
  theme_base(base_size=10) +
  facet_wrap(facets=vars(POP), ncol=1, nrow=3, scales="fixed") +
  theme(
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

ggsave(plot=gg, filename="nSL.png", device=png, width=8, height=4, units="in", dpi=300)
ggsave(plot=gg, filename="nSL.pdf", device=cairo_pdf, width=8, height=4, units="in")


#
library(ggvenn)
library(gridExtra)

outliers <- mutate(outliers, id=paste0(CHROM, ":", POS))

sets_nSL <- 
  list(
    `Del Norte-Humboldt`=filter(outliers, POP=="Del Norte-Humboldt")|>pull(id),
    Mendocino=filter(outliers, POP=="Mendocino")|>pull(id),
    `Santa Barbara`=filter(outliers, POP=="Santa Barbara")|>pull(id))

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
  labs(title="9,438 Candidate Sites (nSL)", tag="c)") + 
  theme(plot.caption=element_text(size=13, hjust=0.5), plot.title=element_text(size=15, hjust=0.5), plot.tag=element_text(size=15))
gg.sets_nSL

ggsave(plot=gg.sets_nSL, filename="nSL.SNPs.venn.png", bg="white", device=png, width=5, height=5, units="in", dpi=300)
ggsave(plot=gg.sets_nSL, filename="nSL.SNPs.venn.pdf", bg="white", device=cairo_pdf, width=5, height=5, units="in")

################################################
## end
################################################















mutate(dot, WINDOW=cut(POS, breaks=windows, labels=windows[-543])) |> 
  group_by(POP, CHROM, WINDOW) |> 
  summarise(
    N_SCORES=n(), 
    MIN_SCORE=min(ABS_nSL), 
    MAX_SCORE=max(ABS_nSL)) |>
  ungroup() |> 
  filter(MAX_SCORE>4) |> 
  arrange(POP, CHROM, WINDOW) |> 
  write_tsv(file="MAX_SCORE_4+.tsv")

peaks <- 
  read_tsv(file="MAX_SCORE_4+.tsv") |> 
  filter(PEAK==TRUE) |> 
  group_by(POP) |> 
  slice_max(MAX_SCORE, n=10) |> 
  arrange(POP, CHROM, WINDOW) |>
  select(POP, CHROM, MAX_SCORE)

peaks10 <- left_join(x=peaks, y=dot, by=c("POP", "CHROM", "MAX_SCORE"="ABS_nSL")) |> select(POP, CHROM, POS, nSL)

write_tsv(peaks10, file="peaks10.tab")

