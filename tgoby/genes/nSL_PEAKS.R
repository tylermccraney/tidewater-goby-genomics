library(tidyverse)
library(ggvenn)
library(gridExtra)

gene.gff3 <- readRDS(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.0/gene.gff3.RDS")
#gene.gff3 <- select(gene.gff3, -start, -end) |> rename(start=prostart, end=proend) |> arrange(seqid, start)

nSL <- read_tsv(file="/Volumes/Tigrigobius/tgoby/nsl/selscan/peaks10.tab")

peaks.within.genes <- 
  bind_rows(
    filter(gene.gff3, seqid==nSL$CHROM[1], start<=nSL$POS[1] & end>=nSL$POS[1]) |> mutate(nSL_chrom=nSL$CHROM[1], nSL_pos=nSL$POS[1], nSL_pop=nSL$POP[1]),
    filter(gene.gff3, seqid==nSL$CHROM[2], start<=nSL$POS[2] & end>=nSL$POS[2]) |> mutate(nSL_chrom=nSL$CHROM[2], nSL_pos=nSL$POS[2], nSL_pop=nSL$POP[2]),
    filter(gene.gff3, seqid==nSL$CHROM[3], start<=nSL$POS[3] & end>=nSL$POS[3]) |> mutate(nSL_chrom=nSL$CHROM[3], nSL_pos=nSL$POS[3], nSL_pop=nSL$POP[3]),
    filter(gene.gff3, seqid==nSL$CHROM[4], start<=nSL$POS[4] & end>=nSL$POS[4]) |> mutate(nSL_chrom=nSL$CHROM[4], nSL_pos=nSL$POS[4], nSL_pop=nSL$POP[4]),
    filter(gene.gff3, seqid==nSL$CHROM[5], start<=nSL$POS[5] & end>=nSL$POS[5]) |> mutate(nSL_chrom=nSL$CHROM[5], nSL_pos=nSL$POS[5], nSL_pop=nSL$POP[5]),
    filter(gene.gff3, seqid==nSL$CHROM[6], start<=nSL$POS[6] & end>=nSL$POS[6]) |> mutate(nSL_chrom=nSL$CHROM[6], nSL_pos=nSL$POS[6], nSL_pop=nSL$POP[6]),
    filter(gene.gff3, seqid==nSL$CHROM[7], start<=nSL$POS[7] & end>=nSL$POS[7]) |> mutate(nSL_chrom=nSL$CHROM[7], nSL_pos=nSL$POS[7], nSL_pop=nSL$POP[7]),
    filter(gene.gff3, seqid==nSL$CHROM[8], start<=nSL$POS[8] & end>=nSL$POS[8]) |> mutate(nSL_chrom=nSL$CHROM[8], nSL_pos=nSL$POS[8], nSL_pop=nSL$POP[8]),
    filter(gene.gff3, seqid==nSL$CHROM[9], start<=nSL$POS[9] & end>=nSL$POS[9]) |> mutate(nSL_chrom=nSL$CHROM[9], nSL_pos=nSL$POS[9], nSL_pop=nSL$POP[9]),
    filter(gene.gff3, seqid==nSL$CHROM[10], start<=nSL$POS[10] & end>=nSL$POS[10]) |> mutate(nSL_chrom=nSL$CHROM[10], nSL_pos=nSL$POS[10], nSL_pop=nSL$POP[10]),
    filter(gene.gff3, seqid==nSL$CHROM[11], start<=nSL$POS[11] & end>=nSL$POS[11]) |> mutate(nSL_chrom=nSL$CHROM[11], nSL_pos=nSL$POS[11], nSL_pop=nSL$POP[11]),
    filter(gene.gff3, seqid==nSL$CHROM[12], start<=nSL$POS[12] & end>=nSL$POS[12]) |> mutate(nSL_chrom=nSL$CHROM[12], nSL_pos=nSL$POS[12], nSL_pop=nSL$POP[12]),
    filter(gene.gff3, seqid==nSL$CHROM[13], start<=nSL$POS[13] & end>=nSL$POS[13]) |> mutate(nSL_chrom=nSL$CHROM[13], nSL_pos=nSL$POS[13], nSL_pop=nSL$POP[13]),
    filter(gene.gff3, seqid==nSL$CHROM[14], start<=nSL$POS[14] & end>=nSL$POS[14]) |> mutate(nSL_chrom=nSL$CHROM[14], nSL_pos=nSL$POS[14], nSL_pop=nSL$POP[14]),
    filter(gene.gff3, seqid==nSL$CHROM[15], start<=nSL$POS[15] & end>=nSL$POS[15]) |> mutate(nSL_chrom=nSL$CHROM[15], nSL_pos=nSL$POS[15], nSL_pop=nSL$POP[15]),
    filter(gene.gff3, seqid==nSL$CHROM[16], start<=nSL$POS[16] & end>=nSL$POS[16]) |> mutate(nSL_chrom=nSL$CHROM[16], nSL_pos=nSL$POS[16], nSL_pop=nSL$POP[16]),
    filter(gene.gff3, seqid==nSL$CHROM[17], start<=nSL$POS[17] & end>=nSL$POS[17]) |> mutate(nSL_chrom=nSL$CHROM[17], nSL_pos=nSL$POS[17], nSL_pop=nSL$POP[17]),
    filter(gene.gff3, seqid==nSL$CHROM[18], start<=nSL$POS[18] & end>=nSL$POS[18]) |> mutate(nSL_chrom=nSL$CHROM[18], nSL_pos=nSL$POS[18], nSL_pop=nSL$POP[18]),
    filter(gene.gff3, seqid==nSL$CHROM[19], start<=nSL$POS[19] & end>=nSL$POS[19]) |> mutate(nSL_chrom=nSL$CHROM[19], nSL_pos=nSL$POS[19], nSL_pop=nSL$POP[19]),
    filter(gene.gff3, seqid==nSL$CHROM[20], start<=nSL$POS[20] & end>=nSL$POS[20]) |> mutate(nSL_chrom=nSL$CHROM[20], nSL_pos=nSL$POS[20], nSL_pop=nSL$POP[20]),
    filter(gene.gff3, seqid==nSL$CHROM[21], start<=nSL$POS[21] & end>=nSL$POS[21]) |> mutate(nSL_chrom=nSL$CHROM[21], nSL_pos=nSL$POS[21], nSL_pop=nSL$POP[21]),
    filter(gene.gff3, seqid==nSL$CHROM[22], start<=nSL$POS[22] & end>=nSL$POS[22]) |> mutate(nSL_chrom=nSL$CHROM[22], nSL_pos=nSL$POS[22], nSL_pop=nSL$POP[22]),
    filter(gene.gff3, seqid==nSL$CHROM[23], start<=nSL$POS[23] & end>=nSL$POS[23]) |> mutate(nSL_chrom=nSL$CHROM[23], nSL_pos=nSL$POS[23], nSL_pop=nSL$POP[23]),
    filter(gene.gff3, seqid==nSL$CHROM[24], start<=nSL$POS[24] & end>=nSL$POS[24]) |> mutate(nSL_chrom=nSL$CHROM[24], nSL_pos=nSL$POS[24], nSL_pop=nSL$POP[24]),
    filter(gene.gff3, seqid==nSL$CHROM[25], start<=nSL$POS[25] & end>=nSL$POS[25]) |> mutate(nSL_chrom=nSL$CHROM[25], nSL_pos=nSL$POS[25], nSL_pop=nSL$POP[25]),
    filter(gene.gff3, seqid==nSL$CHROM[26], start<=nSL$POS[26] & end>=nSL$POS[26]) |> mutate(nSL_chrom=nSL$CHROM[26], nSL_pos=nSL$POS[26], nSL_pop=nSL$POP[26]),
    filter(gene.gff3, seqid==nSL$CHROM[27], start<=nSL$POS[27] & end>=nSL$POS[27]) |> mutate(nSL_chrom=nSL$CHROM[27], nSL_pos=nSL$POS[27], nSL_pop=nSL$POP[27]),
    filter(gene.gff3, seqid==nSL$CHROM[28], start<=nSL$POS[28] & end>=nSL$POS[28]) |> mutate(nSL_chrom=nSL$CHROM[28], nSL_pos=nSL$POS[28], nSL_pop=nSL$POP[28]),
    filter(gene.gff3, seqid==nSL$CHROM[29], start<=nSL$POS[29] & end>=nSL$POS[29]) |> mutate(nSL_chrom=nSL$CHROM[29], nSL_pos=nSL$POS[29], nSL_pop=nSL$POP[29]),
    filter(gene.gff3, seqid==nSL$CHROM[30], start<=nSL$POS[30] & end>=nSL$POS[30]) |> mutate(nSL_chrom=nSL$CHROM[30], nSL_pos=nSL$POS[30], nSL_pop=nSL$POP[30]),
    .id="outlier")
peaks.within.genes

top10 <- 
  bind_rows(
    filter(gene.gff3, seqid==nSL$CHROM[1], start<=nSL$POS[1] , end>=nSL$POS[1]) |> mutate(nSL_chrom=nSL$CHROM[1], nSL_pos=nSL$POS[1], nSL_pop=nSL$POP[1]),
    filter(gene.gff3, seqid==nSL$CHROM[2], start<=nSL$POS[2] , end>=nSL$POS[2]) |> mutate(nSL_chrom=nSL$CHROM[2], nSL_pos=nSL$POS[2], nSL_pop=nSL$POP[2]),
    filter(gene.gff3, seqid==nSL$CHROM[3], start>=nSL$POS[3]-100000 , end<=nSL$POS[3]+100000) |> mutate(nSL_chrom=nSL$CHROM[3], nSL_pos=nSL$POS[3], nSL_pop=nSL$POP[3]),
    filter(gene.gff3, seqid==nSL$CHROM[4], start<=nSL$POS[4] , end>=nSL$POS[4]) |> mutate(nSL_chrom=nSL$CHROM[4], nSL_pos=nSL$POS[4], nSL_pop=nSL$POP[4]),
    filter(gene.gff3, seqid==nSL$CHROM[5], start>=nSL$POS[5]-5000 , end<=nSL$POS[5]+5000) |> mutate(nSL_chrom=nSL$CHROM[5], nSL_pos=nSL$POS[5], nSL_pop=nSL$POP[5]),
    filter(gene.gff3, seqid==nSL$CHROM[6], start>=nSL$POS[6]-5000 , end<=nSL$POS[6]+5000) |> mutate(nSL_chrom=nSL$CHROM[6], nSL_pos=nSL$POS[6], nSL_pop=nSL$POP[6]),
    filter(gene.gff3, seqid==nSL$CHROM[7], start>=nSL$POS[7]-50000 , end<=nSL$POS[7]+50000) |> mutate(nSL_chrom=nSL$CHROM[7], nSL_pos=nSL$POS[7], nSL_pop=nSL$POP[7]),
    filter(gene.gff3, seqid==nSL$CHROM[8], start>=nSL$POS[8]-80000 , end<=nSL$POS[8]+80000) |> mutate(nSL_chrom=nSL$CHROM[8], nSL_pos=nSL$POS[8], nSL_pop=nSL$POP[8]),
    filter(gene.gff3, seqid==nSL$CHROM[9], start>=nSL$POS[9]-160000 , end<=nSL$POS[9]+160000) |> mutate(nSL_chrom=nSL$CHROM[9], nSL_pos=nSL$POS[9], nSL_pop=nSL$POP[9]),
    filter(gene.gff3, seqid==nSL$CHROM[10], start<=nSL$POS[10] , end>=nSL$POS[10]) |> mutate(nSL_chrom=nSL$CHROM[10], nSL_pos=nSL$POS[10], nSL_pop=nSL$POP[10]),
    filter(gene.gff3, seqid==nSL$CHROM[11], start>=nSL$POS[11]-170000 , end<=nSL$POS[11]+170000) |> mutate(nSL_chrom=nSL$CHROM[11], nSL_pos=nSL$POS[11], nSL_pop=nSL$POP[11]),
    filter(gene.gff3, seqid==nSL$CHROM[12], start>=nSL$POS[12]-10000 , end<=nSL$POS[12]+10000) |> mutate(nSL_chrom=nSL$CHROM[12], nSL_pos=nSL$POS[12], nSL_pop=nSL$POP[12]),
    filter(gene.gff3, seqid==nSL$CHROM[13], start<=nSL$POS[13] , end>=nSL$POS[13]) |> mutate(nSL_chrom=nSL$CHROM[13], nSL_pos=nSL$POS[13], nSL_pop=nSL$POP[13]),
    filter(gene.gff3, seqid==nSL$CHROM[14], start>=nSL$POS[14]-50000 , end<=nSL$POS[14]+50000) |> mutate(nSL_chrom=nSL$CHROM[14], nSL_pos=nSL$POS[14], nSL_pop=nSL$POP[14]),
    filter(gene.gff3, seqid==nSL$CHROM[15], start>=nSL$POS[15]-70000 , end<=nSL$POS[15]+70000) |> mutate(nSL_chrom=nSL$CHROM[15], nSL_pos=nSL$POS[15], nSL_pop=nSL$POP[15]),
    filter(gene.gff3, seqid==nSL$CHROM[16], start>=nSL$POS[16]-200000 , end<=nSL$POS[16]+200000) |> mutate(nSL_chrom=nSL$CHROM[16], nSL_pos=nSL$POS[16], nSL_pop=nSL$POP[16]),
    filter(gene.gff3, seqid==nSL$CHROM[17], start<=nSL$POS[17] , end>=nSL$POS[17]) |> mutate(nSL_chrom=nSL$CHROM[17], nSL_pos=nSL$POS[17], nSL_pop=nSL$POP[17]),
    filter(gene.gff3, seqid==nSL$CHROM[18], start>=nSL$POS[18]-70000 , end<=nSL$POS[18]+70000) |> mutate(nSL_chrom=nSL$CHROM[18], nSL_pos=nSL$POS[18], nSL_pop=nSL$POP[18]),
    filter(gene.gff3, seqid==nSL$CHROM[19], start>=nSL$POS[19]-25000 , end<=nSL$POS[19]+25000) |> mutate(nSL_chrom=nSL$CHROM[19], nSL_pos=nSL$POS[19], nSL_pop=nSL$POP[19]),
    filter(gene.gff3, seqid==nSL$CHROM[20], start<=nSL$POS[20] , end>=nSL$POS[20]) |> mutate(nSL_chrom=nSL$CHROM[20], nSL_pos=nSL$POS[20], nSL_pop=nSL$POP[20]),
    filter(gene.gff3, seqid==nSL$CHROM[21], start<=nSL$POS[21] , end>=nSL$POS[21]) |> mutate(nSL_chrom=nSL$CHROM[21], nSL_pos=nSL$POS[21], nSL_pop=nSL$POP[21]),
    filter(gene.gff3, seqid==nSL$CHROM[22], start<=nSL$POS[22] , end>=nSL$POS[22]) |> mutate(nSL_chrom=nSL$CHROM[22], nSL_pos=nSL$POS[22], nSL_pop=nSL$POP[22]),
    filter(gene.gff3, seqid==nSL$CHROM[23], start>=nSL$POS[23]-250000 , end<=nSL$POS[23]+250000) |> mutate(nSL_chrom=nSL$CHROM[23], nSL_pos=nSL$POS[23], nSL_pop=nSL$POP[23]),
    filter(gene.gff3, seqid==nSL$CHROM[24], start<=nSL$POS[24] , end>=nSL$POS[24]) |> mutate(nSL_chrom=nSL$CHROM[24], nSL_pos=nSL$POS[24], nSL_pop=nSL$POP[24]),
    filter(gene.gff3, seqid==nSL$CHROM[25], start>=nSL$POS[25]-50000 , end<=nSL$POS[25]+50000) |> mutate(nSL_chrom=nSL$CHROM[25], nSL_pos=nSL$POS[25], nSL_pop=nSL$POP[25]),
    filter(gene.gff3, seqid==nSL$CHROM[26], start>=nSL$POS[26]-80000 , end<=nSL$POS[26]+80000) |> mutate(nSL_chrom=nSL$CHROM[26], nSL_pos=nSL$POS[26], nSL_pop=nSL$POP[26]),
    filter(gene.gff3, seqid==nSL$CHROM[27], start>=nSL$POS[27]-80000 , end<=nSL$POS[27]+80000) |> mutate(nSL_chrom=nSL$CHROM[27], nSL_pos=nSL$POS[27], nSL_pop=nSL$POP[27]),
    filter(gene.gff3, seqid==nSL$CHROM[28], start<=nSL$POS[28] , end>=nSL$POS[28]) |> mutate(nSL_chrom=nSL$CHROM[28], nSL_pos=nSL$POS[28], nSL_pop=nSL$POP[28]),
    filter(gene.gff3, seqid==nSL$CHROM[29], start>=nSL$POS[29]-50000 , end<=nSL$POS[29]+50000) |> mutate(nSL_chrom=nSL$CHROM[29], nSL_pos=nSL$POS[29], nSL_pop=nSL$POP[29]),
    filter(gene.gff3, seqid==nSL$CHROM[30], start<=nSL$POS[30] , end>=nSL$POS[30]) |> mutate(nSL_chrom=nSL$CHROM[30], nSL_pos=nSL$POS[30], nSL_pop=nSL$POP[30]),
    .id="outlier")
top10

top10 <- 
  distinct(top10, id, PANTHER_accession, nSL_pop, .keep_all=TRUE)

top10 <- 
  rename(top10, peak=outlier, chrom=seqid, pop=nSL_pop) |>
  arrange(pop, chrom, start)

top10 <- mutate(top10, loc=paste0(chrom, ":", start, "–", end))

write_tsv(x=top10, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.4/nSL.gene.hits.peaks.tab")

saveRDS(object=top10, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.4/nSL.gene.hits.peaks.RDS")

