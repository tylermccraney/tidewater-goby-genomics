library(tidyverse)
library(geosphere)
library(RColorBrewer)
library(tidymodels)
library(ggthemes)
library(ape)

setwd(dir="/Volumes/Tigrigobius/tgoby/stats/fst/")

loc <- read_tsv(file="groups.tsv")

fst <- read_delim(file="pairwise.fst")

dat <- 
  left_join(fst, select(loc, 1:4), by=c("pop1"="SAMPLE")) |> 
  left_join(select(loc, 1:4), by=c("pop2"="SAMPLE"), suffix=c("1", "2"))


dat$KM <- 
  c(distVincentyEllipsoid(p1=dat[1,5:6],p2=dat[1,8:9])/1000,
    distVincentyEllipsoid(p1=dat[2,5:6],p2=dat[2,8:9])/1000,
    distVincentyEllipsoid(p1=dat[3,5:6],p2=dat[3,8:9])/1000,
    distVincentyEllipsoid(p1=dat[4,5:6],p2=dat[4,8:9])/1000,
    distVincentyEllipsoid(p1=dat[5,5:6],p2=dat[5,8:9])/1000,
    distVincentyEllipsoid(p1=dat[6,5:6],p2=dat[6,8:9])/1000,
    distVincentyEllipsoid(p1=dat[7,5:6],p2=dat[7,8:9])/1000,
    distVincentyEllipsoid(p1=dat[8,5:6],p2=dat[8,8:9])/1000,
    distVincentyEllipsoid(p1=dat[9,5:6],p2=dat[9,8:9])/1000,
    distVincentyEllipsoid(p1=dat[10,5:6],p2=dat[10,8:9])/1000,
    distVincentyEllipsoid(p1=dat[11,5:6],p2=dat[11,8:9])/1000,
    distVincentyEllipsoid(p1=dat[12,5:6],p2=dat[12,8:9])/1000,
    distVincentyEllipsoid(p1=dat[13,5:6],p2=dat[13,8:9])/1000,
    distVincentyEllipsoid(p1=dat[14,5:6],p2=dat[14,8:9])/1000,
    distVincentyEllipsoid(p1=dat[15,5:6],p2=dat[15,8:9])/1000,
    distVincentyEllipsoid(p1=dat[16,5:6],p2=dat[16,8:9])/1000,
    distVincentyEllipsoid(p1=dat[17,5:6],p2=dat[17,8:9])/1000,
    distVincentyEllipsoid(p1=dat[18,5:6],p2=dat[18,8:9])/1000,
    distVincentyEllipsoid(p1=dat[19,5:6],p2=dat[19,8:9])/1000,
    distVincentyEllipsoid(p1=dat[20,5:6],p2=dat[20,8:9])/1000,
    distVincentyEllipsoid(p1=dat[21,5:6],p2=dat[21,8:9])/1000,
    distVincentyEllipsoid(p1=dat[22,5:6],p2=dat[22,8:9])/1000,
    distVincentyEllipsoid(p1=dat[23,5:6],p2=dat[23,8:9])/1000,
    distVincentyEllipsoid(p1=dat[24,5:6],p2=dat[24,8:9])/1000,
    distVincentyEllipsoid(p1=dat[25,5:6],p2=dat[25,8:9])/1000,
    distVincentyEllipsoid(p1=dat[26,5:6],p2=dat[26,8:9])/1000,
    distVincentyEllipsoid(p1=dat[27,5:6],p2=dat[27,8:9])/1000,
    distVincentyEllipsoid(p1=dat[28,5:6],p2=dat[28,8:9])/1000,
    distVincentyEllipsoid(p1=dat[29,5:6],p2=dat[29,8:9])/1000,
    distVincentyEllipsoid(p1=dat[30,5:6],p2=dat[30,8:9])/1000,
    distVincentyEllipsoid(p1=dat[31,5:6],p2=dat[31,8:9])/1000,
    distVincentyEllipsoid(p1=dat[32,5:6],p2=dat[32,8:9])/1000,
    distVincentyEllipsoid(p1=dat[33,5:6],p2=dat[33,8:9])/1000,
    distVincentyEllipsoid(p1=dat[34,5:6],p2=dat[34,8:9])/1000,
    distVincentyEllipsoid(p1=dat[35,5:6],p2=dat[35,8:9])/1000,
    distVincentyEllipsoid(p1=dat[36,5:6],p2=dat[36,8:9])/1000,
    distVincentyEllipsoid(p1=dat[37,5:6],p2=dat[37,8:9])/1000,
    distVincentyEllipsoid(p1=dat[38,5:6],p2=dat[38,8:9])/1000,
    distVincentyEllipsoid(p1=dat[39,5:6],p2=dat[39,8:9])/1000,
    distVincentyEllipsoid(p1=dat[40,5:6],p2=dat[40,8:9])/1000,
    distVincentyEllipsoid(p1=dat[41,5:6],p2=dat[41,8:9])/1000,
    distVincentyEllipsoid(p1=dat[42,5:6],p2=dat[42,8:9])/1000,
    distVincentyEllipsoid(p1=dat[43,5:6],p2=dat[43,8:9])/1000,
    distVincentyEllipsoid(p1=dat[44,5:6],p2=dat[44,8:9])/1000,
    distVincentyEllipsoid(p1=dat[45,5:6],p2=dat[45,8:9])/1000,
    distVincentyEllipsoid(p1=dat[46,5:6],p2=dat[46,8:9])/1000,
    distVincentyEllipsoid(p1=dat[47,5:6],p2=dat[47,8:9])/1000,
    distVincentyEllipsoid(p1=dat[48,5:6],p2=dat[48,8:9])/1000,
    distVincentyEllipsoid(p1=dat[49,5:6],p2=dat[49,8:9])/1000,
    distVincentyEllipsoid(p1=dat[50,5:6],p2=dat[50,8:9])/1000,
    distVincentyEllipsoid(p1=dat[51,5:6],p2=dat[51,8:9])/1000,
    distVincentyEllipsoid(p1=dat[52,5:6],p2=dat[52,8:9])/1000,
    distVincentyEllipsoid(p1=dat[53,5:6],p2=dat[53,8:9])/1000,
    distVincentyEllipsoid(p1=dat[54,5:6],p2=dat[54,8:9])/1000,
    distVincentyEllipsoid(p1=dat[55,5:6],p2=dat[55,8:9])/1000,
    distVincentyEllipsoid(p1=dat[56,5:6],p2=dat[56,8:9])/1000,
    distVincentyEllipsoid(p1=dat[57,5:6],p2=dat[57,8:9])/1000,
    distVincentyEllipsoid(p1=dat[58,5:6],p2=dat[58,8:9])/1000,
    distVincentyEllipsoid(p1=dat[59,5:6],p2=dat[59,8:9])/1000,
    distVincentyEllipsoid(p1=dat[60,5:6],p2=dat[60,8:9])/1000,
    distVincentyEllipsoid(p1=dat[61,5:6],p2=dat[61,8:9])/1000,
    distVincentyEllipsoid(p1=dat[62,5:6],p2=dat[62,8:9])/1000,
    distVincentyEllipsoid(p1=dat[63,5:6],p2=dat[63,8:9])/1000,
    distVincentyEllipsoid(p1=dat[64,5:6],p2=dat[64,8:9])/1000,
    distVincentyEllipsoid(p1=dat[65,5:6],p2=dat[65,8:9])/1000,
    distVincentyEllipsoid(p1=dat[66,5:6],p2=dat[66,8:9])/1000,
    distVincentyEllipsoid(p1=dat[67,5:6],p2=dat[67,8:9])/1000,
    distVincentyEllipsoid(p1=dat[68,5:6],p2=dat[68,8:9])/1000,
    distVincentyEllipsoid(p1=dat[69,5:6],p2=dat[69,8:9])/1000,
    distVincentyEllipsoid(p1=dat[70,5:6],p2=dat[70,8:9])/1000,
    distVincentyEllipsoid(p1=dat[71,5:6],p2=dat[71,8:9])/1000,
    distVincentyEllipsoid(p1=dat[72,5:6],p2=dat[72,8:9])/1000,
    distVincentyEllipsoid(p1=dat[73,5:6],p2=dat[73,8:9])/1000,
    distVincentyEllipsoid(p1=dat[74,5:6],p2=dat[74,8:9])/1000,
    distVincentyEllipsoid(p1=dat[75,5:6],p2=dat[75,8:9])/1000,
    distVincentyEllipsoid(p1=dat[76,5:6],p2=dat[76,8:9])/1000,
    distVincentyEllipsoid(p1=dat[77,5:6],p2=dat[77,8:9])/1000,
    distVincentyEllipsoid(p1=dat[78,5:6],p2=dat[78,8:9])/1000,
    distVincentyEllipsoid(p1=dat[79,5:6],p2=dat[79,8:9])/1000,
    distVincentyEllipsoid(p1=dat[80,5:6],p2=dat[80,8:9])/1000,
    distVincentyEllipsoid(p1=dat[81,5:6],p2=dat[81,8:9])/1000,
    distVincentyEllipsoid(p1=dat[82,5:6],p2=dat[82,8:9])/1000,
    distVincentyEllipsoid(p1=dat[83,5:6],p2=dat[83,8:9])/1000,
    distVincentyEllipsoid(p1=dat[84,5:6],p2=dat[84,8:9])/1000,
    distVincentyEllipsoid(p1=dat[85,5:6],p2=dat[85,8:9])/1000,
    distVincentyEllipsoid(p1=dat[86,5:6],p2=dat[86,8:9])/1000,
    distVincentyEllipsoid(p1=dat[87,5:6],p2=dat[87,8:9])/1000,
    distVincentyEllipsoid(p1=dat[88,5:6],p2=dat[88,8:9])/1000,
    distVincentyEllipsoid(p1=dat[89,5:6],p2=dat[89,8:9])/1000,
    distVincentyEllipsoid(p1=dat[90,5:6],p2=dat[90,8:9])/1000,
    distVincentyEllipsoid(p1=dat[91,5:6],p2=dat[91,8:9])/1000)


