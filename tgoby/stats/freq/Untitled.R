library(tidyverse)
library(ggthemes)
library(ggvenn)
library(gridExtra)

setwd(dir="/Volumes/Tigrigobius/tgoby/stats/")

col_names <- c("CHR", "POS", "N_ALLELES", "N_CHR", "p", "q")

Big06 <- inner_join(x=read_tsv(file="freq/2006Big.1250159.frq", col_names=col_names, skip=1), y=read_tsv(file="hardy/2006Big.1250159.hwe"))

Big06 <- mutate(Big06, N_HET=str_split_i(string=`OBS(HOM1/HET/HOM2)`, pattern="/", i=2)|>as.numeric()) |> select(CHR, POS, p, q, N_HET)

Big06 <- mutate(Big06, He=2*p*q, Ho=N_HET/6, D=He/(He-Ho))

Big06 <- filter(Big06, !is.nan(D))

Ne <- function(D){(-1/(2*D))}

Ne(D=mean(Big06$D))

NorteHumboldt <- read_tsv(file="NorteHumboldt.frq") |> mutate(LOCUS=paste0(CHROM, ":", POS))
Mendocino <- read_tsv(file="Mendocino.frq") |> mutate(LOCUS=paste0(CHROM, ":", POS))
SantaBarbara <- read_tsv(file="SantaBarbara.frq") |> mutate(LOCUS=paste0(CHROM, ":", POS))

brewpal <- read_tsv(file="../../brewpal2.tab")

vdat <- 
  list(
    `Del Norte-Humboldt`=filter(NorteHumboldt, !FREQ0 %in% c(0, 1)) |> pull(LOCUS), 
    Mendocino=filter(Mendocino, !FREQ0 %in% c(0, 1)) |> pull(LOCUS),
    `Santa Barbara`=filter(SantaBarbara, !FREQ0 %in% c(0, 1)) |> pull(LOCUS))

unique(c(vdat[[1]], vdat[[2]], vdat[[3]])) |> length()

udat <- 
  list(
    `Del Norte-Humboldt`=filter(NorteHumboldt, FREQ0 %in% c(0, 1)) |> pull(LOCUS), 
    Mendocino=filter(Mendocino, FREQ0 %in% c(0, 1)) |> pull(LOCUS),
    `Santa Barbara`=filter(SantaBarbara, FREQ0 %in% c(0, 1)) |> pull(LOCUS))

unique(c(udat[[1]], udat[[2]], udat[[3]])) |> length()

gg <- 
  ggvenn(
    data=vdat, 
    digits=0,
    stroke_size=0.5, 
    set_name_size=4.5,
    text_size=4,
    fill_color=rep("white", 3), 
    fill_alpha=1,
    stroke_color=rep(x=brewpal$COLOR1[c(8,6,4)], times=100), 
    stroke_alpha=1,
    auto_scale=FALSE) + 
  labs(title="Segregating SNPs") + 
  theme(plot.title=element_text(size=15, hjust=0.5), plot.subtitle=element_text(size=13, hjust=0.5))
gg 


ggg <- 
  ggvenn(
    data=udat, 
    digits=0,
    stroke_size=0.5, 
    set_name_size=4.5,
    text_size=4,
    fill_color=rep("white", 3), 
    fill_alpha=1,
    stroke_color=rep(x=brewpal$COLOR1[c(8,6,4)], times=100), 
    stroke_alpha=1,
    auto_scale=FALSE) + 
  labs(title="Fixed SNPs") + 
  theme(plot.title=element_text(size=15, hjust=0.5), plot.subtitle=element_text(size=13, hjust=0.5))
ggg 

ggsave(plot=gg, filename="/Volumes/Tigrigobius/tgoby/.venn.png", bg="white", device=png, width=5, height=5, units="in", dpi=300)
