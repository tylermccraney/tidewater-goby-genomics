library(tidyverse)
library(RColorBrewer)
library(ggthemes)

setwd(dir="/Volumes/Tigrigobius/tgoby/admixture/")

CVerror <- read_tsv(file="cv.tab")

gg.a <- 
  ggplot(data=CVerror, mapping=aes(x=K, y=`CV error`)) + 
  geom_point(shape=1) + 
  geom_line() +
  scale_x_continuous(breaks=1:10, labels=c("1","","3*","","","","","","","10")) +
  scale_y_continuous(n.breaks=8) +
  theme_classic() +
  labs(y="CV error") +
  theme(
    axis.ticks.length = unit(1, units="mm"),
#    axis.line=element_blank(),
    axis.title.x=element_text(face="italic"),
    line=element_line(lineend="square", linewidth=0.5),
    axis.text=element_text(size=12), 
    axis.title=element_text(size=12),
#    panel.background=element_rect(),
#    panel.border=element_rect(fill=NA, linewidth=0),
#    plot.background=element_rect(linetype="blank"),
    )


ggsave(plot=gg.a, filename="../talk/CVerror.png", device=png, width=2.25, height=1.5, units="in", dpi=300)
ggsave(plot=gg.a, filename="../talk/CVerror.pdf", device=cairo_pdf, width=3, height=2, units="in")

tbl3 <- 
  read_delim(file="pruned.3.Q", col_names=FALSE) |> 
  bind_cols(
    read_delim(file="../plink/pruned.fam", col_names=FALSE) |> 
      select(1))

indv <- select(tbl3, indv=4)

indv <- indv[c(31:36, 25:30, 13:18, 73:78, 1:6, 61:66, 19:24, 79:84, 7:12, 67:72, 49:60, 37:48),]

tbl3 <- 
  left_join(indv, tbl3, by=c("indv"="X1...4")) |>
  select(Q1=3, Q2=2, Q3=4, 1)

#
tbl4 <- 
  read_delim(file="pruned.4.Q", col_names=FALSE) |> 
  bind_cols(
    read_delim(file="../plink/pruned.fam", col_names=FALSE) |> 
      select(1))

tbl4 <- 
  left_join(indv, tbl4, by=c("indv"="X1...5")) |>
  select(Q1=4, Q2=2, Q3=5, Q4=3, 1)

#
tbl5 <- 
  read_delim(file="pruned.5.Q", col_names=FALSE) |> 
  bind_cols(
    read_delim(file="../plink/pruned.fam", col_names=FALSE) |> 
      select(1))

tbl5 <- 
  left_join(indv, tbl5, by=c("indv"="X1...6"))

tbl5 <- 
  select(tbl5, Q1=6, Q2=2, Q3=5, Q4=3, Q5=4, 1)

#
tbl6 <- 
  read_delim(file="pruned.6.Q", col_names=FALSE) |> 
  bind_cols(
    read_delim(file="../plink/pruned.fam", col_names=FALSE) |> 
      select(1))

tbl6 <- 
  left_join(indv, tbl6, by=c("indv"="X1...7"))

tbl6 <-
  select(tbl6, Q1=2, Q2=6, Q3=3, Q4=4, Q5=5, Q6=7, 1)

#
tbl2 <- 
  read_delim(file="pruned.2.Q", col_names=FALSE) |> 
  bind_cols(
    read_delim(file="../plink/pruned.fam", col_names=FALSE) |> 
      select(1))

tbl2 <- 
  left_join(indv, tbl2, by=c("indv"="X1...3")) |>
  select(Q1=2, Q2=3, 1)

#
tbl7 <- 
  read_delim(file="pruned.7.Q", col_names=FALSE) |> 
  bind_cols(
    read_delim(file="../plink/pruned.fam", col_names=FALSE) |> 
      select(1))

tbl7 <- 
  left_join(indv, tbl7, by=c("indv"="X1...8"))

tbl7 <-
  select(tbl7, Q1=3, Q2=4, Q3=7, Q4=2, Q5=5, Q6=6, Q7=8, 1)

#
tbl8 <- 
  read_delim(file="pruned.8.Q", col_names=FALSE) |> 
  bind_cols(
    read_delim(file="../plink/pruned.fam", col_names=FALSE) |> 
      select(1))

