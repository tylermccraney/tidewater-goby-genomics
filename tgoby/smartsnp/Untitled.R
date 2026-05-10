library(tidyverse)
library(smartsnp)
library(RColorBrewer)
library(ggthemes)

setwd(dir="/Volumes/Tigrigobius/tgoby/")

dat <- read_tsv(file="smartsnp/groups.tsv")

#
pca <-
  smart_pca(
    pc_axes=3,
    snp_data="plink/recode_genotypeMatrix.traw", 
    sample_group=dat$Population[1:84])

pca$pca.sample_coordinates$PC3 <- 
  -1*pca$pca.sample_coordinates$PC3

pca_hwe <-
  smart_pca(
    pc_axes=3,
    snp_data="plink/hwe_recode_genotypeMatrix.traw", 
    sample_group=dat$Population[1:84])

pca_hwe$pca.sample_coordinates$PC3 <- 
  -1*pca_hwe$pca.sample_coordinates$PC3

pca_out_hwe <-
  smart_pca(
    pc_axes=3,
    snp_data="plink/not_hwe_recode_genotypeMatrix.traw", 
    sample_group=dat$Population[1:84])

pca_out_hwe$pca.sample_coordinates$PC2 <- 
  -1*pca_out_hwe$pca.sample_coordinates$PC2

pca_hwe_pruned <-
  smart_pca(
    pc_axes=3,
    snp_data="plink/hwe_recode_pruned_genotypeMatrix.traw", 
    sample_group=dat$Population[1:84])

pca_hwe_pruned$pca.sample_coordinates$PC2 <- 
  -1*pca_hwe_pruned$pca.sample_coordinates$PC2

pca_pruned <-
  smart_pca(
    pc_axes=3,
    snp_data="plink/pruned_recode_genotypeMatrix.traw", 
    sample_group=dat$Population[1:84])

pca_pruned$pca.sample_coordinates$PC2 <- 
  -1*pca_pruned$pca.sample_coordinates$PC2


pcas <- 
  bind_rows(
    pca$pca.sample_coordinates %>% mutate(level="SNPs"),
    pca_hwe$pca.sample_coordinates %>% mutate(level="HWE SNPs"),
    pca_pruned$pca.sample_coordinates %>% mutate(level="LD-pruned SNPs"),
    pca_hwe_pruned$pca.sample_coordinates %>% mutate(level="LD-pruned HWE SNPs")) |>
  as_tibble()

levs <- list(Group=rev(unique(dat$Population)[c(8,7,10,9,2,4,1,3,5,6)]), level=unique(pcas$level))

pcas$Group <- factor(pcas$Group, levels=levs$Group, ordered=TRUE)

pcas$level <- factor(pcas$level, levels=levs$level, ordered=TRUE)

color <- read_tsv(file="brewpal2.tab")
color$Population <- factor(color$Population) |> fct_inorder() |> fct_rev()

color$Population <- factor(color$Population, ordered=TRUE)

color <- 
  mutate(
    color, 
    County=c(rep("Santa Barbara", 4), rep("Mendocino", 2), rep("Del Norte-Humboldt", 4))|>factor(ordered=TRUE), 
    shape=c(rep(25, 4), rep(22, 2), rep(24, 4)), 
    size=c(rep(3, 4), rep(3, 2), rep(3, 4)),
    stroke=c(rep(1, 4), rep(1, 2), rep(1, 4)))


pcas <- left_join(x=pcas, y=color, by=c("Group"="Population"))


ggpca1 <- 
  ggplot(data=pcas, mapping=aes(x=PC2, y=PC3, color=I(COLOR1), shape=I(shape), size=I(size))) +
  scale_shape_identity(guide="legend", name=NULL, breaks=rev(color$shape|>unique()), labels=rev(color$County|>unique())) +
  scale_color_identity(guide="legend", name=NULL, na.translate=FALSE, breaks=rev(color$COLOR1), labels=rev(color$Population), aesthetics=c("colour", "fill")) +
  geom_vline(xintercept=0, lty=1, color="lightgray") +
  geom_hline(yintercept=0, lty=1, color="lightgray") +
  geom_point() +
  facet_wrap(~level, ncol=1) +
  theme_base(base_size=11) +
  theme(legend.title=element_blank(), plot.background=element_rect(linetype="blank"))


ggsave(
  filename="smartsnp/pca1.png", 
  plot=ggpca1, 
  width=6, 
  height=8, 
  units="in", 
  dpi=300)

ggsave(
  filename="smartsnp/pca1.pdf", 
  plot=ggpca1, 
  width=6, 
  height=8, 
  units="in", 
  device=cairo_pdf)

ggpca2 <- 
  ggplot(data=filter(pcas, level==levels(pcas$level)[4]), mapping=aes(x=PC1, y=PC2, color=I(COLOR1), shape=I(shape), size=I(size))) +
  scale_shape_identity(guide="legend", name=NULL, breaks=rev(color$shape|>unique()), labels=rev(color$County|>unique())) +
  scale_color_identity(guide="legend", name=NULL, na.translate=FALSE, breaks=rev(color$COLOR1), labels=rev(color$Population), aesthetics=c("colour", "fill")) +
  geom_vline(xintercept=0, lty=1, color="lightgray") +
  geom_hline(yintercept=0, lty=1, color="lightgray") +
  geom_point() +
  theme_base(base_size=11) +
  theme(legend.title=element_blank(), plot.background=element_rect(linetype="blank"))

