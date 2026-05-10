library(tidyverse)
library(maps)
library(RColorBrewer)
library(ggrepel)
library(ggthemes)
library(ggspatial)
library(colorspace)

ca <- 
  map_data(
    map="world", 
    region="USA")

ca <- 
  map_data(
    map = "state", 
    region = c("california", "oregon", "nevada", "arizona"))


samp <- 
  read_csv(file="../maps/coord.csv") %>%
  filter(!is.na(SAMPLE))%>%
  mutate(
    LAT=LATITUDE + c(0.3, -0.1, 0.1, -0.3, 0.2, -0.2, 0.3, -0.2, -0.4, -0.8), 
    LONG=LONGITUDE - c(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.2, -0.3),
    YEAR=as.factor(YEAR))

coo <- 
  read_csv(file="../maps/coord.csv") %>%
  mutate(PRESENT=as.factor(2016))

color <- read_tsv(file="/Volumes/Tigrigobius/tgoby/brewpal2.tab")

color$Population <- factor(color$Population) |> fct_inorder(ordered=TRUE) |> fct_rev()

color <- 
  mutate(
    color, 
    County=c(rep("Santa Barbara", 4), rep("Mendocino", 2), rep("Del Norte-Humboldt", 4))|>factor(ordered=TRUE), 
    shape=c(rep(25, 4), rep(22, 2), rep(24, 4)))

samp <- 
  left_join(x=samp, y=color, by=c("POPULATION"="Population")) |> select(-YEAR, -COUNTY, -PCH)

samp <- mutate(samp, POP=gsub(pattern=" ", replacement="\n", x=POPULATION))
  
basemap <- 
  ggplot(
    data=ca, 
    mapping=aes(x=long, y=lat, group=group)) + 
  geom_polygon(fill="lightgray", color="black") + 
  coord_map(xlim=c(-126.0,-117.5), ylim=c(32.5,42.0)) +
  geom_text(
    data=tibble(
      x=c(-119.5, -121, -118, -118.25, -124.16, -120.47, -124.41, -122.42),
      y=c(39.5, 42.3, 40, 34.05, 40.7, 34.45, 40.44, 37.77), 
      label=c(NA, NA, NA, "Los Angeles", "Eureka", "Point Conception", "Cape Mendocino", "San Francisco"),
      hjust=c(0.5, 0.5, 0.5, 0.5, -0.1, 0.0, -0.1, -0.1),
      vjust=c(0.5, 0.5, 0.5, -0.5, 0.0, -1, 0.5, 0.0)), 
    mapping=aes(x=x, y=y, label=label, hjust=hjust, vjust=vjust), 
    inherit.aes=FALSE, fontface="plain") +
  geom_point(
    data=tibble(
      x=c(-118.25, -124.16, -122.42), 
      y=c(34.05, 40.8, 37.77)), 
    mapping=aes(x=x, y=y), 
    inherit.aes=FALSE, 
#    color="#666666",
    shape=13)
basemap
ref <- read_tsv(file="/Volumes/Tigrigobius/tgoby/stats/fst/groups.tsv")[15,]

ref$COLOR1 <- brewer.pal(n=8, name="Dark2")[8]

ref$POP <- "Ref. genome &\ntranscriptome"

samp$LONG[9] <- samp$LONG[9]+0.5

g <- 
  basemap +
  geom_segment(
    data=samp,
    mapping=aes(color=I(COLOR1), x=LONG, xend=LONGITUDE, y=LAT, yend=LATITUDE),
    inherit.aes=F, 
    linetype="dotted") +
  geom_point(
    data=samp,
    mapping=aes(x=LONGITUDE, y=LATITUDE, color=I(COLOR1), fill=I(COLOR1)),
    inherit.aes=F, 
    stroke=1,
    shape=1,
    size=3) +
  geom_label(
    data=samp,
    mapping=aes(x=LONG, y=LAT, label=POP, color=I(COLOR1)), 
    lineheight=0.75,
    inherit.aes=FALSE, 
    label.size=0) +
  geom_point(
    data=ref,
    mapping=aes(x=LONGITUDE, y=LATTITUDE, color=I(COLOR1), fill=I(COLOR1)), 
    inherit.aes=FALSE, 
    stroke=1,
    shape=1,
    size=3) +
  geom_segment(
    data=ref,
    mapping=aes(color=I(COLOR1), x=LONGITUDE, xend=LONGITUDE, y=LATTITUDE-1, yend=LATTITUDE),
    inherit.aes=F, 
    linetype="dotted") +
  geom_label(
#    nudge_x=-0.2,
    nudge_y=-1,
    data=ref,
    mapping=aes(x=LONGITUDE, y=LATTITUDE, label=POP, color=I(COLOR1)), 
    lineheight=0.75,
    inherit.aes=FALSE, 
    label.size=0) +
  annotate(geom="text", label="PACIFIC OCEAN", x=-125, y=36.25, lineheight=0.75, fontface="italic") +
  theme_map() +
  theme(
    panel.grid.major=element_line(colour="lightgray", linewidth=0.2), 
    axis.text=element_text(size=10), 
    plot.background=element_rect(fill="white", color=NA))
