library(tidyverse)
library(ggthemes)

brewpal2 <- read_tsv(file="../brewpal2.tab")
brewpal2x <- read_tsv(file="../brewpal2x.tab")
barplot(1:9, col=brewpal2x$COLORX)

iHS <- readRDS(file="/Volumes/Tigrigobius/tgoby/windows/iHS.RDS")

iHS$POP1 <- 
  factor(
    iHS$POP1, 
    ordered=TRUE, 
    levels=c(
      "NorteHumboldt", 
      "Mendocino",
      "SantaBarbara"),
    labels=c(
      "Del Norte-Humboldt", 
      "Mendocino",
      "Santa Barbara"))

##
nSL <- readRDS(file="/Volumes/Tigrigobius/tgoby/windows/nSL.RDS")

nSL$POP1 <- 
  factor(
    nSL$POP1, 
    ordered=TRUE, 
    levels=c(
      "NorteHumboldt", 
      "Mendocino",
      "SantaBarbara"),
    labels=c(
      "Del Norte-Humboldt", 
      "Mendocino",
      "Santa Barbara"))

##
XPnSL <- readRDS(file="/Volumes/Tigrigobius/tgoby/windows/XP-nSL.RDS")

XPnSL.neg <- XPnSL

XPnSL$samplesA <- 
  factor(
    XPnSL$samplesA, 
    ordered=TRUE, 
    levels=c(
      "NorteHumboldt", 
      "Mendocino",
      "SantaBarbara"),
    labels=c(
      "Del Norte-Humboldt", 
      "Mendocino",
      "Santa Barbara"))

XPnSL$samplesB <- 
  factor(
    XPnSL$samplesB, 
    ordered=TRUE, 
    levels=c(
      "NorteHumboldt", 
      "Mendocino",
      "SantaBarbara"),
    labels=c(
      "Del Norte\nHumboldt", 
      "Mendocino",
      "Santa\nBarbara"))


##
XPCLR <- readRDS(file="/Volumes/Tigrigobius/tgoby/windows/XP-CLR.RDS")

XPCLR$samplesA <- 
  factor(
    XPCLR$samplesA, 
    ordered=TRUE, 
    levels=c(
      "NorteHumboldt", 
      "Mendocino",
      "SantaBarbara"),
    labels=c(
      "Del Norte-Humboldt", 
      "Mendocino",
      "Santa Barbara"))

XPCLR$samplesB <- 
  factor(
    XPCLR$samplesB, 
    ordered=TRUE, 
    levels=c(
      "NorteHumboldt", 
      "Mendocino",
      "SantaBarbara"),
    labels=c(
      "Del Norte\nHumboldt", 
      "Mendocino",
      "Santa\nBarbara"))


iHS.cuts <- group_by(iHS, POP1, QUAN) |> summarise(MAX_SCORE=max(N_SCORES), N_WINDOWS=n()) |> ungroup() |> filter(QUAN!=10)

gg.iHS <- 
  ggplot() + 
  geom_point(data=iHS, mapping=aes(x=N_SCORES, y=PROP_CRIT), shape=1, size=1, color=brewpal2x$COLORX[7], show.legend=FALSE) + 
  geom_point(data=filter(iHS, CANDIDATE==TRUE), mapping=aes(x=N_SCORES, y=PROP_CRIT), shape=1, size=1, color=brewpal2x$COLORX[4], show.legend=FALSE) + 
  geom_vline(data=iHS.cuts, mapping=aes(xintercept=MAX_SCORE), linetype="dashed", color=brewpal2x$COLORX[1]) + 
  facet_wrap(facets=vars(POP1), nrow=3, ncol=1) +
  scale_x_log10(expand=expansion(mult=c(0.05, 0.05))) +
  scale_y_continuous(expand=expansion(mult=c(0.05, 0.05)), n.breaks=6) +
  labs(
    tag="(a)",
    x="Number of iHS scores in window", 
    y="Proportion of |iHS| scores > 2 in window") +
  theme_base(base_size=10) +
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
gg.iHS