#write_tsv(dat, file="dat.tsv")

#dat <- read_tsv(file="dat.tsv")


dat <- filter(dat, !grepl("2006", pop1)) |> filter(!grepl("2006", pop2))

dat <- mutate(dat, `FST/(1-FST)`=fst/(1-fst))

dat <- rename(dat, FST=fst)

loc <- loc[-15,]

# FST/(1-FST) ~ KM
ggplot(dat=dat, aes(x=KM, y=`FST/(1-FST)`)) + geom_point() + geom_smooth(method="lm", se=FALSE, color="black")

# FST/(1-FST) ~ KM
lm(`FST/(1-FST)`~KM, data=dat) |> summary()

set.seed(1)
boots <- bootstraps(dat, times=10000, apparent=TRUE)
boots

fit_lm_on_bootstrap <- function(split){lm(`FST/(1-FST)`~KM, analysis(split))}

boot_models <- mutate(boots, model=map(splits, fit_lm_on_bootstrap), coef_info=map(model, tidy))

boot_R2 <- mutate(boot_models, fit=map(model, summary), r.squared=map_dbl(fit, "r.squared")) |> select(id, model, fit, r.squared)
boot_R2

boot_coefs <- unnest(boot_models, coef_info)
boot_coefs

percentile_intervals <- int_pctl(boot_models, coef_info)
percentile_intervals



