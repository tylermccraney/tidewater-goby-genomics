library(tidyverse)
library(slider)
library(ggthemes)

# data import
setwd(dir="/Volumes/Tigrigobius/tgoby/ihs/selscan/gmap/")

filename <- dir(pattern="*.ihs.out.\\d\\dbins.norm.100kb.windows$")

dat <- 
  filename |> 
  map(
    \(filename) read_tsv(file=filename, col_names=c("START", "END", "N_SCORES", "PROP_CRIT", "PERCENTILE", "MAX_SCORE")) |> 
      mutate(test=gsub(".ihs.out.\\d\\dbins.norm.100kb.windows", "", filename))) |>
  reduce(rbind)

dat <- 
  filter(dat, !is.na(MAX_SCORE))

dat <- 
  mutate(dat, CHROM=str_split_i(string=test, pattern="chr", i=2) |> as.numeric()) |> 
  mutate(test=str_split_i(string=test, pattern="\\.chr", i=1)) |> 
  rename(POP=test)

dot <- 
  dat |>
  group_by(CHROM) |> 
  reframe(chr_len=max(END, na.rm=TRUE)) |> 
  mutate(tot=cumsum(chr_len)-chr_len) |>
  select(-chr_len) |>
  left_join(dat, ., by="CHROM") |>
  arrange(CHROM, START) |>
  mutate(BPcum=START+tot) |> 
  select(-tot) |> 
  arrange(BPcum) |>
  filter(!is.na(START))

axisdf <- 
  dot |> 
  group_by(CHROM) |> 
  summarize(center=(max(BPcum)+min(BPcum))/2)

dot

saveRDS(object=dot, file="iHS.100Kb.RDS")
write_tsv(dot, file="iHS.100Kb.tsv")

dot$POP <- 
  factor(
    dot$POP, 
    levels=c("NorteHumboldt", "Mendocino", "SantaBarbara"), 
    labels=c("Del Norte-Humboldt", "Mendocino", "Santa Barbara"), 
    ordered=TRUE)

brewpal2 <- read_tsv(file="../../../brewpal2.tab")
brewpal2x <- read_tsv(file="../../../brewpal2x.tab")
barplot(1:9, col=brewpal2x$COLORX)

group_by(dot, POP) |> count()
group_by(dot, POP, PERCENTILE) |> count()

92/8093
90/8198
87/8097

#dot$PERCENTILE <- factor(dot$PERCENTILE, levels=c(99, 95, 0), ordered=TRUE)

factor(1:22, levels = 1:22, labels = 23:44)

gg <- 
  ggplot(filter(dot, PROP_CRIT>0), aes(x=BPcum, y=PROP_CRIT)) +
  geom_point(mapping=aes(color=as.factor(CHROM)), shape=1, size=1) +
  geom_point(data=filter(dot, PERCENTILE==1), mapping=aes(x=BPcum, y=PROP_CRIT, color=factor(CHROM, levels=1:22, labels=23:44)), shape=1, size=1) +
  scale_color_manual(values=c(rep(brewpal2x$COLORX[7:8], times=11), rep(brewpal2x$COLORX[4:5], times=11))) +
  scale_x_continuous(
    expand=expansion(mult=c(0.005, 0.005)),
    label=1:22,
    breaks=axisdf$center) +
  scale_y_continuous(n.breaks=7) +
  labs(
    tag="(b)",
    x="Chromosome", 
    y="Proportion of |iHS| scores > 2 in window") +
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

ggsave(plot=gg, filename="iHS.100Kb.png", device=png, width=8, height=4, units="in", dpi=320)
ggsave(plot=gg, filename="iHS.100Kb.pdf", device=cairo_pdf, width=8, height=4, units="in")



## stopped 10/16/2024


outliers <- filter(dot, PERCENTILE==1)

write_tsv(outliers, file="outliers.100Kb.tab")

saveRDS(object=outliers, file="outliers.100Kb.RDS")

#
library(ggvenn)
library(gridExtra)

outliers <- mutate(outliers, END=as.integer(END-1), id=paste0(CHROM, ":", START, "-", END))

sets_iHS <- 
  list(
    `Del Norte-Humboldt`=filter(outliers, POP=="Del Norte-Humboldt")|>pull(id),
    Mendocino=filter(outliers, POP=="Mendocino")|>pull(id),
    `Santa Barbara`=filter(outliers, POP=="Santa Barbara")|>pull(id))

unique(c(sets_iHS[[1]], sets_iHS[[2]], sets_iHS[[3]])) |> length()

str(sets_iHS)