tbl8 <- 
  left_join(indv, tbl8, by=c("indv"="X1...9"))

tbl8 <-
  select(tbl8, Q1=7, Q2=8, Q3=3, Q4=5, Q5=2, Q6=9, Q7=4, Q8=6, 1)

#
tbl9 <- 
  read_delim(file="pruned.9.Q", col_names=FALSE) |> 
  bind_cols(
    read_delim(file="../plink/pruned.fam", col_names=FALSE) |> 
      select(1))

tbl9 <- 
  left_join(indv, tbl9, by=c("indv"="X1...10"))

tbl9 <-
  select(tbl9, Q1=10, Q2=7, Q3=6, Q4=9, Q5=4, Q6=2, Q7=5, Q8=3, Q9=8, 1)

#
tbl10 <- 
  read_delim(file="pruned.10.Q", col_names=FALSE) |> 
  bind_cols(
    read_delim(file="../plink/pruned.fam", col_names=FALSE) |> 
      select(1))

tbl10 <- 
  left_join(indv, tbl10, by=c("indv"="X1...11"))

tbl10 <-
  select(tbl10, Q1=10, Q2=7, Q3=11, Q4=3, Q5=4, Q6=9, Q7=8, Q8=5, Q9=6, Q10=2, 1)

tbl1 <- 
  read_delim(file="pruned.1.Q", col_names=FALSE, delim=" ") |> 
  bind_cols(
    read_delim(file="../plink/pruned.fam", col_names=FALSE) |> 
      select(1))

tbl1 <- 
  left_join(indv, tbl1, by=c("indv"="X1...2"))

tbl1 <-
  select(tbl1, Q1=2, 1)



tbl1 <- tbl1[84:1,]
tbl2 <- tbl2[84:1,]
tbl3 <- tbl3[84:1,]
tbl4 <- tbl4[84:1,]
tbl5 <- tbl5[84:1,]
tbl6 <- tbl6[84:1,]
tbl7 <- tbl7[84:1,]
tbl8 <- tbl8[84:1,]
tbl9 <- tbl9[84:1,]
tbl10 <- tbl10[84:1,]

tbl3l <- pivot_longer(tbl3, 1:3, names_to="group", values_to="Q")

tbl3l$group <- factor(tbl3l$group)
tbl3l$indv <- fct_inorder(tbl3l$indv, ordered=TRUE)



ggplot(tbl3l) + 
  geom_bar(aes(y=indv, x=Q, fill=group, group=group), stat="identity", show.legend=FALSE) + 
  scale_fill_manual(values=brewpal2$COLOR1[c(8, 6, 4)]) +
  theme_void()

brewpal2 <- read_tsv(file="../brewpal2.tab")
brewpal2x <- read_tsv(file="../brewpal2x.tab")
barplot(1:10, col=alpha(colour=brewpal2$COLOR2, alpha=1))

dev.off(); plot.new()

png(filename="pruned.3.4.Q.png", width=7, height=13, units="in", res=300)
par(mar=c(5,4,4,2)+0.1, mfrow=c(1,2))
barplot(
  height=t(as.matrix(tbl3[1:3])), 
  col=brewpal2$COLOR1[c(8, 6, 4)],
  xlab=substitute(paste("Ancestry (", italic('K'), "=3*)")),
  ylab=NA, 
  border=NA, 
  space=0,
  horiz=TRUE)
abline(h=c(0,6,12,18,24,36,48,60,72,78,84), lwd=2, col="white")
abline(h=0:84, lwd=0.5, col="white")
barplot(
  height=t(as.matrix(tbl4[1:4])), 
  col=brewpal2$COLOR1[c(10, 8, 6, 4)],
  xlab=substitute(paste("Ancestry (", italic('K'), "=4)")),
  ylab=NA, 
  border=NA, 
  space=0,
  horiz=TRUE)
abline(h=c(0,6,12,18,24,36,48,60,72,78,84), lwd=2, col="white")
abline(h=0:84, lwd=0.5, col="white")
mtext(
  adj=0.5,
  text=pull(brewpal2, Population)|>
    gsub(pattern=" ", replacement="\n"),
  side=2,
  line=3, 
  at=c(3,9,15,21,30,42,54,66,75,81), 
  las=1, 
  col=pull(brewpal2, COLOR1))