boot_dat <- 
  bind_rows(
    select(boot_R2, -model, -fit) |> mutate(term="r.squared") |> rename(estimate=r.squared), 
    select(boot_coefs, id, estimate, term)) |> 
  arrange(id, term) |>
  filter(id!="Apparent") |>
  rename(value=estimate, name=term)
boot_dat

boot_results <- 
  group_by(boot_dat, name) |> 
  summarise(
    avg=mean(value), 
    lower=quantile(value, probs=c(0.025)), 
    upper=quantile(value, probs=c(0.975)))

write_tsv(boot_results, file="boot.results.tab")

boot_dat$name <- gsub(pattern="r.squared", replacement=expression(italic(R)^2), x=boot_dat$name)
boot_results$name <- gsub(pattern="r.squared", replacement=expression(italic(R)^2), x=boot_results$name)

boot_dat$name <- factor(boot_dat$name, ordered=TRUE, levels=c("(Intercept)", "KM", "italic(R)^2"))
boot_results$name <- factor(boot_results$name, ordered=TRUE, levels=c("(Intercept)", "KM", "italic(R)^2"))



g <- 
  ggplot(boot_dat, aes(x=value)) +
  geom_histogram(bins=15, linewidth=0.5, fill="lightgray", color="black") +
  facet_wrap(facets=vars(name), ncol=3, nrow=1, scales ="free_x", strip.position="bottom", labeller="label_parsed") +
  theme_base(base_size=10) + 
  labs(x=NULL, y="Frequency", tag="b)") + 
  geom_vline(aes(xintercept=lower), data=boot_results, col=brewer.pal(n=4, name="Dark2")[4], linewidth=0.5, linetype="dashed") +
  geom_vline(aes(xintercept=upper), data=boot_results, col=brewer.pal(n=4, name="Dark2")[4], linewidth=0.5, linetype="dashed") +
  scale_x_continuous(n.breaks=3, expand=expansion(mult=c(0.02, 0.02))) +