ggsave(plot=gg.iHS, filename="/Volumes/Tigrigobius/tgoby/windows/iHS.png", device=png, width=8, height=4, units="in", dpi=320)
ggsave(plot=gg.iHS, filename="/Volumes/Tigrigobius/tgoby/windows/iHS.pdf", device=cairo_pdf, width=8, height=4, units="in")

saveRDS(object=gg.iHS, file="/Volumes/Tigrigobius/tgoby/windows/iHSa.RDS")
saveRDS(object=gg.iHS, file="/Users/macrodontogobius/Library/CloudStorage/GoogleDrive-wtm3@humboldt.edu/My Drive/tgoby/fig2/iHSa.RDS")


nSL.cuts <- group_by(nSL, POP1, QUAN) |> summarise(MAX_SCORE=max(N_SCORES), N_WINDOWS=n()) |> ungroup() |> filter(QUAN!=10)

gg.nSL <-
  ggplot() + 
  geom_point(data=nSL, mapping=aes(x=N_SCORES, y=PROP_CRIT), shape=1, size=1, color=brewpal2x$COLORX[7], show.legend=FALSE) + 
  geom_point(data=filter(nSL, CANDIDATE==TRUE), mapping=aes(x=N_SCORES, y=PROP_CRIT), shape=1, size=1, color=brewpal2x$COLORX[4], show.legend=FALSE) + 
  geom_vline(data=nSL.cuts, mapping=aes(xintercept=MAX_SCORE), linetype="dashed", color=brewpal2x$COLORX[1]) + 
  facet_wrap(facets=vars(POP1), nrow=3, ncol=1) +
  scale_x_log10(expand=expansion(mult=c(0.05, 0.05))) +
  scale_y_continuous(expand=expansion(mult=c(0.05, 0.05)), n.breaks=6) +
  labs(
    tag="(a)",
    x="Number of nSL scores in window", 
    y="Proportion of |nSL| scores > 2 in window") +
  theme_base(base_size=10) +
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
gg.nSL

ggsave(plot=gg.nSL, filename="/Volumes/Tigrigobius/tgoby/windows/nSL.png", device=png, width=8, height=4, units="in", dpi=320)
ggsave(plot=gg.nSL, filename="/Volumes/Tigrigobius/tgoby/windows/nSL.pdf", device=cairo_pdf, width=8, height=4, units="in")

saveRDS(object=gg.nSL, file="/Volumes/Tigrigobius/tgoby/windows/nSLa.RDS")
saveRDS(object=gg.nSL, file="/Users/macrodontogobius/Library/CloudStorage/GoogleDrive-wtm3@humboldt.edu/My Drive/tgoby/fig2/nSLa.RDS")



XPnSL.cuts <- 
  group_by(XPnSL, samplesA, samplesB, QUAN) |> summarise(MAX_SCORE=max(N_SCORES), N_WINDOWS=n()) |> ungroup() |> filter(QUAN!=10)

gg.XPnSL <-
  ggplot() + 
  geom_point(data=XPnSL, mapping=aes(x=N_SCORES, y=PROP_CRIT1), shape=1, size=1, color=brewpal2x$COLORX[7], show.legend=FALSE) + 
  geom_point(data=filter(XPnSL, CANDIDATE1==TRUE), mapping=aes(x=N_SCORES, y=PROP_CRIT1), shape=1, size=1, color=brewpal2x$COLORX[4], show.legend=FALSE) + 
  geom_vline(data=XPnSL.cuts, mapping=aes(xintercept=MAX_SCORE), linetype="dashed", color=brewpal2x$COLORX[1]) + 
  facet_grid(rows=vars(samplesB), cols=vars(samplesA), scales="fixed") +
  scale_x_log10(expand=expansion(mult=c(0.01, 0.01))) +
  scale_y_continuous(expand=expansion(mult=c(0.1, 0.1)), n.breaks=7) +
  labs(
    tag="(a)",
    x="Number of XP-nSL scores in window", 
    y="Proportion of XP-nSL scores > 2 in window") +
  theme_base(base_size=10) +
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
gg.XPnSL

