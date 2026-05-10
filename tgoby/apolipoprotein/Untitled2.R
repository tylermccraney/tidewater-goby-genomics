library(tidyverse)
library(ggthemes)
library(patchwork)
library(ggformula)

"%!in%" <- Negate(`%in%`)

gene.gff3 <- readRDS(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18/Genes.RDS")

setwd(dir="/Volumes/Tigrigobius/tgoby/ldhat/stat3/")

filename <- dir(pattern="*_res.txt$")

rho <- 
  filename |> 
  map(
    \(filename) read_tsv(file=filename, skip=2, col_names=c("Loci", "Mean_rho", "Median", "L95", "U95")) |> 
      mutate(test=gsub("_res.txt", "", filename))) |> 
  reduce(rbind)

rho <- 
  mutate(
    rho, 
    chr=str_extract(string=test, pattern="chr(\\d\\d)", group=1) |> as.double(), 
    stat=str_extract(string=test, pattern="chr\\d\\d(\\w+)", group=1),
    pos=Loci*1000) |>
  select(-test, -Loci) |> 
  relocate(chr, pos, Mean_rho, Median, L95, U95, stat)

rates <- filter(rho, stat=="rates")
bounds <- filter(rho, stat=="bounds")

rates <- 
  rates |> 
  group_by(chr) |> 
  summarise(chr_len=max(pos)) |> 
  mutate(tot=cumsum(chr_len)-chr_len) |>
  select(-chr_len) |>
  left_join(rates, ., by=c("chr"="chr")) |>
  arrange(chr, pos) |>
  mutate(BPcum=pos+tot) |> 
  select(-tot)

axisdf <- 
  rates |> 
  group_by(chr) |> 
  summarize(center=(max(BPcum)+min(BPcum))/2)

bounds <- left_join(x=bounds, y=select(rates, chr, pos, BPcum), by=join_by(chr, pos))

brewpal2 <- read_tsv(file="../../brewpal2.tab")
brewpal2x <- read_tsv(file="../../brewpal2x.tab")

ldhat <- 
  full_join(
    x=filter(rates, chr==13, between(pos, left=19400001, right=19750000)), 
    y=filter(bounds, chr==13, Median==1, between(pos, left=19400001, right=19750000)), 
    by=join_by(chr, pos), 
    suffix=c(".rates", ".bounds")) |>
  mutate(pos=as.factor(pos))

p5 <- 
  ggplot() +
  geom_area(data=ldhat, mapping=aes(x=as.numeric(pos), y=Mean_rho.rates/4000), fill=brewpal2x$COLORX[7]) + 
  scale_x_continuous(expand=expansion(mult=c(0.06, 0.001))) +
  scale_y_continuous(breaks=seq(from=0, to=0.02, by=0.01)) +
  ylab(expression(italic(N)[e]*italic(r))) +
  theme_base(base_size=8) +
  theme(
    axis.title.y=element_text(size=8, angle=0, vjust=0.5),
    axis.title.x=element_blank(),
    axis.text=element_text(size=8),
    axis.text.x=element_blank(),
    axis.ticks.y=element_line(linewidth=0.25, colour=brewpal2x$COLORX[9]),
    axis.ticks.length.y=unit(x=1, units="mm"),
    axis.ticks.x=element_blank(),
    axis.line=element_blank(),
    legend.position="none",
    panel.background=element_rect(linetype="blank"),
    panel.border=element_rect(linetype="blank"),
    panel.grid.major.y=element_line(colour="lightgray", linewidth=0.25),
    plot.background=element_rect(linetype="blank"))
p5

##
locs <- 
  read_tsv(
    file="/Volumes/Tigrigobius/tgoby/apolipoprotein/chr13_19400001_19800000.ldhat.locs", 
    col_names="Loci", 
    skip=1) |> 
  mutate(Loci=1000*Loci)

samps <- 
  read_tsv(
    file="/Volumes/Tigrigobius/tgoby/apolipoprotein/chr13_19400001_19800000.ldhat.labels.tab", 
    col_names="label")

sites <- 
  read_tsv(
    file="/Volumes/Tigrigobius/tgoby/apolipoprotein/chr13_19400001_19800000.ldhat.sites.tab", 
    col_names=as.character(locs$Loci))

dat <- bind_cols(samps, sites)

levs <- 
  read_tsv(
    file="/Volumes/Tigrigobius/tgoby/apolipoprotein/chr13_19400001_19800000.ldhat.labels.ordered.tab", 
    col_names=c("label", "POP", "pop"))

datl <- 
  pivot_longer(
    data=dat, 
    cols=2:1316, 
    names_to="pos", 
    names_transform=list(pos=as.numeric), 
    values_to="allele", 
    values_transform=list(allele=as.numeric))

# intersection of MAF sites across pops
mafc <- 
  inner_join(
    x=read_tsv(file="/Volumes/Tigrigobius/tgoby/apolipoprotein/NorteHumboldt_13.kept.sites"), 
    y=read_tsv(file="/Volumes/Tigrigobius/tgoby/apolipoprotein/Mendocino_13.kept.sites"), 
    by=join_by(CHROM, POS)) |> 
  inner_join(
    y=read_tsv(file="/Volumes/Tigrigobius/tgoby/apolipoprotein/SantaBarbara_13.kept.sites"), 
    by=join_by(CHROM, POS)) |> 
  filter(between(POS, left=19400001, right=19750000)) |> 
  arrange(POS) |>
  pull(POS)

# union of MAF sites across pops
mafa <- 
  full_join(
    x=read_tsv(file="/Volumes/Tigrigobius/tgoby/apolipoprotein/NorteHumboldt_13.kept.sites"), 
    y=read_tsv(file="/Volumes/Tigrigobius/tgoby/apolipoprotein/Mendocino_13.kept.sites"), 
    by=join_by(CHROM, POS)) |> 
  full_join(
    y=read_tsv(file="/Volumes/Tigrigobius/tgoby/apolipoprotein/SantaBarbara_13.kept.sites"), 
    by=join_by(CHROM, POS)) |> 
  filter(between(POS, left=19400001, right=19750000)) |> 
  arrange(POS) |>
  pull(POS)

datl <- filter(datl, pos%in%mafa) #|> mutate(pos=as.factor(pos))

dato <- group_by(datl, label)|>summarise(alleles=sum(allele))

levs <- 
  left_join(x=levs, y=dato, by=join_by(label)) |> 
  mutate(POP=fct_inorder(POP, ordered=TRUE)) |> 
  arrange(POP, desc(alleles))

# Humb 1:36     | 37:72
# Humb 412:319  | 318:204

# Mendo 1:14    | 15:48
# Mendo 401:316 | 315:152

# SantaB 1:11,17      | 12:16,18:48
# SantaB 436:334,243  | 335:242,244:34

levs$haplotype <- 
  c(rep(1, times=36), rep(2, times=36), rep(1, times=14), rep(2, times=34), rep(1, times=11), rep(2, times=5), 1, rep(2, times=31))

levs$pop <- 
  factor(
    levs$pop, 
    levels=
      c("Tillas Slough", "Lake Earl", "Stone Lagoon", "Big Lagoon", 
        "Virgin Creek", "Pudding Creek", 
        "San Antonio Creek", "Santa Ynez River", "Arroyo Burro Creek", "Arroyo Paredon Creek"), 
    ordered=TRUE)

levs <- arrange(levs, POP, haplotype, pop, desc(alleles))

datl$label <- 
  factor(datl$label, levels=levs$label, ordered=TRUE)
datl$POP <- 
  factor(datl$label, levels=levs$label, labels=levs$POP, ordered=TRUE)
datl$pop <- 
  factor(datl$label, levels=levs$label, labels=levs$pop)

datl <- 
  arrange(datl, label, pos) |> relocate(pop, POP, .after=label) |>
  mutate(pos=factor(pos))

levs$p <- levs$pop

levels(levs$p) <- 
  c("TS", "LE", "SL", "BL", "VC", "PC", "SA", "SY", "AB", "AP")

levs <- mutate(levs, pop2=p)

levels(levs$pop2) <- 
  c("Tillas", "Earl", "Stone", "Big", "Virgin", "Pudding", "Antonio", "Ynez", "Burro", "Paredon")

levs$pop2 <- as.character(levs$pop2)

rdat <- 
  tibble(
    xmin=c(-40, -40, -40), 
    xmax=c(-20, -20, -20), 
    ymin=c(96.5, 48.5, 0.5), 
    ymax=c(168.5, 96.5, 48.5), 
    label=c("Del Norte-Humboldt", "Mendocino", "Santa Barbara"),
    color=brewpal2$COLOR1[c(8, 6, 4)])
rdat

#write_tsv(mutate(levs, y=168:1), file="/Volumes/Tigrigobius/tgoby/apolipoprotein/levs.tsv")

rlevs <- read_tsv(file="/Volumes/Tigrigobius/tgoby/apolipoprotein/levs.tsv")

rlevs <- 
  distinct(rlevs, POP, pop, haplotype, p, pop2, xmin, xmax, ymin, ymax) |> mutate(rowname=1:20)

rlevs <- 
  left_join(x=rlevs, y=brewpal2, by=join_by(pop==Population))

rlevs2 <- 
  distinct(rlevs, POP, haplotype, xmin, xmax, ymin, ymax) |>
  group_by(POP, haplotype, xmin, xmax) |> 
  summarise(ymin=min(ymin), ymax=max(ymax))

rlevs <- 
  mutate(rlevs, COLOR3=if_else(condition=haplotype==1, true=alpha(colour=COLOR1, alpha=0.5), false=COLOR1))

rlevs2 <-
  left_join(x=rlevs2, y=select(rdat, POP=label, COLOR1=color)) |> 
  left_join(y=select(rlevs, POP, COLOR1, COLOR3), relationship="many-to-many") |>
  ungroup() |>
  slice(1, 4, 5, 8, 9, 12) |>
  mutate(xmin=-40, xmax=-20)

labdat <- 
  tibble(label=rdat$label, color=rdat$color, x=-50, y=rdat$ymax-(rdat$ymax-rdat$ymin)/2)

p1 <- 
  ggplot() + 
  geom_raster(data=datl, mapping=aes(x=as.numeric(pos), y=as.numeric(fct_rev(label)), fill=as.factor(allele)), show.legend=FALSE) + 
  scale_fill_manual(values=brewpal2x$COLORX[c(7, 9)], guide="none") +
  geom_rect(data=rdat, mapping=aes(ymin=ymin+0.25, ymax=ymax-0.25, colour=I(color)), fill=NA, xmin=-60, xmax=-40.5) +
  geom_rect(data=rlevs2, mapping=aes(xmin=xmin, xmax=xmax, ymin=ymin, ymax=ymax, fill=I(COLOR3))) +
  geom_rect(data=rlevs, mapping=aes(xmin=xmin, xmax=xmax, ymin=ymin, ymax=ymax, fill=I(COLOR3))) +
  geom_text(data=labdat, mapping=aes(x=x, y=y, label=label, colour=I(color)), angle=90, size=2.5) +
  scale_x_continuous(expand=expansion(mult=c(0.011, 0.001))) +
  scale_y_continuous(expand=expansion(mult=c(0.02, 0.001))) +
  theme_void() 
p1

#
xpnsl <- readRDS(file="../../xpnsl/selscan/XP-nSL.RDS")
nsl <- readRDS(file="../../nsl/selscan/nSL.RDS") 
ihs <- readRDS(file="../../ihs/selscan/gmap/iHS.RDS") 

xpnsl <- 
  inner_join(
    x=mutate(datl, pos=as.numeric(as.character(pos))), 
    y=filter(xpnsl, chr==13, pos%in%mafa), 
    by=join_by(POP, pos), 
    relationship="many-to-many") |> 
  select(POP, samplesA, samplesB, pos, xpnsl_norm) |> 
  distinct(samplesA, samplesB, pos, xpnsl_norm, .keep_all=TRUE) |>
  mutate(samplesAB=paste0(samplesA, "_", samplesB))

xpnsl <- 
  group_by(xpnsl, POP, pos) |> slice_max(xpnsl_norm)

nsl <- 
  inner_join(
    x=mutate(datl, pos=as.numeric(as.character(pos))), 
    y=filter(nsl, CHROM==13, POS%in%mafa), 
    by=join_by(POP, pos==POS)) |> 
  select(POP, pos, allele, ABS_nSL) |> 
  distinct(POP, pos, .keep_all=TRUE)

ihs <- 
  inner_join(
    x=mutate(datl, pos=as.numeric(as.character(pos))), 
    y=filter(ihs, CHROM==13, POS%in%mafa), 
    by=join_by(POP, pos==POS)) |> 
  select(POP, pos, allele, ABS_iHS) |> 
  distinct(POP, pos, .keep_all=TRUE)

p4 <- 
  ggplot(data=xpnsl) + 
  geom_spline(mapping=aes(x=as.factor(pos), y=xpnsl_norm, colour=POP, group=POP)) +
  scale_color_manual(values=brewpal2$COLOR1[c(8, 6, 4)]) +
  labs(y="XP-nSL") +
  scale_x_discrete(expand=expansion(mult=c(0.06, 0.001))) +
  scale_y_continuous(breaks=seq(0, 4, 2)) +
  theme_base(base_size=8) +
  theme(
    axis.title.y=element_text(size=8, angle=0, vjust=0.5),
    axis.title.x=element_blank(),
    axis.text=element_text(size=8),
    axis.text.x=element_blank(),
    axis.ticks.y=element_line(linewidth=0.25, colour=brewpal2x$COLORX[9]),
    axis.ticks.length.y=unit(x=1, units="mm"),
    axis.ticks.x=element_blank(),
    axis.line=element_blank(),
    legend.position="none",
    panel.background=element_rect(linetype="blank"),
    panel.border=element_rect(linetype="blank"),
    panel.grid.major.y=element_line(colour="lightgray", linewidth=0.25),
    plot.background=element_rect(linetype="blank"))
p4

p3 <- 
  ggplot(data=nsl) + 
  geom_spline(mapping=aes(x=as.factor(pos), y=ABS_nSL, colour=POP, group=POP)) +
  scale_color_manual(values=brewpal2$COLOR1[c(8, 6, 4)]) +
  scale_x_discrete(expand=expansion(mult=c(0.06, 0.001))) +
  scale_y_continuous(breaks=seq(0, 4, 2)) +
  labs(y="nSL") +
  theme_base(base_size=8) +
  theme(
    axis.title.y=element_text(size=8, angle=0, vjust=0.5),
    axis.title.x=element_blank(),
    axis.text=element_text(size=8),
    axis.text.x=element_blank(),
    axis.ticks.y=element_line(linewidth=0.25, colour=brewpal2x$COLORX[9]),
    axis.ticks.length.y=unit(x=1, units="mm"),
    axis.ticks.x=element_blank(),
    axis.line=element_blank(),
    legend.position="none",
    panel.background=element_rect(linetype="blank"),
    panel.border=element_rect(linetype="blank"),
    panel.grid.major.y=element_line(colour="lightgray", linewidth=0.25),
    plot.background=element_rect(linetype="blank"))
p3

p2 <- 
  ggplot(data=ihs) + 
  geom_spline(mapping=aes(x=as.factor(pos), y=ABS_iHS, colour=POP, group=POP)) +
  scale_color_manual(values=brewpal2$COLOR1[c(8, 6, 4)]) +
  scale_x_discrete(expand=expansion(mult=c(0.06, 0.001))) +
  scale_y_continuous(breaks=seq(0, 4, 2)) +
  labs(y="iHS") +
  theme_base(base_size=8) +
  theme(
    axis.title.y=element_text(size=8, angle=0, vjust=0.5),
    axis.title.x=element_blank(),
    axis.text=element_text(size=8),
    axis.text.x=element_blank(),
    axis.ticks.y=element_line(linewidth=0.25, colour=brewpal2x$COLORX[9]),
    axis.ticks.length.y=unit(x=1, units="mm"),
    axis.ticks.x=element_blank(),
    axis.line=element_blank(),
    legend.position="none",
    panel.background=element_rect(linetype="blank"),
    panel.border=element_rect(linetype="blank"),
    panel.grid.major.y=element_line(colour="lightgray", linewidth=0.25),
    plot.background=element_rect(linetype="blank"))
p2

intv <- (19750000-19400001) / 1035

gpos <- seq(from=19400001, to=19750000, by=intv)[-1036]
names(gpos) <- 1:1035

ppos <- levels(datl$pos) |> as.numeric()
names(ppos) <- 1:1035

xx <- as_tibble(cbind(gpos, ppos))

##
genes <- 
  filter(
    gene.gff3, 
    ORF_type=="complete",
    seqid==13, 
    between(start, left=19400001, right=19750000))
genes

gcoor <- 
  sort(c(19400001, genes$start, genes$end, 19750000))

gcoorl <- 
  c(NA, genes$gene_id[1], 
    NA, genes$gene_id[2], 
    NA, genes$gene_id[3], 
    NA, genes$gene_id[4], 
    NA, genes$gene_id[5], 
    NA, genes$gene_id[6], 
    NA, genes$gene_id[7], 
    NA, genes$gene_id[8], 
    NA, genes$gene_id[9], 
    NA, genes$gene_id[10], 
    NA, genes$gene_id[11], 
    NA)

xx <- 
  mutate(xx, id=cut(ppos, breaks=gcoor, labels=gcoorl))

xxx <- group_by(xx, id) |> summarise(xmin=min(gpos, na.rm=TRUE), xmax=max(gpos, na.rm=TRUE))

ann <- readRDS(file="/Volumes/Tigrigobius/tgoby/snpEff/annotations.RDS")

miss <- 
  filter(
    ann, 
    Gene_id%in%levels(xxx$id)[-1], 
    ANNOTATION%in%c("missense_variant", "missense_variant&splice_region_variant", "stop_gained")) |> 
  mutate(id=cut(POS, breaks=gcoor, labels=gcoorl))

miss <- 
  inner_join(miss, xx, by=join_by(id, POS==ppos))

p7 <- 
  ggplot(data=xxx) + 
  geom_rect(mapping=aes(xmin=xmin, xmax=xmax, ymin=0, ymax=1, fill=id), show.legend=FALSE) + 
  scale_fill_manual(values=c(rep(brewpal2x$COLORX[8], 11), "white")) +
  geom_vline(data=miss, mapping=aes(xintercept=gpos), linewidth=0.25, colour=brewpal2x$COLORX[1]) +
  scale_x_continuous(expand=expansion(mult=c(0.06, 0.001))) +
  scale_y_continuous(expand=expansion(mult=c(0, 0))) +
  theme_void()
p7

map13 <- 
  read_table(file="/Volumes/Tigrigobius/tgoby/ldhat/map3/chr13.map", col_names=c("chr", "id", "cM", "pos")) |>
  mutate(Mb=pos*0.000001)

map13

map13 <- 
  filter(map13, between(pos, 19400000, 19750000), pos%in%mafa) |> rename(ppos=pos)

map13 <- 
  inner_join(x=select(map13, -chr, -id), y=xx, by=join_by(ppos))

map13 <- 
  mutate(map13, bin2=cut_width(cM, width=0.05, labels=seq(11.65, 12.35, 0.05)))

map1313 <- 
  slice(mutate(map13, rowname=seq_along(cM)), 111, 132, 243, 279, 499, 532, 546, 593, 612, 622, 728, 814, 839)

levels(map1313$bin2)[seq(2,14,2)] <- c("11.70", "11.80", "11.90", "12.00", "12.10", "12.20", "12.30")

map137 <- 
  slice(mutate(map13, rowname=seq_along(cM)), 53, 127, 189, 341, 677, 912)

p0 <- 
  ggplot(data=map13) + 
  geom_segment(mapping=aes(x=gpos, xend=gpos, y=0, yend=1), lineend="round", linejoin="round", linewidth=0.25, colour=brewpal2x$COLORX[8]) + 
  geom_segment(mapping=aes(x=gpos, xend=ppos, y=1, yend=9), lineend="round", linejoin="round", linewidth=0.25, colour=brewpal2x$COLORX[8]) + 
  geom_segment(mapping=aes(x=ppos, xend=ppos, y=9, yend=10), lineend="round", linejoin="round", linewidth=0.25, colour=brewpal2x$COLORX[8]) + 
  geom_segment(data=bind_rows(map137, tibble(cM=NA, gpos=19750000, ppos=19750000, Mb=NA, bin2=NA, rowname=NA)), mapping=aes(x=gpos, xend=gpos, y=0, yend=1), lineend="round", linejoin="round", linewidth=0.25, colour="black") + 
  geom_segment(data=bind_rows(map137, tibble(cM=NA, gpos=19750000, ppos=19750000, Mb=NA, bin2=NA, rowname=NA)), mapping=aes(x=gpos, xend=ppos, y=1, yend=9), lineend="round", linejoin="round", linewidth=0.25, colour="black") + 
  geom_segment(data=bind_rows(map137, tibble(cM=NA, gpos=19750000, ppos=19750000, Mb=NA, bin2=NA, rowname=NA)), mapping=aes(x=ppos, xend=ppos, y=9, yend=10), lineend="round", linejoin="round", linewidth=0.25, colour="black") + 
  theme_base(base_size=7) +
  scale_x_continuous(
    expand=expansion(mult=c(0.06, 0.001)),
    position="top", 
    breaks=c(map137$ppos, 19750000), 
    labels=c(round(map137$Mb, digits=2), "Mb"), 
    name="Mb", 
    sec.axis=sec_axis(
      ~.,
      breaks=c(map137$gpos, 19750000), 
      labels=c(round(map137$cM, digits=2), "cM"), 
      name="cM")) +
  scale_y_continuous(expand=expansion(mult=c(0, 0))) +
  theme(
    axis.title=element_blank(), 
    axis.text.y=element_blank(), 
    axis.ticks.length.x=unit(1, units="mm"),
    axis.ticks.x=element_line(linewidth=0.25),
    axis.ticks.y=element_blank(),
    axis.text=element_text(size=7),
    axis.line.x=element_line(linewidth=0.25),
    legend.position="none",
    panel.background=element_rect(linetype="blank"),
    panel.border=element_rect(linetype="blank"),
    plot.background=element_rect(linetype="blank"), 
    plot.margin=unit(c(0,0,0,0), units="pt"))
p0

gg1 <- p0 / p1 / p7 / p5 / p2 / p3 / p4 + plot_layout(heights=c(0.4, 5.5, 0.2, 0.5, 0.5, 0.5, 0.5))

ggsave(plot=gg1, filename="../../apolipoprotein/19.4Mb-19.75Mb.png", device=png, width=7, height=7, units="in", dpi=300)
ggsave(plot=gg1, filename="../../apolipoprotein/19.4Mb-19.75Mb.pdf", device=cairo_pdf, width=7, height=7, units="in")


#
library(cluster)
library(factoextra)
library(FactoMineR)
datw <- pivot_wider(data=datl, names_from=pos, values_from=allele) |> select(-pop, -POP)
df <- data.frame(datw[-1], row.names=datw$label) |> scale()
distinct(select(datw, 4:1163))
res.hk <-hkmeans(df, 6)
res.dist <- dist(df)
as.matrix(res.dist)[1:6, 1:6]
res.hc <- hclust(d=res.dist, method="ward.D2")
fviz_dend(res.hc, cex=0.5)
fviz_nbclust(df, pam, method="silhouette") + theme_classic()
pam.res <- pam(df, k=9)
print(pam.res)
fviz_cluster(pam.res, ellipse.type="t", repel=TRUE, ggtheme=theme_classic())
res.pca <- PCA(df, scale.unit=FALSE, graph=FALSE)
eig.val <- get_eigenvalue(res.pca)
fviz_eig(res.pca, addlabels=TRUE)
group_by(gene.gff3, ORF_type) |> count()
filter(gene.gff3, id%in%c("STRG8634", "STRG8643", "STRG8645"))
