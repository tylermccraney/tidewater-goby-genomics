library(tidyverse)
library(RColorBrewer)
library(ggthemes)

setwd(dir="/Volumes/Tigrigobius/tgoby/stats/")

boot_dat <- 
  bind_rows(
    `SNPs`=readRDS(file="fst/WGS_vs_Kinziger_et_al_2015/cor/boot_dat.RDS"), 
    `LD-pruned SNPs`=readRDS(file="pruned/fst/WGS_vs_Kinziger_et_al_2015/cor/boot_dat.RDS"), 
    .id="callset")

boot_results <- 
  bind_rows(
    `SNPs`=read_tsv(file="fst/WGS_vs_Kinziger_et_al_2015/cor/boot.results.tab"), 
    `LD-pruned SNPs`=read_tsv(file="pruned/fst/WGS_vs_Kinziger_et_al_2015/cor/boot.results.tab"), 
    .id="callset")

boot_results$name <- gsub(pattern="corr", replacement=expression(rho), x=boot_results$name)


boot_dat$callset <- factor(boot_dat$callset) |> fct_inorder(ordered=TRUE)
boot_results$callset <- factor(boot_results$callset) |> fct_inorder(ordered=TRUE)

g <- 
  ggplot(filter(boot_dat, callset!="SNPs"), aes(x=value)) +
  geom_histogram(bins=20, linewidth=0.5, fill="lightgray", color="black") +
  geom_vline(aes(xintercept=lower), data=filter(boot_results, callset!="SNPs"), col=brewer.pal(n=4, name="Dark2")[4], linewidth=0.5, linetype="dashed") +
  geom_vline(aes(xintercept=upper), data=filter(boot_results, callset!="SNPs"), col=brewer.pal(n=4, name="Dark2")[4], linewidth=0.5, linetype="dashed") +
  scale_x_continuous(expand=expansion(mult=c(0.05, 0.05)), n.breaks=8, limits = c(0, NA)) +
  scale_y_continuous(expand=expansion(mult=c(0.01, 0.05)), n.breaks=4) +
  facet_wrap(facets=vars(callset), nrow=2, ncol=1, scales="fixed", strip.position="right") +
  labs(x=expression(rho), y="Frequency", tag="b)", parse=TRUE) + 
  theme_base(base_size=10) + 
  theme(
    strip.text.y=element_blank(),
    axis.text=element_text(size=10), 
    axis.line.y.left=element_line(linewidth=0.4),
    axis.ticks=element_line(),
    axis.ticks.length=unit(1, units="mm"),
    line=element_line(lineend="square", linewidth=0.4),
    panel.background=element_rect(linetype="blank"),
    panel.border=element_rect(linetype="blank"),
    plot.background=element_rect(linetype="blank"),
    strip.background=element_blank(), 
    strip.placement="outside",
    strip.text=element_text(size=10), 
    strip.switch.pad.grid=unit(0, units="mm"))

ggsave(plot=g, filename="WGS_vs_Kinziger_et_al_2015-facet-boots.2.png", device=png, width=6, height=2, units="in", dpi=300)
ggsave(plot=g, filename="WGS_vs_Kinziger_et_al_2015-facet-boots.2.pdf", device=cairo_pdf, width=6, height=2, units="in")

dat <- 
  bind_rows(
    `SNPs`=readRDS(file="fst/WGS_vs_Kinziger_et_al_2015/cor/dat.RDS"), 
    `LD-pruned SNPs`=readRDS(file="pruned/fst/WGS_vs_Kinziger_et_al_2015/cor/dat.RDS"), 
    .id="callset")

dat$callset <- factor(dat$callset) |> fct_inorder(ordered=TRUE)

cor.obs <- group_by(dat, callset) |> summarize(correlation=cor(x=STR, y=SNP))

levels(boot_dat$callset)
levels(cor.obs$callset)
levels(dat$callset)

gg <- 
  ggplot() +
  geom_abline(data=filter(boot_dat, callset!="SNPs"), mapping=aes(slope=value, intercept=0), alpha=0.05, col="gray", linewidth=0.5) +
  geom_abline(lty=2, linewidth=0.3) + 
  geom_abline(data=filter(cor.obs, callset!="SNPs"), mapping=aes(slope=correlation, intercept=0)) +
  geom_point(data=filter(dat, callset!="SNPs"), mapping=aes(x=STR, y=SNP), shape=1, alpha=1, size=2) + 
  theme_base(base_size=10) +
  labs(y=expression(SNP~italic(F)[ST]), x=expression(STR~italic(F)[ST]), tag="a)") +
  facet_wrap(facets=vars(callset), nrow=1, ncol=2) +
  scale_x_continuous(expand=expansion(mult=c(0.02, 0.05))) +
  scale_y_continuous(expand=expansion(mult=c(0.03, 0.05))) +
#  coord_cartesian(xlim=c(0, NA), ylim=c(0, NA)) +
  theme(
    axis.ticks.length=unit(1, units="mm"),
    line=element_line(lineend="square", linewidth=0.4),
    axis.text=element_text(size=10), 
    axis.title=element_text(size=10),
    strip.text=element_blank(), 
    panel.background=element_rect(linewidth=0.4),
#    panel.border=element_rect(linewidth=0.25),
    plot.background=element_rect(linetype="blank"))

ggsave(plot=gg, filename="WGS_vs_Kinziger_et_al_2015-facet-fst~km.2.png", device=png, width=6, height=3, units="in", dpi=300)
ggsave(plot=gg, filename="WGS_vs_Kinziger_et_al_2015-facet-fst~km.2.pdf", device=cairo_pdf, width=6, height=3, units="in")