ggsave(plot=gg.XPnSL, filename="/Volumes/Tigrigobius/tgoby/windows/XP-nSL.png", device=png, width=17, height=4, units="in", dpi=320)
ggsave(plot=gg.XPnSL, filename="/Volumes/Tigrigobius/tgoby/windows/XP-nSL.pdf", device=cairo_pdf, width=17, height=4, units="in")

saveRDS(object=gg.XPnSL, file="/Volumes/Tigrigobius/tgoby/windows/XP-nSLa.RDS")
saveRDS(object=gg.XPnSL, file="/Users/macrodontogobius/Library/CloudStorage/GoogleDrive-wtm3@humboldt.edu/My Drive/tgoby/fig2/XP-nSLa.RDS")

XPnSL.neg$samplesB <- 
  factor(
    XPnSL.neg$samplesB, 
    ordered=TRUE, 
    levels=c(
      "NorteHumboldt", 
      "Mendocino",
      "SantaBarbara"),
    labels=c(
      "Del Norte-Humboldt", 
      "Mendocino",
      "Santa Barbara"))

XPnSL.neg$samplesA <- 
  factor(
    XPnSL.neg$samplesA, 
    ordered=TRUE, 
    levels=c(
      "NorteHumboldt", 
      "Mendocino",
      "SantaBarbara"),
    labels=c(
      "Del Norte\nHumboldt", 
      "Mendocino",
      "Santa\nBarbara"))

XPnSL.neg.cuts <- 
  group_by(XPnSL.neg, samplesA, samplesB, QUAN) |> summarise(MAX_SCORE=max(N_SCORES), N_WINDOWS=n()) |> ungroup() |> filter(QUAN!=10)


gg.XPnSL.neg <-
  ggplot() + 
  geom_point(data=XPnSL.neg, mapping=aes(x=N_SCORES, y=PROP_CRIT2), shape=1, size=1, color=brewpal2x$COLORX[7], show.legend=FALSE) + 
  geom_point(data=filter(XPnSL.neg, CANDIDATE2==TRUE), mapping=aes(x=N_SCORES, y=PROP_CRIT2), shape=1, size=1, color=brewpal2x$COLORX[4], show.legend=FALSE) + 
  geom_vline(data=XPnSL.neg.cuts, mapping=aes(xintercept=MAX_SCORE), linetype="dashed", color=brewpal2x$COLORX[1]) + 
  facet_grid(rows=vars(samplesA), cols=vars(samplesB), scales="fixed") +
  scale_x_log10(expand=expansion(mult=c(0.01, 0.01))) +
  scale_y_continuous(expand=expansion(mult=c(0.1, 0.1)), n.breaks=7) +
  labs(
    tag="(a)",
    x="Number of XP-nSL scores in window", 
    y="Proportion of XP-nSL scores < -2 in window") +
  theme_base(base_size=10) +
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
gg.XPnSL.neg

ggsave(plot=gg.XPnSL.neg, filename="/Volumes/Tigrigobius/tgoby/windows/-XP-nSL.png", device=png, width=17, height=4, units="in", dpi=320)
ggsave(plot=gg.XPnSL.neg, filename="/Volumes/Tigrigobius/tgoby/windows/-XP-nSL.pdf", device=cairo_pdf, width=17, height=4, units="in")

saveRDS(object=gg.XPnSL.neg, file="/Volumes/Tigrigobius/tgoby/windows/-XP-nSLa.RDS")
saveRDS(object=gg.XPnSL.neg, file="/Users/macrodontogobius/Library/CloudStorage/GoogleDrive-wtm3@humboldt.edu/My Drive/tgoby/fig2/-XP-nSLa.RDS")


