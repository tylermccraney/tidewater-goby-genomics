library(tidyverse)
library(ggthemes)

setwd(dir="/Volumes/Tigrigobius/tgoby/stats/pi/")

filename <- dir(pattern="*.windowed.pi")

filename <- filename[c(1,3,5)]

dat <- 
  filename |> 
  map(\(filename) read_tsv(file=filename) |> 
        mutate(TEST=gsub(".windowed.pi", "", filename))) |> 
  reduce(rbind)

dat <- 
  mutate(dat, TEST=gsub(pattern="recode.", replacement="", x=TEST)) |> 
  mutate(TEST=gsub(pattern=".100Kb-20Kb", replacement="", x=TEST)) |>
  filter(N_VARIANTS>=10)

dot <- 
  dat |>
  mutate(stop=BIN_START+100000) |>
  group_by(CHROM) |> 
  summarise(chr_len=max(stop)) |> 
  mutate(tot=cumsum(chr_len)-chr_len) |>
  select(-chr_len) |>
  left_join(dat, ., by="CHROM") |>
  arrange(CHROM, BIN_START) |>
  mutate(BPcum=BIN_START+tot) |> select(-tot)

axisdf <- 
  dot |> 
  group_by(CHROM) |> 
  summarize(center=(max(BPcum)+min(BPcum))/2)

NorteHumboldt <- filter(dot, TEST=="NorteHumboldt")
Mendocino <- filter(dot, TEST=="Mendocino")
SantaBarbara <- filter(dot, TEST=="SantaBarbara")

NorteHumboldt <- 
  mutate(NorteHumboldt, RANK=cume_dist(PI), SNP_RANK=cume_dist(N_VARIANTS)) |>
  mutate(POS=RANK>=0.995, NEG=RANK<=0.005, SNP_POS=SNP_RANK>=0.995, SNP_NEG=SNP_RANK<=0.005)
Mendocino <- 
  mutate(Mendocino, RANK=cume_dist(PI), SNP_RANK=cume_dist(N_VARIANTS)) |>
  mutate(POS=RANK>=0.995, NEG=RANK<=0.005, SNP_POS=SNP_RANK>=0.995, SNP_NEG=SNP_RANK<=0.005)
SantaBarbara <- 
  mutate(SantaBarbara, RANK=cume_dist(PI), SNP_RANK=cume_dist(N_VARIANTS)) |>
  mutate(POS=RANK>=0.995, NEG=RANK<=0.005, SNP_POS=SNP_RANK>=0.995, SNP_NEG=SNP_RANK<=0.005)

dd <- 
  tibble(
    X=c("NorteHumboldt", "Mendocino", "SantaBarbara"), 
    UPPER=c(
      filter(NorteHumboldt, POS==TRUE)|>pull(PI)|>min(), 
      filter(Mendocino, POS==TRUE)|>pull(PI)|>min(), 
      filter(SantaBarbara, POS==TRUE)|>pull(PI)|>min()), 
    LOWER=c(
      filter(NorteHumboldt, NEG==TRUE)|>pull(PI)|>max(), 
      filter(Mendocino, NEG==TRUE)|>pull(PI)|>max(), 
      filter(SantaBarbara, NEG==TRUE)|>pull(PI)|>max()),
    SNP_UPPER=c(
      filter(NorteHumboldt, SNP_POS==TRUE)|>pull(N_VARIANTS)|>min(), 
      filter(Mendocino, SNP_POS==TRUE)|>pull(N_VARIANTS)|>min(), 
      filter(SantaBarbara, SNP_POS==TRUE)|>pull(N_VARIANTS)|>min()), 
    SNP_LOWER=c(
      filter(NorteHumboldt, SNP_NEG==TRUE)|>pull(N_VARIANTS)|>max(), 
      filter(Mendocino, SNP_NEG==TRUE)|>pull(N_VARIANTS)|>max(), 
      filter(SantaBarbara, SNP_NEG==TRUE)|>pull(N_VARIANTS)|>max()))



ddd <- 
  bind_rows(NorteHumboldt, Mendocino, SantaBarbara) |> rename(X=TEST) |> 
  left_join(y=dd)

