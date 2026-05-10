library(tidyverse)
library(ggvenn)
library(gridExtra)

gene.gff3 <- readRDS(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.0/gene.gff3.RDS")
#gene.gff3 <- select(gene.gff3, -start, -end) |> rename(start=prostart, end=proend) |> arrange(seqid, start)

xpnsl <- read_tsv(file="/Volumes/Tigrigobius/tgoby/xpnsl/selscan/outliers.PROP_CRIT.tsv", col_types="ccnnnnnnnnnnnnnnn")

xpnsl <- filter(xpnsl, PROP_CRIT==1)

genes.within.regions <- 
  bind_rows(
    filter(gene.gff3, seqid==xpnsl$CHROM[1], start>=xpnsl$START[1] & end<=xpnsl$END[1]) |> mutate(xpnsl_start=xpnsl$START[1], xpnsl_end=xpnsl$END[1], xpnsl_pop=xpnsl$samplesA[1], xpnsl_og=xpnsl$samplesB[1]),
    filter(gene.gff3, seqid==xpnsl$CHROM[2], start>=xpnsl$START[2] & end<=xpnsl$END[2]) |> mutate(xpnsl_start=xpnsl$START[2], xpnsl_end=xpnsl$END[2], xpnsl_pop=xpnsl$samplesA[2], xpnsl_og=xpnsl$samplesB[2]),
    filter(gene.gff3, seqid==xpnsl$CHROM[3], start>=xpnsl$START[3] & end<=xpnsl$END[3]) |> mutate(xpnsl_start=xpnsl$START[3], xpnsl_end=xpnsl$END[3], xpnsl_pop=xpnsl$samplesA[3], xpnsl_og=xpnsl$samplesB[3]),
    filter(gene.gff3, seqid==xpnsl$CHROM[4], start>=xpnsl$START[4] & end<=xpnsl$END[4]) |> mutate(xpnsl_start=xpnsl$START[4], xpnsl_end=xpnsl$END[4], xpnsl_pop=xpnsl$samplesA[4], xpnsl_og=xpnsl$samplesB[4]),
    filter(gene.gff3, seqid==xpnsl$CHROM[5], start>=xpnsl$START[5] & end<=xpnsl$END[5]) |> mutate(xpnsl_start=xpnsl$START[5], xpnsl_end=xpnsl$END[5], xpnsl_pop=xpnsl$samplesA[5], xpnsl_og=xpnsl$samplesB[5]),
    filter(gene.gff3, seqid==xpnsl$CHROM[6], start>=xpnsl$START[6] & end<=xpnsl$END[6]) |> mutate(xpnsl_start=xpnsl$START[6], xpnsl_end=xpnsl$END[6], xpnsl_pop=xpnsl$samplesA[6], xpnsl_og=xpnsl$samplesB[6]),
    filter(gene.gff3, seqid==xpnsl$CHROM[7], start>=xpnsl$START[7] & end<=xpnsl$END[7]) |> mutate(xpnsl_start=xpnsl$START[7], xpnsl_end=xpnsl$END[7], xpnsl_pop=xpnsl$samplesA[7], xpnsl_og=xpnsl$samplesB[7]),
    filter(gene.gff3, seqid==xpnsl$CHROM[8], start>=xpnsl$START[8] & end<=xpnsl$END[8]) |> mutate(xpnsl_start=xpnsl$START[8], xpnsl_end=xpnsl$END[8], xpnsl_pop=xpnsl$samplesA[8], xpnsl_og=xpnsl$samplesB[8]),
    filter(gene.gff3, seqid==xpnsl$CHROM[9], start>=xpnsl$START[9] & end<=xpnsl$END[9]) |> mutate(xpnsl_start=xpnsl$START[9], xpnsl_end=xpnsl$END[9], xpnsl_pop=xpnsl$samplesA[9], xpnsl_og=xpnsl$samplesB[9]),
    filter(gene.gff3, seqid==xpnsl$CHROM[10], start>=xpnsl$START[10] & end<=xpnsl$END[10]) |> mutate(xpnsl_start=xpnsl$START[10], xpnsl_end=xpnsl$END[10], xpnsl_pop=xpnsl$samplesA[10], xpnsl_og=xpnsl$samplesB[10]),
    filter(gene.gff3, seqid==xpnsl$CHROM[11], start>=xpnsl$START[11] & end<=xpnsl$END[11]) |> mutate(xpnsl_start=xpnsl$START[11], xpnsl_end=xpnsl$END[11], xpnsl_pop=xpnsl$samplesA[11], xpnsl_og=xpnsl$samplesB[11]),
    filter(gene.gff3, seqid==xpnsl$CHROM[12], start>=xpnsl$START[12] & end<=xpnsl$END[12]) |> mutate(xpnsl_start=xpnsl$START[12], xpnsl_end=xpnsl$END[12], xpnsl_pop=xpnsl$samplesA[12], xpnsl_og=xpnsl$samplesB[12]),
    filter(gene.gff3, seqid==xpnsl$CHROM[13], start>=xpnsl$START[13] & end<=xpnsl$END[13]) |> mutate(xpnsl_start=xpnsl$START[13], xpnsl_end=xpnsl$END[13], xpnsl_pop=xpnsl$samplesA[13], xpnsl_og=xpnsl$samplesB[13]),
    filter(gene.gff3, seqid==xpnsl$CHROM[14], start>=xpnsl$START[14] & end<=xpnsl$END[14]) |> mutate(xpnsl_start=xpnsl$START[14], xpnsl_end=xpnsl$END[14], xpnsl_pop=xpnsl$samplesA[14], xpnsl_og=xpnsl$samplesB[14]),
    filter(gene.gff3, seqid==xpnsl$CHROM[15], start>=xpnsl$START[15] & end<=xpnsl$END[15]) |> mutate(xpnsl_start=xpnsl$START[15], xpnsl_end=xpnsl$END[15], xpnsl_pop=xpnsl$samplesA[15], xpnsl_og=xpnsl$samplesB[15]),
    filter(gene.gff3, seqid==xpnsl$CHROM[16], start>=xpnsl$START[16] & end<=xpnsl$END[16]) |> mutate(xpnsl_start=xpnsl$START[16], xpnsl_end=xpnsl$END[16], xpnsl_pop=xpnsl$samplesA[16], xpnsl_og=xpnsl$samplesB[16]),
    filter(gene.gff3, seqid==xpnsl$CHROM[17], start>=xpnsl$START[17] & end<=xpnsl$END[17]) |> mutate(xpnsl_start=xpnsl$START[17], xpnsl_end=xpnsl$END[17], xpnsl_pop=xpnsl$samplesA[17], xpnsl_og=xpnsl$samplesB[17]),
    filter(gene.gff3, seqid==xpnsl$CHROM[18], start>=xpnsl$START[18] & end<=xpnsl$END[18]) |> mutate(xpnsl_start=xpnsl$START[18], xpnsl_end=xpnsl$END[18], xpnsl_pop=xpnsl$samplesA[18], xpnsl_og=xpnsl$samplesB[18]),
    filter(gene.gff3, seqid==xpnsl$CHROM[19], start>=xpnsl$START[19] & end<=xpnsl$END[19]) |> mutate(xpnsl_start=xpnsl$START[19], xpnsl_end=xpnsl$END[19], xpnsl_pop=xpnsl$samplesA[19], xpnsl_og=xpnsl$samplesB[19]),
    filter(gene.gff3, seqid==xpnsl$CHROM[20], start>=xpnsl$START[20] & end<=xpnsl$END[20]) |> mutate(xpnsl_start=xpnsl$START[20], xpnsl_end=xpnsl$END[20], xpnsl_pop=xpnsl$samplesA[20], xpnsl_og=xpnsl$samplesB[20]),
    filter(gene.gff3, seqid==xpnsl$CHROM[21], start>=xpnsl$START[21] & end<=xpnsl$END[21]) |> mutate(xpnsl_start=xpnsl$START[21], xpnsl_end=xpnsl$END[21], xpnsl_pop=xpnsl$samplesA[21], xpnsl_og=xpnsl$samplesB[21]),
    filter(gene.gff3, seqid==xpnsl$CHROM[22], start>=xpnsl$START[22] & end<=xpnsl$END[22]) |> mutate(xpnsl_start=xpnsl$START[22], xpnsl_end=xpnsl$END[22], xpnsl_pop=xpnsl$samplesA[22], xpnsl_og=xpnsl$samplesB[22]),
    filter(gene.gff3, seqid==xpnsl$CHROM[23], start>=xpnsl$START[23] & end<=xpnsl$END[23]) |> mutate(xpnsl_start=xpnsl$START[23], xpnsl_end=xpnsl$END[23], xpnsl_pop=xpnsl$samplesA[23], xpnsl_og=xpnsl$samplesB[23]),
    filter(gene.gff3, seqid==xpnsl$CHROM[24], start>=xpnsl$START[24] & end<=xpnsl$END[24]) |> mutate(xpnsl_start=xpnsl$START[24], xpnsl_end=xpnsl$END[24], xpnsl_pop=xpnsl$samplesA[24], xpnsl_og=xpnsl$samplesB[24]),
    filter(gene.gff3, seqid==xpnsl$CHROM[25], start>=xpnsl$START[25] & end<=xpnsl$END[25]) |> mutate(xpnsl_start=xpnsl$START[25], xpnsl_end=xpnsl$END[25], xpnsl_pop=xpnsl$samplesA[25], xpnsl_og=xpnsl$samplesB[25]),
    filter(gene.gff3, seqid==xpnsl$CHROM[26], start>=xpnsl$START[26] & end<=xpnsl$END[26]) |> mutate(xpnsl_start=xpnsl$START[26], xpnsl_end=xpnsl$END[26], xpnsl_pop=xpnsl$samplesA[26], xpnsl_og=xpnsl$samplesB[26]),
    filter(gene.gff3, seqid==xpnsl$CHROM[27], start>=xpnsl$START[27] & end<=xpnsl$END[27]) |> mutate(xpnsl_start=xpnsl$START[27], xpnsl_end=xpnsl$END[27], xpnsl_pop=xpnsl$samplesA[27], xpnsl_og=xpnsl$samplesB[27]),
    filter(gene.gff3, seqid==xpnsl$CHROM[28], start>=xpnsl$START[28] & end<=xpnsl$END[28]) |> mutate(xpnsl_start=xpnsl$START[28], xpnsl_end=xpnsl$END[28], xpnsl_pop=xpnsl$samplesA[28], xpnsl_og=xpnsl$samplesB[28]),
    filter(gene.gff3, seqid==xpnsl$CHROM[29], start>=xpnsl$START[29] & end<=xpnsl$END[29]) |> mutate(xpnsl_start=xpnsl$START[29], xpnsl_end=xpnsl$END[29], xpnsl_pop=xpnsl$samplesA[29], xpnsl_og=xpnsl$samplesB[29]),
    filter(gene.gff3, seqid==xpnsl$CHROM[30], start>=xpnsl$START[30] & end<=xpnsl$END[30]) |> mutate(xpnsl_start=xpnsl$START[30], xpnsl_end=xpnsl$END[30], xpnsl_pop=xpnsl$samplesA[30], xpnsl_og=xpnsl$samplesB[30]),
    .id="outlier")
genes.within.regions


genes.starting.in.regions <- 
  bind_rows(
    filter(gene.gff3, seqid==xpnsl$CHROM[1], between(start, left=xpnsl$START[1], right=xpnsl$END[1])) |> mutate(xpnsl_start=xpnsl$START[1], xpnsl_end=xpnsl$END[1], xpnsl_pop=xpnsl$samplesA[1], xpnsl_og=xpnsl$samplesB[1]),
    filter(gene.gff3, seqid==xpnsl$CHROM[2], between(start, left=xpnsl$START[2], right=xpnsl$END[2])) |> mutate(xpnsl_start=xpnsl$START[2], xpnsl_end=xpnsl$END[2], xpnsl_pop=xpnsl$samplesA[2], xpnsl_og=xpnsl$samplesB[2]),
    filter(gene.gff3, seqid==xpnsl$CHROM[3], between(start, left=xpnsl$START[3], right=xpnsl$END[3])) |> mutate(xpnsl_start=xpnsl$START[3], xpnsl_end=xpnsl$END[3], xpnsl_pop=xpnsl$samplesA[3], xpnsl_og=xpnsl$samplesB[3]),
    filter(gene.gff3, seqid==xpnsl$CHROM[4], between(start, left=xpnsl$START[4], right=xpnsl$END[4])) |> mutate(xpnsl_start=xpnsl$START[4], xpnsl_end=xpnsl$END[4], xpnsl_pop=xpnsl$samplesA[4], xpnsl_og=xpnsl$samplesB[4]),
    filter(gene.gff3, seqid==xpnsl$CHROM[5], between(start, left=xpnsl$START[5], right=xpnsl$END[5])) |> mutate(xpnsl_start=xpnsl$START[5], xpnsl_end=xpnsl$END[5], xpnsl_pop=xpnsl$samplesA[5], xpnsl_og=xpnsl$samplesB[5]),
    filter(gene.gff3, seqid==xpnsl$CHROM[6], between(start, left=xpnsl$START[6], right=xpnsl$END[6])) |> mutate(xpnsl_start=xpnsl$START[6], xpnsl_end=xpnsl$END[6], xpnsl_pop=xpnsl$samplesA[6], xpnsl_og=xpnsl$samplesB[6]),
    filter(gene.gff3, seqid==xpnsl$CHROM[7], between(start, left=xpnsl$START[7], right=xpnsl$END[7])) |> mutate(xpnsl_start=xpnsl$START[7], xpnsl_end=xpnsl$END[7], xpnsl_pop=xpnsl$samplesA[7], xpnsl_og=xpnsl$samplesB[7]),
    filter(gene.gff3, seqid==xpnsl$CHROM[8], between(start, left=xpnsl$START[8], right=xpnsl$END[8])) |> mutate(xpnsl_start=xpnsl$START[8], xpnsl_end=xpnsl$END[8], xpnsl_pop=xpnsl$samplesA[8], xpnsl_og=xpnsl$samplesB[8]),
    filter(gene.gff3, seqid==xpnsl$CHROM[9], between(start, left=xpnsl$START[9], right=xpnsl$END[9])) |> mutate(xpnsl_start=xpnsl$START[9], xpnsl_end=xpnsl$END[9], xpnsl_pop=xpnsl$samplesA[9], xpnsl_og=xpnsl$samplesB[9]),
    filter(gene.gff3, seqid==xpnsl$CHROM[10], between(start, left=xpnsl$START[10], right=xpnsl$END[10])) |> mutate(xpnsl_start=xpnsl$START[10], xpnsl_end=xpnsl$END[10], xpnsl_pop=xpnsl$samplesA[10], xpnsl_og=xpnsl$samplesB[10]),
    filter(gene.gff3, seqid==xpnsl$CHROM[11], between(start, left=xpnsl$START[11], right=xpnsl$END[11])) |> mutate(xpnsl_start=xpnsl$START[11], xpnsl_end=xpnsl$END[11], xpnsl_pop=xpnsl$samplesA[11], xpnsl_og=xpnsl$samplesB[11]),
    filter(gene.gff3, seqid==xpnsl$CHROM[12], between(start, left=xpnsl$START[12], right=xpnsl$END[12])) |> mutate(xpnsl_start=xpnsl$START[12], xpnsl_end=xpnsl$END[12], xpnsl_pop=xpnsl$samplesA[12], xpnsl_og=xpnsl$samplesB[12]),
    filter(gene.gff3, seqid==xpnsl$CHROM[13], between(start, left=xpnsl$START[13], right=xpnsl$END[13])) |> mutate(xpnsl_start=xpnsl$START[13], xpnsl_end=xpnsl$END[13], xpnsl_pop=xpnsl$samplesA[13], xpnsl_og=xpnsl$samplesB[13]),
    filter(gene.gff3, seqid==xpnsl$CHROM[14], between(start, left=xpnsl$START[14], right=xpnsl$END[14])) |> mutate(xpnsl_start=xpnsl$START[14], xpnsl_end=xpnsl$END[14], xpnsl_pop=xpnsl$samplesA[14], xpnsl_og=xpnsl$samplesB[14]),
    filter(gene.gff3, seqid==xpnsl$CHROM[15], between(start, left=xpnsl$START[15], right=xpnsl$END[15])) |> mutate(xpnsl_start=xpnsl$START[15], xpnsl_end=xpnsl$END[15], xpnsl_pop=xpnsl$samplesA[15], xpnsl_og=xpnsl$samplesB[15]),
    filter(gene.gff3, seqid==xpnsl$CHROM[16], between(start, left=xpnsl$START[16], right=xpnsl$END[16])) |> mutate(xpnsl_start=xpnsl$START[16], xpnsl_end=xpnsl$END[16], xpnsl_pop=xpnsl$samplesA[16], xpnsl_og=xpnsl$samplesB[16]),
    filter(gene.gff3, seqid==xpnsl$CHROM[17], between(start, left=xpnsl$START[17], right=xpnsl$END[17])) |> mutate(xpnsl_start=xpnsl$START[17], xpnsl_end=xpnsl$END[17], xpnsl_pop=xpnsl$samplesA[17], xpnsl_og=xpnsl$samplesB[17]),
    filter(gene.gff3, seqid==xpnsl$CHROM[18], between(start, left=xpnsl$START[18], right=xpnsl$END[18])) |> mutate(xpnsl_start=xpnsl$START[18], xpnsl_end=xpnsl$END[18], xpnsl_pop=xpnsl$samplesA[18], xpnsl_og=xpnsl$samplesB[18]),
    filter(gene.gff3, seqid==xpnsl$CHROM[19], between(start, left=xpnsl$START[19], right=xpnsl$END[19])) |> mutate(xpnsl_start=xpnsl$START[19], xpnsl_end=xpnsl$END[19], xpnsl_pop=xpnsl$samplesA[19], xpnsl_og=xpnsl$samplesB[19]),
    filter(gene.gff3, seqid==xpnsl$CHROM[20], between(start, left=xpnsl$START[20], right=xpnsl$END[20])) |> mutate(xpnsl_start=xpnsl$START[20], xpnsl_end=xpnsl$END[20], xpnsl_pop=xpnsl$samplesA[20], xpnsl_og=xpnsl$samplesB[20]),
    filter(gene.gff3, seqid==xpnsl$CHROM[21], between(start, left=xpnsl$START[21], right=xpnsl$END[21])) |> mutate(xpnsl_start=xpnsl$START[21], xpnsl_end=xpnsl$END[21], xpnsl_pop=xpnsl$samplesA[21], xpnsl_og=xpnsl$samplesB[21]),
    filter(gene.gff3, seqid==xpnsl$CHROM[22], between(start, left=xpnsl$START[22], right=xpnsl$END[22])) |> mutate(xpnsl_start=xpnsl$START[22], xpnsl_end=xpnsl$END[22], xpnsl_pop=xpnsl$samplesA[22], xpnsl_og=xpnsl$samplesB[22]),
    filter(gene.gff3, seqid==xpnsl$CHROM[23], between(start, left=xpnsl$START[23], right=xpnsl$END[23])) |> mutate(xpnsl_start=xpnsl$START[23], xpnsl_end=xpnsl$END[23], xpnsl_pop=xpnsl$samplesA[23], xpnsl_og=xpnsl$samplesB[23]),
    filter(gene.gff3, seqid==xpnsl$CHROM[24], between(start, left=xpnsl$START[24], right=xpnsl$END[24])) |> mutate(xpnsl_start=xpnsl$START[24], xpnsl_end=xpnsl$END[24], xpnsl_pop=xpnsl$samplesA[24], xpnsl_og=xpnsl$samplesB[24]),
    filter(gene.gff3, seqid==xpnsl$CHROM[25], between(start, left=xpnsl$START[25], right=xpnsl$END[25])) |> mutate(xpnsl_start=xpnsl$START[25], xpnsl_end=xpnsl$END[25], xpnsl_pop=xpnsl$samplesA[25], xpnsl_og=xpnsl$samplesB[25]),
    filter(gene.gff3, seqid==xpnsl$CHROM[26], between(start, left=xpnsl$START[26], right=xpnsl$END[26])) |> mutate(xpnsl_start=xpnsl$START[26], xpnsl_end=xpnsl$END[26], xpnsl_pop=xpnsl$samplesA[26], xpnsl_og=xpnsl$samplesB[26]),
    filter(gene.gff3, seqid==xpnsl$CHROM[27], between(start, left=xpnsl$START[27], right=xpnsl$END[27])) |> mutate(xpnsl_start=xpnsl$START[27], xpnsl_end=xpnsl$END[27], xpnsl_pop=xpnsl$samplesA[27], xpnsl_og=xpnsl$samplesB[27]),
    filter(gene.gff3, seqid==xpnsl$CHROM[28], between(start, left=xpnsl$START[28], right=xpnsl$END[28])) |> mutate(xpnsl_start=xpnsl$START[28], xpnsl_end=xpnsl$END[28], xpnsl_pop=xpnsl$samplesA[28], xpnsl_og=xpnsl$samplesB[28]),
    filter(gene.gff3, seqid==xpnsl$CHROM[29], between(start, left=xpnsl$START[29], right=xpnsl$END[29])) |> mutate(xpnsl_start=xpnsl$START[29], xpnsl_end=xpnsl$END[29], xpnsl_pop=xpnsl$samplesA[29], xpnsl_og=xpnsl$samplesB[29]),
    filter(gene.gff3, seqid==xpnsl$CHROM[30], between(start, left=xpnsl$START[30], right=xpnsl$END[30])) |> mutate(xpnsl_start=xpnsl$START[30], xpnsl_end=xpnsl$END[30], xpnsl_pop=xpnsl$samplesA[30], xpnsl_og=xpnsl$samplesB[30]),
    .id="outlier")
genes.starting.in.regions

genes.ending.in.regions <- 
  bind_rows(
    filter(gene.gff3, seqid==xpnsl$CHROM[1], between(end, left=xpnsl$START[1], right=xpnsl$END[1])) |> mutate(xpnsl_start=xpnsl$START[1], xpnsl_end=xpnsl$END[1], xpnsl_pop=xpnsl$samplesA[1], xpnsl_og=xpnsl$samplesB[1]),
    filter(gene.gff3, seqid==xpnsl$CHROM[2], between(end, left=xpnsl$START[2], right=xpnsl$END[2])) |> mutate(xpnsl_start=xpnsl$START[2], xpnsl_end=xpnsl$END[2], xpnsl_pop=xpnsl$samplesA[2], xpnsl_og=xpnsl$samplesB[2]),
    filter(gene.gff3, seqid==xpnsl$CHROM[3], between(end, left=xpnsl$START[3], right=xpnsl$END[3])) |> mutate(xpnsl_start=xpnsl$START[3], xpnsl_end=xpnsl$END[3], xpnsl_pop=xpnsl$samplesA[3], xpnsl_og=xpnsl$samplesB[3]),
    filter(gene.gff3, seqid==xpnsl$CHROM[4], between(end, left=xpnsl$START[4], right=xpnsl$END[4])) |> mutate(xpnsl_start=xpnsl$START[4], xpnsl_end=xpnsl$END[4], xpnsl_pop=xpnsl$samplesA[4], xpnsl_og=xpnsl$samplesB[4]),
    filter(gene.gff3, seqid==xpnsl$CHROM[5], between(end, left=xpnsl$START[5], right=xpnsl$END[5])) |> mutate(xpnsl_start=xpnsl$START[5], xpnsl_end=xpnsl$END[5], xpnsl_pop=xpnsl$samplesA[5], xpnsl_og=xpnsl$samplesB[5]),
    filter(gene.gff3, seqid==xpnsl$CHROM[6], between(end, left=xpnsl$START[6], right=xpnsl$END[6])) |> mutate(xpnsl_start=xpnsl$START[6], xpnsl_end=xpnsl$END[6], xpnsl_pop=xpnsl$samplesA[6], xpnsl_og=xpnsl$samplesB[6]),
    filter(gene.gff3, seqid==xpnsl$CHROM[7], between(end, left=xpnsl$START[7], right=xpnsl$END[7])) |> mutate(xpnsl_start=xpnsl$START[7], xpnsl_end=xpnsl$END[7], xpnsl_pop=xpnsl$samplesA[7], xpnsl_og=xpnsl$samplesB[7]),
    filter(gene.gff3, seqid==xpnsl$CHROM[8], between(end, left=xpnsl$START[8], right=xpnsl$END[8])) |> mutate(xpnsl_start=xpnsl$START[8], xpnsl_end=xpnsl$END[8], xpnsl_pop=xpnsl$samplesA[8], xpnsl_og=xpnsl$samplesB[8]),
    filter(gene.gff3, seqid==xpnsl$CHROM[9], between(end, left=xpnsl$START[9], right=xpnsl$END[9])) |> mutate(xpnsl_start=xpnsl$START[9], xpnsl_end=xpnsl$END[9], xpnsl_pop=xpnsl$samplesA[9], xpnsl_og=xpnsl$samplesB[9]),
    filter(gene.gff3, seqid==xpnsl$CHROM[10], between(end, left=xpnsl$START[10], right=xpnsl$END[10])) |> mutate(xpnsl_start=xpnsl$START[10], xpnsl_end=xpnsl$END[10], xpnsl_pop=xpnsl$samplesA[10], xpnsl_og=xpnsl$samplesB[10]),
    filter(gene.gff3, seqid==xpnsl$CHROM[11], between(end, left=xpnsl$START[11], right=xpnsl$END[11])) |> mutate(xpnsl_start=xpnsl$START[11], xpnsl_end=xpnsl$END[11], xpnsl_pop=xpnsl$samplesA[11], xpnsl_og=xpnsl$samplesB[11]),
    filter(gene.gff3, seqid==xpnsl$CHROM[12], between(end, left=xpnsl$START[12], right=xpnsl$END[12])) |> mutate(xpnsl_start=xpnsl$START[12], xpnsl_end=xpnsl$END[12], xpnsl_pop=xpnsl$samplesA[12], xpnsl_og=xpnsl$samplesB[12]),
    filter(gene.gff3, seqid==xpnsl$CHROM[13], between(end, left=xpnsl$START[13], right=xpnsl$END[13])) |> mutate(xpnsl_start=xpnsl$START[13], xpnsl_end=xpnsl$END[13], xpnsl_pop=xpnsl$samplesA[13], xpnsl_og=xpnsl$samplesB[13]),
    filter(gene.gff3, seqid==xpnsl$CHROM[14], between(end, left=xpnsl$START[14], right=xpnsl$END[14])) |> mutate(xpnsl_start=xpnsl$START[14], xpnsl_end=xpnsl$END[14], xpnsl_pop=xpnsl$samplesA[14], xpnsl_og=xpnsl$samplesB[14]),
    filter(gene.gff3, seqid==xpnsl$CHROM[15], between(end, left=xpnsl$START[15], right=xpnsl$END[15])) |> mutate(xpnsl_start=xpnsl$START[15], xpnsl_end=xpnsl$END[15], xpnsl_pop=xpnsl$samplesA[15], xpnsl_og=xpnsl$samplesB[15]),
    filter(gene.gff3, seqid==xpnsl$CHROM[16], between(end, left=xpnsl$START[16], right=xpnsl$END[16])) |> mutate(xpnsl_start=xpnsl$START[16], xpnsl_end=xpnsl$END[16], xpnsl_pop=xpnsl$samplesA[16], xpnsl_og=xpnsl$samplesB[16]),
    filter(gene.gff3, seqid==xpnsl$CHROM[17], between(end, left=xpnsl$START[17], right=xpnsl$END[17])) |> mutate(xpnsl_start=xpnsl$START[17], xpnsl_end=xpnsl$END[17], xpnsl_pop=xpnsl$samplesA[17], xpnsl_og=xpnsl$samplesB[17]),
    filter(gene.gff3, seqid==xpnsl$CHROM[18], between(end, left=xpnsl$START[18], right=xpnsl$END[18])) |> mutate(xpnsl_start=xpnsl$START[18], xpnsl_end=xpnsl$END[18], xpnsl_pop=xpnsl$samplesA[18], xpnsl_og=xpnsl$samplesB[18]),
    filter(gene.gff3, seqid==xpnsl$CHROM[19], between(end, left=xpnsl$START[19], right=xpnsl$END[19])) |> mutate(xpnsl_start=xpnsl$START[19], xpnsl_end=xpnsl$END[19], xpnsl_pop=xpnsl$samplesA[19], xpnsl_og=xpnsl$samplesB[19]),
    filter(gene.gff3, seqid==xpnsl$CHROM[20], between(end, left=xpnsl$START[20], right=xpnsl$END[20])) |> mutate(xpnsl_start=xpnsl$START[20], xpnsl_end=xpnsl$END[20], xpnsl_pop=xpnsl$samplesA[20], xpnsl_og=xpnsl$samplesB[20]),
    filter(gene.gff3, seqid==xpnsl$CHROM[21], between(end, left=xpnsl$START[21], right=xpnsl$END[21])) |> mutate(xpnsl_start=xpnsl$START[21], xpnsl_end=xpnsl$END[21], xpnsl_pop=xpnsl$samplesA[21], xpnsl_og=xpnsl$samplesB[21]),
    filter(gene.gff3, seqid==xpnsl$CHROM[22], between(end, left=xpnsl$START[22], right=xpnsl$END[22])) |> mutate(xpnsl_start=xpnsl$START[22], xpnsl_end=xpnsl$END[22], xpnsl_pop=xpnsl$samplesA[22], xpnsl_og=xpnsl$samplesB[22]),
    filter(gene.gff3, seqid==xpnsl$CHROM[23], between(end, left=xpnsl$START[23], right=xpnsl$END[23])) |> mutate(xpnsl_start=xpnsl$START[23], xpnsl_end=xpnsl$END[23], xpnsl_pop=xpnsl$samplesA[23], xpnsl_og=xpnsl$samplesB[23]),
    filter(gene.gff3, seqid==xpnsl$CHROM[24], between(end, left=xpnsl$START[24], right=xpnsl$END[24])) |> mutate(xpnsl_start=xpnsl$START[24], xpnsl_end=xpnsl$END[24], xpnsl_pop=xpnsl$samplesA[24], xpnsl_og=xpnsl$samplesB[24]),
    filter(gene.gff3, seqid==xpnsl$CHROM[25], between(end, left=xpnsl$START[25], right=xpnsl$END[25])) |> mutate(xpnsl_start=xpnsl$START[25], xpnsl_end=xpnsl$END[25], xpnsl_pop=xpnsl$samplesA[25], xpnsl_og=xpnsl$samplesB[25]),
    filter(gene.gff3, seqid==xpnsl$CHROM[26], between(end, left=xpnsl$START[26], right=xpnsl$END[26])) |> mutate(xpnsl_start=xpnsl$START[26], xpnsl_end=xpnsl$END[26], xpnsl_pop=xpnsl$samplesA[26], xpnsl_og=xpnsl$samplesB[26]),
    filter(gene.gff3, seqid==xpnsl$CHROM[27], between(end, left=xpnsl$START[27], right=xpnsl$END[27])) |> mutate(xpnsl_start=xpnsl$START[27], xpnsl_end=xpnsl$END[27], xpnsl_pop=xpnsl$samplesA[27], xpnsl_og=xpnsl$samplesB[27]),
    filter(gene.gff3, seqid==xpnsl$CHROM[28], between(end, left=xpnsl$START[28], right=xpnsl$END[28])) |> mutate(xpnsl_start=xpnsl$START[28], xpnsl_end=xpnsl$END[28], xpnsl_pop=xpnsl$samplesA[28], xpnsl_og=xpnsl$samplesB[28]),
    filter(gene.gff3, seqid==xpnsl$CHROM[29], between(end, left=xpnsl$START[29], right=xpnsl$END[29])) |> mutate(xpnsl_start=xpnsl$START[29], xpnsl_end=xpnsl$END[29], xpnsl_pop=xpnsl$samplesA[29], xpnsl_og=xpnsl$samplesB[29]),
    filter(gene.gff3, seqid==xpnsl$CHROM[30], between(end, left=xpnsl$START[30], right=xpnsl$END[30])) |> mutate(xpnsl_start=xpnsl$START[30], xpnsl_end=xpnsl$END[30], xpnsl_pop=xpnsl$samplesA[30], xpnsl_og=xpnsl$samplesB[30]),
    .id="outlier")
genes.ending.in.regions

genes.across.regions <- 
  bind_rows(
    filter(gene.gff3, seqid==xpnsl$CHROM[1], start<=xpnsl$START[1] & end>=xpnsl$END[1]) |> mutate(xpnsl_start=xpnsl$START[1], xpnsl_end=xpnsl$END[1], xpnsl_pop=xpnsl$samplesA[1], xpnsl_og=xpnsl$samplesB[1]),
    filter(gene.gff3, seqid==xpnsl$CHROM[2], start<=xpnsl$START[2] & end>=xpnsl$END[2]) |> mutate(xpnsl_start=xpnsl$START[2], xpnsl_end=xpnsl$END[2], xpnsl_pop=xpnsl$samplesA[2], xpnsl_og=xpnsl$samplesB[2]),
    filter(gene.gff3, seqid==xpnsl$CHROM[3], start<=xpnsl$START[3] & end>=xpnsl$END[3]) |> mutate(xpnsl_start=xpnsl$START[3], xpnsl_end=xpnsl$END[3], xpnsl_pop=xpnsl$samplesA[3], xpnsl_og=xpnsl$samplesB[3]),
    filter(gene.gff3, seqid==xpnsl$CHROM[4], start<=xpnsl$START[4] & end>=xpnsl$END[4]) |> mutate(xpnsl_start=xpnsl$START[4], xpnsl_end=xpnsl$END[4], xpnsl_pop=xpnsl$samplesA[4], xpnsl_og=xpnsl$samplesB[4]),
    filter(gene.gff3, seqid==xpnsl$CHROM[5], start<=xpnsl$START[5] & end>=xpnsl$END[5]) |> mutate(xpnsl_start=xpnsl$START[5], xpnsl_end=xpnsl$END[5], xpnsl_pop=xpnsl$samplesA[5], xpnsl_og=xpnsl$samplesB[5]),
    filter(gene.gff3, seqid==xpnsl$CHROM[6], start<=xpnsl$START[6] & end>=xpnsl$END[6]) |> mutate(xpnsl_start=xpnsl$START[6], xpnsl_end=xpnsl$END[6], xpnsl_pop=xpnsl$samplesA[6], xpnsl_og=xpnsl$samplesB[6]),
    filter(gene.gff3, seqid==xpnsl$CHROM[7], start<=xpnsl$START[7] & end>=xpnsl$END[7]) |> mutate(xpnsl_start=xpnsl$START[7], xpnsl_end=xpnsl$END[7], xpnsl_pop=xpnsl$samplesA[7], xpnsl_og=xpnsl$samplesB[7]),
    filter(gene.gff3, seqid==xpnsl$CHROM[8], start<=xpnsl$START[8] & end>=xpnsl$END[8]) |> mutate(xpnsl_start=xpnsl$START[8], xpnsl_end=xpnsl$END[8], xpnsl_pop=xpnsl$samplesA[8], xpnsl_og=xpnsl$samplesB[8]),
    filter(gene.gff3, seqid==xpnsl$CHROM[9], start<=xpnsl$START[9] & end>=xpnsl$END[9]) |> mutate(xpnsl_start=xpnsl$START[9], xpnsl_end=xpnsl$END[9], xpnsl_pop=xpnsl$samplesA[9], xpnsl_og=xpnsl$samplesB[9]),
    filter(gene.gff3, seqid==xpnsl$CHROM[10], start<=xpnsl$START[10] & end>=xpnsl$END[10]) |> mutate(xpnsl_start=xpnsl$START[10], xpnsl_end=xpnsl$END[10], xpnsl_pop=xpnsl$samplesA[10], xpnsl_og=xpnsl$samplesB[10]),
    filter(gene.gff3, seqid==xpnsl$CHROM[11], start<=xpnsl$START[11] & end>=xpnsl$END[11]) |> mutate(xpnsl_start=xpnsl$START[11], xpnsl_end=xpnsl$END[11], xpnsl_pop=xpnsl$samplesA[11], xpnsl_og=xpnsl$samplesB[11]),
    filter(gene.gff3, seqid==xpnsl$CHROM[12], start<=xpnsl$START[12] & end>=xpnsl$END[12]) |> mutate(xpnsl_start=xpnsl$START[12], xpnsl_end=xpnsl$END[12], xpnsl_pop=xpnsl$samplesA[12], xpnsl_og=xpnsl$samplesB[12]),
    filter(gene.gff3, seqid==xpnsl$CHROM[13], start<=xpnsl$START[13] & end>=xpnsl$END[13]) |> mutate(xpnsl_start=xpnsl$START[13], xpnsl_end=xpnsl$END[13], xpnsl_pop=xpnsl$samplesA[13], xpnsl_og=xpnsl$samplesB[13]),
    filter(gene.gff3, seqid==xpnsl$CHROM[14], start<=xpnsl$START[14] & end>=xpnsl$END[14]) |> mutate(xpnsl_start=xpnsl$START[14], xpnsl_end=xpnsl$END[14], xpnsl_pop=xpnsl$samplesA[14], xpnsl_og=xpnsl$samplesB[14]),
    filter(gene.gff3, seqid==xpnsl$CHROM[15], start<=xpnsl$START[15] & end>=xpnsl$END[15]) |> mutate(xpnsl_start=xpnsl$START[15], xpnsl_end=xpnsl$END[15], xpnsl_pop=xpnsl$samplesA[15], xpnsl_og=xpnsl$samplesB[15]),
    filter(gene.gff3, seqid==xpnsl$CHROM[16], start<=xpnsl$START[16] & end>=xpnsl$END[16]) |> mutate(xpnsl_start=xpnsl$START[16], xpnsl_end=xpnsl$END[16], xpnsl_pop=xpnsl$samplesA[16], xpnsl_og=xpnsl$samplesB[16]),
    filter(gene.gff3, seqid==xpnsl$CHROM[17], start<=xpnsl$START[17] & end>=xpnsl$END[17]) |> mutate(xpnsl_start=xpnsl$START[17], xpnsl_end=xpnsl$END[17], xpnsl_pop=xpnsl$samplesA[17], xpnsl_og=xpnsl$samplesB[17]),
    filter(gene.gff3, seqid==xpnsl$CHROM[18], start<=xpnsl$START[18] & end>=xpnsl$END[18]) |> mutate(xpnsl_start=xpnsl$START[18], xpnsl_end=xpnsl$END[18], xpnsl_pop=xpnsl$samplesA[18], xpnsl_og=xpnsl$samplesB[18]),
    filter(gene.gff3, seqid==xpnsl$CHROM[19], start<=xpnsl$START[19] & end>=xpnsl$END[19]) |> mutate(xpnsl_start=xpnsl$START[19], xpnsl_end=xpnsl$END[19], xpnsl_pop=xpnsl$samplesA[19], xpnsl_og=xpnsl$samplesB[19]),
    filter(gene.gff3, seqid==xpnsl$CHROM[20], start<=xpnsl$START[20] & end>=xpnsl$END[20]) |> mutate(xpnsl_start=xpnsl$START[20], xpnsl_end=xpnsl$END[20], xpnsl_pop=xpnsl$samplesA[20], xpnsl_og=xpnsl$samplesB[20]),
    filter(gene.gff3, seqid==xpnsl$CHROM[21], start<=xpnsl$START[21] & end>=xpnsl$END[21]) |> mutate(xpnsl_start=xpnsl$START[21], xpnsl_end=xpnsl$END[21], xpnsl_pop=xpnsl$samplesA[21], xpnsl_og=xpnsl$samplesB[21]),
    filter(gene.gff3, seqid==xpnsl$CHROM[22], start<=xpnsl$START[22] & end>=xpnsl$END[22]) |> mutate(xpnsl_start=xpnsl$START[22], xpnsl_end=xpnsl$END[22], xpnsl_pop=xpnsl$samplesA[22], xpnsl_og=xpnsl$samplesB[22]),
    filter(gene.gff3, seqid==xpnsl$CHROM[23], start<=xpnsl$START[23] & end>=xpnsl$END[23]) |> mutate(xpnsl_start=xpnsl$START[23], xpnsl_end=xpnsl$END[23], xpnsl_pop=xpnsl$samplesA[23], xpnsl_og=xpnsl$samplesB[23]),
    filter(gene.gff3, seqid==xpnsl$CHROM[24], start<=xpnsl$START[24] & end>=xpnsl$END[24]) |> mutate(xpnsl_start=xpnsl$START[24], xpnsl_end=xpnsl$END[24], xpnsl_pop=xpnsl$samplesA[24], xpnsl_og=xpnsl$samplesB[24]),
    filter(gene.gff3, seqid==xpnsl$CHROM[25], start<=xpnsl$START[25] & end>=xpnsl$END[25]) |> mutate(xpnsl_start=xpnsl$START[25], xpnsl_end=xpnsl$END[25], xpnsl_pop=xpnsl$samplesA[25], xpnsl_og=xpnsl$samplesB[25]),
    filter(gene.gff3, seqid==xpnsl$CHROM[26], start<=xpnsl$START[26] & end>=xpnsl$END[26]) |> mutate(xpnsl_start=xpnsl$START[26], xpnsl_end=xpnsl$END[26], xpnsl_pop=xpnsl$samplesA[26], xpnsl_og=xpnsl$samplesB[26]),
    filter(gene.gff3, seqid==xpnsl$CHROM[27], start<=xpnsl$START[27] & end>=xpnsl$END[27]) |> mutate(xpnsl_start=xpnsl$START[27], xpnsl_end=xpnsl$END[27], xpnsl_pop=xpnsl$samplesA[27], xpnsl_og=xpnsl$samplesB[27]),
    filter(gene.gff3, seqid==xpnsl$CHROM[28], start<=xpnsl$START[28] & end>=xpnsl$END[28]) |> mutate(xpnsl_start=xpnsl$START[28], xpnsl_end=xpnsl$END[28], xpnsl_pop=xpnsl$samplesA[28], xpnsl_og=xpnsl$samplesB[28]),
    filter(gene.gff3, seqid==xpnsl$CHROM[29], start<=xpnsl$START[29] & end>=xpnsl$END[29]) |> mutate(xpnsl_start=xpnsl$START[29], xpnsl_end=xpnsl$END[29], xpnsl_pop=xpnsl$samplesA[29], xpnsl_og=xpnsl$samplesB[29]),
    filter(gene.gff3, seqid==xpnsl$CHROM[30], start<=xpnsl$START[30] & end>=xpnsl$END[30]) |> mutate(xpnsl_start=xpnsl$START[30], xpnsl_end=xpnsl$END[30], xpnsl_pop=xpnsl$samplesA[30], xpnsl_og=xpnsl$samplesB[30]),
    .id="outlier")
genes.across.regions

gene.hits.regions <- 
  bind_rows(genes.within.regions, genes.starting.in.regions, genes.ending.in.regions, genes.across.regions) |> 
  distinct(id, PANTHER_accession, xpnsl_pop, xpnsl_og, .keep_all=TRUE)

gene.hits.regions <- 
  rename(gene.hits.regions, region=outlier, chrom=seqid) |>
  arrange(chrom, start, xpnsl_pop, xpnsl_og)
  
gene.hits.regions <- mutate(gene.hits.regions, loc=paste0(chrom, ":", start, "–", end))
  
write_tsv(x=gene.hits.regions, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.3/XP-nSL_PROP_CRIT.gene.hits.regions.tab")

saveRDS(object=gene.hits.regions, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.3/XP-nSL_PROP_CRIT.gene.hits.regions.RDS")