mtext(text="b)", outer=TRUE, line=-6, adj=0.01, cex=1.2)
dev.off()



cairo_pdf(filename="pruned.3.4.Q.pdf", width=7, height=13)
par(mar=c(5,4,4,2)+0.1, mfrow=c(1,2))
barplot(
  height=t(as.matrix(tbl3[1:3])), 
  col=brewpal2$COLOR1[c(8, 6, 4)],
  xlab=substitute(paste("Ancestry (", italic('K'), "=3*)")),
  ylab=NA, 
  border=NA, 
  space=0,
  horiz=TRUE)
abline(h=c(0,6,12,18,24,36,48,60,72,78,84), lwd=2, col="white")
abline(h=0:84, lwd=0.5, col="white")
barplot(
  height=t(as.matrix(tbl4[1:4])), 
  col=brewpal2$COLOR1[c(10, 8, 6, 4)],
  xlab=substitute(paste("Ancestry (", italic('K'), "=4)")),
  ylab=NA, 
  border=NA, 
  space=0,
  horiz=TRUE)
abline(h=c(0,6,12,18,24,36,48,60,72,78,84), lwd=2, col="white")
abline(h=0:84, lwd=0.5, col="white")
mtext(
  adj=0.5,
  text=pull(brewpal2, Population)|>
    gsub(pattern=" ", replacement="\n"),
  side=2,
  line=3, 
  at=c(3,9,15,21,30,42,54,66,75,81), 
  las=1, 
  col=pull(brewpal2, COLOR1))
mtext(text="b)", outer=TRUE, line=-6, adj=0.01, cex=1.2)
dev.off()


png(filename="pruned.2-6.Q.png", width=11, height=13, units="in", res=300)
par(mar=c(5, 6, 4, 0)+0.1, mfrow=c(1,5))
barplot(
  height=t(as.matrix(tbl2[1:2])), 
  col=alpha(colour=brewpal2$COLOR1, alpha=0.67)[c(7, 3)],
  xlab=substitute(paste("Ancestry (", italic('K'), "=2)")),
  ylab=NA, 
  border=NA, 
  space=0,
  horiz=TRUE)
abline(h=c(0,6,12,18,24,36,48,60,72,78,84), lwd=2, col="white")
abline(h=0:84, lwd=0.5, col="white")
mtext(
  cex=0.75,
  adj=0.5,
  text=pull(brewpal2, Population)|>
    gsub(pattern=" ", replacement="\n"),
  side=2,
  line=3, 
  at=c(3,9,15,21,30,42,54,66,75,81), 
  las=1, 
  col=pull(brewpal2, COLOR1))
par(mar=c(5, 5.5, 4, 0.5)+0.1)
barplot(
  height=t(as.matrix(tbl3[1:3])), 
  col=alpha(colour=brewpal2$COLOR1, alpha=0.67)[c(7, 5, 3)],
  xlab=substitute(paste("Ancestry (", italic('K'), "=3*)")),
  ylab=NA, 
  border=NA, 
  space=0,
  horiz=TRUE)
abline(h=c(0,6,12,18,24,36,48,60,72,78,84), lwd=2, col="white")
abline(h=0:84, lwd=0.5, col="white")
par(mar=c(5, 5, 4, 1)+0.1)
barplot(
  height=t(as.matrix(tbl4[1:4])), 
  col=alpha(colour=brewpal2$COLOR1, alpha=0.67)[c(9, 7, 5, 3)],
  xlab=substitute(paste("Ancestry (", italic('K'), "=4)")),
  ylab=NA, 
  border=NA, 
  space=0,
  horiz=TRUE)
abline(h=c(0,6,12,18,24,36,48,60,72,78,84), lwd=2, col="white")
abline(h=0:84, lwd=0.5, col="white")
par(mar=c(5, 4.5, 4, 1.5)+0.1)
barplot(
  height=t(as.matrix(tbl5[1:5])), 
  col=alpha(colour=brewpal2$COLOR1, alpha=0.67)[c(9, 8, 7, 5, 3)],
  xlab=substitute(paste("Ancestry (", italic('K'), "=5)")),
  ylab=NA, 
  border=NA, 
  space=0,
  horiz=TRUE)