ddd$X <- 
  factor(
    ddd$X, 
    levels=c("NorteHumboldt", "Mendocino", "SantaBarbara"), 
    labels=c("Del Norte-Humboldt", "Mendocino", "Santa Barbara"), 
    ordered=TRUE)

summary(ddd)

brewpal2 <- read_tsv(file="../../brewpal2.tab")
brewpal2x <- read_tsv(file="../../brewpal2x.tab")
barplot(1:9, col=brewpal2x$COLORX)

g <- 
  ggplot(data=ddd, mapping=aes(x=PI)) + 
  geom_histogram(bins=20, linewidth=0.5, fill="lightgray", color="black") + 
  facet_wrap(facets=vars(X), ncol=1, nrow=3, scales="fixed") +
  geom_vline(aes(xintercept=LOWER), lty=2, color=brewpal2x$COLORX[4], linewidth=0.5) +
  geom_vline(aes(xintercept=UPPER), lty=2, color=brewpal2x$COLORX[4], linewidth=0.5) +
  theme_base(base_size=10) +
  labs(x="π", y="Frequency", size=10) +
  scale_x_log10() +
#  scale_x_continuous(breaks=seq(from=-2, to=8, by=2)) +
  scale_y_continuous(expand=expansion(mult=c(0.005, 0.05))) +
  theme(axis.title.x=element_text(face="italic"),
    line=element_line(lineend="square"),
    axis.text=element_text(size=10), 
    axis.title=element_text(size=10),
    axis.ticks.length=unit(1, units="mm"),
    axis.line.y.left=element_line(),
    panel.background=element_rect(linetype="blank"),
    panel.border=element_rect(linetype="blank"),
    plot.background=element_rect(linetype="blank"),
    strip.text=element_text(size=10, hjust=1))

ggsave(plot=g, filename="PI.100Kb-20Kb.png", device=png, width=3, height=5, units="in", dpi=300)

ggsave(plot=g, filename="PI.100Kb-20Kb.pdf", device=cairo_pdf, width=3, height=5, units="in")

saveRDS(object=ddd, file="PI.100Kb-20Kb.RDS")


gSNP <- 
  ggplot(data=ddd, mapping=aes(x=N_VARIANTS)) + 
  geom_histogram(bins=20, linewidth=0.5, fill="lightgray", color="black") + 
  facet_wrap(facets=vars(X), ncol=1, nrow=3, scales="fixed") +
  geom_vline(aes(xintercept=SNP_LOWER), lty=2, color=brewpal2x$COLORX[4], linewidth=0.5) +
  geom_vline(aes(xintercept=SNP_UPPER), lty=2, color=brewpal2x$COLORX[4], linewidth=0.5) +
  theme_base(base_size=10) +
  labs(x="SNPs", y="Frequency", size=10) +
  scale_x_log10() +
#  scale_x_continuous(breaks=seq(from=-2, to=8, by=2)) +
  scale_y_continuous(expand=expansion(mult=c(0.005, 0.05))) +
  theme(
    line=element_line(lineend="square"),
    axis.text=element_text(size=10), 
    axis.title=element_text(size=10),
    axis.ticks.length=unit(1, units="mm"),
    axis.line.y.left=element_line(),
    panel.background=element_rect(linetype="blank"),
    panel.border=element_rect(linetype="blank"),
    plot.background=element_rect(linetype="blank"),
    strip.text=element_text(size=10, hjust=1))

ggsave(plot=gSNP, filename="SNP.100Kb-20Kb.png", device=png, width=3, height=5, units="in", dpi=300)

ggsave(plot=gSNP, filename="SNP.100Kb-20Kb.pdf", device=cairo_pdf, width=3, height=5, units="in")