g

ggsave(
  plot=g,
  filename="/Volumes/Tigrigobius/tgoby/talk/sampling.png", 
  device=png,  
  width=7, 
  height=10, 
  units="in", 
  dpi=300)

ggsave(
  plot=g,
  filename="/Volumes/Tigrigobius/tgoby/talk/sampling.pdf", 
  device=cairo_pdf,  
  width=7, 
  height=10, 
  units="in")

# rangewide mapping of climate data
dat <- 
  read_csv(file="/Users/bimaculata/Documents/twg/ExploratoryDataAnalysis/AnnClimateData1991-2020/climate-normals-rangewide.csv") %>%
  filter(!is.na(ANN_PRCP_NORMAL),!is.na(ANN_TAVG_NORMAL)) %>%
  filter(!STATION_NAME %in% c("REDONDO BEACH","LOS ANGELES INTL AP","SANTA MONICA MUNI AP","MONTEREY WFO","BIG SUR STN"))


ggg <- 
  basemap +
  geom_point(
    data=dat, 
    mapping=aes(x=LONGITUDE, y=LATITUDE, size=SON_PRCP_NORMAL, fill=SON_TMAX_NORMAL),
    inherit.aes=F, 
    shape=21) +
  scale_fill_continuous_sequential(name="Temperature (F)\nSep-Oct-Nov", palette="Heat") +
  scale_size(name="Precipitation (in)\nSep-Oct-Nov", breaks=c(16, 12, 8, 4)) +
  annotate(geom="text", label="PACIFIC OCEAN", x=-125, y=36.25, lineheight=0.75, fontface="italic") +
#  annotate(geom="text", label="Sep-Oct-Nov\nAverage Normals", x=-120, y=41, lineheight=1) +
  theme_map() +
  theme(legend.title=element_text(size=11), legend.text=element_text(size=11), panel.grid.major=element_line(colour="lightgray", linewidth=0.2), axis.text=element_text(size=10)) +
  guides(
    size=guide_legend(order=1),
    colour=guide_legend(order=2),
    plot.background=element_rect(fill="white", color=NA))
  

ggsave(
  plot=ggg,
  filename="/Volumes/Tigrigobius/tgoby/talk/rangewide-climate-son.pdf", 
  device=cairo_pdf,  
  width=7, 
  height=10, 
  units="in")


gggg <- 
  basemap +
  geom_point(
    data=dat, 
    mapping=aes(x=LONGITUDE, y=LATITUDE, size=DJF_PRCP_NORMAL, fill=DJF_TMAX_NORMAL),
    inherit.aes=F, 
    shape=21) +
  scale_fill_continuous_sequential(name="Temperature (F)\nDec-Jan-Feb", palette="Heat", n.breaks=6) +
  scale_size(name="Precipitation (in)\nDec-Jan-Feb", breaks=c(30, 20, 10)) +
  annotate(geom="text", label="PACIFIC OCEAN", x=-125, y=36.25, lineheight=0.75, fontface="italic") +
#  annotate(geom="text", label="Dec-Jan-Feb\nAverage Normals", x=-120, y=41, lineheight=1) +
  theme_map() +
  theme(
    panel.grid.major=element_line(colour="lightgray", linewidth=0.2), 
    axis.text=element_text(size=10),
    plot.background=element_rect(fill="white", color=NA))

ggsave(
  plot=gggg,
  filename="/Volumes/Tigrigobius/tgoby/talk/rangewide-climate-djf.pdf", 
  device=cairo_pdf,  
  width=7, 
  height=10, 
  units="in")