abline(h=c(0,6,12,18,24,36,48,60,72,78,84), lwd=2, col="white")
abline(h=0:84, lwd=0.5, col="white")
par(mar=c(5, 4, 4, 2)+0.1)
barplot(
  height=t(as.matrix(tbl6[1:6])), 
  col=alpha(colour=brewpal2$COLOR1, alpha=0.67)[c(9, 7, 6, 5, 3, 1)],
  xlab=substitute(paste("Ancestry (", italic('K'), "=6)")),
  ylab=NA, 
  border=NA, 
  space=0,
  horiz=TRUE)
abline(h=c(0,6,12,18,24,36,48,60,72,78,84), lwd=2, col="white")
abline(h=0:84, lwd=0.5, col="white")
mtext(text="b)", outer=TRUE, line=-6, adj=0.01, cex=1.2)
dev.off()


cairo_pdf(filename="pruned.2-6.Q.pdf", width=11, height=13)
par(mar=c(5, 6, 4, 0)+0.1, mfrow=c(1,5))
barplot(
  height=t(as.matrix(tbl2[1:2])), 
  col=alpha(colour=brewpal2$COLOR1, alpha=0.67)[c(7, 3)],
  xlab=substitute(paste("Ancestry (", italic('K'), "=2)")),
  ylab=NA, 
  border=NA, 
  space=0,
  horiz=TRUE)
abline(h=c(0,6,12,18,24,36,48,60,72,78,84), lwd=2, col="white")
abline(h=0:84, lwd=0.5, col="white")
mtext(
  cex=0.75,
  adj=0.5,
  text=pull(brewpal2, Population)|>
    gsub(pattern=" ", replacement="\n"),
  side=2,
  line=3, 
  at=c(3,9,15,21,30,42,54,66,75,81), 
  las=1, 
  col=pull(brewpal2, COLOR1))
par(mar=c(5, 5.5, 4, 0.5)+0.1)
barplot(
  height=t(as.matrix(tbl3[1:3])), 
  col=alpha(colour=brewpal2$COLOR1, alpha=0.67)[c(7, 5, 3)],
  xlab=substitute(paste("Ancestry (", italic('K'), "=3*)")),
  ylab=NA, 
  border=NA, 
  space=0,
  horiz=TRUE)
abline(h=c(0,6,12,18,24,36,48,60,72,78,84), lwd=2, col="white")
abline(h=0:84, lwd=0.5, col="white")
par(mar=c(5, 5, 4, 1)+0.1)
barplot(
  height=t(as.matrix(tbl4[1:4])), 
  col=alpha(colour=brewpal2$COLOR1, alpha=0.67)[c(9, 7, 5, 3)],
  xlab=substitute(paste("Ancestry (", italic('K'), "=4)")),
  ylab=NA, 
  border=NA, 
  space=0,
  horiz=TRUE)
abline(h=c(0,6,12,18,24,36,48,60,72,78,84), lwd=2, col="white")
abline(h=0:84, lwd=0.5, col="white")
par(mar=c(5, 4.5, 4, 1.5)+0.1)
barplot(
  height=t(as.matrix(tbl5[1:5])), 
  col=alpha(colour=brewpal2$COLOR1, alpha=0.67)[c(9, 8, 7, 5, 3)],
  xlab=substitute(paste("Ancestry (", italic('K'), "=5)")),
  ylab=NA, 
  border=NA, 
  space=0,
  horiz=TRUE)
abline(h=c(0,6,12,18,24,36,48,60,72,78,84), lwd=2, col="white")
abline(h=0:84, lwd=0.5, col="white")
par(mar=c(5, 4, 4, 2)+0.1)
barplot(
  height=t(as.matrix(tbl6[1:6])), 
  col=alpha(colour=brewpal2$COLOR1, alpha=0.67)[c(9, 7, 6, 5, 3, 1)],
  xlab=substitute(paste("Ancestry (", italic('K'), "=6)")),
  ylab=NA, 
  border=NA, 
  space=0,
  horiz=TRUE)
abline(h=c(0,6,12,18,24,36,48,60,72,78,84), lwd=2, col="white")
abline(h=0:84, lwd=0.5, col="white")
mtext(text="b)", outer=TRUE, line=-6, adj=0.01, cex=1.2)
dev.off()


















