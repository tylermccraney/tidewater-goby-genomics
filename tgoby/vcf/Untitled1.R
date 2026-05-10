library(tidyverse)
library(ggthemes)


genome_base = ggplot(NULL) +
  geom_bar(data = chr_dat, 
           aes(x = chr_name, y = chr_len) , 
           stat='identity', 
           fill='grey80', 
           colour='grey80', 
           width=.2) +
  labs(y = "Base pair position", 
       x = "Arctic charr chromosome") +
  theme_minimal() +
  theme_light() +
  theme(panel.border = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank()) + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1),
        axis.ticks.x = element_blank())



genome_base
