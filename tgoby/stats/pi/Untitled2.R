library(tidyverse)
library(ggthemes)

setwd(dir="/Volumes/Tigrigobius/tgoby/stats/pi/")

filename <- dir(pattern="*.1250159.windowed.pi")

dat <- 
  filename |> 
  map(\(filename) read_tsv(file=filename) |> 
        mutate(TEST=gsub(".1250159.windowed.pi", "", filename))) |> 
  reduce(rbind)

labs <- 
  c("Del Norte-Humboldt", 
    "Del Norte-Humboldt", 
    "Del Norte-Humboldt", 
    "Del Norte-Humboldt", 
    "Del Norte-Humboldt", 
    "Del Norte-Humboldt", 
    "Mendocino", 
    "Mendocino", 
    "Mendocino", 
    "Mendocino", 
    "Santa Barbara", 
    "Santa Barbara", 
    "Santa Barbara", 
    "Santa Barbara")

levs <- 
  c("2011Tillas", 
    "2011Earl", 
    "2006Stone", 
    "2021Stone", 
    "2006Big", 
    "2021Big", 
    "2006Virgin", 
    "2021Virgin",
    "2006Pudding", 
    "2021Pudding", 
    "2017Antonio", 
    "2017Ynez", 
    "2014Burro", 
    "2014Paredon")

dat$POP <- factor(dat$TEST, labels=labs, levels=levs, ordered=TRUE)
dat$TEST <- factor(dat$TEST, levels=levs, ordered=TRUE)

dat <- group_by(dat, TEST) |> mutate(RANK_PI=percent_rank(PI))

summarise(dat, MAX_PI=max(PI)) |> arrange(MAX_PI)

write_tsv(dat, file="pi.populations.tab")



unique(dat$SNP) |> length()

group_by(dat, TEST, PI) |> 
  summarise(
    N_SNPS=n()) |> 
  arrange(TEST) |>
  print(n=100)


dot <- 
  group_by(dat, TEST) |> 
  summarise(
#    N_SNPS=n(), 
#    PROP_POLY=round(N_SNPS/1250159, digits=3), 
    PROP_POLY=, 
    MEAN_PI=mean(PI)|>round(digits=3), 
    SD_PI=sd(PI)|>round(digits=3)) |> 
  arrange(TEST)

write_tsv(dot, file="site.pi.tab")


d1 <- read_tsv(file="NorteHumboldt.mac.100Kb-20Kb.windowed.pi")
d2 <- read_tsv(file="Mendocino.mac.100Kb-20Kb.windowed.pi")
d3 <- read_tsv(file="SantaBarbara.mac.100Kb-20Kb.windowed.pi")


filename2 <- dir(pattern="*.mac1.windowed.pi")

dat2 <- 
  filename2 |> 
  map(\(filename2) read_tsv(file=filename2) |> 
        mutate(TEST=gsub(".mac1.windowed.pi", "", filename2))) |> 
  reduce(rbind)

dat2 <- filter(dat2, !grepl("2006", TEST))

dat2$TEST <- factor(dat2$TEST, levels=levs[c(-3, -5, -7, -9)], ordered=TRUE)

dot2 <- 
  group_by(dat2, TEST) |> 
  summarise(
    N_WINDOWS=n(),
    N_SNPS=sum(N_VARIANTS, na.rm=TRUE),
    PROP_POLY=round(N_SNPS/1250159, digits=3), 
    MEAN_SNP_DENSITY_100Kb=mean(N_VARIANTS, na.rm=TRUE)|>round(digits=1),
    SD_SNP_DENSITY_100Kb=sd(N_VARIANTS, na.rm=TRUE)|>round(digits=1),
    SE_SNP_DENSITY_100Kb=SD_SNP_DENSITY_100Kb/sqrt(N_WINDOWS),
    MEAN_PI_100Kb=mean(PI, na.rm=TRUE)|>round(digits=6), 
    SD_PI_100Kb=sd(PI, na.rm=TRUE)|>round(digits=6),
    SE_PI_100Kb=SD_PI_100Kb/sqrt(N_WINDOWS)) |> 
  arrange(TEST)

write_tsv(dot2, file="window.pi.tab")

dot2$TEST <- fct_rev(dot2$TEST)

brewpal <- read_tsv(file="../../brewpal2.tab")

dot2$COLOR <- rev(brewpal$COLOR1)

ggplot(data=dot2, mapping=aes(x=TEST, y=MEAN_PI_100Kb, ymin=MEAN_PI_100Kb-(2*SE_PI_100Kb), ymax=MEAN_PI_100Kb+(2*SE_PI_100Kb), color=I(COLOR))) + 
  geom_pointrange() + 
  coord_flip(clip="off") +
  scale_y_continuous(n.breaks=5) +
  labs(x=NULL, y="Nucleotide diversity") +
  theme_classic(base_size=12) +
  theme(
    axis.ticks.y=element_blank(),
    axis.text.y=element_blank(),
    axis.line.y=element_blank(), 
    line=element_line(lineend="square"),
    axis.ticks.length=unit(1, units="mm"),
    plot.background=element_rect(linetype="blank"))

g <- 
  ggplot(data=dot2, mapping=aes(x=TEST, y=MEAN_SNP_DENSITY_100Kb, ymin=MEAN_SNP_DENSITY_100Kb-(2*SE_SNP_DENSITY_100Kb), ymax=MEAN_SNP_DENSITY_100Kb+(2*SE_SNP_DENSITY_100Kb), color=I(COLOR))) + 
  geom_pointrange() + 
  coord_flip(clip="off") +
  scale_y_continuous(n.breaks=4) +
  labs(x=NULL, y="SNPs (100 Kb)") +
  theme_classic(base_size=12) +
  theme(
    panel.grid.major.x=element_line(linetype=3),
    axis.ticks.y=element_blank(),
    axis.text.y=element_blank(),
    axis.title.x=element_text(face="plain"),
    axis.line.y=element_blank(), 
    line=element_line(lineend="square"),
    axis.ticks.length=unit(1, units="mm"),
    plot.background=element_rect(linetype="blank"))
g

ggsave(filename="../../talk/snps.pdf", device=cairo_pdf, width=2, height=9, units="in")

gg <- 
  ggplot(data=dot2, mapping=aes(x=TEST, y=MEAN_PI_100Kb, ymin=MEAN_PI_100Kb-(2*SE_PI_100Kb), ymax=MEAN_PI_100Kb+(2*SE_PI_100Kb), color=I(COLOR))) + 
  geom_pointrange() + 
  coord_flip(clip="off") +
  scale_y_continuous(n.breaks=5) +
  labs(x=NULL, y="π (100 Kb)") +
  theme_classic(base_size=12) +
  theme(
    panel.grid.major.x=element_line(linetype=3),
    axis.ticks.y=element_blank(),
    axis.text.x=element_text(hjust=0.4),
    axis.text.y=element_blank(),
    axis.title.x=element_text(face="plain"),
    axis.line.y=element_blank(), 
    line=element_line(lineend="square"),
    axis.ticks.length=unit(1, units="mm"),
    plot.background=element_rect(linetype="blank"))
gg

ggsave(filename="../../talk/nucleotide_diversity.pdf", device=cairo_pdf, width=2, height=9, units="in")