png(filename="pruned.1-10.Q.png", width=9, height=11, units="in", res=300)
par(mar=c(0, 1, 0, 1)+0.0, mfrow=c(1, 11))
barplot(
  axes=FALSE,
  height=t(as.matrix(tbl1[1])), 
  col="white",
  ylab=NA, 
  border=NA, 
  space=0,
  horiz=TRUE)
abline(h=c(0,6,12,18,24,36,48,60,72,78,84), lwd=2, col="white")
abline(h=0:84, lwd=0.5, col="white")
mtext(
  cex=1,
  adj=0.5,
  text=pull(brewpal2, Population)|>
    gsub(pattern=" ", replacement="\n"),
  side=4,
  line=-2, 
  at=c(3,9,15,21,30,42,54,66,75,81), 
  las=1, 
  col=pull(brewpal2, COLOR1))
barplot(
  axes=FALSE,
  height=t(as.matrix(tbl1[1])), 
  col=brewpal2$COLOR1[8],
  ylab=NA, 
  border=NA, 
  space=0,
  horiz=TRUE)
mtext(text=substitute(paste(italic('K'), "=1")), adj=0.5, side=3, line=-2)
abline(h=c(0,6,12,18,24,36,48,60,72,78,84), lwd=2, col="white")
abline(h=0:84, lwd=0.5, col="white")
barplot(
  axes=FALSE,
  height=t(as.matrix(tbl2[1:2])), 
  col=brewpal2$COLOR1[c(8, 4)],
  ylab=NA, 
  border=NA, 
  space=0,
  horiz=TRUE)
abline(h=c(0,6,12,18,24,36,48,60,72,78,84), lwd=2, col="white")
abline(h=0:84, lwd=0.5, col="white")
mtext(text=substitute(paste(italic('K'), "=2")), adj=0.5, side=3, line=-2)
barplot(
  axes=FALSE,
  height=t(as.matrix(tbl3[1:3])), 
  col=brewpal2$COLOR1[c(8, 6, 4)],
  ylab=NA, 
  border=NA, 
  space=0,
  horiz=TRUE)
abline(h=c(0,6,12,18,24,36,48,60,72,78,84), lwd=2, col="white")
abline(h=0:84, lwd=0.5, col="white")
mtext(text=substitute(paste(italic('K'), "=3*")), adj=0.5, side=3, line=-2)
barplot(
  axes=FALSE,
  height=t(as.matrix(tbl4[1:4])), 
  col=brewpal2$COLOR1[c(10, 8, 6, 4)],
  ylab=NA, 
  border=NA, 
  space=0,
  horiz=TRUE)
abline(h=c(0,6,12,18,24,36,48,60,72,78,84), lwd=2, col="white")
abline(h=0:84, lwd=0.5, col="white")
mtext(text=substitute(paste(italic('K'), "=4")), adj=0.5, side=3, line=-2)
barplot(
  axes=FALSE,
  height=t(as.matrix(tbl5[1:5])), 
  col=brewpal2$COLOR1[c(10, 8, 7, 6, 4)],
  ylab=NA, 
  border=NA, 
  space=0,
  horiz=TRUE)
abline(h=c(0,6,12,18,24,36,48,60,72,78,84), lwd=2, col="white")
abline(h=0:84, lwd=0.5, col="white")
mtext(text=substitute(paste(italic('K'), "=5")), adj=0.5, side=3, line=-2)
barplot(
  axes=FALSE,
  height=t(as.matrix(tbl6[1:6])), 
  col=brewpal2$COLOR1[c(10, 8, 6, 5, 4, 2)],
  ylab=NA, 
  border=NA, 
  space=0,
  horiz=TRUE)
abline(h=c(0,6,12,18,24,36,48,60,72,78,84), lwd=2, col="white")
abline(h=0:84, lwd=0.5, col="white")
mtext(text=substitute(paste(italic('K'), "=6")), adj=0.5, side=3, line=-2)
barplot(
  axes=FALSE,
  height=t(as.matrix(tbl7[1:7])), 
  col=brewpal2$COLOR1[c(10, 8, 7, 6, 5, 4, 2)],
  ylab=NA, 
  border=NA, 
  space=0,
  horiz=TRUE)
