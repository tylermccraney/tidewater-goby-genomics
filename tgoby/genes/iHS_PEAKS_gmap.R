library(tidyverse)
library(ggvenn)
library(gridExtra)

gene.gff3 <- readRDS(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.0/gene.gff3.RDS")
#gene.gff3 <- select(gene.gff3, -start, -end) |> rename(start=prostart, end=proend) |> arrange(seqid, start)

iHS <- read_tsv(file="/Volumes/Tigrigobius/tgoby/ihs/selscan/gmap/peaks10.tab")

peaks.within.genes <- 
  bind_rows(
    filter(gene.gff3, seqid==iHS$CHROM[1], start<=iHS$POS[1] & end>=iHS$POS[1]) |> mutate(iHS_chrom=iHS$CHROM[1], iHS_pos=iHS$POS[1], iHS_pop=iHS$POP[1]),
    filter(gene.gff3, seqid==iHS$CHROM[2], start<=iHS$POS[2] & end>=iHS$POS[2]) |> mutate(iHS_chrom=iHS$CHROM[2], iHS_pos=iHS$POS[2], iHS_pop=iHS$POP[2]),
    filter(gene.gff3, seqid==iHS$CHROM[3], start<=iHS$POS[3] & end>=iHS$POS[3]) |> mutate(iHS_chrom=iHS$CHROM[3], iHS_pos=iHS$POS[3], iHS_pop=iHS$POP[3]),
    filter(gene.gff3, seqid==iHS$CHROM[4], start<=iHS$POS[4] & end>=iHS$POS[4]) |> mutate(iHS_chrom=iHS$CHROM[4], iHS_pos=iHS$POS[4], iHS_pop=iHS$POP[4]),
    filter(gene.gff3, seqid==iHS$CHROM[5], start<=iHS$POS[5] & end>=iHS$POS[5]) |> mutate(iHS_chrom=iHS$CHROM[5], iHS_pos=iHS$POS[5], iHS_pop=iHS$POP[5]),
    filter(gene.gff3, seqid==iHS$CHROM[6], start<=iHS$POS[6] & end>=iHS$POS[6]) |> mutate(iHS_chrom=iHS$CHROM[6], iHS_pos=iHS$POS[6], iHS_pop=iHS$POP[6]),
    filter(gene.gff3, seqid==iHS$CHROM[7], start<=iHS$POS[7] & end>=iHS$POS[7]) |> mutate(iHS_chrom=iHS$CHROM[7], iHS_pos=iHS$POS[7], iHS_pop=iHS$POP[7]),
    filter(gene.gff3, seqid==iHS$CHROM[8], start<=iHS$POS[8] & end>=iHS$POS[8]) |> mutate(iHS_chrom=iHS$CHROM[8], iHS_pos=iHS$POS[8], iHS_pop=iHS$POP[8]),
    filter(gene.gff3, seqid==iHS$CHROM[9], start<=iHS$POS[9] & end>=iHS$POS[9]) |> mutate(iHS_chrom=iHS$CHROM[9], iHS_pos=iHS$POS[9], iHS_pop=iHS$POP[9]),
    filter(gene.gff3, seqid==iHS$CHROM[10], start<=iHS$POS[10] & end>=iHS$POS[10]) |> mutate(iHS_chrom=iHS$CHROM[10], iHS_pos=iHS$POS[10], iHS_pop=iHS$POP[10]),
    filter(gene.gff3, seqid==iHS$CHROM[11], start<=iHS$POS[11] & end>=iHS$POS[11]) |> mutate(iHS_chrom=iHS$CHROM[11], iHS_pos=iHS$POS[11], iHS_pop=iHS$POP[11]),
    filter(gene.gff3, seqid==iHS$CHROM[12], start<=iHS$POS[12] & end>=iHS$POS[12]) |> mutate(iHS_chrom=iHS$CHROM[12], iHS_pos=iHS$POS[12], iHS_pop=iHS$POP[12]),
    filter(gene.gff3, seqid==iHS$CHROM[13], start<=iHS$POS[13] & end>=iHS$POS[13]) |> mutate(iHS_chrom=iHS$CHROM[13], iHS_pos=iHS$POS[13], iHS_pop=iHS$POP[13]),
    filter(gene.gff3, seqid==iHS$CHROM[14], start<=iHS$POS[14] & end>=iHS$POS[14]) |> mutate(iHS_chrom=iHS$CHROM[14], iHS_pos=iHS$POS[14], iHS_pop=iHS$POP[14]),
    filter(gene.gff3, seqid==iHS$CHROM[15], start<=iHS$POS[15] & end>=iHS$POS[15]) |> mutate(iHS_chrom=iHS$CHROM[15], iHS_pos=iHS$POS[15], iHS_pop=iHS$POP[15]),
    filter(gene.gff3, seqid==iHS$CHROM[16], start<=iHS$POS[16] & end>=iHS$POS[16]) |> mutate(iHS_chrom=iHS$CHROM[16], iHS_pos=iHS$POS[16], iHS_pop=iHS$POP[16]),
    filter(gene.gff3, seqid==iHS$CHROM[17], start<=iHS$POS[17] & end>=iHS$POS[17]) |> mutate(iHS_chrom=iHS$CHROM[17], iHS_pos=iHS$POS[17], iHS_pop=iHS$POP[17]),
    filter(gene.gff3, seqid==iHS$CHROM[18], start<=iHS$POS[18] & end>=iHS$POS[18]) |> mutate(iHS_chrom=iHS$CHROM[18], iHS_pos=iHS$POS[18], iHS_pop=iHS$POP[18]),
    filter(gene.gff3, seqid==iHS$CHROM[19], start<=iHS$POS[19] & end>=iHS$POS[19]) |> mutate(iHS_chrom=iHS$CHROM[19], iHS_pos=iHS$POS[19], iHS_pop=iHS$POP[19]),
    filter(gene.gff3, seqid==iHS$CHROM[20], start<=iHS$POS[20] & end>=iHS$POS[20]) |> mutate(iHS_chrom=iHS$CHROM[20], iHS_pos=iHS$POS[20], iHS_pop=iHS$POP[20]),
    filter(gene.gff3, seqid==iHS$CHROM[21], start<=iHS$POS[21] & end>=iHS$POS[21]) |> mutate(iHS_chrom=iHS$CHROM[21], iHS_pos=iHS$POS[21], iHS_pop=iHS$POP[21]),
    filter(gene.gff3, seqid==iHS$CHROM[22], start<=iHS$POS[22] & end>=iHS$POS[22]) |> mutate(iHS_chrom=iHS$CHROM[22], iHS_pos=iHS$POS[22], iHS_pop=iHS$POP[22]),
    filter(gene.gff3, seqid==iHS$CHROM[23], start<=iHS$POS[23] & end>=iHS$POS[23]) |> mutate(iHS_chrom=iHS$CHROM[23], iHS_pos=iHS$POS[23], iHS_pop=iHS$POP[23]),
    filter(gene.gff3, seqid==iHS$CHROM[24], start<=iHS$POS[24] & end>=iHS$POS[24]) |> mutate(iHS_chrom=iHS$CHROM[24], iHS_pos=iHS$POS[24], iHS_pop=iHS$POP[24]),
    filter(gene.gff3, seqid==iHS$CHROM[25], start<=iHS$POS[25] & end>=iHS$POS[25]) |> mutate(iHS_chrom=iHS$CHROM[25], iHS_pos=iHS$POS[25], iHS_pop=iHS$POP[25]),
    filter(gene.gff3, seqid==iHS$CHROM[26], start<=iHS$POS[26] & end>=iHS$POS[26]) |> mutate(iHS_chrom=iHS$CHROM[26], iHS_pos=iHS$POS[26], iHS_pop=iHS$POP[26]),
    filter(gene.gff3, seqid==iHS$CHROM[27], start<=iHS$POS[27] & end>=iHS$POS[27]) |> mutate(iHS_chrom=iHS$CHROM[27], iHS_pos=iHS$POS[27], iHS_pop=iHS$POP[27]),
    filter(gene.gff3, seqid==iHS$CHROM[28], start<=iHS$POS[28] & end>=iHS$POS[28]) |> mutate(iHS_chrom=iHS$CHROM[28], iHS_pos=iHS$POS[28], iHS_pop=iHS$POP[28]),
    filter(gene.gff3, seqid==iHS$CHROM[29], start<=iHS$POS[29] & end>=iHS$POS[29]) |> mutate(iHS_chrom=iHS$CHROM[29], iHS_pos=iHS$POS[29], iHS_pop=iHS$POP[29]),
    filter(gene.gff3, seqid==iHS$CHROM[30], start<=iHS$POS[30] & end>=iHS$POS[30]) |> mutate(iHS_chrom=iHS$CHROM[30], iHS_pos=iHS$POS[30], iHS_pop=iHS$POP[30]),
    filter(gene.gff3, seqid==iHS$CHROM[31], start<=iHS$POS[31] & end>=iHS$POS[31]) |> mutate(iHS_chrom=iHS$CHROM[31], iHS_pos=iHS$POS[31], iHS_pop=iHS$POP[31]),
    filter(gene.gff3, seqid==iHS$CHROM[32], start<=iHS$POS[32] & end>=iHS$POS[32]) |> mutate(iHS_chrom=iHS$CHROM[32], iHS_pos=iHS$POS[32], iHS_pop=iHS$POP[32]),
    filter(gene.gff3, seqid==iHS$CHROM[33], start<=iHS$POS[33] & end>=iHS$POS[33]) |> mutate(iHS_chrom=iHS$CHROM[33], iHS_pos=iHS$POS[33], iHS_pop=iHS$POP[33]),
    filter(gene.gff3, seqid==iHS$CHROM[34], start<=iHS$POS[34] & end>=iHS$POS[34]) |> mutate(iHS_chrom=iHS$CHROM[34], iHS_pos=iHS$POS[34], iHS_pop=iHS$POP[34]),
    filter(gene.gff3, seqid==iHS$CHROM[35], start<=iHS$POS[35] & end>=iHS$POS[35]) |> mutate(iHS_chrom=iHS$CHROM[35], iHS_pos=iHS$POS[35], iHS_pop=iHS$POP[35]),
    filter(gene.gff3, seqid==iHS$CHROM[36], start<=iHS$POS[36] & end>=iHS$POS[36]) |> mutate(iHS_chrom=iHS$CHROM[36], iHS_pos=iHS$POS[36], iHS_pop=iHS$POP[36]),
    filter(gene.gff3, seqid==iHS$CHROM[37], start<=iHS$POS[37] & end>=iHS$POS[37]) |> mutate(iHS_chrom=iHS$CHROM[37], iHS_pos=iHS$POS[37], iHS_pop=iHS$POP[37]),
    filter(gene.gff3, seqid==iHS$CHROM[38], start<=iHS$POS[38] & end>=iHS$POS[38]) |> mutate(iHS_chrom=iHS$CHROM[38], iHS_pos=iHS$POS[38], iHS_pop=iHS$POP[38]),
    .id="outlier")
peaks.within.genes


top10 <- 
  bind_rows(
    filter(gene.gff3, seqid==iHS$CHROM[1], start>=iHS$POS[1]-30000 & end<=iHS$POS[1]+30000) |> mutate(iHS_start=iHS$POS[1], iHS_end=iHS$POS[1], iHS_pop=iHS$POP[1]),
    filter(gene.gff3, seqid==iHS$CHROM[2], start>=iHS$POS[2]-180000 & end<=iHS$POS[2]+180000) |> mutate(iHS_start=iHS$POS[2], iHS_end=iHS$POS[2], iHS_pop=iHS$POP[2]),
    filter(gene.gff3, seqid==iHS$CHROM[3], start>=iHS$POS[3]-240000 & end<=iHS$POS[3]+240000) |> mutate(iHS_start=iHS$POS[3], iHS_end=iHS$POS[3], iHS_pop=iHS$POP[3]),
    filter(gene.gff3, seqid==iHS$CHROM[4], start<=iHS$POS[4] & end>=iHS$POS[4]) |> mutate(iHS_chrom=iHS$CHROM[4], iHS_pos=iHS$POS[4], iHS_pop=iHS$POP[4]),
    filter(gene.gff3, seqid==iHS$CHROM[5], start<=iHS$POS[5] & end>=iHS$POS[5]) |> mutate(iHS_chrom=iHS$CHROM[5], iHS_pos=iHS$POS[5], iHS_pop=iHS$POP[5]),
    filter(gene.gff3, seqid==iHS$CHROM[6], start>=iHS$POS[6]-90000 & end<=iHS$POS[6]+90000) |> mutate(iHS_start=iHS$POS[6], iHS_end=iHS$POS[6], iHS_pop=iHS$POP[6]),
    filter(gene.gff3, seqid==iHS$CHROM[7], start>=iHS$POS[7]-108500 & end<=iHS$POS[7]+108500) |> mutate(iHS_start=iHS$POS[7], iHS_end=iHS$POS[7], iHS_pop=iHS$POP[7]),
    filter(gene.gff3, seqid==iHS$CHROM[8], start>=iHS$POS[8]-30000 & end<=iHS$POS[8]+30000) |> mutate(iHS_start=iHS$POS[8], iHS_end=iHS$POS[8], iHS_pop=iHS$POP[8]),
    filter(gene.gff3, seqid==iHS$CHROM[9], start>=iHS$POS[9]-150000 & end<=iHS$POS[9]+150000) |> mutate(iHS_start=iHS$POS[9], iHS_end=iHS$POS[9], iHS_pop=iHS$POP[9]),
    filter(gene.gff3, seqid==iHS$CHROM[10], start>=iHS$POS[10]-100000 & end<=iHS$POS[10]+100000) |> mutate(iHS_start=iHS$POS[10], iHS_end=iHS$POS[10], iHS_pop=iHS$POP[10]),
    filter(gene.gff3, seqid==iHS$CHROM[11], start>=iHS$POS[11]-160000 & end<=iHS$POS[11]+160000) |> mutate(iHS_start=iHS$POS[11], iHS_end=iHS$POS[11], iHS_pop=iHS$POP[11]),
    filter(gene.gff3, seqid==iHS$CHROM[12], start<=iHS$POS[12] & end>=iHS$POS[12]) |> mutate(iHS_chrom=iHS$CHROM[12], iHS_pos=iHS$POS[12], iHS_pop=iHS$POP[12]),
    filter(gene.gff3, seqid==iHS$CHROM[13], start>=iHS$POS[13]-70000 & end<=iHS$POS[13]+70000) |> mutate(iHS_start=iHS$POS[13], iHS_end=iHS$POS[13], iHS_pop=iHS$POP[13]),
    filter(gene.gff3, seqid==iHS$CHROM[14], start<=iHS$POS[14] & end>=iHS$POS[14]) |> mutate(iHS_chrom=iHS$CHROM[14], iHS_pos=iHS$POS[14], iHS_pop=iHS$POP[14]),
    filter(gene.gff3, seqid==iHS$CHROM[15], start<=iHS$POS[15] & end>=iHS$POS[15]) |> mutate(iHS_chrom=iHS$CHROM[15], iHS_pos=iHS$POS[15], iHS_pop=iHS$POP[15]),
    filter(gene.gff3, seqid==iHS$CHROM[16], start>=iHS$POS[16]-35000 & end<=iHS$POS[16]+35000) |> mutate(iHS_start=iHS$POS[16], iHS_end=iHS$POS[16], iHS_pop=iHS$POP[16]),
    filter(gene.gff3, seqid==iHS$CHROM[17], start>=iHS$POS[17]-100000 & end<=iHS$POS[17]+100000) |> mutate(iHS_start=iHS$POS[17], iHS_end=iHS$POS[17], iHS_pop=iHS$POP[17]),
    filter(gene.gff3, seqid==iHS$CHROM[18], start>=iHS$POS[18]-310000 & end<=iHS$POS[18]+310000) |> mutate(iHS_start=iHS$POS[18], iHS_end=iHS$POS[18], iHS_pop=iHS$POP[18]),
    filter(gene.gff3, seqid==iHS$CHROM[19], start>=iHS$POS[19]-150000 & end<=iHS$POS[19]+150000) |> mutate(iHS_start=iHS$POS[19], iHS_end=iHS$POS[19], iHS_pop=iHS$POP[19]),
    filter(gene.gff3, seqid==iHS$CHROM[20], start>=iHS$POS[20]-200000 & end<=iHS$POS[20]+200000) |> mutate(iHS_start=iHS$POS[20], iHS_end=iHS$POS[20], iHS_pop=iHS$POP[20]),
    filter(gene.gff3, seqid==iHS$CHROM[21], start<=iHS$POS[21] & end>=iHS$POS[21]) |> mutate(iHS_chrom=iHS$CHROM[21], iHS_pos=iHS$POS[21], iHS_pop=iHS$POP[21]),
    filter(gene.gff3, seqid==iHS$CHROM[22], start<=iHS$POS[22] & end>=iHS$POS[22]) |> mutate(iHS_chrom=iHS$CHROM[22], iHS_pos=iHS$POS[22], iHS_pop=iHS$POP[22]),
    filter(gene.gff3, seqid==iHS$CHROM[23], start<=iHS$POS[23] & end>=iHS$POS[23]) |> mutate(iHS_chrom=iHS$CHROM[23], iHS_pos=iHS$POS[23], iHS_pop=iHS$POP[23]),
    filter(gene.gff3, seqid==iHS$CHROM[24], start<=iHS$POS[24] & end>=iHS$POS[24]) |> mutate(iHS_chrom=iHS$CHROM[24], iHS_pos=iHS$POS[24], iHS_pop=iHS$POP[24]),
    filter(gene.gff3, seqid==iHS$CHROM[25], start>=iHS$POS[25]-40000 & end<=iHS$POS[25]+40000) |> mutate(iHS_start=iHS$POS[25], iHS_end=iHS$POS[25], iHS_pop=iHS$POP[25]),
    filter(gene.gff3, seqid==iHS$CHROM[26], start>=iHS$POS[26]-15000 & end<=iHS$POS[26]+15000) |> mutate(iHS_chrom=iHS$CHROM[26], iHS_pos=iHS$POS[26], iHS_pop=iHS$POP[26]),
    filter(gene.gff3, seqid==iHS$CHROM[27], start>=iHS$POS[27]-50000 & end<=iHS$POS[27]+50000) |> mutate(iHS_start=iHS$POS[27], iHS_end=iHS$POS[27], iHS_pop=iHS$POP[27]),
    filter(gene.gff3, seqid==iHS$CHROM[28], start>=iHS$POS[28]-50000 & end<=iHS$POS[28]+50000) |> mutate(iHS_start=iHS$POS[28], iHS_end=iHS$POS[28], iHS_pop=iHS$POP[28]),
    filter(gene.gff3, seqid==iHS$CHROM[29], start<=iHS$POS[29] & end>=iHS$POS[29]) |> mutate(iHS_chrom=iHS$CHROM[29], iHS_pos=iHS$POS[29], iHS_pop=iHS$POP[29]),
    filter(gene.gff3, seqid==iHS$CHROM[30], start<=iHS$POS[30] & end>=iHS$POS[30]) |> mutate(iHS_chrom=iHS$CHROM[30], iHS_pos=iHS$POS[30], iHS_pop=iHS$POP[30]),
    filter(gene.gff3, seqid==iHS$CHROM[31], start<=iHS$POS[31] & end>=iHS$POS[31]) |> mutate(iHS_chrom=iHS$CHROM[31], iHS_pos=iHS$POS[31], iHS_pop=iHS$POP[31]),
    filter(gene.gff3, seqid==iHS$CHROM[32], start>=iHS$POS[32]-20000 & end<=iHS$POS[32]+20000) |> mutate(iHS_start=iHS$POS[32], iHS_end=iHS$POS[32], iHS_pop=iHS$POP[32]),
    filter(gene.gff3, seqid==iHS$CHROM[33], start>=iHS$POS[33]-20000 & end<=iHS$POS[33]+20000) |> mutate(iHS_start=iHS$POS[33], iHS_end=iHS$POS[33], iHS_pop=iHS$POP[33]),
    filter(gene.gff3, seqid==iHS$CHROM[34], start>=iHS$POS[34]-20000 & end<=iHS$POS[34]+20000) |> mutate(iHS_start=iHS$POS[34], iHS_end=iHS$POS[34], iHS_pop=iHS$POP[34]),
    filter(gene.gff3, seqid==iHS$CHROM[35], start<=iHS$POS[35] & end>=iHS$POS[35]) |> mutate(iHS_chrom=iHS$CHROM[35], iHS_pos=iHS$POS[35], iHS_pop=iHS$POP[35]),
    filter(gene.gff3, seqid==iHS$CHROM[36], start<=iHS$POS[36] & end>=iHS$POS[36]) |> mutate(iHS_chrom=iHS$CHROM[36], iHS_pos=iHS$POS[36], iHS_pop=iHS$POP[36]),
    filter(gene.gff3, seqid==iHS$CHROM[37], start>=iHS$POS[37]-50000 & end<=iHS$POS[37]+50000) |> mutate(iHS_start=iHS$POS[37], iHS_end=iHS$POS[37], iHS_pop=iHS$POP[37]),
    filter(gene.gff3, seqid==iHS$CHROM[38], start<=iHS$POS[38] & end>=iHS$POS[38]) |> mutate(iHS_chrom=iHS$CHROM[38], iHS_pos=iHS$POS[38], iHS_pop=iHS$POP[38]),
    .id="outlier")
top10

top10 <- 
  distinct(top10, id, PANTHER_accession, iHS_pop, .keep_all=TRUE)

top10 <- 
  rename(top10, peak=outlier, chrom=seqid, pop=iHS_pop) |>
  arrange(pop, chrom, start)
  
top10 <- mutate(top10, loc=paste0(chrom, ":", start, "–", end))

write_tsv(x=top10, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.4/ABS_iHS.gmap.gene.hits.top10.tab")

saveRDS(object=top10, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.4/ABS_iHS.gmap.gene.hits.top10.RDS")
