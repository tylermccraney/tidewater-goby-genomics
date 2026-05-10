library(tidyverse)
library(ggtree)
library(treeio)

setwd(dir="/Volumes/Tigrigobius/tgoby/astral/")

dat <- read_tsv(file="../brewpal2.tab")
barplot(1:10, col=dat$COLOR1)

tre <- read.newick(file="uces.astral-hybrid.2.nwk", node.label="support")

tre@data

ggt <- ggtree(tr=tre)

ggt <- 
  rotate(tree_view=ggt, node=98) %>% 
  rotate(node=99) %>% 
  rotate(node=104) %>% 
  rotate(node=156) %>% 
  rotate(node=157) %>% 
  rotate(node=162) %>% 
  rotate(node=91)

ggt + geom_tiplab() + geom_nodelab(mapping=aes(label=node), hjust=0)

dat2 <- left_join(x=read_tsv(file="groups2.tsv"), y=dat, by="Population")

ggt$data <- left_join(x=ggt$data, y=dat2, by="label") |> select(-number, -Collection)

#write_csv(select(ggt$data, node, Population), file="nodePopulation.csv")

ggt$data <- left_join(y=read_csv(file="nodePopulation.csv", col_types=cols(node=col_integer())), x=ggt$data, by="node")

ggt$data <- left_join(x=ggt$data, y=dat, by="Population")

write_tsv(x=ggt$data, file="ggt-data.tsv")

ggt + geom_tiplab() + geom_nodelab(aes(label=node), hjust=0)

ggt$data$name <- NA 
ggt$data$name[132] <- "Del Norte-Humboldt"
ggt$data$name[109] <- "Mendocino"
ggt$data$name[86] <- "Santa Barbara"

cladelabs <- filter(ggt$data, node%in%c(132, 109, 86))|>select(node, name, color=COLOR1)

ggt$data <- select(ggt$data, -name)

poplabs <- filter(ggt$data, node%in%c(75, 82, 67, 55, 43, 31, 16, 22, 10, 6))|>select(node, name=Population, color=COLOR1)

poplabs$name <- gsub(pattern=" ", replacement="\n", poplabs$name)

gg <- 
  ggt + 
  geom_hilight(
    mapping=aes(subset=node%in%c(132, 109, 86), fill=I(COLOR1)),
#    color="white",
    type="gradient", 
    gradient.direction='tr', 
    alpha=0.2, 
    to.bottom=TRUE, 
    align="right", 
    extend=1) +
  geom_strip(taxa1="2011Tillas22", taxa2="2011Tillas19", color=dat$COLOR1[10], barsize=1, extend=0.5, offset=0.4) +
  geom_strip(taxa1="2011Earl04", taxa2="2011Earl10", color=dat$COLOR1[9], barsize=1, extend=0.5, offset=0.4) +
  geom_strip(taxa1="2021Big02", taxa2="2006Big20", color=dat$COLOR1[7], barsize=1, extend=0.5, offset=0.4) +
  geom_strip(taxa1="2006Stone32", taxa2="2021Stone07", color=dat$COLOR1[8], barsize=1, extend=0.5, offset=0.4) +
  geom_strip(taxa1="2021Big03", taxa2="2021Big03", color=dat$COLOR1[7], barsize=1, extend=0.5, offset=0.4) +
  geom_strip(taxa1="2021Stone05", taxa2="2021Stone02", color=dat$COLOR1[8], barsize=1, extend=0.5, offset=0.4) +
  geom_strip(taxa1="2006Big19", taxa2="2006Big19", color=dat$COLOR1[7], barsize=1, extend=0.5, offset=0.4) +
  geom_strip(taxa1="2006Stone03", taxa2="2021Stone01", color=dat$COLOR1[8], barsize=1, extend=0.5, offset=0.4) +
  geom_strip(taxa1="2006Big06", taxa2="2006Big06", color=dat$COLOR1[7], barsize=1, extend=0.5, offset=0.4) +
  geom_strip(taxa1="2006Stone09", taxa2="2006Stone31", color=dat$COLOR1[8], barsize=1, extend=0.5, offset=0.4) +
  geom_strip(taxa1="2021Big06", taxa2="2021Big04", color=dat$COLOR1[7], barsize=1, extend=0.5, offset=0.4) +
  geom_strip(taxa1="2021Stone04", taxa2="2006Stone30", color=dat$COLOR1[8], barsize=1, extend=0.5, offset=0.4) +
  geom_strip(taxa1="2006Big13", taxa2="2006Big13", color=dat$COLOR1[7], barsize=1, extend=0.5, offset=0.4) +
  geom_strip(taxa1="2021Virgin09", taxa2="2006Virgin40", color=dat$COLOR1[6], barsize=1, extend=0.5, offset=0.4) +
  geom_strip(taxa1="2006Pudding31", taxa2="2006Pudding16", color=dat$COLOR1[5], barsize=1, extend=0.5, offset=0.4) +
  geom_strip(taxa1="2017Antonio22", taxa2="2017Antonio30", color=dat$COLOR1[4], barsize=1, extend=0.5, offset=0.4) +
  geom_strip(taxa1="2017Ynez28", taxa2="2017Ynez20", color=dat$COLOR1[3], barsize=1, extend=0.5, offset=0.4) +
  geom_strip(taxa1="2014Burro16", taxa2="2014Burro04", color=dat$COLOR1[2], barsize=1, extend=0.5, offset=0.4) +
  geom_strip(taxa1="2014Paredon18", taxa2="2014Paredon18", color=dat$COLOR1[1], barsize=1, extend=0.5, offset=0.4) +
  geom_strip(taxa1="2014Burro15", taxa2="2014Burro15", color=dat$COLOR1[2], barsize=1, extend=0.5, offset=0.4) +
  geom_strip(taxa1="2014Paredon39", taxa2="2014Paredon28", color=dat$COLOR1[1], barsize=1, extend=0.5, offset=0.4) +
  geom_tree(mapping=aes(color=I(COLOR1))) + 
  geom_tree(mapping=aes(size=I(support), color=I(COLOR1))) + 
  geom_cladelab(
    data=cladelabs,
    mapping=aes(node=node, label=name, colour=I(color)),
    align=TRUE,
    angle=270,
    barsize=0,
    barcolour=NA,
    hjust=0.5,
    offset=0.49) +
  geom_cladelab(
    data=poplabs,
    mapping=aes(node=node, label=name, colour=I(color)),
    align=TRUE,
    lineheight=0.8,
    barsize=0,
    barcolour=NA,
    hjust=0.5,
    offset=0.14,
    fontsize=3.5) +
  geom_treescale(label=NA, y=-1, fontsize=0, x=0.88, width=0.2) + 
  annotate(geom="text", label="Coalescent units", x=0.31, y=-1) +
  annotate(geom="text", label="0.2", x=1.23, y=-1) +
  scale_size_identity(guide="legend", name="Posterior Probability") +
  xlim(c(NA, 2.5)) + 
  theme(
    legend.text=element_text(size=11), 
    legend.title=element_text(size=11), 
    legend.position="bottom", legend.direction="horizontal")

ggsave(plot=gg, filename="uces.astral-hybrid.2.png", width=4, height=8, device=png, dpi=300, units="in")
ggsave(plot=gg, filename="uces.astral-hybrid.2.pdf", width=4, height=8, device=cairo_pdf)