abline(h=c(0,6,12,18,24,36,48,60,72,78,84), lwd=2, col="white")
abline(h=0:84, lwd=0.5, col="white")
mtext(text=substitute(paste(italic('K'), "=7")), adj=0.5, side=3, line=-2)
barplot(
  axes=FALSE,
  height=t(as.matrix(tbl8[1:8])), 
  col=brewpal2$COLOR1[c(10, 8, 7, 6, 5, 4, 3, 2)],
  ylab=NA, 
  border=NA, 
  space=0,
  horiz=TRUE)
abline(h=c(0,6,12,18,24,36,48,60,72,78,84), lwd=2, col="white")
abline(h=0:84, lwd=0.5, col="white")
mtext(text=substitute(paste(italic('K'), "=8")), adj=0.5, side=3, line=-2)
barplot(
  axes=FALSE,
  height=t(as.matrix(tbl9[1:9])), 
  col=c(brewpal2$COLOR1[c(10, 9, 8)], brewpal2$COLOR2[6], brewpal2$COLOR1[c(6, 5, 4, 2, 1)]),
  ylab=NA, 
  border=NA, 
  space=0,
  horiz=TRUE)
abline(h=c(0,6,12,18,24,36,48,60,72,78,84), lwd=2, col="white")
abline(h=0:84, lwd=0.5, col="white")
mtext(text=substitute(paste(italic('K'), "=9")), adj=0.5, side=3, line=-2)
barplot(
  axes=FALSE,
  height=t(as.matrix(tbl10[1:10])), 
  col=c(brewpal2$COLOR1[10], brewpal2$COLOR2[8], brewpal2$COLOR1[c(8, 7)], brewpal2$COLOR2[6], brewpal2$COLOR1[c(6, 5, 4, 3, 2)]),
  ylab=NA, 
  border=NA, 
  space=0,
  horiz=TRUE)
abline(h=c(0,6,12,18,24,36,48,60,72,78,84), lwd=2, col="white")
abline(h=0:84, lwd=0.5, col="white")
mtext(text=substitute(paste(italic('K'), "=10")), adj=0.5, side=3, line=-2)
mtext(text="b)", outer=TRUE, line=-2, adj=0.01, cex=1.4)
dev.off()



cairo_pdf(filename="pruned.1-10.Q.pdf", width=9, height=11)
par(mar=c(0, 1, 0, 1)+0.0, mfrow=c(1, 11))
barplot(
  axes=FALSE,
  height=t(as.matrix(tbl1[1])), 
  col="white",
  ylab=NA, 
  border=NA, 
  space=0,
  horiz=TRUE)
abline(h=c(0,6,12,18,24,36,48,60,72,78,84), lwd=2, col="white")
abline(h=0:84, lwd=0.5, col="white")
mtext(
  cex=1,
  adj=0.5,
  text=pull(brewpal2, Population)|>
    gsub(pattern=" ", replacement="\n"),
  side=4,
  line=-2, 
  at=c(3,9,15,21,30,42,54,66,75,81), 
  las=1, 
  col=pull(brewpal2, COLOR1))
barplot(
  axes=FALSE,
  height=t(as.matrix(tbl1[1])), 
  col=brewpal2$COLOR1[8],
  ylab=NA, 
  border=NA, 
  space=0,
  horiz=TRUE)
mtext(text=substitute(paste(italic('K'), "=1")), adj=0.5, side=3, line=-2)
abline(h=c(0,6,12,18,24,36,48,60,72,78,84), lwd=2, col="white")
abline(h=0:84, lwd=0.5, col="white")
barplot(
  axes=FALSE,
  height=t(as.matrix(tbl2[1:2])), 
  col=brewpal2$COLOR1[c(8, 4)],
  ylab=NA, 
  border=NA, 
  space=0,
  horiz=TRUE)
abline(h=c(0,6,12,18,24,36,48,60,72,78,84), lwd=2, col="white")
abline(h=0:84, lwd=0.5, col="white")
mtext(text=substitute(paste(italic('K'), "=2")), adj=0.5, side=3, line=-2)
barplot(
  axes=FALSE,
  height=t(as.matrix(tbl3[1:3])), 
  col=brewpal2$COLOR1[c(8, 6, 4)],
  ylab=NA, 
  border=NA, 
  space=0,
  horiz=TRUE)