XPCLR.cuts <- 
  group_by(XPCLR, samplesA, samplesB, QUAN) |> summarise(MAX_SCORE=max(nSNPs), N_WINDOWS=n()) |> ungroup() |> filter(QUAN!=10)

gg.XPCLR <-
  ggplot() + 
  geom_point(data=XPCLR, mapping=aes(x=nSNPs, y=xpclr_norm), shape=1, size=1, color=brewpal2x$COLORX[7], show.legend=FALSE) + 
  geom_point(data=filter(XPCLR, CANDIDATE==TRUE), mapping=aes(x=nSNPs, y=xpclr_norm), shape=1, size=1, color=brewpal2x$COLORX[4], show.legend=FALSE) + 
  geom_vline(data=XPCLR.cuts, mapping=aes(xintercept=MAX_SCORE), linetype="dashed", color=brewpal2x$COLORX[1]) + 
  facet_grid(rows=vars(samplesB), cols=vars(samplesA), scales="fixed") +
  scale_x_log10(expand=expansion(mult=c(0.03, 0.03))) +
  scale_y_continuous(expand=expansion(mult=c(0.05, 0.05)), n.breaks=7) +
  labs(
    tag="(a)",
    x="Number of sites in window", 
    y="XP-CLR") +
  theme_base(base_size=10) +
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
gg.XPCLR

ggsave(plot=gg.XPCLR, filename="/Volumes/Tigrigobius/tgoby/windows/XP-CLR.png", device=png, width=17, height=4, units="in", dpi=320)
ggsave(plot=gg.XPCLR, filename="/Volumes/Tigrigobius/tgoby/windows/XP-CLR.pdf", device=cairo_pdf, width=17, height=4, units="in")

saveRDS(object=gg.XPCLR, file="/Volumes/Tigrigobius/tgoby/windows/XP-CLRa.RDS")
saveRDS(object=gg.XPCLR, file="/Users/macrodontogobius/Library/CloudStorage/GoogleDrive-wtm3@humboldt.edu/My Drive/tgoby/fig2/XP-CLRa.RDS")

#
library(ggvenn)

iHS <- unite(data=iHS, col="WINDOW", CHROM, START)
nSL <- unite(data=nSL, col="WINDOW", CHROM, START)
XPnSL <- unite(data=XPnSL, col="WINDOW", CHROM, START)
XPnSL.neg <- unite(data=XPnSL.neg, col="WINDOW", CHROM, START)


sets_iHS <- 
  list(
    `Del Norte-Humboldt`=filter(iHS, POP1=="Del Norte-Humboldt", CANDIDATE==TRUE)|>pull(WINDOW),
    Mendocino=filter(iHS, POP1=="Mendocino", CANDIDATE==TRUE)|>pull(WINDOW),
    `Santa Barbara`=filter(iHS, POP1=="Santa Barbara", CANDIDATE==TRUE)|>pull(WINDOW))

sets_nSL <- 
  list(
    `Del Norte-Humboldt`=filter(nSL, POP1=="Del Norte-Humboldt", CANDIDATE==TRUE)|>pull(WINDOW),
    Mendocino=filter(nSL, POP1=="Mendocino", CANDIDATE==TRUE)|>pull(WINDOW),
    `Santa Barbara`=filter(nSL, POP1=="Santa Barbara", CANDIDATE==TRUE)|>pull(WINDOW))

sets_XPnSL <- 
  list(
    `Del Norte-Humboldt`=filter(XPnSL, samplesA=="Del Norte-Humboldt", CANDIDATE1==TRUE)|>pull(WINDOW),
    Mendocino=filter(XPnSL, samplesA=="Mendocino", CANDIDATE1==TRUE)|>pull(WINDOW),
    `Santa Barbara`=filter(XPnSL, samplesA=="Santa Barbara", CANDIDATE1==TRUE)|>pull(WINDOW))