ggggg <-
  basemap +
  geom_point(
    data=dat, 
    mapping=aes(x=LONGITUDE, y=LATITUDE, size=ANN_PRCP_NORMAL, fill=ANN_TAVG_NORMAL),
    inherit.aes=F, 
    shape=21) +
  scale_fill_continuous_sequential(name="Temperature (F)", palette="Heat", n.breaks=6) +
  scale_size(name="Precipitation (in)", breaks=c(60, 40, 20)) +
  annotate(geom="text", label="PACIFIC OCEAN", x=-125, y=36.25, lineheight=0.75, fontface="italic") +
#  annotate(geom="text", label="US Climate Normals\nAnnual Average", x=-120, y=41, lineheight=1) +
  theme_map() +
  theme(
    plot.background=element_rect(fill="white", color=NA),
    legend.title=element_text(size=11), 
    legend.text=element_text(size=11), 
    panel.grid.major=element_line(colour="lightgray", linewidth=0.2), 
    axis.text=element_text(size=10))

ggsave(
  plot=ggggg,
  filename="/Volumes/Tigrigobius/tgoby/talk/rangewide-climate-ann.pdf", 
  device=cairo_pdf,  
  width=7, 
  height=10, 
  units="in")

ggsave(
  plot=ggggg,
  filename="/Volumes/Tigrigobius/tgoby/talk/rangewide-climate-ann.png", 
  device=png,  
  width=7, 
  height=10,
  dpi=300, 
  units="in")



##
env <- 
  read_csv(file="/Users/bimaculata/Documents/twg/ExploratoryDataAnalysis/AnnClimateData1991-2020/climate-normals-precipitation.csv") %>%
  left_join(y=read_csv(file="/Users/bimaculata/Documents/twg/ExploratoryDataAnalysis/AnnClimateData1991-2020/climate-normals-temperature.csv"), by=names(.)[1:6], suffix=c("_PRCP","_TAVG"))

samp

ggsampclim <- 
  basemap +
  geom_segment(
    data=samp,
    mapping=aes(color=I(COLOR1), x=LONG, xend=LONGITUDE, y=LAT, yend=LATITUDE),
    inherit.aes=F, 
    linetype="dotted") +
  geom_point(
    data=samp,
    mapping=aes(x=LONGITUDE, y=LATITUDE, color=I(COLOR1), fill=I(COLOR1)),
    inherit.aes=F, 
    stroke=1,
    shape=1,
    size=3) +
  geom_point(
    data=dat, 
    mapping=aes(x=LONGITUDE, y=LATITUDE, size=ANN_PRCP_NORMAL, fill=ANN_TAVG_NORMAL),
    inherit.aes=F, 
    shape=21) +
#  geom_point(
#    data=samp,
#    mapping=aes(x=LONGITUDE, y=LATITUDE, color=I(COLOR1), fill=I(COLOR1)),
#    inherit.aes=F, 
#    shape=21,
#    size=3) +
  geom_label(
    data=samp,
    mapping=aes(x=LONG, y=LAT, label=POP, color=I(COLOR1)), 
    lineheight=0.75,
    inherit.aes=FALSE, 
    label.size=0) +
  scale_fill_continuous_sequential(name="Temperature (F)", palette="Heat", n.breaks=6) +
  scale_size(name="Precipitation (in)", breaks=c(60, 40, 20)) +
  annotate(geom="text", label="PACIFIC OCEAN", x=-125, y=36.25, lineheight=0.75, fontface="italic") +
#  annotate(geom="text", label="US Climate Normals\nAnnual Average", x=-120, y=41, lineheight=1) +
  theme_map() +
  theme(
    plot.background=element_rect(fill="white", color=NA),
    legend.title=element_text(size=11), 
    legend.text=element_text(size=11), 
    panel.grid.major=element_line(colour="lightgray", linewidth=0.2), 
    axis.text=element_text(size=10))

ggsave(
  plot=ggsampclim,
  filename="/Volumes/Tigrigobius/tgoby/talk/sampling-climate-ann.pdf", 
  device=cairo_pdf,  
  width=7, 
  height=10, 
  units="in")

names(dat)

PRCP_NORMAL <- 
  pivot_longer(
    data=dat, 
    cols=c(DJF_PRCP_NORMAL, MAM_PRCP_NORMAL, JJA_PRCP_NORMAL, SON_PRCP_NORMAL), 
    names_to="SEASON", 
    values_to="PRCP_NORMAL") |> 
  select(STATION, LATITUDE, LONGITUDE, SEASON, PRCP_NORMAL)