## dot0 <- dot|>filter(BIN_START%in%seq(from=1, to=max(dot$BIN_START), by=100000))
## 
## NorteHumboldt0 <- filter(dot0, TEST=="NorteHumboldt")
## Mendocino0 <- filter(dot0, TEST=="Mendocino")
## SantaBarbara0 <- filter(dot0, TEST=="SantaBarbara")
## 
## NorteHumboldt0 <- 
##   mutate(NorteHumboldt0, RANK=cume_dist(PI)) |>
##   mutate(POS=RANK<=0.005, NEG=RANK>=0.995)
## Mendocino0 <- 
##   mutate(Mendocino0, RANK=cume_dist(PI)) |>
##   mutate(POS=RANK<=0.005, NEG=RANK>=0.995)
## SantaBarbara0 <- 
##   mutate(SantaBarbara0, RANK=cume_dist(PI)) |>
##   mutate(POS=RANK<=0.005, NEG=RANK>=0.995)
## 
## dd0 <- 
##   tibble(
##     X=c("NorteHumboldt", "Mendocino", "SantaBarbara"), 
##     UPPER=c(
##       filter(NorteHumboldt0, POS==TRUE)|>pull(PI)|>min(), 
##       filter(Mendocino0, POS==TRUE)|>pull(PI)|>min(), 
##       filter(SantaBarbara0, POS==TRUE)|>pull(PI)|>min()), 
##     LOWER=c(
##       filter(NorteHumboldt0, NEG==TRUE)|>pull(PI)|>max(), 
##       filter(Mendocino0, NEG==TRUE)|>pull(PI)|>max(), 
##       filter(SantaBarbara0, NEG==TRUE)|>pull(PI)|>max()))
## 
## 
## 
## ddd0 <- 
##   bind_rows(NorteHumboldt0, Mendocino0, SantaBarbara0) |> rename(X=TEST) |> 
##   left_join(y=dd0)
## 
## ddd0$X <- 
##   factor(
##     ddd0$X, 
##     levels=c("NorteHumboldt", "Mendocino", "SantaBarbara"), 
##     labels=c("Del Norte-Humboldt", "Mendocino", "Santa Barbara"), 
##     ordered=TRUE)
## 
## g0 <- 
##   ggplot(
##     data=ddd0, 
##     mapping=aes(x=PI)) + 
##   geom_histogram(bins=15, linewidth=0.5, fill="lightgray", color="black") + 
##   facet_wrap(facets=vars(X), ncol=1, nrow=3, scales="fixed") +
##   geom_vline(aes(xintercept=LOWER), lty=2, color=brewpal2x$COLORX[4], linewidth=0.5) +
##   geom_vline(aes(xintercept=UPPER), lty=2, color=brewpal2x$COLORX[4], linewidth=0.5) +
##   theme_base(base_size=10) +
##   labs(x="\u03C0", y="Frequency", size=10) +
##   scale_x_log10() +
##   scale_y_continuous(expand=expansion(mult=c(0.005, 0.05))) +
##   theme(
##     line=element_line(lineend="square"),
##     axis.text=element_text(size=10), 
##     axis.title=element_text(size=10),
##     axis.ticks.length=unit(1, units="mm"),
##     axis.line.y.left=element_line(),
##     panel.background=element_rect(linetype="blank"),
##     panel.border=element_rect(linetype="blank"),
##     plot.background=element_rect(linetype="blank"),
##     strip.text=element_text(size=10, hjust=1))
## 
## ggsave(plot=g0, filename="PI.100Kb.png", device=png, width=3, height=5, units="in", dpi=300)
## 
## ggsave(plot=g0, filename="PI.100Kb.pdf", device=cairo_pdf, width=3, height=5, units="in")
## 
## saveRDS(object=ddd0, file="PI.100Kb.RDS")
## 
## qq <- 
##   ggplot(
##     data=ddd, 
##     mapping=aes(sample=PI, group=X)) + 
##   geom_qq(shape=1, distribution=stats::qlnorm) +
##   geom_qq_line(distribution=stats::qlnorm) + 
##   facet_wrap(facets=vars(X), ncol=1, nrow=3, scales="fixed") +
##   theme_base(base_size=10) +
##   theme(
##     line=element_line(lineend="square"),
##     axis.text=element_text(size=10), 
##     axis.title=element_text(size=10),
##     axis.ticks.length=unit(1, units="mm"),
##     plot.background=element_rect(linetype="blank"),
##     strip.text=element_text(size=10, hjust=1))
## 
## ggsave(plot=qq, filename="qqPI.100Kb-10Kb.png", device=png, width=3, height=5, units="in", dpi=300)
## 
## ggsave(plot=qq, filename="qqPI.100Kb-10Kb.pdf", device=cairo_pdf, width=3, height=5, units="in")
## 
## qq0 <- 
##   ggplot(
##     data=ddd0, 
##     mapping=aes(sample=PI, group=X)) + 
##   geom_qq(shape=1, distribution=stats::qlnorm) +
##   geom_qq_line(distribution=stats::qlnorm) + 
##   facet_wrap(facets=vars(X), ncol=1, nrow=3, scales="fixed") +
##   theme_base(base_size=10) +
##   theme(
##     line=element_line(lineend="square"),
##     axis.text=element_text(size=10), 
##     axis.title=element_text(size=10),
##     axis.ticks.length=unit(1, units="mm"),
##     plot.background=element_rect(linetype="blank"),
##     strip.text=element_text(size=10, hjust=1))
## 
## ggsave(plot=qq0, filename="qqPI.100Kb.png", device=png, width=3, height=5, units="in", dpi=300)
## 
## ggsave(plot=qq0, filename="qqPI.100Kb.pdf", device=cairo_pdf, width=3, height=5, units="in")
## 
## ################################
## 
## setwd(dir="../pi-boots/")
## 
## filenameB <- dir(pattern="*.windowed.pi")
## 
## datB <- 
##   filenameB |> 
##   map(\(filenameB) read_tsv(file=filenameB) |> 
##         mutate(TEST=gsub(".windowed.pi", "", filenameB))) |> 
##   reduce(rbind)
## 
## datB <- 
##   filter(datB, !is.na(PI)) |>
##   mutate(TEST=gsub(pattern="recode.", replacement="", x=TEST)) |> 
##   mutate(TEST=gsub(pattern=".100Kb", replacement="", x=TEST)) |> 
##   mutate(CHROM=gsub(pattern="\\.1", replacement="", x=CHROM)) |> 
##   mutate(CHROM=gsub(pattern="JAPEHO0100000", replacement="", x=CHROM) |> as.double()) |> 
##   mutate(POP=str_split_i(string=TEST, pattern="\\.", i=1)) |> 
##   mutate(BOOT=str_split_i(string=TEST, pattern="\\.", i=2)|> as.double()) |>
##   select(-TEST)
## 
## dotB <- 
##   datB |>
##   mutate(stop=BIN_START+100000) |>
##   group_by(CHROM) |> 
##   summarise(chr_len=max(stop)) |> 
##   mutate(tot=cumsum(chr_len)-chr_len) |>
##   select(-chr_len) |>
##   left_join(datB, ., by="CHROM") |>
##   arrange(CHROM, BIN_START) |>
##   mutate(BPcum=BIN_START+tot) |> select(-tot)
## 
## axisdfB <- 
##   dotB |> 
##   group_by(CHROM) |> 
##   summarize(center=(max(BPcum)+min(BPcum))/2)
## 
## dotB |>
##   mutate(stop=BIN_START+100000) |>
##   group_by(CHROM) |> 
##   summarise(chr_len=max(stop)) |> 
##   mutate(tot_len=cumsum(chr_len)-chr_len)
## 
## 
## NorteHumboldtB <- filter(dotB, POP=="NorteHumboldt")
## MendocinoB <- filter(dotB, POP=="Mendocino")
## SantaBarbaraB <- filter(dotB, POP=="SantaBarbara")
## 
## summary(NorteHumboldtB)
## 
## dddB <- bind_rows(NorteHumboldtB, MendocinoB, SantaBarbaraB) |> rename(X=POP)
## 
## 
## dddB$X <- 
##   factor(
##     dddB$X, 
##     ordered=TRUE, 
##     levels=c("NorteHumboldt", "Mendocino", "SantaBarbara"), 
##     labels=c("Del Norte-Humboldt", "Mendocino", "Santa Barbara"))
## 
## dddB <- 
##   left_join(
##     x=dddB, 
##     y=group_by(dddB, CHROM, BIN_START, X) |> 
##       summarise(
##         BOOT_LOWER=quantile(x=PI, probs=c(0.005)), 
##         BOOT_UPPER=quantile(x=PI, probs=c(0.995)),
##         SNP_BOOT_LOWER=quantile(x=N_VARIANTS, probs=c(0.005)), 
##         SNP_BOOT_UPPER=quantile(x=N_VARIANTS, probs=c(0.995))) |> 
##       arrange(CHROM, BIN_START), 
##     by=c("CHROM", "BIN_START", "X"))
## 
## dddB <- 
##   left_join(
##     y=dddB|>distinct(X, BPcum, .keep_all=TRUE) |> select(X, BPcum, BOOT_LOWER, BOOT_UPPER, SNP_BOOT_LOWER, SNP_BOOT_UPPER), 
##     x=ddd)
## 
## barplot(1:9, col=brewpal2x$COLORX)
## 
## axisdfB