#  scale_x_continuous(breaks=c(-0.10, 0.003, 0.1, 0.87, 0.92, 0.97), labels=c("-0.1", "0.003", "0.1", "0.87", "0.92", "0.97"), expand=expansion(mult=c(0.02, 0.02))) +
  scale_y_continuous(expand=expansion(mult=c(0.01, 0.05))) +
  theme(
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
    strip.text=element_text(size=10))



ggsave(plot=g, filename="boots.png", device=png, width=6, height=1.5, units="in", dpi=300)
ggsave(plot=g, filename="boots.pdf", device=cairo_pdf, width=6, height=1.5, units="in")

saveRDS(object=boot_dat, file="boot_dat.RDS")


boot_aug <- 
  boot_models %>% 
  mutate(augmented=map(model, augment)) %>% 
  unnest(augmented)

gg <- 
  ggplot(boot_aug, aes(x=KM, y=`FST/(1-FST)`)) +
  geom_line(aes(y=.fitted, group=id), alpha=0.1, col="gray") +
  geom_smooth(data=dat, mapping=aes(x=KM, y=`FST/(1-FST)`), method="lm", se=FALSE, color="black", linewidth=0.5, alpha=1) +
  geom_point(data=dat, mapping=aes(x=KM, y=`FST/(1-FST)`), pch=1, alpha=1, size=2) + 
  scale_y_continuous(breaks=c(0, 1, 2, 3), labels=c("0.0", "1.0", "2.0", "3.0")) +
  theme_base(base_size=10) +
  labs(y=expression(italic(F)[ST]/(1-italic(F)[ST])), tag="a)") + 
  theme(
    axis.ticks.length=unit(1, units="mm"),
    line=element_line(lineend="square", linewidth=0.4),
    axis.text=element_text(size=10), 
    axis.title=element_text(size=10),
    panel.background=element_rect(linewidth=0.4),
    plot.background=element_rect(linetype="blank"))


ggsave(plot=gg, filename="fst~km.png", device=png, width=6, height=3, units="in", dpi=300)
ggsave(plot=gg, filename="fst~km.pdf", device=cairo_pdf, width=6, height=3, units="in")

write_tsv(dat, file="fst-data.tab")

saveRDS(object=dat, file="dat.RDS")
saveRDS(object=boot_aug, file="boot_aug.RDS")

##
M1 <- matrix(NA, nrow=10, ncol=10, dimnames=list(loc$SAMPLE[c(-3, -5, -7, -9)], loc$SAMPLE[c(-3, -5, -7, -9)]))
M2 <- matrix(NA, nrow=10, ncol=10, dimnames=list(loc$SAMPLE[c(-3, -5, -7, -9)], loc$SAMPLE[c(-3, -5, -7, -9)]))

M1[2:10, 1] <- dat$`FST/(1-FST)`[1:9]
M1[3:10, 2] <- dat$`FST/(1-FST)`[10:17]
M1[4:10, 3] <- dat$`FST/(1-FST)`[18:24]
M1[5:10, 4] <- dat$`FST/(1-FST)`[25:30]
M1[6:10, 5] <- dat$`FST/(1-FST)`[31:35]
M1[7:10, 6] <- dat$`FST/(1-FST)`[36:39]
M1[8:10, 7] <- dat$`FST/(1-FST)`[40:42]
M1[9:10, 8] <- dat$`FST/(1-FST)`[43:44]
M1[10, 9] <- dat$`FST/(1-FST)`[45]

M2[2:10, 1] <- dat$KM[1:9]
M2[3:10, 2] <- dat$KM[10:17]
M2[4:10, 3] <- dat$KM[18:24]
M2[5:10, 4] <- dat$KM[25:30]
M2[6:10, 5] <- dat$KM[31:35]
M2[7:10, 6] <- dat$KM[36:39]
M2[8:10, 7] <- dat$KM[40:42]
M2[9:10, 8] <- dat$KM[43:44]
M2[10, 9] <- dat$KM[45]

M1[is.na(M1)] <- 0
M2[is.na(M2)] <- 0

mantel.test(m1=M1, m2=M2, nperm=10000) |> as_tibble() |> write_tsv(file="Mantel.txt")

cor.test(formula=~`FST/(1-FST)`+KM, data=dat, method="spearman")
