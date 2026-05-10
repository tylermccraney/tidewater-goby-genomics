library(tidyverse)
library(geosphere)
library(RColorBrewer)
library(tidymodels)
library(ggthemes)
library(ape)

setwd(dir="/Volumes/Tigrigobius/tgoby/stats/")

boot_dat <- 
  bind_rows(
    `SNPs`=readRDS(file="fst/boot_dat.RDS"), 
    `LD-pruned~SNPs`=readRDS(file="pruned/fst/boot_dat.RDS"), 
    .id="callset")

boot_results <- 
  bind_rows(
    `SNPs`=read_tsv(file="fst/boot.results.tab"), 
    `LD-pruned~SNPs`=read_tsv(file="pruned/fst/boot.results.tab"), 
    .id="callset")

boot_results$name <- gsub(pattern="r.squared", replacement=expression(italic(R)^2), x=boot_results$name)
boot_results$name <- gsub(pattern="\\(Intercept\\)", replacement="Intercept", x=boot_results$name)

boot_results$name <- factor(boot_results$name, ordered=TRUE, levels=c("Intercept", "KM", "italic(R)^2"))

boot_dat$name <- gsub(pattern="\\(Intercept\\)", replacement="Intercept", x=boot_dat$name)

boot_dat$name <- factor(boot_dat$name, ordered=TRUE, levels=c("Intercept", "KM", "italic(R)^2"))

boot_dat$callset <- factor(boot_dat$callset) |> fct_inorder(ordered=TRUE)
boot_results$callset <- factor(boot_results$callset) |> fct_inorder(ordered=TRUE)

g <- 
  ggplot(boot_dat, aes(x=value)) +
  geom_histogram(bins=20, linewidth=0.5, fill="lightgray", color="black") +
  geom_vline(aes(xintercept=lower), data=boot_results, col=brewer.pal(n=4, name="Dark2")[4], linewidth=0.5, linetype="dashed") +
  geom_vline(aes(xintercept=upper), data=boot_results, col=brewer.pal(n=4, name="Dark2")[4], linewidth=0.5, linetype="dashed") +
  scale_x_continuous(expand=expansion(mult=c(0.02, 0.02))) +
  scale_y_continuous(expand=expansion(mult=c(0.01, 0.05)), n.breaks=4) +
  facet_grid(rows=vars(callset), cols=vars(name), scales="free_x", switch="x", labeller="label_parsed") +
  labs(x=NULL, y="Frequency", tag="b)") + 
  theme_base(base_size=10) + 
  theme(
    strip.text.y=element_text(angle=0),
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

ggsave(plot=g, filename="facet-boots.png", device=png, width=8, height=2, units="in", dpi=300)
ggsave(plot=g, filename="facet-boots.pdf", device=cairo_pdf, width=8, height=2, units="in")

boot_aug <- 
  bind_rows(
    `SNPs`=readRDS(file="fst/boot_aug.RDS"), 
    `LD-pruned SNPs`=readRDS(file="pruned/fst/boot_aug.RDS"), 
    .id="callset")

boot_aug$callset <- fct_inorder(boot_aug$callset, ordered=TRUE) 

dat <- 
  bind_rows(
    `SNPs`=readRDS(file="fst/dat.RDS"), 
    `LD-pruned SNPs`=readRDS(file="pruned/fst/dat.RDS"), 
    .id="callset")

dat$callset <- fct_inorder(dat$callset, ordered=TRUE) 

gg <- 
  ggplot(boot_aug, aes(x=KM, y=`FST/(1-FST)`)) +
  geom_line(aes(y=.fitted, group=id), alpha=0.1, col="gray") +
  geom_smooth(data=dat, mapping=aes(x=KM, y=`FST/(1-FST)`), method="lm", se=FALSE, color="black", linewidth=0.5, alpha=1) +
  geom_point(data=dat, mapping=aes(x=KM, y=`FST/(1-FST)`), pch=1, alpha=1) + 
  facet_wrap(facets=vars(callset), ncol=2, nrow=1, scales="fixed") +
  theme_base(base_size=10) +
  labs(tag="a)", y=expression(italic(F)[ST]/(1-italic(F)[ST]))) + 
  theme(
    strip.text=element_text(size=10),
    axis.ticks.length=unit(1, units="mm"),
    line=element_line(lineend="square", linewidth=0.4),
    axis.text=element_text(size=10), 
    axis.title=element_text(size=10),
    panel.background=element_rect(linewidth=0.4),
    plot.background=element_rect(linetype="blank"))

ggsave(plot=gg, filename="facet-fst~km.png", device=png, width=8, height=3, units="in", dpi=300)
ggsave(plot=gg, filename="facet-fst~km.pdf", device=cairo_pdf, width=8, height=3, units="in")