sets_XPnSL.neg <- 
  list(
    `Del Norte-Humboldt`=filter(XPnSL.neg, samplesB=="Del Norte-Humboldt", CANDIDATE2==TRUE)|>pull(WINDOW),
    Mendocino=filter(XPnSL.neg, samplesB=="Mendocino", CANDIDATE2==TRUE)|>pull(WINDOW),
    `Santa Barbara`=filter(XPnSL.neg, samplesB=="Santa Barbara", CANDIDATE2==TRUE)|>pull(WINDOW))


sets_XPCLR <- 
  list(
    `Del Norte-Humboldt`=filter(XPCLR, samplesA=="Del Norte-Humboldt", CANDIDATE==TRUE)|>pull(id),
    Mendocino=filter(XPCLR, samplesA=="Mendocino", CANDIDATE==TRUE)|>pull(id),
    `Santa Barbara`=filter(XPCLR, samplesA=="Santa Barbara", CANDIDATE==TRUE)|>pull(id))

##
unique(c(sets_iHS[[1]], sets_iHS[[2]], sets_iHS[[3]])) |> length()

str(sets_iHS)

gg.sets_iHS <- 
  ggvenn(
    data=sets_iHS, 
    digits=0,
    stroke_size=0.5, 
    set_name_size=4.5,
    text_size=4,
    fill_color=rep("white", 3), 
    fill_alpha=1,
    stroke_color=c(rep(x=brewpal2$COLOR1[8], times=100), rep(x=brewpal2$COLOR1[6], times=100), rep(x=brewpal2$COLOR1[4], times=100)), 
    stroke_alpha=1,
    auto_scale=FALSE) + 
  labs(title="206 Candidate Regions (iHS)", tag="(c)") + 
  theme(plot.caption=element_text(size=13, hjust=0.5), plot.title=element_text(size=15, hjust=0.5), plot.tag=element_text(size=15))

gg.sets_iHS

ggsave(plot=gg.sets_iHS, filename="/Volumes/Tigrigobius/tgoby/windows/iHS.venn.png", bg="white", device=png, width=5, height=5, units="in", dpi=320)
ggsave(plot=gg.sets_iHS, filename="/Volumes/Tigrigobius/tgoby/windows/iHS.venn.pdf", bg="white", device=cairo_pdf, width=5, height=5, units="in")

saveRDS(object=gg.sets_iHS, file="/Volumes/Tigrigobius/tgoby/windows/iHSc.RDS")
saveRDS(object=gg.sets_iHS, file="/Users/macrodontogobius/Library/CloudStorage/GoogleDrive-wtm3@humboldt.edu/My Drive/tgoby/fig2/iHSc.RDS")

unique(c(sets_nSL[[1]], sets_nSL[[2]], sets_nSL[[3]])) |> length()

str(sets_nSL)

gg.sets_nSL <- 
  ggvenn(
    data=sets_nSL, 
    digits=0,
    stroke_size=0.5, 
    set_name_size=4.5,
    text_size=4,
    fill_color=rep("white", 3), 
    fill_alpha=1,
    stroke_color=c(rep(x=brewpal2$COLOR1[8], times=100), rep(x=brewpal2$COLOR1[6], times=100), rep(x=brewpal2$COLOR1[4], times=100)), 
    stroke_alpha=1,
    auto_scale=FALSE) + 
  labs(title="227 Candidate Regions (nSL)", tag="(c)") + 
  theme(plot.caption=element_text(size=13, hjust=0.5), plot.title=element_text(size=15, hjust=0.5), plot.tag=element_text(size=15))
gg.sets_nSL

