library(tidyverse)
library(geosphere)
library(RColorBrewer)
library(ggthemes)

setwd(dir="/Volumes/Tigrigobius/tgoby/stats/phase/")

brewpal2 <- read_tsv(file="../../brewpal2.tab")
brewpal2x <- read_tsv(file="../../brewpal2x.tab")
barplot(1:10, col=alpha(colour=brewpal2$COLOR1, alpha=1))

loc <- read_tsv(file="groups.tsv", col_types = "fcddc")
loc$POP <- fct_inorder(f=loc$SAMPLE, ordered=TRUE)
levels(loc$POP)[15] <- NA

#dat1 <- 
#  bind_rows(
#    read_csv(file="ne-1000/phase-switch-errors-pop.csv") |> mutate(ne=1000),
#    read_csv(file="ne-10000/phase-switch-errors-pop.csv") |> mutate(ne=10000),
#    read_csv(file="ne-100000/phase-switch-errors-pop.csv") |> mutate(ne=100000),
#    read_csv(file="ne-1000000/phase-switch-errors-pop.csv") |> mutate(ne=1000000))

#group_by(dat1, POP, ne) |> summarise(avg.error=mean(SWITCH_ERROR_RATE)) |> view()

dat <- read_csv(file="phase-switch-errors-pop-chrom.csv")


#dat <- filter(dat, !grepl("2006", POP))

dat$POP <- 
  factor(
    dat$POP, 
    levels=c("2011Tillas", "2011Earl", "2006Stone", "2021Stone", "2006Big", "2021Big", "2006Virgin", "2021Virgin", "2006Pudding", "2021Pudding", "2017Antonio", "2017Ynez", "2014Burro", "2014Paredon"),
    labels=levels(loc$POP), 
    ordered=TRUE)

dat <- left_join(dat, loc[-15, -2])

dat$POP <- fct_rev(dat$POP)
loc$POP <- fct_rev(loc$POP)

group_by(dat, POP) |> summarise(XX=mean(SWITCH_ERROR_RATE)|> round(2)) |> arrange(XX)
group_by(dat, LOCUS) |> summarise(XX=mean(SWITCH_ERROR_RATE)|> round(2)) |> arrange(XX) |> print(n=22)
sd(dat$SWITCH_ERROR_RATE)
gg <- 
  ggplot(
    data=dat, 
    mapping=aes(y=SWITCH_ERROR_RATE, x=POP, fill=I(COLOR))) +
  geom_boxplot() + 
  coord_flip(clip="off") +
  scale_y_continuous(n.breaks = 5) +
  labs(x=NULL, y="Phase switch error") +
  theme_classic(base_size=12) +
  theme(
    axis.ticks.y=element_blank(),
    axis.text.y=element_blank(),
    axis.line.y=element_blank(), 
    line=element_line(lineend="square"),
    axis.ticks.length=unit(1, units="mm"),
    plot.background=element_rect(linetype="blank"))


ggsave(filename="phase-switch-error.png", device=png, width=5, height=8, units="in", dpi=300)
ggsave(filename="../../talk/phase-switch-error.pdf", device=cairo_pdf, width=2, height=9, units="in")