abline(h=c(0,6,12,18,24,36,48,60,72,78,84), lwd=2, col="white")
abline(h=0:84, lwd=0.5, col="white")
mtext(text=substitute(paste(italic('K'), "=3*")), adj=0.5, side=3, line=-2)
barplot(
  axes=FALSE,
  height=t(as.matrix(tbl4[1:4])), 
  col=brewpal2$COLOR1[c(10, 8, 6, 4)],
  ylab=NA, 
  border=NA, 
  space=0,
  horiz=TRUE)
abline(h=c(0,6,12,18,24,36,48,60,72,78,84), lwd=2, col="white")
abline(h=0:84, lwd=0.5, col="white")
mtext(text=substitute(paste(italic('K'), "=4")), adj=0.5, side=3, line=-2)
barplot(
  axes=FALSE,
  height=t(as.matrix(tbl5[1:5])), 
  col=brewpal2$COLOR1[c(10, 8, 7, 6, 4)],
  ylab=NA, 
  border=NA, 
  space=0,
  horiz=TRUE)
abline(h=c(0,6,12,18,24,36,48,60,72,78,84), lwd=2, col="white")
abline(h=0:84, lwd=0.5, col="white")
mtext(text=substitute(paste(italic('K'), "=5")), adj=0.5, side=3, line=-2)
barplot(
  axes=FALSE,
  height=t(as.matrix(tbl6[1:6])), 
  col=brewpal2$COLOR1[c(10, 8, 6, 5, 4, 2)],
  ylab=NA, 
  border=NA, 
  space=0,
  horiz=TRUE)
abline(h=c(0,6,12,18,24,36,48,60,72,78,84), lwd=2, col="white")
abline(h=0:84, lwd=0.5, col="white")
mtext(text=substitute(paste(italic('K'), "=6")), adj=0.5, side=3, line=-2)
barplot(
  axes=FALSE,
  height=t(as.matrix(tbl7[1:7])), 
  col=brewpal2$COLOR1[c(10, 8, 7, 6, 5, 4, 2)],
  ylab=NA, 
  border=NA, 
  space=0,
  horiz=TRUE)
abline(h=c(0,6,12,18,24,36,48,60,72,78,84), lwd=2, col="white")
abline(h=0:84, lwd=0.5, col="white")
mtext(text=substitute(paste(italic('K'), "=7")), adj=0.5, side=3, line=-2)
barplot(
  axes=FALSE,
  height=t(as.matrix(tbl8[1:8])), 
  col=brewpal2$COLOR1[c(10, 8, 7, 6, 5, 4, 3, 2)],
  ylab=NA, 
  border=NA, 
  space=0,
  horiz=TRUE)
abline(h=c(0,6,12,18,24,36,48,60,72,78,84), lwd=2, col="white")
abline(h=0:84, lwd=0.5, col="white")
mtext(text=substitute(paste(italic('K'), "=8")), adj=0.5, side=3, line=-2)
barplot(
  axes=FALSE,
  height=t(as.matrix(tbl9[1:9])), 
  col=c(brewpal2$COLOR1[c(10, 9, 8)], brewpal2$COLOR2[6], brewpal2$COLOR1[c(6, 5, 4, 2, 1)]),
  ylab=NA, 
  border=NA, 
  space=0,
  horiz=TRUE)
abline(h=c(0,6,12,18,24,36,48,60,72,78,84), lwd=2, col="white")
abline(h=0:84, lwd=0.5, col="white")
mtext(text=substitute(paste(italic('K'), "=9")), adj=0.5, side=3, line=-2)
barplot(
  axes=FALSE,
  height=t(as.matrix(tbl10[1:10])), 
  col=c(brewpal2$COLOR1[10], brewpal2$COLOR2[8], brewpal2$COLOR1[c(8, 7)], brewpal2$COLOR2[6], brewpal2$COLOR1[c(6, 5, 4, 3, 2)]),
  ylab=NA, 
  border=NA, 
  space=0,
  horiz=TRUE)
abline(h=c(0,6,12,18,24,36,48,60,72,78,84), lwd=2, col="white")
abline(h=0:84, lwd=0.5, col="white")
mtext(text=substitute(paste(italic('K'), "=10")), adj=0.5, side=3, line=-2)
mtext(text="b)", outer=TRUE, line=-2, adj=0.01, cex=1.4)
dev.off()