ggsave(
  filename="smartsnp/pca2.png", 
  plot=ggpca2, 
  width=5, 
  height=3, 
  units="in", 
  device=png,
  dpi=300)

ggsave(
  filename="smartsnp/pca2.pdf", 
  plot=ggpca2, 
  width=5, 
  height=3, 
  units="in", 
  device=pdf)


ggpca3 <- 
  ggplot(data=filter(pcas, level==levels(pcas$level)[4]), mapping=aes(x=PC1, y=PC3, color=I(COLOR1), shape=I(shape), size=I(size))) +
  scale_shape_identity(guide="legend", name=NULL, breaks=rev(color$shape|>unique()), labels=rev(color$County|>unique())) +
  scale_color_identity(guide="legend", name=NULL, na.translate=FALSE, breaks=rev(color$COLOR1), labels=rev(color$Population), aesthetics=c("colour", "fill")) +
  geom_vline(xintercept=0, lty=1, color="lightgray") +
  geom_hline(yintercept=0, lty=1, color="lightgray") +
  geom_point() +
  theme_base(base_size=11) +
  theme(legend.title=element_blank(), plot.background=element_rect(linetype="blank"))

ggsave(
  filename="smartsnp/pca3.png", 
  plot=ggpca3, 
  width=5, 
  height=3, 
  units="in", 
  device=png,
  dpi=300)

ggsave(
  filename="smartsnp/pca3.pdf", 
  plot=ggpca3, 
  width=5, 
  height=3, 
  units="in", 
  device=pdf)




ggpca4 <- 
  ggplot(data=filter(pcas, level==levels(pcas$level)[4]), mapping=aes(x=PC2, y=PC3, color=I(COLOR1), shape=I(shape), size=I(size))) +
  scale_shape_identity(guide="legend", name=NULL, breaks=rev(color$shape|>unique()), labels=rev(color$County|>unique())) +
  scale_color_identity(guide="legend", name=NULL, na.translate=FALSE, breaks=rev(color$COLOR1), labels=rev(color$Population), aesthetics=c("colour", "fill")) +
  geom_vline(xintercept=0, lty=1, color="lightgray") +
  geom_hline(yintercept=0, lty=1, color="lightgray") +
  geom_point() +
  theme_base(base_size=11) +
  theme(legend.title=element_blank(), plot.background=element_rect(linetype="blank"))

ggsave(
  filename="smartsnp/pca4.png", 
  plot=ggpca4, 
  width=5, 
  height=3, 
  units="in", 
  device=png,
  dpi=300)

ggsave(
  filename="smartsnp/pca4.pdf", 
  plot=ggpca4, 
  width=5, 
  height=3, 
  units="in", 
  device=pdf)




###########

pcaGrid <- filter(pcas, level==levels(pcas$level)[c(1,3)])

pcaGrid$level <- factor(pcaGrid$level)

pcaGrid <- 
  bind_rows(
    select(pcaGrid, -Class, -PC3) |> rename(x=PC1, y=PC2) |> mutate(x.PC="PC1",y.PC="PC2"), 
    select(pcaGrid, -Class, -PC2) |> rename(x=PC1, y=PC3) |> mutate(x.PC="PC1",y.PC="PC3"))

ggpca5 <- 
  ggplot(pcaGrid, mapping=aes(x=x, y=y, color=I(COLOR1), shape=I(shape), size=I(size), group=Group)) +
  scale_shape_identity(guide="legend", name=NULL, breaks=rev(color$shape|>unique()), labels=rev(color$County|>unique())) +
  scale_color_identity(guide="legend", name=NULL, na.translate=FALSE, breaks=rev(color$COLOR1), labels=rev(color$Population)) +
  geom_vline(xintercept=0, lty=2, color="lightgray") +
  geom_hline(yintercept=0, lty=2, color="lightgray") +
  geom_point() +
  facet_grid(rows=vars(y.PC), cols=vars(level), switch="y", scales="free") +
  theme_base(base_size=11) +
  labs(x="PC1") +
  theme(
    axis.ticks.length=unit(1, units="mm"),
    strip.background=element_blank(), 
    strip.text=element_text(size=10),
    strip.placement="outside",
    legend.title=element_blank(), 
    axis.title.x=element_text(size=10), 
    axis.title.y=element_blank(), 
    plot.background=element_rect(linetype="blank"))

ggsave(
  filename="smartsnp/pca123.png", 
  plot=ggpca5, 
  width=6.5, 
  height=4, 
  units="in", 
  device=png,
  dpi=300)

ggsave(
  filename="smartsnp/pca123.pdf", 
  plot=ggpca5, 
  width=6.5, 
  height=4, 
  units="in", 
  device=pdf)

