library(tidyverse)
library(ggvenn)
library(gridExtra)

gene.gff3 <- readRDS(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.0/gene.gff3.RDS")
#gene.gff3 <- select(gene.gff3, -start, -end) |> rename(start=prostart, end=proend) |> arrange(seqid, start)

nSL <- read_tsv(file="/Volumes/Tigrigobius/tgoby/nsl/selscan/outliers999.PROP_CRIT.tsv")

genes.within.regions <- 
  bind_rows(
    filter(gene.gff3, seqid==nSL$CHROM[1], start>=nSL$START[1] & end<=nSL$END[1]) |> mutate(nSL_start=nSL$START[1], nSL_end=nSL$END[1], nSL_pop=nSL$POP[1], nSL_prop_crit=nSL$PROP_CRIT[1]),
    filter(gene.gff3, seqid==nSL$CHROM[2], start>=nSL$START[2] & end<=nSL$END[2]) |> mutate(nSL_start=nSL$START[2], nSL_end=nSL$END[2], nSL_pop=nSL$POP[2], nSL_prop_crit=nSL$PROP_CRIT[2]),
    filter(gene.gff3, seqid==nSL$CHROM[3], start>=nSL$START[3] & end<=nSL$END[3]) |> mutate(nSL_start=nSL$START[3], nSL_end=nSL$END[3], nSL_pop=nSL$POP[3], nSL_prop_crit=nSL$PROP_CRIT[3]),
    filter(gene.gff3, seqid==nSL$CHROM[4], start>=nSL$START[4] & end<=nSL$END[4]) |> mutate(nSL_start=nSL$START[4], nSL_end=nSL$END[4], nSL_pop=nSL$POP[4], nSL_prop_crit=nSL$PROP_CRIT[4]),
    filter(gene.gff3, seqid==nSL$CHROM[5], start>=nSL$START[5] & end<=nSL$END[5]) |> mutate(nSL_start=nSL$START[5], nSL_end=nSL$END[5], nSL_pop=nSL$POP[5], nSL_prop_crit=nSL$PROP_CRIT[5]),
    filter(gene.gff3, seqid==nSL$CHROM[6], start>=nSL$START[6] & end<=nSL$END[6]) |> mutate(nSL_start=nSL$START[6], nSL_end=nSL$END[6], nSL_pop=nSL$POP[6], nSL_prop_crit=nSL$PROP_CRIT[6]),
    filter(gene.gff3, seqid==nSL$CHROM[7], start>=nSL$START[7] & end<=nSL$END[7]) |> mutate(nSL_start=nSL$START[7], nSL_end=nSL$END[7], nSL_pop=nSL$POP[7], nSL_prop_crit=nSL$PROP_CRIT[7]),
    filter(gene.gff3, seqid==nSL$CHROM[8], start>=nSL$START[8] & end<=nSL$END[8]) |> mutate(nSL_start=nSL$START[8], nSL_end=nSL$END[8], nSL_pop=nSL$POP[8], nSL_prop_crit=nSL$PROP_CRIT[8]),
    filter(gene.gff3, seqid==nSL$CHROM[9], start>=nSL$START[9] & end<=nSL$END[9]) |> mutate(nSL_start=nSL$START[9], nSL_end=nSL$END[9], nSL_pop=nSL$POP[9], nSL_prop_crit=nSL$PROP_CRIT[9]),
    filter(gene.gff3, seqid==nSL$CHROM[10], start>=nSL$START[10] & end<=nSL$END[10]) |> mutate(nSL_start=nSL$START[10], nSL_end=nSL$END[10], nSL_pop=nSL$POP[10], nSL_prop_crit=nSL$PROP_CRIT[10]),
    filter(gene.gff3, seqid==nSL$CHROM[11], start>=nSL$START[11] & end<=nSL$END[11]) |> mutate(nSL_start=nSL$START[11], nSL_end=nSL$END[11], nSL_pop=nSL$POP[11], nSL_prop_crit=nSL$PROP_CRIT[11]),
    filter(gene.gff3, seqid==nSL$CHROM[12], start>=nSL$START[12] & end<=nSL$END[12]) |> mutate(nSL_start=nSL$START[12], nSL_end=nSL$END[12], nSL_pop=nSL$POP[12], nSL_prop_crit=nSL$PROP_CRIT[12]),
    filter(gene.gff3, seqid==nSL$CHROM[13], start>=nSL$START[13] & end<=nSL$END[13]) |> mutate(nSL_start=nSL$START[13], nSL_end=nSL$END[13], nSL_pop=nSL$POP[13], nSL_prop_crit=nSL$PROP_CRIT[13]),
    filter(gene.gff3, seqid==nSL$CHROM[14], start>=nSL$START[14] & end<=nSL$END[14]) |> mutate(nSL_start=nSL$START[14], nSL_end=nSL$END[14], nSL_pop=nSL$POP[14], nSL_prop_crit=nSL$PROP_CRIT[14]),
    filter(gene.gff3, seqid==nSL$CHROM[15], start>=nSL$START[15] & end<=nSL$END[15]) |> mutate(nSL_start=nSL$START[15], nSL_end=nSL$END[15], nSL_pop=nSL$POP[15], nSL_prop_crit=nSL$PROP_CRIT[15]),
    filter(gene.gff3, seqid==nSL$CHROM[16], start>=nSL$START[16] & end<=nSL$END[16]) |> mutate(nSL_start=nSL$START[16], nSL_end=nSL$END[16], nSL_pop=nSL$POP[16], nSL_prop_crit=nSL$PROP_CRIT[16]),
    filter(gene.gff3, seqid==nSL$CHROM[17], start>=nSL$START[17] & end<=nSL$END[17]) |> mutate(nSL_start=nSL$START[17], nSL_end=nSL$END[17], nSL_pop=nSL$POP[17], nSL_prop_crit=nSL$PROP_CRIT[17]),
    filter(gene.gff3, seqid==nSL$CHROM[18], start>=nSL$START[18] & end<=nSL$END[18]) |> mutate(nSL_start=nSL$START[18], nSL_end=nSL$END[18], nSL_pop=nSL$POP[18], nSL_prop_crit=nSL$PROP_CRIT[18]),
    filter(gene.gff3, seqid==nSL$CHROM[19], start>=nSL$START[19] & end<=nSL$END[19]) |> mutate(nSL_start=nSL$START[19], nSL_end=nSL$END[19], nSL_pop=nSL$POP[19], nSL_prop_crit=nSL$PROP_CRIT[19]),
    filter(gene.gff3, seqid==nSL$CHROM[20], start>=nSL$START[20] & end<=nSL$END[20]) |> mutate(nSL_start=nSL$START[20], nSL_end=nSL$END[20], nSL_pop=nSL$POP[20], nSL_prop_crit=nSL$PROP_CRIT[20]),
    filter(gene.gff3, seqid==nSL$CHROM[21], start>=nSL$START[21] & end<=nSL$END[21]) |> mutate(nSL_start=nSL$START[21], nSL_end=nSL$END[21], nSL_pop=nSL$POP[21], nSL_prop_crit=nSL$PROP_CRIT[21]),
    filter(gene.gff3, seqid==nSL$CHROM[22], start>=nSL$START[22] & end<=nSL$END[22]) |> mutate(nSL_start=nSL$START[22], nSL_end=nSL$END[22], nSL_pop=nSL$POP[22], nSL_prop_crit=nSL$PROP_CRIT[22]),
    filter(gene.gff3, seqid==nSL$CHROM[23], start>=nSL$START[23] & end<=nSL$END[23]) |> mutate(nSL_start=nSL$START[23], nSL_end=nSL$END[23], nSL_pop=nSL$POP[23], nSL_prop_crit=nSL$PROP_CRIT[23]),
    filter(gene.gff3, seqid==nSL$CHROM[24], start>=nSL$START[24] & end<=nSL$END[24]) |> mutate(nSL_start=nSL$START[24], nSL_end=nSL$END[24], nSL_pop=nSL$POP[24], nSL_prop_crit=nSL$PROP_CRIT[24]),
    filter(gene.gff3, seqid==nSL$CHROM[25], start>=nSL$START[25] & end<=nSL$END[25]) |> mutate(nSL_start=nSL$START[25], nSL_end=nSL$END[25], nSL_pop=nSL$POP[25], nSL_prop_crit=nSL$PROP_CRIT[25]),
    filter(gene.gff3, seqid==nSL$CHROM[26], start>=nSL$START[26] & end<=nSL$END[26]) |> mutate(nSL_start=nSL$START[26], nSL_end=nSL$END[26], nSL_pop=nSL$POP[26], nSL_prop_crit=nSL$PROP_CRIT[26]),
    .id="outlier")
genes.within.regions


genes.starting.in.regions <- 
  bind_rows(
    filter(gene.gff3, seqid==nSL$CHROM[1], between(start, left=nSL$START[1], right=nSL$END[1])) |> mutate(nSL_start=nSL$START[1], nSL_end=nSL$END[1], nSL_pop=nSL$POP[1], nSL_prop_crit=nSL$PROP_CRIT[1]),
    filter(gene.gff3, seqid==nSL$CHROM[2], between(start, left=nSL$START[2], right=nSL$END[2])) |> mutate(nSL_start=nSL$START[2], nSL_end=nSL$END[2], nSL_pop=nSL$POP[2], nSL_prop_crit=nSL$PROP_CRIT[2]),
    filter(gene.gff3, seqid==nSL$CHROM[3], between(start, left=nSL$START[3], right=nSL$END[3])) |> mutate(nSL_start=nSL$START[3], nSL_end=nSL$END[3], nSL_pop=nSL$POP[3], nSL_prop_crit=nSL$PROP_CRIT[3]),
    filter(gene.gff3, seqid==nSL$CHROM[4], between(start, left=nSL$START[4], right=nSL$END[4])) |> mutate(nSL_start=nSL$START[4], nSL_end=nSL$END[4], nSL_pop=nSL$POP[4], nSL_prop_crit=nSL$PROP_CRIT[4]),
    filter(gene.gff3, seqid==nSL$CHROM[5], between(start, left=nSL$START[5], right=nSL$END[5])) |> mutate(nSL_start=nSL$START[5], nSL_end=nSL$END[5], nSL_pop=nSL$POP[5], nSL_prop_crit=nSL$PROP_CRIT[5]),
    filter(gene.gff3, seqid==nSL$CHROM[6], between(start, left=nSL$START[6], right=nSL$END[6])) |> mutate(nSL_start=nSL$START[6], nSL_end=nSL$END[6], nSL_pop=nSL$POP[6], nSL_prop_crit=nSL$PROP_CRIT[6]),
    filter(gene.gff3, seqid==nSL$CHROM[7], between(start, left=nSL$START[7], right=nSL$END[7])) |> mutate(nSL_start=nSL$START[7], nSL_end=nSL$END[7], nSL_pop=nSL$POP[7], nSL_prop_crit=nSL$PROP_CRIT[7]),
    filter(gene.gff3, seqid==nSL$CHROM[8], between(start, left=nSL$START[8], right=nSL$END[8])) |> mutate(nSL_start=nSL$START[8], nSL_end=nSL$END[8], nSL_pop=nSL$POP[8], nSL_prop_crit=nSL$PROP_CRIT[8]),
    filter(gene.gff3, seqid==nSL$CHROM[9], between(start, left=nSL$START[9], right=nSL$END[9])) |> mutate(nSL_start=nSL$START[9], nSL_end=nSL$END[9], nSL_pop=nSL$POP[9], nSL_prop_crit=nSL$PROP_CRIT[9]),
    filter(gene.gff3, seqid==nSL$CHROM[10], between(start, left=nSL$START[10], right=nSL$END[10])) |> mutate(nSL_start=nSL$START[10], nSL_end=nSL$END[10], nSL_pop=nSL$POP[10], nSL_prop_crit=nSL$PROP_CRIT[10]),
    filter(gene.gff3, seqid==nSL$CHROM[11], between(start, left=nSL$START[11], right=nSL$END[11])) |> mutate(nSL_start=nSL$START[11], nSL_end=nSL$END[11], nSL_pop=nSL$POP[11], nSL_prop_crit=nSL$PROP_CRIT[11]),
    filter(gene.gff3, seqid==nSL$CHROM[12], between(start, left=nSL$START[12], right=nSL$END[12])) |> mutate(nSL_start=nSL$START[12], nSL_end=nSL$END[12], nSL_pop=nSL$POP[12], nSL_prop_crit=nSL$PROP_CRIT[12]),
    filter(gene.gff3, seqid==nSL$CHROM[13], between(start, left=nSL$START[13], right=nSL$END[13])) |> mutate(nSL_start=nSL$START[13], nSL_end=nSL$END[13], nSL_pop=nSL$POP[13], nSL_prop_crit=nSL$PROP_CRIT[13]),
    filter(gene.gff3, seqid==nSL$CHROM[14], between(start, left=nSL$START[14], right=nSL$END[14])) |> mutate(nSL_start=nSL$START[14], nSL_end=nSL$END[14], nSL_pop=nSL$POP[14], nSL_prop_crit=nSL$PROP_CRIT[14]),
    filter(gene.gff3, seqid==nSL$CHROM[15], between(start, left=nSL$START[15], right=nSL$END[15])) |> mutate(nSL_start=nSL$START[15], nSL_end=nSL$END[15], nSL_pop=nSL$POP[15], nSL_prop_crit=nSL$PROP_CRIT[15]),
    filter(gene.gff3, seqid==nSL$CHROM[16], between(start, left=nSL$START[16], right=nSL$END[16])) |> mutate(nSL_start=nSL$START[16], nSL_end=nSL$END[16], nSL_pop=nSL$POP[16], nSL_prop_crit=nSL$PROP_CRIT[16]),
    filter(gene.gff3, seqid==nSL$CHROM[17], between(start, left=nSL$START[17], right=nSL$END[17])) |> mutate(nSL_start=nSL$START[17], nSL_end=nSL$END[17], nSL_pop=nSL$POP[17], nSL_prop_crit=nSL$PROP_CRIT[17]),
    filter(gene.gff3, seqid==nSL$CHROM[18], between(start, left=nSL$START[18], right=nSL$END[18])) |> mutate(nSL_start=nSL$START[18], nSL_end=nSL$END[18], nSL_pop=nSL$POP[18], nSL_prop_crit=nSL$PROP_CRIT[18]),
    filter(gene.gff3, seqid==nSL$CHROM[19], between(start, left=nSL$START[19], right=nSL$END[19])) |> mutate(nSL_start=nSL$START[19], nSL_end=nSL$END[19], nSL_pop=nSL$POP[19], nSL_prop_crit=nSL$PROP_CRIT[19]),
    filter(gene.gff3, seqid==nSL$CHROM[20], between(start, left=nSL$START[20], right=nSL$END[20])) |> mutate(nSL_start=nSL$START[20], nSL_end=nSL$END[20], nSL_pop=nSL$POP[20], nSL_prop_crit=nSL$PROP_CRIT[20]),
    filter(gene.gff3, seqid==nSL$CHROM[21], between(start, left=nSL$START[21], right=nSL$END[21])) |> mutate(nSL_start=nSL$START[21], nSL_end=nSL$END[21], nSL_pop=nSL$POP[21], nSL_prop_crit=nSL$PROP_CRIT[21]),
    filter(gene.gff3, seqid==nSL$CHROM[22], between(start, left=nSL$START[22], right=nSL$END[22])) |> mutate(nSL_start=nSL$START[22], nSL_end=nSL$END[22], nSL_pop=nSL$POP[22], nSL_prop_crit=nSL$PROP_CRIT[22]),
    filter(gene.gff3, seqid==nSL$CHROM[23], between(start, left=nSL$START[23], right=nSL$END[23])) |> mutate(nSL_start=nSL$START[23], nSL_end=nSL$END[23], nSL_pop=nSL$POP[23], nSL_prop_crit=nSL$PROP_CRIT[23]),
    filter(gene.gff3, seqid==nSL$CHROM[24], between(start, left=nSL$START[24], right=nSL$END[24])) |> mutate(nSL_start=nSL$START[24], nSL_end=nSL$END[24], nSL_pop=nSL$POP[24], nSL_prop_crit=nSL$PROP_CRIT[24]),
    filter(gene.gff3, seqid==nSL$CHROM[25], between(start, left=nSL$START[25], right=nSL$END[25])) |> mutate(nSL_start=nSL$START[25], nSL_end=nSL$END[25], nSL_pop=nSL$POP[25], nSL_prop_crit=nSL$PROP_CRIT[25]),
    filter(gene.gff3, seqid==nSL$CHROM[26], between(start, left=nSL$START[26], right=nSL$END[26])) |> mutate(nSL_start=nSL$START[26], nSL_end=nSL$END[26], nSL_pop=nSL$POP[26], nSL_prop_crit=nSL$PROP_CRIT[26]),
    .id="outlier")
genes.starting.in.regions

genes.ending.in.regions <- 
  bind_rows(
    filter(gene.gff3, seqid==nSL$CHROM[1], between(end, left=nSL$START[1], right=nSL$END[1])) |> mutate(nSL_start=nSL$START[1], nSL_end=nSL$END[1], nSL_pop=nSL$POP[1], nSL_prop_crit=nSL$PROP_CRIT[1]),
    filter(gene.gff3, seqid==nSL$CHROM[2], between(end, left=nSL$START[2], right=nSL$END[2])) |> mutate(nSL_start=nSL$START[2], nSL_end=nSL$END[2], nSL_pop=nSL$POP[2], nSL_prop_crit=nSL$PROP_CRIT[2]),
    filter(gene.gff3, seqid==nSL$CHROM[3], between(end, left=nSL$START[3], right=nSL$END[3])) |> mutate(nSL_start=nSL$START[3], nSL_end=nSL$END[3], nSL_pop=nSL$POP[3], nSL_prop_crit=nSL$PROP_CRIT[3]),
    filter(gene.gff3, seqid==nSL$CHROM[4], between(end, left=nSL$START[4], right=nSL$END[4])) |> mutate(nSL_start=nSL$START[4], nSL_end=nSL$END[4], nSL_pop=nSL$POP[4], nSL_prop_crit=nSL$PROP_CRIT[4]),
    filter(gene.gff3, seqid==nSL$CHROM[5], between(end, left=nSL$START[5], right=nSL$END[5])) |> mutate(nSL_start=nSL$START[5], nSL_end=nSL$END[5], nSL_pop=nSL$POP[5], nSL_prop_crit=nSL$PROP_CRIT[5]),
    filter(gene.gff3, seqid==nSL$CHROM[6], between(end, left=nSL$START[6], right=nSL$END[6])) |> mutate(nSL_start=nSL$START[6], nSL_end=nSL$END[6], nSL_pop=nSL$POP[6], nSL_prop_crit=nSL$PROP_CRIT[6]),
    filter(gene.gff3, seqid==nSL$CHROM[7], between(end, left=nSL$START[7], right=nSL$END[7])) |> mutate(nSL_start=nSL$START[7], nSL_end=nSL$END[7], nSL_pop=nSL$POP[7], nSL_prop_crit=nSL$PROP_CRIT[7]),
    filter(gene.gff3, seqid==nSL$CHROM[8], between(end, left=nSL$START[8], right=nSL$END[8])) |> mutate(nSL_start=nSL$START[8], nSL_end=nSL$END[8], nSL_pop=nSL$POP[8], nSL_prop_crit=nSL$PROP_CRIT[8]),
    filter(gene.gff3, seqid==nSL$CHROM[9], between(end, left=nSL$START[9], right=nSL$END[9])) |> mutate(nSL_start=nSL$START[9], nSL_end=nSL$END[9], nSL_pop=nSL$POP[9], nSL_prop_crit=nSL$PROP_CRIT[9]),
    filter(gene.gff3, seqid==nSL$CHROM[10], between(end, left=nSL$START[10], right=nSL$END[10])) |> mutate(nSL_start=nSL$START[10], nSL_end=nSL$END[10], nSL_pop=nSL$POP[10], nSL_prop_crit=nSL$PROP_CRIT[10]),
    filter(gene.gff3, seqid==nSL$CHROM[11], between(end, left=nSL$START[11], right=nSL$END[11])) |> mutate(nSL_start=nSL$START[11], nSL_end=nSL$END[11], nSL_pop=nSL$POP[11], nSL_prop_crit=nSL$PROP_CRIT[11]),
    filter(gene.gff3, seqid==nSL$CHROM[12], between(end, left=nSL$START[12], right=nSL$END[12])) |> mutate(nSL_start=nSL$START[12], nSL_end=nSL$END[12], nSL_pop=nSL$POP[12], nSL_prop_crit=nSL$PROP_CRIT[12]),
    filter(gene.gff3, seqid==nSL$CHROM[13], between(end, left=nSL$START[13], right=nSL$END[13])) |> mutate(nSL_start=nSL$START[13], nSL_end=nSL$END[13], nSL_pop=nSL$POP[13], nSL_prop_crit=nSL$PROP_CRIT[13]),
    filter(gene.gff3, seqid==nSL$CHROM[14], between(end, left=nSL$START[14], right=nSL$END[14])) |> mutate(nSL_start=nSL$START[14], nSL_end=nSL$END[14], nSL_pop=nSL$POP[14], nSL_prop_crit=nSL$PROP_CRIT[14]),
    filter(gene.gff3, seqid==nSL$CHROM[15], between(end, left=nSL$START[15], right=nSL$END[15])) |> mutate(nSL_start=nSL$START[15], nSL_end=nSL$END[15], nSL_pop=nSL$POP[15], nSL_prop_crit=nSL$PROP_CRIT[15]),
    filter(gene.gff3, seqid==nSL$CHROM[16], between(end, left=nSL$START[16], right=nSL$END[16])) |> mutate(nSL_start=nSL$START[16], nSL_end=nSL$END[16], nSL_pop=nSL$POP[16], nSL_prop_crit=nSL$PROP_CRIT[16]),
    filter(gene.gff3, seqid==nSL$CHROM[17], between(end, left=nSL$START[17], right=nSL$END[17])) |> mutate(nSL_start=nSL$START[17], nSL_end=nSL$END[17], nSL_pop=nSL$POP[17], nSL_prop_crit=nSL$PROP_CRIT[17]),
    filter(gene.gff3, seqid==nSL$CHROM[18], between(end, left=nSL$START[18], right=nSL$END[18])) |> mutate(nSL_start=nSL$START[18], nSL_end=nSL$END[18], nSL_pop=nSL$POP[18], nSL_prop_crit=nSL$PROP_CRIT[18]),
    filter(gene.gff3, seqid==nSL$CHROM[19], between(end, left=nSL$START[19], right=nSL$END[19])) |> mutate(nSL_start=nSL$START[19], nSL_end=nSL$END[19], nSL_pop=nSL$POP[19], nSL_prop_crit=nSL$PROP_CRIT[19]),
    filter(gene.gff3, seqid==nSL$CHROM[20], between(end, left=nSL$START[20], right=nSL$END[20])) |> mutate(nSL_start=nSL$START[20], nSL_end=nSL$END[20], nSL_pop=nSL$POP[20], nSL_prop_crit=nSL$PROP_CRIT[20]),
    filter(gene.gff3, seqid==nSL$CHROM[21], between(end, left=nSL$START[21], right=nSL$END[21])) |> mutate(nSL_start=nSL$START[21], nSL_end=nSL$END[21], nSL_pop=nSL$POP[21], nSL_prop_crit=nSL$PROP_CRIT[21]),
    filter(gene.gff3, seqid==nSL$CHROM[22], between(end, left=nSL$START[22], right=nSL$END[22])) |> mutate(nSL_start=nSL$START[22], nSL_end=nSL$END[22], nSL_pop=nSL$POP[22], nSL_prop_crit=nSL$PROP_CRIT[22]),
    filter(gene.gff3, seqid==nSL$CHROM[23], between(end, left=nSL$START[23], right=nSL$END[23])) |> mutate(nSL_start=nSL$START[23], nSL_end=nSL$END[23], nSL_pop=nSL$POP[23], nSL_prop_crit=nSL$PROP_CRIT[23]),
    filter(gene.gff3, seqid==nSL$CHROM[24], between(end, left=nSL$START[24], right=nSL$END[24])) |> mutate(nSL_start=nSL$START[24], nSL_end=nSL$END[24], nSL_pop=nSL$POP[24], nSL_prop_crit=nSL$PROP_CRIT[24]),
    filter(gene.gff3, seqid==nSL$CHROM[25], between(end, left=nSL$START[25], right=nSL$END[25])) |> mutate(nSL_start=nSL$START[25], nSL_end=nSL$END[25], nSL_pop=nSL$POP[25], nSL_prop_crit=nSL$PROP_CRIT[25]),
    filter(gene.gff3, seqid==nSL$CHROM[26], between(end, left=nSL$START[26], right=nSL$END[26])) |> mutate(nSL_start=nSL$START[26], nSL_end=nSL$END[26], nSL_pop=nSL$POP[26], nSL_prop_crit=nSL$PROP_CRIT[26]),
    .id="outlier")
genes.ending.in.regions

genes.across.regions <- 
  bind_rows(
    filter(gene.gff3, seqid==nSL$CHROM[1], start<=nSL$START[1] & end>=nSL$END[1]) |> mutate(nSL_start=nSL$START[1], nSL_end=nSL$END[1], nSL_pop=nSL$POP[1], nSL_prop_crit=nSL$PROP_CRIT[1]),
    filter(gene.gff3, seqid==nSL$CHROM[2], start<=nSL$START[2] & end>=nSL$END[2]) |> mutate(nSL_start=nSL$START[2], nSL_end=nSL$END[2], nSL_pop=nSL$POP[2], nSL_prop_crit=nSL$PROP_CRIT[2]),
    filter(gene.gff3, seqid==nSL$CHROM[3], start<=nSL$START[3] & end>=nSL$END[3]) |> mutate(nSL_start=nSL$START[3], nSL_end=nSL$END[3], nSL_pop=nSL$POP[3], nSL_prop_crit=nSL$PROP_CRIT[3]),
    filter(gene.gff3, seqid==nSL$CHROM[4], start<=nSL$START[4] & end>=nSL$END[4]) |> mutate(nSL_start=nSL$START[4], nSL_end=nSL$END[4], nSL_pop=nSL$POP[4], nSL_prop_crit=nSL$PROP_CRIT[4]),
    filter(gene.gff3, seqid==nSL$CHROM[5], start<=nSL$START[5] & end>=nSL$END[5]) |> mutate(nSL_start=nSL$START[5], nSL_end=nSL$END[5], nSL_pop=nSL$POP[5], nSL_prop_crit=nSL$PROP_CRIT[5]),
    filter(gene.gff3, seqid==nSL$CHROM[6], start<=nSL$START[6] & end>=nSL$END[6]) |> mutate(nSL_start=nSL$START[6], nSL_end=nSL$END[6], nSL_pop=nSL$POP[6], nSL_prop_crit=nSL$PROP_CRIT[6]),
    filter(gene.gff3, seqid==nSL$CHROM[7], start<=nSL$START[7] & end>=nSL$END[7]) |> mutate(nSL_start=nSL$START[7], nSL_end=nSL$END[7], nSL_pop=nSL$POP[7], nSL_prop_crit=nSL$PROP_CRIT[7]),
    filter(gene.gff3, seqid==nSL$CHROM[8], start<=nSL$START[8] & end>=nSL$END[8]) |> mutate(nSL_start=nSL$START[8], nSL_end=nSL$END[8], nSL_pop=nSL$POP[8], nSL_prop_crit=nSL$PROP_CRIT[8]),
    filter(gene.gff3, seqid==nSL$CHROM[9], start<=nSL$START[9] & end>=nSL$END[9]) |> mutate(nSL_start=nSL$START[9], nSL_end=nSL$END[9], nSL_pop=nSL$POP[9], nSL_prop_crit=nSL$PROP_CRIT[9]),
    filter(gene.gff3, seqid==nSL$CHROM[10], start<=nSL$START[10] & end>=nSL$END[10]) |> mutate(nSL_start=nSL$START[10], nSL_end=nSL$END[10], nSL_pop=nSL$POP[10], nSL_prop_crit=nSL$PROP_CRIT[10]),
    filter(gene.gff3, seqid==nSL$CHROM[11], start<=nSL$START[11] & end>=nSL$END[11]) |> mutate(nSL_start=nSL$START[11], nSL_end=nSL$END[11], nSL_pop=nSL$POP[11], nSL_prop_crit=nSL$PROP_CRIT[11]),
    filter(gene.gff3, seqid==nSL$CHROM[12], start<=nSL$START[12] & end>=nSL$END[12]) |> mutate(nSL_start=nSL$START[12], nSL_end=nSL$END[12], nSL_pop=nSL$POP[12], nSL_prop_crit=nSL$PROP_CRIT[12]),
    filter(gene.gff3, seqid==nSL$CHROM[13], start<=nSL$START[13] & end>=nSL$END[13]) |> mutate(nSL_start=nSL$START[13], nSL_end=nSL$END[13], nSL_pop=nSL$POP[13], nSL_prop_crit=nSL$PROP_CRIT[13]),
    filter(gene.gff3, seqid==nSL$CHROM[14], start<=nSL$START[14] & end>=nSL$END[14]) |> mutate(nSL_start=nSL$START[14], nSL_end=nSL$END[14], nSL_pop=nSL$POP[14], nSL_prop_crit=nSL$PROP_CRIT[14]),
    filter(gene.gff3, seqid==nSL$CHROM[15], start<=nSL$START[15] & end>=nSL$END[15]) |> mutate(nSL_start=nSL$START[15], nSL_end=nSL$END[15], nSL_pop=nSL$POP[15], nSL_prop_crit=nSL$PROP_CRIT[15]),
    filter(gene.gff3, seqid==nSL$CHROM[16], start<=nSL$START[16] & end>=nSL$END[16]) |> mutate(nSL_start=nSL$START[16], nSL_end=nSL$END[16], nSL_pop=nSL$POP[16], nSL_prop_crit=nSL$PROP_CRIT[16]),
    filter(gene.gff3, seqid==nSL$CHROM[17], start<=nSL$START[17] & end>=nSL$END[17]) |> mutate(nSL_start=nSL$START[17], nSL_end=nSL$END[17], nSL_pop=nSL$POP[17], nSL_prop_crit=nSL$PROP_CRIT[17]),
    filter(gene.gff3, seqid==nSL$CHROM[18], start<=nSL$START[18] & end>=nSL$END[18]) |> mutate(nSL_start=nSL$START[18], nSL_end=nSL$END[18], nSL_pop=nSL$POP[18], nSL_prop_crit=nSL$PROP_CRIT[18]),
    filter(gene.gff3, seqid==nSL$CHROM[19], start<=nSL$START[19] & end>=nSL$END[19]) |> mutate(nSL_start=nSL$START[19], nSL_end=nSL$END[19], nSL_pop=nSL$POP[19], nSL_prop_crit=nSL$PROP_CRIT[19]),
    filter(gene.gff3, seqid==nSL$CHROM[20], start<=nSL$START[20] & end>=nSL$END[20]) |> mutate(nSL_start=nSL$START[20], nSL_end=nSL$END[20], nSL_pop=nSL$POP[20], nSL_prop_crit=nSL$PROP_CRIT[20]),
    filter(gene.gff3, seqid==nSL$CHROM[21], start<=nSL$START[21] & end>=nSL$END[21]) |> mutate(nSL_start=nSL$START[21], nSL_end=nSL$END[21], nSL_pop=nSL$POP[21], nSL_prop_crit=nSL$PROP_CRIT[21]),
    filter(gene.gff3, seqid==nSL$CHROM[22], start<=nSL$START[22] & end>=nSL$END[22]) |> mutate(nSL_start=nSL$START[22], nSL_end=nSL$END[22], nSL_pop=nSL$POP[22], nSL_prop_crit=nSL$PROP_CRIT[22]),
    filter(gene.gff3, seqid==nSL$CHROM[23], start<=nSL$START[23] & end>=nSL$END[23]) |> mutate(nSL_start=nSL$START[23], nSL_end=nSL$END[23], nSL_pop=nSL$POP[23], nSL_prop_crit=nSL$PROP_CRIT[23]),
    filter(gene.gff3, seqid==nSL$CHROM[24], start<=nSL$START[24] & end>=nSL$END[24]) |> mutate(nSL_start=nSL$START[24], nSL_end=nSL$END[24], nSL_pop=nSL$POP[24], nSL_prop_crit=nSL$PROP_CRIT[24]),
    filter(gene.gff3, seqid==nSL$CHROM[25], start<=nSL$START[25] & end>=nSL$END[25]) |> mutate(nSL_start=nSL$START[25], nSL_end=nSL$END[25], nSL_pop=nSL$POP[25], nSL_prop_crit=nSL$PROP_CRIT[25]),
    filter(gene.gff3, seqid==nSL$CHROM[26], start<=nSL$START[26] & end>=nSL$END[26]) |> mutate(nSL_start=nSL$START[26], nSL_end=nSL$END[26], nSL_pop=nSL$POP[26], nSL_prop_crit=nSL$PROP_CRIT[26]),
    .id="outlier")
genes.across.regions

gene.hits.regions <- 
  bind_rows(genes.within.regions, genes.starting.in.regions, genes.ending.in.regions, genes.across.regions) |> 
  distinct(id, PANTHER_accession, nSL_pop, .keep_all=TRUE)

gene.hits.regions <- 
  rename(gene.hits.regions, region=outlier, chrom=seqid) |>
  arrange(chrom, start, nSL_pop)
  
gene.hits.regions <- mutate(gene.hits.regions, loc=paste0(chrom, ":", start, "–", end))
  
write_tsv(x=gene.hits.regions, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.999/nSL_PROP_CRIT.gene.hits.regions.tab")

saveRDS(object=gene.hits.regions, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.999/nSL_PROP_CRIT.gene.hits.regions.RDS")

#
## filter(gene.hits.regions, nSL_pop=="Del Norte-Humboldt") |> 
##   select(id, PANTHER_accession) |> 
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.6/nSL2_NorteHumboldt", col_names=FALSE)

## filter(gene.hits.regions, nSL_pop=="Mendocino") |> 
##   select(id, PANTHER_accession) |> 
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.6/nSL2_Mendocino", col_names=FALSE)

## filter(gene.hits.regions, nSL_pop=="Santa Barbara") |> 
##   select(id, PANTHER_accession) |> 
##   distinct() |>
##   write_tsv(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.6/nSL2_SantaBarbara", col_names=FALSE)