gg <- 
  ggplot(data=ddd, aes(x=BPcum, y=PI)) +
  geom_step(mapping=aes(color=as.factor(CHROM), group=as.factor(CHROM)), linewidth=0.5) +
  geom_hline(data=ddd, aes(yintercept=UPPER), lty=2, color=brewpal2x$COLORX[4], linewidth=0.5) +
  geom_hline(data=ddd, aes(yintercept=LOWER), lty=2, color=brewpal2x$COLORX[4], linewidth=0.5) +
#  geom_point(aes(color=as.factor(CHROM)), shape=20, size=0.00001) +
  scale_color_manual(values=rep(brewpal2x$COLORX[1:2], times=11)) +
  scale_x_continuous(
    expand=expansion(mult=c(0.005, 0.005)),
    label=1:22,
    breaks=axisdf$center) +
  scale_y_continuous(
    trans="log10", 
    expand=expansion(mult=c(0.005, 0.05)), 
    breaks=c(1e-05, 1e-04, 1e-03), 
    labels=c("1e-05", "1e-04", "1e-03"), 
    limits=c(1e-05, NA)) +
  labs(
    tag="a)",
    x="Chromosome", 
    y="π") +
  facet_wrap(facets=vars(X), nrow=3, ncol=1, scales="fixed") +
  theme_base(base_size=10) +
  theme(axis.title.y=element_text(face="italic"),
    line=element_line(lineend="square"),
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


ggsave(plot=gg, filename="K3.100Kb-20Kb.png", device=png, width=8, height=5, units="in", dpi=300)

ggsave(plot=gg, filename="K3.100Kb-20Kb.pdf", device=cairo_pdf, width=8, height=5, units="in")

saveRDS(object=ddd, file="K3.100Kb-20Kb.RDS")

#  strip.background=element_rect(fill=NA, colour="black", linewidth=0.3), 
#  stat_smooth(data=dddB|>filter(!is.na(BOOT_UPPER)), geom="area", aes(y=BOOT_UPPER), fill="lightgrey", fullrange=TRUE) +
#  stat_smooth(data=dddB|>filter(!is.na(BOOT_LOWER)), geom="area", aes(y=BOOT_LOWER), fill="lightgrey", fullrange=TRUE) +
#  stat_smooth(data=dddB|>filter(!is.na(BOOT_UPPER)), geom="ribbon", aes(y=BOOT_UPPER, ymax=after_stat(y)), ymin=0, method="gam", formula=y~s(x, bs="cs"), fill="lightgrey", fullrange=TRUE, n=3) +
#  stat_smooth(data=dddB|>filter(!is.na(BOOT_LOWER)), geom="ribbon", aes(y=BOOT_LOWER, ymin=after_stat(y)), ymax=0, method="gam", formula=y~s(x, bs="cs"), fill="lightgrey", fullrange=TRUE, n=3) +

ggSNP <- 
  ggplot(data=ddd, aes(x=BPcum, y=N_VARIANTS)) +
  geom_step(mapping=aes(color=as.factor(CHROM), group=as.factor(CHROM)), linewidth=0.5) +
  geom_hline(data=ddd, aes(yintercept=SNP_UPPER), lty=2, color=brewpal2x$COLORX[4], linewidth=0.5) +
  geom_hline(data=ddd, aes(yintercept=SNP_LOWER), lty=2, color=brewpal2x$COLORX[4], linewidth=0.5) +
#  geom_point(aes(color=as.factor(CHROM)), shape=20, size=0.1) +
  scale_color_manual(values=rep(brewpal2x$COLORX[1:2], times=11)) +
  scale_x_continuous(
    expand=expansion(mult=c(0.005, 0.005)),
    label=1:22,
    breaks=axisdf$center) +
  scale_y_continuous(expand=expansion(mult=c(0.005, 0.05)), trans="log10") +
  labs(
    tag="a)",
    x="Chromosome", 
    y="SNP") +
  facet_wrap(facets=vars(X), nrow=3, ncol=1, scales="fixed") +
  theme_base(base_size=10) +
  theme(
    line=element_line(lineend="square"),
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


ggsave(plot=ggSNP, filename="SNP_K3.100Kb-20Kb.png", device=png, width=8, height=5, units="in", dpi=300)

ggsave(plot=ggSNP, filename="SNP_K3.100Kb-20Kb.pdf", device=cairo_pdf, width=8, height=5, units="in")











outliers.1 <- filter(NorteHumboldt, RANK<=0.005) |> bind_rows(filter(NorteHumboldt, RANK>=0.995)) |> arrange(CHROM, BIN_START, BIN_END)
outliers.2 <- filter(Mendocino, RANK<=0.005) |> bind_rows(filter(Mendocino, RANK>=0.995)) |> arrange(CHROM, BIN_START, BIN_END)
outliers.3 <- filter(SantaBarbara, RANK<=0.005) |> bind_rows(filter(SantaBarbara, RANK>=0.995)) |> arrange(CHROM, BIN_START, BIN_END)

# 
outliers.1 <- 
  group_by(outliers.1, POS, NEG, CHROM) |> 
  mutate(NEXT=lead(BIN_START)-BIN_START, NEW=NEXT>100001) |> 
  select(CHROM, BIN_START, BIN_END, NEXT, NEW) |>
  arrange(POS, NEG, CHROM, BIN_START, BIN_END)

outliers.2 <- 
  group_by(outliers.2, POS, NEG, CHROM) |> 
  mutate(NEXT=lead(BIN_START)-BIN_START, NEW=NEXT>100001) |> 
  select(CHROM, BIN_START, BIN_END, NEXT, NEW) |>
  arrange(POS, NEG, CHROM, BIN_START, BIN_END)


outliers.3 <- 
  group_by(outliers.3, POS, NEG, CHROM) |> 
  mutate(NEXT=lead(BIN_START)-BIN_START, NEW=NEXT>100001) |> 
  select(CHROM, BIN_START, BIN_END, NEXT, NEW) |>
  arrange(POS, NEG, CHROM, BIN_START, BIN_END)



summary(outliers.1)
summary(outliers.2)
summary(outliers.3)

outliers.1$NEW[is.na(outliers.1$NEW)] <- TRUE
outliers.2$NEW[is.na(outliers.2$NEW)] <- TRUE
outliers.3$NEW[is.na(outliers.3$NEW)] <- TRUE

write_tsv(relocate(mutate(ungroup(outliers.1), ROW=1:nrow(outliers.1)), ROW), file="outliers.NorteHumboldt.tsv")
write_tsv(relocate(mutate(ungroup(outliers.2), ROW=1:nrow(outliers.2)), ROW), file="outliers.Mendocino.tsv")
write_tsv(relocate(mutate(ungroup(outliers.3), ROW=1:nrow(outliers.3)), ROW), file="outliers.SantaBarbara.tsv")

# manual verification of outlier intervals with spreadsheets

outliers.1 <- read_tsv(file="outliers.NorteHumboldt.tsv")
outliers.2 <- read_tsv(file="outliers.Mendocino.tsv")
outliers.3 <- read_tsv(file="outliers.SantaBarbara.tsv")

NorteHumboldt <- 
  bind_rows(
    left_join(
      x=NorteHumboldt_Mendocino, 
      y=filter(outliers.1, samplesB=="Mendocino")|>select(-row, -`next`, -new), 
      by=join_by(chr, start, stop, samplesA, samplesB)),
    left_join(
      x=NorteHumboldt_SantaBarbara, 
      y=filter(outliers.1, samplesB=="SantaBarbara")|>select(-row, -`next`, -new), 
      by=join_by(chr, start, stop, samplesA, samplesB)))

Mendocino <- 
  bind_rows(
    left_join(
      x=Mendocino_NorteHumboldt, 
      y=filter(outliers.2, samplesB=="NorteHumboldt")|>select(-row, -`next`, -new), 
      by=join_by(chr, start, stop, samplesA, samplesB)),
    left_join(
      x=Mendocino_SantaBarbara, 
      y=filter(outliers.2, samplesB=="SantaBarbara")|>select(-row, -`next`, -new), 
      by=join_by(chr, start, stop, samplesA, samplesB)))

SantaBarbara <- 
  bind_rows(
    left_join(
      x=SantaBarbara_NorteHumboldt, 
      y=filter(outliers.3, samplesB=="NorteHumboldt")|>select(-row, -`next`, -new), 
      by=join_by(chr, start, stop, samplesA, samplesB)),
    left_join(
      x=SantaBarbara_Mendocino, 
      y=filter(outliers.3, samplesB=="Mendocino")|>select(-row, -`next`, -new), 
      by=join_by(chr, start, stop, samplesA, samplesB)))

K3.outliers <- 
  bind_rows(
    list(
      NorteHumboldt, 
      Mendocino, 
      SantaBarbara), 
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






















### Tajima's D
## Watterson's theta
# THETA_W=#SNPs/(1/1 + 1/2 + 1/3 + ... + 1/(2N-1))
a1 <- (1 / seq(from=1, to=((2*36)-1), by=1)) |> sum()
a2 <- (1 / seq(from=1, to=((2*24)-1), by=1)) |> sum()
a3 <- (1 / seq(from=1, to=((2*24)-1), by=1)) |> sum()

## Create a function to calculate var(d)
## n=the number of chromosomes (2 x num. samples)
## S=# SNPs
variance.d <- function(n,S) {
  a1=sum(1/(seq(from=1, to=(n-1), by=1)))
  a2=sum(1/((seq(from=1, to=(n-1), by=1))**2))
  b1=(n+1)/(3*(n-1))
  b2=(2*((n**2)+n+3))/((9*n)*(n-1))
  c1=b1 - (1/a1)
  c2=b2-((n+2)/(a1*n)) + (a2/(a1**2))
  e1=c1/a1
  e2=c2/((a1**2)+a2)
  var=(e1*S) + (e2*S*(S-1))
  return(var)}


dddd <- 
  bind_rows(
    filter(ddd, X=="Del Norte-Humboldt") |> mutate(N_CHR=2*36, A=a1, THETA_W=N_VARIANTS/A, VAR_d=variance.d(n=2*36, S=N_VARIANTS), TajimaD=(PI-THETA_W)/sqrt(VAR_d), MU=mean(TajimaD), SIGMA=sd(TajimaD)), 
    filter(ddd, X=="Mendocino") |> mutate(N_CHR=2*24, A=a2, THETA_W=N_VARIANTS/A, VAR_d=variance.d(n=2*24, S=N_VARIANTS), TajimaD=(PI-THETA_W)/sqrt(VAR_d), MU=mean(TajimaD), SIGMA=sd(TajimaD)),
    filter(ddd, X=="Santa Barbara") |> mutate(N_CHR=2*24, A=a3, THETA_W=N_VARIANTS/A, VAR_d=variance.d(n=2*24, S=N_VARIANTS), TajimaD=(PI-THETA_W)/sqrt(VAR_d), MU=mean(TajimaD), SIGMA=sd(TajimaD)))

dddd <- mutate(dddd, TajimaD_NORM=(TajimaD-mu)/sigma)

hist(dddd$TajimaD_NORM, xlim=c(-3, 10))