PRCP_NORMAL$SEASON <- gsub(pattern="_PRCP_NORMAL", replacement="", x=PRCP_NORMAL$SEASON)

TAVG_NORMAL <- 
  pivot_longer(
    data=dat, 
    cols=c(DJF_TAVG_NORMAL, MAM_TAVG_NORMAL, JJA_TAVG_NORMAL, SON_TAVG_NORMAL), 
    names_to="SEASON", 
    values_to="TAVG_NORMAL") |> 
  select(STATION, LATITUDE, LONGITUDE, SEASON, TAVG_NORMAL)

TAVG_NORMAL$SEASON <- gsub(pattern="_TAVG_NORMAL", replacement="", x=TAVG_NORMAL$SEASON)

clim <- inner_join(x=PRCP_NORMAL, y=TAVG_NORMAL)

clim$SEASON <- 
  factor(
    clim$SEASON, 
    levels=c("JJA", "SON", "DJF", "MAM"), 
    labels=c("Jun\nJul\nAug", "Sep\nOct\nNov", "Dec\nJan\nFeb", "Mar\nApr\nMay"), 
    ordered=TRUE)

gg_clim <- 
  ggplot(data=clim, mapping=aes(y=PRCP_NORMAL, x=TAVG_NORMAL, group=SEASON)) +
  geom_smooth(method="gam", se=FALSE, color="black", linewidth=0.5) +
  geom_point(mapping=aes(fill=LATITUDE), size=3, shape=21) +
  scale_fill_continuous_sequential(palette="Terrain2", begin=0.4, end=1, name="Latitude") +
  scale_x_continuous(n.breaks=9) +
  facet_wrap(facets=vars(SEASON), nrow=4, strip.position="right") +
  labs(title="US Climate Normals", x="Temperature (F)", y="Precipitation (in)") +
  theme_base() +
  theme(
    strip.text.y.right=element_text(angle=0, lineheight=1),
    plot.title=element_text(face="plain"), 
    plot.background=element_rect(fill="white", color=NA))
gg_clim

ggsave(
  plot=gg_clim,
  filename="/Volumes/Tigrigobius/tgoby/talk/rangewide-climate-season-xy.pdf", 
  device=cairo_pdf,  
  width=5, 
  height=8, 
  units="in")

ggsave(
  plot=gg_clim,
  filename="/Volumes/Tigrigobius/tgoby/talk/rangewide-climate-season-xy.png", 
  device=png,  
  width=5, 
  height=8, 
  dpi=300,
  units="in")



ggxy <- 
  ggplot(data=dat, mapping=aes(y=ANN_PRCP_NORMAL, x=ANN_TAVG_NORMAL)) +
#  geom_smooth(method="gam", se=FALSE, color="lightgray") +
  geom_point(mapping=aes(fill=LATITUDE), size=5, shape=21) +
  scale_fill_continuous_sequential(palette="Terrain2", begin=0.4, end=1, name="Latitude") +
  labs(title="US Climate Normals - Annual Average", x="Temperature (F)", y="Precipitation (in)") +
  theme_base() +
  theme(
    legend.position=c(0.875, 0.65), 
    plot.title=element_text(face="plain"), 
    plot.background=element_rect(fill="white", color=NA))
  
ggsave(
  plot=ggxy,
  filename="/Volumes/Tigrigobius/tgoby/talk/rangewide-climate-ann-xy.pdf", 
  device=cairo_pdf,  
  width=6, 
  height=4, 
  units="in")

ggsave(
  plot=ggxy,
  filename="/Volumes/Tigrigobius/tgoby/talk/rangewide-climate-ann-xy.png", 
  device=png,  
  width=6, 
  height=4, 
  dpi=300,
  units="in")


#redg <- diverging_hcl(palette="Red-Green", n=5)
redg <- brewer.pal(n=5, name="RdYlGn")
barplot(1:5, col=redg)
display.brewer.all()
##
status <- 
  read_csv(file="/Users/bimaculata/Documents/twg/ExploratoryDataAnalysis/maps/Sutter_and_Kinziger_2019_survey.csv") %>%
  mutate(
    Species=factor(Species, levels=c("newberryi", "kristinae"), ordered=T),
    Status=factor(Status, levels=c("Present", "Absent", "Unknown"), ordered=T))


