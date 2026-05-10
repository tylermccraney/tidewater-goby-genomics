library(tidyverse)
library(maps)
library(RColorBrewer)
library(ggthemes)

# simple example of BC, Mexico
# get map data
mx <- 
  map_data(
    map="world", 
    region=c("Mexico", "USA"))

# prepare annotation data (could also be imported from CSV or other file)
surfspots <- 
  data.frame(
    x=c(-116.729967, -112.479870), 
    y=c(31.900540, 26.236268),
    label=c("San Miguel Bay", "Scorpion Bay"),
    shape=c(2, 6),
    color=c("red", "purple"))

surfspots

# build map
bajasurfmap <- 
  ggplot(
    data=mx, 
    mapping=aes(x=long, y=lat, group=group)) + 
  geom_polygon(fill="lightgray", color="black") + 
  coord_map(xlim=c(-120, -108), ylim=c(22, 33)) +
  geom_text(
    data=surfspots, 
    mapping=aes(x=x-0.2, y=y, label=label),
    hjust=1,
    inherit.aes=FALSE) +
  geom_point(
    data=surfspots, 
    mapping=aes(x=x, y=y, shape=I(shape), color=I(color)), 
    inherit.aes=FALSE) +
  theme_map()

bajasurfmap

# complex example
ca <- 
  map_data(
    map="state", 
    region=c("california", "oregon", "nevada", "arizona"))

samp <- 
  read_csv(file="/Volumes/Tigrigobius/tgoby/maps/coord.csv") |>
  filter(!is.na(SAMPLE)) |>
  mutate(
    LAT=LATITUDE + c(0.3, -0.1, 0.1, -0.3, 0.2, -0.2, 0.3, -0.2, -0.4, -0.8), 
    LONG=LONGITUDE - c(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.2, -0.3),
    YEAR=as.factor(YEAR))

samp

color <- read_tsv(file="/Volumes/Tigrigobius/tgoby/brewpal2.tab")

color

color$Population <- factor(color$Population) |> fct_inorder(ordered=TRUE) |> fct_rev()

color <- 
  mutate(
    color, 
    County=c(rep("Santa Barbara", 4), rep("Mendocino", 2), rep("Del Norte-Humboldt", 4)) |> factor(ordered=TRUE), 
    shape=c(rep(25, 4), rep(22, 2), rep(24, 4)))

color

samp <- 
  left_join(x=samp, y=color, by=c("POPULATION"="Population")) |> select(-YEAR, -COUNTY, -PCH)

samp <- mutate(samp, POP=gsub(pattern=" ", replacement="\n", x=POPULATION))

samp

basemap <- 
  ggplot(
    data=ca, 
    mapping=aes(x=long, y=lat, group=group)) + 
  geom_polygon(fill="lightgray", color="black") + 
  coord_map(xlim=c(-126.0,-117.5), ylim=c(32.5,42.0)) +
  geom_text(
    data=tibble(
      x=c(-118.25, -124.16, -120.47, -124.41, -122.42),
      y=c(34.05, 40.7, 34.45, 40.44, 37.77), 
      label=c("Los Angeles", "Eureka", "Point Conception", "Cape Mendocino", "San Francisco"),
      hjust=c(0.5, -0.1, 0.0, -0.1, -0.1),
      vjust=c(-0.5, 0.0, -1, 0.5, 0.0)), 
    mapping=aes(x=x, y=y, label=label, hjust=hjust, vjust=vjust), 
    inherit.aes=FALSE) +
  geom_point(
    data=tibble(
      x=c(-118.25, -124.16, -122.42), 
      y=c(34.05, 40.8, 37.77)), 
    mapping=aes(x=x, y=y), 
    inherit.aes=FALSE, 
    shape=13)

basemap

ref <- read_tsv(file="/Volumes/Tigrigobius/tgoby/stats/fst/groups.tsv")[15,]

ref

ref$COLOR1 <- brewer.pal(n=8, name="Dark2")[8]

ref$POP <- "Ref. genome &\ntranscriptome"

ref

samp$LONG[9] <- samp$LONG[9]+0.5

g <- 
  basemap +
  geom_segment(
    data=samp,
    mapping=aes(color=I(COLOR1), x=LONG, xend=LONGITUDE, y=LAT, yend=LATITUDE),
    inherit.aes=FALSE, 
    linetype="dotted") +
  geom_point(
    data=samp,
    mapping=aes(x=LONGITUDE, y=LATITUDE, color=I(COLOR1), fill=I(COLOR1)),
    inherit.aes=FALSE, 
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
  filename="/Volumes/Tigrigobius/tgoby/maps/mapdemo.png", 
  device=png,  
  width=7, 
  height=10, 
  units="in", 
  dpi=300)

ggsave(
  plot=g,
  filename="/Volumes/Tigrigobius/tgoby/maps/mapdemo.pdf", 
  device=cairo_pdf,  
  width=7, 
  height=10, 
  units="in")
