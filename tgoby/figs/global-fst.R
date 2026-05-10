library(tidyverse)
library(ggthemes)

fst <- 
  read_tsv(file="/Volumes/Tigrigobius/tgoby/stats/fst/global.weir.fst") |>
  filter(!is.nan(WEIR_AND_COCKERHAM_FST))

gg <- 
  ggplot(data=fst, mapping=aes(x=WEIR_AND_COCKERHAM_FST)) + 
  geom_histogram(bins=22, fill="lightgray", color="black") +
  scale_x_continuous(breaks=seq(0,1,0.2)) +
  labs(x=expression(italic(F)[ST]), y="Frequency") +
  theme_base(base_size=11) + 
  theme(
#    axis.text=element_text(size=10), 
    axis.ticks.length=unit(1, units="mm"),
    axis.ticks=element_line(linewidth=0.5),
#    panel.background=element_rect(linetype="blank"),
    panel.border=element_rect(linewidth=0.5),
    plot.background=element_rect(linetype="blank"),
    )
gg

saveRDS(object=gg, file="/Volumes/Tigrigobius/tgoby/figs/global-fst.RDS")

group_by(fst, WEIR_AND_COCKERHAM_FST) |> count(sort=TRUE)

101780/1250159
## 0.08141364 fixation
