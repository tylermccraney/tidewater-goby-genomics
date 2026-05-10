library(tidyverse)
library(RColorBrewer)
library(ggthemes)


dp1 <- 
  read_table(
    file="NorteHumboldt.ld.gz", 
    col_names=c("CHR_A", "BP_A", "SNP_A", "CHR_B", "BP_B", "SNP_B", "R2", "DP", "BP"), 
    skip=1) |> 
  mutate(BP=BP_B-BP_A) |> 
  select(-SNP_A, -CHR_B, -SNP_B) |> 
  rename(CHROM=CHR_A)

dp2 <- 
  read_table(
    file="Mendocino.ld.gz", 
    col_names=c("CHR_A", "BP_A", "SNP_A", "CHR_B", "BP_B", "SNP_B", "R2", "DP", "BP"), 
    skip=1) |> 
  mutate(BP=BP_B-BP_A) |> 
  select(-SNP_A, -CHR_B, -SNP_B) |> 
  rename(CHROM=CHR_A)

dp3 <- 
  read_table(
    file="SantaBarbara.ld.gz", 
    col_names=c("CHR_A", "BP_A", "SNP_A", "CHR_B", "BP_B", "SNP_B", "R2", "DP", "BP"), 
    skip=1) |> 
  mutate(BP=BP_B-BP_A) |> 
  select(-SNP_A, -CHR_B, -SNP_B) |> 
  rename(CHROM=CHR_A)


ddp1 <- 
  mutate(dp1, BIN=cut_interval(BP, length=1000, labels=seq(1000, 1000000, 1000))) |> 
  group_by(BIN) |> 
  summarise(MEAN_R2=mean(R2), SD_R2=sd(R2), MEAN_DP=mean(DP), SD_DP=sd(DP)) 

ddp2 <- 
  mutate(dp2, BIN=cut_interval(BP, length=1000, labels=seq(1000, 1000000, 1000))) |> 
  group_by(BIN) |> 
  summarise(MEAN_R2=mean(R2), SD_R2=sd(R2), MEAN_DP=mean(DP), SD_DP=sd(DP)) 

ddp3 <- 
  mutate(dp3, BIN=cut_interval(BP, length=1000, labels=seq(1000, 1000000, 1000))) |> 
  group_by(BIN) |> 
  summarise(MEAN_R2=mean(R2), SD_R2=sd(R2), MEAN_DP=mean(DP), SD_DP=sd(DP)) 


dat <- 
  bind_rows(
    `Del Norte-Humboldt`=ddp1, 
    Mendocino=ddp2, 
    `Santa Barbara`=ddp3, 
    .id="POP")

dat$POP <- factor(dat$POP, ordered=TRUE) |> fct_inorder()

brewpal2 <- read_tsv(file="../brewpal2.tab")
brewpal2x <- read_tsv(file="../brewpal2x.tab")
barplot(1:10, col=brewpal2$COLOR1)

# plot LD decay
g <- 
  ggplot(data=dat, mapping=aes(x=as.numeric(BIN)*1000, y=MEAN_R2, color=POP, group=POP)) + 
  geom_point(shape=1) +
  geom_hline(yintercept=0.1, linetype=2, colour="lightgray", alpha=1) +
  geom_vline(xintercept=100000, linetype=2, colour="lightgray", alpha=1) +
#  geom_smooth(se=FALSE, linewidth=0.5) +
  labs(x="Physical distance between SNPs (Kb)", y=expression(italic(r)^2), tag="a)") +
  theme_classic() + 
  theme(legend.title=element_blank(), legend.position=c(0.7, 0.85)) +
  scale_color_manual(values=c("#66A61E", "#E6AB02", "#A6761D")) +
  scale_x_continuous(
    breaks=seq(from=0, to=1000000, by=200000), 
    labels=as.character(seq(from=0, to=1000, by=200)))

ggsave(filename="r2.png", plot=g, device=png, width=4, height=3, units="in", dpi=300)

ggsave(filename="r2.pdf", plot=g, device=pdf, width=4, height=3, units="in")


gg <- 
  ggplot(data=dat, mapping=aes(x=as.numeric(BIN)*1000, y=MEAN_DP, color=POP, group=POP)) + 
  geom_point(shape=1) +
#  geom_smooth(se=FALSE, linewidth=0.5) +
  labs(x="Physical distance between SNPs (Kb)", y=expression(paste("Lewontin's ", italic("D'"), sep=" ")), tag="b)") +
  theme_classic() + 
  theme(legend.title=element_blank(), legend.position=c(0.7, 0.85)) +
  scale_color_manual(values=c("#66A61E", "#E6AB02", "#A6761D")) +
  scale_x_continuous(
    breaks=seq(from=0, to=1000000, by=200000), 
    labels=as.character(seq(from=0, to=1000, by=200)))

ggsave(filename="D'.png", plot=gg, device=png, width=4, height=3, units="in", dpi=300)

ggsave(filename="D'.pdf", plot=gg, device=pdf, width=4, height=3, units="in")




filter(dat, BIN==1000000) |> select(-1, -2) |> round(2)