ggall <- 
  basemap +
  geom_point(
    show.legend=TRUE,
    data=status|>filter(Status=="Absent"),
    mapping=aes(shape=Species, x=Longitude, y=Latitude, fill=Status, color=Status),
    size=3,
#    shape=1,
    inherit.aes=F) +
  geom_point(
    show.legend=TRUE,
    data=status|>filter(Status=="Unknown"),
    mapping=aes(shape=Species, x=Longitude, y=Latitude, fill=Status, color=Status),
    size=3,
    inherit.aes=F) +
  geom_point(
    show.legend=TRUE,
    data=status|>filter(Status=="Present"),
    mapping=aes(shape=Species, x=Longitude, y=Latitude, fill=Status, color=Status),
    size=3,
    inherit.aes=F) +
  scale_color_manual(
    drop=FALSE,
    values=c("Present"=redg[5], "Absent"=redg[1], "Unknown"=brewer.pal(n=3, name="BrBG")[1]), 
    name="eDNA Survey\nSutter & Kinziger, 2019") +
  scale_fill_manual(
    drop=FALSE,
    values=c("Present"=redg[4], "Absent"=redg[2], "Unknown"=redg[3]), 
    name="eDNA Survey\nSutter & Kinziger, 2019") +
  scale_shape_manual(
    drop=FALSE,
    values=c("newberryi"=21, "kristinae"=23), 
    name=expression(italic(Eucyclogobius)), 
    labels=c(expression(italic(newberryi)), expression(italic(kristinae)))) +
  annotate(geom="text", label="PACIFIC OCEAN", x=-125, y=36.25, lineheight=0.75, fontface="italic") +
  theme_map() +
  theme(
    legend.title=element_text(size=11), 
    legend.text=element_text(size=11), 
    panel.grid.major=element_line(colour="lightgray", linewidth=0.2), 
    axis.text=element_text(size=10)) +
  guides(
    shape=guide_legend(order=1),
    colour=guide_legend(order=2),
    fill=guide_legend(order=2))

  
ggsave(
  plot=ggall,
  filename="/Volumes/Tigrigobius/tgoby/talk/all.pdf", 
  device=cairo_pdf,  
  width=7, 
  height=10, 
  units="in")

ggsave(
  plot=ggall,
  filename="/Volumes/Tigrigobius/tgoby/talk/all.png", 
  device=png,
  dpi=300,  
  width=7, 
  height=10, 
  units="in")



ggalln <- 
  basemap +
  geom_point(
    show.legend=TRUE,
    data=status|>filter(Status=="Present"),
    mapping=aes(shape=Species, x=Longitude, y=Latitude, fill=Status, color=Status),
    size=3,
    inherit.aes=F) +
  scale_color_manual(
#    drop=FALSE,
    values=c("Present"=redg[5], "Absent"=redg[1], "Unknown"=brewer.pal(n=3, name="BrBG")[1]), 
    name="eDNA Survey\nSutter & Kinziger, 2019") +
  scale_fill_manual(
#    drop=FALSE,
    values=c("Present"=redg[4], "Absent"=redg[2], "Unknown"=redg[3]), 
    name="eDNA Survey\nSutter & Kinziger, 2019") +
  scale_shape_manual(
#    drop=FALSE,
    values=c("newberryi"=21, "kristinae"=23), 
    name=expression(italic(Eucyclogobius)), 
    labels=c(expression(italic(newberryi)), expression(italic(kristinae)))) +
  annotate(geom="text", label="PACIFIC OCEAN", x=-125, y=36.25, lineheight=0.75, fontface="italic") +
#  annotate(geom="text", label="Tidewater goby survey\nSutter & Kinziger, 2019", x=-120, y=41, lineheight=1) +
  theme_map() +
  theme(legend.title=element_text(size=11), legend.text=element_text(size=11), panel.grid.major=element_line(colour="lightgray", linewidth=0.2), axis.text=element_text(size=10)) +
  guides(
    shape=guide_legend(order=1),
    colour=guide_legend(order=2),
    fill=guide_legend(order=2))


ggsave(
  plot=ggalln,
  filename="/Volumes/Tigrigobius/tgoby/talk/all-n-present.pdf", 
  device=cairo_pdf,  
  width=7, 
  height=10, 
  units="in")

ggsave(
  plot=ggalln,
  filename="/Volumes/Tigrigobius/tgoby/talk/all-n-present.png", 
  device=png,  
  width=7, 
  height=10, 
  dpi=300,
  units="in")