gg.sets_iHS <- 
  ggvenn(
    data=sets_iHS, 
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
  labs(title="229 Candidate Regions (iHS)", tag="(b)") + 
  theme(plot.caption=element_text(size=13, hjust=0.5), plot.title=element_text(size=15, hjust=0.5), plot.tag=element_text(size=15))
gg.sets_iHS

ggsave(plot=gg.sets_iHS, filename="iHS.100Kb.venn.png", bg="white", device=png, width=5, height=5, units="in", dpi=300)
ggsave(plot=gg.sets_iHS, filename="iHS.100Kb.venn.pdf", bg="white", device=cairo_pdf, width=5, height=5, units="in")


############################################################################
## end
############################################################################





























gg <- 
  ggplot(dot1, aes(x=BPcum, y=PROP_OUTLIERS)) +
  geom_point(aes(color=as.factor(CHROM)), shape=1, size=1) +
  scale_color_manual(values=rep(brewpal2x$COLORX[1:2], times=11)) +
  geom_hline(aes(yintercept=UPPER_PROP_OUTLIERS), color=brewpal2x$COLORX[4], linewidth=0.5, linetype="dashed") +
  scale_x_continuous(
    expand=expansion(mult=c(0.005, 0.005)),
    label=1:22,
    breaks=axisdf1$center) +
  scale_y_continuous(n.breaks=7) +
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


dot <- bind_rows(NorteHumboldt, Mendocino, SantaBarbara)

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


#
outliers.1 <- filter(NorteHumboldt, RANK_ABS_iHS>=0.99) |> arrange(CHROM, POS) |> mutate(id=paste(CHROM, POS, sep=":"))
outliers.2 <- filter(Mendocino, RANK_ABS_iHS>=0.99) |> arrange(CHROM, POS) |> mutate(id=paste(CHROM, POS, sep=":"))
outliers.3 <- filter(SantaBarbara, RANK_ABS_iHS>=0.99) |> arrange(CHROM, POS) |> mutate(id=paste(CHROM, POS, sep=":"))

intersect(outliers.1$id, outliers.2$id)
intersect(outliers.2$id, outliers.3$id)
intersect(outliers.1$id, outliers.3$id)

#

group_by(dot, POP, CHROM) |> summarise(MAX_ABS_iHS=max(ABS_iHS))

## group_by(dot1, POP, CHROM) |> 
##   slice_max(MAX_SCORE, n=10) |> 
##   arrange(POP, CHROM, WINDOW) |> 
##   select(CHROM, WINDOW, MAX_SCORE, POP, BPcum) |> 
##   write_tsv(file="top10perChr.tsv")

## mutate(dot, WINDOW=cut(POS, breaks=windows, labels=windows[-543])) |> 
##   group_by(POP, CHROM, WINDOW) |> 
##   summarise(
##     N_SCORES=n(), 
##     MAX_SCORE=max(ABS_iHS)) |>
##   slice_max(MAX_SCORE, n=5) |> 
##   arrange(POP, CHROM, WINDOW) |> 
##   write_tsv(file="top5perChr.tsv")

mutate(dot, WINDOW=cut(POS, breaks=windows, labels=windows[-543])) |> 
  group_by(POP, CHROM, WINDOW) |> 
  summarise(
    N_SCORES=n(), 
    MIN_SCORE=min(ABS_iHS), 
    MAX_SCORE=max(ABS_iHS)) |>
#  slice_max(MAX_SCORE, n=10) |> 
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


# 
outliers.1 <- 
  group_by(outliers.1, CHROM) |> 
  mutate(`next`=lead(POS)-POS, new=`next`>100000) |> 
  select(ABS_iHS, POP, CHROM, POS, id, `next`, new)

outliers.2 <- 
  group_by(outliers.2, CHROM) |> 
  mutate(`next`=lead(POS)-POS, new=`next`>100000) |> 
  select(ABS_iHS, POP, CHROM, POS, id, `next`, new)

outliers.3 <- 
  group_by(outliers.3, CHROM) |> 
  mutate(`next`=lead(POS)-POS, new=`next`>100000) |> 
  select(ABS_iHS, POP, CHROM, POS, id, `next`, new)

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

write_tsv(outliers.123, file="outliers.p01.tsv")



# windows
outliers.1 <- filter(NorteHumboldt100, RANK_PROP_CRIT>=0.99) |> arrange(CHROM, WINDOW) |> mutate(id=paste(CHROM, WINDOW, sep=":"))
outliers.2 <- filter(Mendocino100, RANK_PROP_CRIT>=0.99) |> arrange(CHROM, WINDOW) |> mutate(id=paste(CHROM, WINDOW, sep=":"))
outliers.3 <- filter(SantaBarbara100, RANK_PROP_CRIT>=0.99) |> arrange(CHROM, WINDOW) |> mutate(id=paste(CHROM, WINDOW, sep=":"))

intersect(outliers.1$id, outliers.2$id)
intersect(outliers.2$id, outliers.3$id)
intersect(outliers.1$id, outliers.3$id)

#
sets_iHS <- 
  list(
    `Del Norte-Humboldt`=pull(outliers.1, id),
    Mendocino=pull(outliers.2, id),
    `Santa Barbara`=pull(outliers.3, id))

unique(c(sets_iHS[[1]], sets_iHS[[2]], sets_iHS[[3]])) |> length()

str(sets_iHS)

gg.sets_iHS <- 
  ggvenn(
    data=sets_iHS, 
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
  labs(title="203 Outlier Windows (iHS)", tag="b)") + 
  theme(plot.caption=element_text(size=13, hjust=0.5), plot.title=element_text(size=15, hjust=0.5), plot.tag=element_text(size=15))
gg.sets_iHS

ggsave(plot=gg.sets_iHS, filename="PROP_CRIT.venn.png", bg="white", device=png, width=5, height=5, units="in", dpi=300)
ggsave(plot=gg.sets_iHS, filename="PROP_CRIT.venn.pdf", bg="white", device=cairo_pdf, width=5, height=5, units="in")




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

write_tsv(outliers.123, file="outliers.PROP_CRIT.tab")