ggsave(plot=gg.sets_nSL, filename="/Volumes/Tigrigobius/tgoby/windows/nSL.venn.png", bg="white", device=png, width=5, height=5, units="in", dpi=320)
ggsave(plot=gg.sets_nSL, filename="/Volumes/Tigrigobius/tgoby/windows/nSL.venn.pdf", bg="white", device=cairo_pdf, width=5, height=5, units="in")

saveRDS(object=gg.sets_nSL, file="/Volumes/Tigrigobius/tgoby/windows/nSLc.RDS")
saveRDS(object=gg.sets_nSL, file="/Users/macrodontogobius/Library/CloudStorage/GoogleDrive-wtm3@humboldt.edu/My Drive/tgoby/fig2/nSLc.RDS")


unique(c(sets_XPnSL[[1]], sets_XPnSL[[2]], sets_XPnSL[[3]])) |> length()

str(sets_XPnSL)

gg.sets_XPnSL <- 
  ggvenn(
    data=sets_XPnSL, 
    digits=0,
    stroke_size=0.5, 
    set_name_size=4.5,
    text_size=4,
    fill_color=rep("white", 3), 
    fill_alpha=1,
    stroke_color=c(rep(x=brewpal2$COLOR1[8], times=100), rep(x=brewpal2$COLOR1[6], times=100), rep(x=brewpal2$COLOR1[4], times=100)), 
    stroke_alpha=1,
    auto_scale=FALSE) + 
  labs(title="387 Candidate Regions (XP-nSL)", tag="(c)") + 
  theme(plot.caption=element_text(size=13, hjust=0.5), plot.title=element_text(size=15, hjust=0.5), plot.tag=element_text(size=15))
gg.sets_XPnSL

ggsave(plot=gg.sets_XPnSL, filename="/Volumes/Tigrigobius/tgoby/windows/XP-nSL.venn.png", bg="white", device=png, width=5, height=5, units="in", dpi=320)
ggsave(plot=gg.sets_XPnSL, filename="/Volumes/Tigrigobius/tgoby/windows/XP-nSL.venn.pdf", bg="white", device=cairo_pdf, width=5, height=5, units="in")

saveRDS(object=gg.sets_XPnSL, file="/Volumes/Tigrigobius/tgoby/windows/XP-nSLc.RDS")
saveRDS(object=gg.sets_XPnSL, file="/Users/macrodontogobius/Library/CloudStorage/GoogleDrive-wtm3@humboldt.edu/My Drive/tgoby/fig2/XP-nSLc.RDS")

unique(c(sets_XPnSL.neg[[1]], sets_XPnSL.neg[[2]], sets_XPnSL.neg[[3]])) |> length()

str(sets_XPnSL.neg)

gg.sets_XPnSL.neg <- 
  ggvenn(
    data=sets_XPnSL.neg, 
    digits=0,
    stroke_size=0.5, 
    set_name_size=4.5,
    text_size=4,
    fill_color=rep("white", 3), 
    fill_alpha=1,
    stroke_color=c(rep(x=brewpal2$COLOR1[8], times=100), rep(x=brewpal2$COLOR1[6], times=100), rep(x=brewpal2$COLOR1[4], times=100)), 
    stroke_alpha=1,
    auto_scale=FALSE) + 
  labs(title="387 Candidate Regions (-XP-nSL)", tag="(c)") + 
  theme(plot.caption=element_text(size=13, hjust=0.5), plot.title=element_text(size=15, hjust=0.5), plot.tag=element_text(size=15))
gg.sets_XPnSL.neg

ggsave(plot=gg.sets_XPnSL.neg, filename="/Volumes/Tigrigobius/tgoby/windows/-XP-nSL.venn.png", bg="white", device=png, width=5, height=5, units="in", dpi=320)
ggsave(plot=gg.sets_XPnSL.neg, filename="/Volumes/Tigrigobius/tgoby/windows/-XP-nSL.venn.pdf", bg="white", device=cairo_pdf, width=5, height=5, units="in")



unique(c(sets_XPCLR[[1]], sets_XPCLR[[2]], sets_XPCLR[[3]])) |> length()

str(sets_XPCLR)

gg.sets_XPCLR <- 
  ggvenn(
    data=sets_XPCLR, 
    digits=0,
    stroke_size=0.5, 
    set_name_size=4.5,
    text_size=4,
    fill_color=rep("white", 3), 
    fill_alpha=1,
    stroke_color=c(rep(x=brewpal2$COLOR1[8], times=100), rep(x=brewpal2$COLOR1[6], times=100), rep(x=brewpal2$COLOR1[4], times=100)), 
    stroke_alpha=1,
    auto_scale=FALSE) + 
  labs(title="382 Candidate Regions (XP-CLR)", tag="(c)") + 
  theme(plot.caption=element_text(size=13, hjust=0.5), plot.title=element_text(size=15, hjust=0.5), plot.tag=element_text(size=15))
gg.sets_XPCLR

ggsave(plot=gg.sets_XPCLR, filename="/Volumes/Tigrigobius/tgoby/windows/XP-CLR.venn.png", bg="white", device=png, width=5, height=5, units="in", dpi=320)
ggsave(plot=gg.sets_XPCLR, filename="/Volumes/Tigrigobius/tgoby/windows/XP-CLR.venn.pdf", bg="white", device=cairo_pdf, width=5, height=5, units="in")

saveRDS(object=gg.sets_XPCLR, file="/Volumes/Tigrigobius/tgoby/windows/XP-CLRc.RDS")
saveRDS(object=gg.sets_XPCLR, file="/Users/macrodontogobius/Library/CloudStorage/GoogleDrive-wtm3@humboldt.edu/My Drive/tgoby/fig2/XP-CLRc.RDS")




# check Hsp70
PC00027 <- read_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete.redo/scrap/PC00027.tsv")
XPnSL_scores_NorteHumboldt_SantaBarbara <- 
  read_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete.redo/XP-nSL_scores_NorteHumboldt_SantaBarbara", col_names=FALSE)
XPnSL_scores_NorteHumboldt_Mendocino <- 
  read_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete.redo/XP-nSL_scores_NorteHumboldt_Mendocino", col_names=FALSE)
XPnSL_scores_Mendocino_NorteHumboldt <- 
  read_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete.redo/XP-nSL_scores_Mendocino_NorteHumboldt", col_names=FALSE)
XPnSL_scores_Mendocino_SantaBarbara <- 
  read_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete.redo/XP-nSL_scores_Mendocino_SantaBarbara", col_names=FALSE)
XPnSL_scores_SantaBarbara_NorteHumboldt <- 
  read_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete.redo/XP-nSL_scores_SantaBarbara_NorteHumboldt", col_names=FALSE)
XPnSL_scores_SantaBarbara_Mendocino <- 
  read_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete.redo/XP-nSL_scores_SantaBarbara_Mendocino", col_names=FALSE)

left_join(PC00027, XPnSL_scores_NorteHumboldt_SantaBarbara, by=join_by(PC00027==X1))|>summarise(sum(X3))
left_join(PC00027, XPnSL_scores_NorteHumboldt_Mendocino, by=join_by(PC00027==X1))|>summarise(sum(X3))
left_join(PC00027, XPnSL_scores_Mendocino_NorteHumboldt, by=join_by(PC00027==X1))|>summarise(sum(X3))
left_join(PC00027, XPnSL_scores_Mendocino_SantaBarbara, by=join_by(PC00027==X1))|>summarise(sum(X3))
left_join(PC00027, XPnSL_scores_SantaBarbara_NorteHumboldt, by=join_by(PC00027==X1))|>summarise(sum(X3))
left_join(PC00027, XPnSL_scores_SantaBarbara_Mendocino, by=join_by(PC00027==X1))|>summarise(sum(X3))
