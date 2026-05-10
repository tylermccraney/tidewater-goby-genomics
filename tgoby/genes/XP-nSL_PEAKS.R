library(tidyverse)
library(ggvenn)
library(gridExtra)

gene.gff3 <- readRDS(file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.0/gene.gff3.RDS")
#gene.gff3 <- select(gene.gff3, -start, -end) |> rename(start=prostart, end=proend) |> arrange(seqid, start)

xpnsl <- read_tsv(file="/Volumes/Tigrigobius/tgoby/xpnsl/selscan/peaks10.tab") |> rename(CHROM=chr, POS=pos)

peaks.within.genes <- 
  bind_rows(
    filter(gene.gff3, seqid==xpnsl$CHROM[1], start<=xpnsl$POS[1] & end>=xpnsl$POS[1]) |> mutate(xpnsl_chrom=xpnsl$CHROM[1], xpnsl_pos=xpnsl$POS[1], xpnsl_popA=xpnsl$samplesA[1], xpnsl_popB=xpnsl$samplesB[1]),
    filter(gene.gff3, seqid==xpnsl$CHROM[2], start<=xpnsl$POS[2] & end>=xpnsl$POS[2]) |> mutate(xpnsl_chrom=xpnsl$CHROM[2], xpnsl_pos=xpnsl$POS[2], xpnsl_popA=xpnsl$samplesA[2], xpnsl_popB=xpnsl$samplesB[2]),
    filter(gene.gff3, seqid==xpnsl$CHROM[3], start<=xpnsl$POS[3] & end>=xpnsl$POS[3]) |> mutate(xpnsl_chrom=xpnsl$CHROM[3], xpnsl_pos=xpnsl$POS[3], xpnsl_popA=xpnsl$samplesA[3], xpnsl_popB=xpnsl$samplesB[3]),
    filter(gene.gff3, seqid==xpnsl$CHROM[4], start<=xpnsl$POS[4] & end>=xpnsl$POS[4]) |> mutate(xpnsl_chrom=xpnsl$CHROM[4], xpnsl_pos=xpnsl$POS[4], xpnsl_popA=xpnsl$samplesA[4], xpnsl_popB=xpnsl$samplesB[4]),
    filter(gene.gff3, seqid==xpnsl$CHROM[5], start<=xpnsl$POS[5] & end>=xpnsl$POS[5]) |> mutate(xpnsl_chrom=xpnsl$CHROM[5], xpnsl_pos=xpnsl$POS[5], xpnsl_popA=xpnsl$samplesA[5], xpnsl_popB=xpnsl$samplesB[5]),
    filter(gene.gff3, seqid==xpnsl$CHROM[6], start<=xpnsl$POS[6] & end>=xpnsl$POS[6]) |> mutate(xpnsl_chrom=xpnsl$CHROM[6], xpnsl_pos=xpnsl$POS[6], xpnsl_popA=xpnsl$samplesA[6], xpnsl_popB=xpnsl$samplesB[6]),
    filter(gene.gff3, seqid==xpnsl$CHROM[7], start<=xpnsl$POS[7] & end>=xpnsl$POS[7]) |> mutate(xpnsl_chrom=xpnsl$CHROM[7], xpnsl_pos=xpnsl$POS[7], xpnsl_popA=xpnsl$samplesA[7], xpnsl_popB=xpnsl$samplesB[7]),
    filter(gene.gff3, seqid==xpnsl$CHROM[8], start<=xpnsl$POS[8] & end>=xpnsl$POS[8]) |> mutate(xpnsl_chrom=xpnsl$CHROM[8], xpnsl_pos=xpnsl$POS[8], xpnsl_popA=xpnsl$samplesA[8], xpnsl_popB=xpnsl$samplesB[8]),
    filter(gene.gff3, seqid==xpnsl$CHROM[9], start<=xpnsl$POS[9] & end>=xpnsl$POS[9]) |> mutate(xpnsl_chrom=xpnsl$CHROM[9], xpnsl_pos=xpnsl$POS[9], xpnsl_popA=xpnsl$samplesA[9], xpnsl_popB=xpnsl$samplesB[9]),
    filter(gene.gff3, seqid==xpnsl$CHROM[10], start<=xpnsl$POS[10] & end>=xpnsl$POS[10]) |> mutate(xpnsl_chrom=xpnsl$CHROM[10], xpnsl_pos=xpnsl$POS[10], xpnsl_popA=xpnsl$samplesA[10], xpnsl_popB=xpnsl$samplesB[10]),
    filter(gene.gff3, seqid==xpnsl$CHROM[11], start<=xpnsl$POS[11] & end>=xpnsl$POS[11]) |> mutate(xpnsl_chrom=xpnsl$CHROM[11], xpnsl_pos=xpnsl$POS[11], xpnsl_popA=xpnsl$samplesA[11], xpnsl_popB=xpnsl$samplesB[11]),
    filter(gene.gff3, seqid==xpnsl$CHROM[12], start<=xpnsl$POS[12] & end>=xpnsl$POS[12]) |> mutate(xpnsl_chrom=xpnsl$CHROM[12], xpnsl_pos=xpnsl$POS[12], xpnsl_popA=xpnsl$samplesA[12], xpnsl_popB=xpnsl$samplesB[12]),
    filter(gene.gff3, seqid==xpnsl$CHROM[13], start<=xpnsl$POS[13] & end>=xpnsl$POS[13]) |> mutate(xpnsl_chrom=xpnsl$CHROM[13], xpnsl_pos=xpnsl$POS[13], xpnsl_popA=xpnsl$samplesA[13], xpnsl_popB=xpnsl$samplesB[13]),
    filter(gene.gff3, seqid==xpnsl$CHROM[14], start<=xpnsl$POS[14] & end>=xpnsl$POS[14]) |> mutate(xpnsl_chrom=xpnsl$CHROM[14], xpnsl_pos=xpnsl$POS[14], xpnsl_popA=xpnsl$samplesA[14], xpnsl_popB=xpnsl$samplesB[14]),
    filter(gene.gff3, seqid==xpnsl$CHROM[15], start<=xpnsl$POS[15] & end>=xpnsl$POS[15]) |> mutate(xpnsl_chrom=xpnsl$CHROM[15], xpnsl_pos=xpnsl$POS[15], xpnsl_popA=xpnsl$samplesA[15], xpnsl_popB=xpnsl$samplesB[15]),
    filter(gene.gff3, seqid==xpnsl$CHROM[16], start<=xpnsl$POS[16] & end>=xpnsl$POS[16]) |> mutate(xpnsl_chrom=xpnsl$CHROM[16], xpnsl_pos=xpnsl$POS[16], xpnsl_popA=xpnsl$samplesA[16], xpnsl_popB=xpnsl$samplesB[16]),
    filter(gene.gff3, seqid==xpnsl$CHROM[17], start<=xpnsl$POS[17] & end>=xpnsl$POS[17]) |> mutate(xpnsl_chrom=xpnsl$CHROM[17], xpnsl_pos=xpnsl$POS[17], xpnsl_popA=xpnsl$samplesA[17], xpnsl_popB=xpnsl$samplesB[17]),
    filter(gene.gff3, seqid==xpnsl$CHROM[18], start<=xpnsl$POS[18] & end>=xpnsl$POS[18]) |> mutate(xpnsl_chrom=xpnsl$CHROM[18], xpnsl_pos=xpnsl$POS[18], xpnsl_popA=xpnsl$samplesA[18], xpnsl_popB=xpnsl$samplesB[18]),
    filter(gene.gff3, seqid==xpnsl$CHROM[19], start<=xpnsl$POS[19] & end>=xpnsl$POS[19]) |> mutate(xpnsl_chrom=xpnsl$CHROM[19], xpnsl_pos=xpnsl$POS[19], xpnsl_popA=xpnsl$samplesA[19], xpnsl_popB=xpnsl$samplesB[19]),
    filter(gene.gff3, seqid==xpnsl$CHROM[20], start<=xpnsl$POS[20] & end>=xpnsl$POS[20]) |> mutate(xpnsl_chrom=xpnsl$CHROM[20], xpnsl_pos=xpnsl$POS[20], xpnsl_popA=xpnsl$samplesA[20], xpnsl_popB=xpnsl$samplesB[20]),
    filter(gene.gff3, seqid==xpnsl$CHROM[21], start<=xpnsl$POS[21] & end>=xpnsl$POS[21]) |> mutate(xpnsl_chrom=xpnsl$CHROM[21], xpnsl_pos=xpnsl$POS[21], xpnsl_popA=xpnsl$samplesA[21], xpnsl_popB=xpnsl$samplesB[21]),
    filter(gene.gff3, seqid==xpnsl$CHROM[22], start<=xpnsl$POS[22] & end>=xpnsl$POS[22]) |> mutate(xpnsl_chrom=xpnsl$CHROM[22], xpnsl_pos=xpnsl$POS[22], xpnsl_popA=xpnsl$samplesA[22], xpnsl_popB=xpnsl$samplesB[22]),
    filter(gene.gff3, seqid==xpnsl$CHROM[23], start<=xpnsl$POS[23] & end>=xpnsl$POS[23]) |> mutate(xpnsl_chrom=xpnsl$CHROM[23], xpnsl_pos=xpnsl$POS[23], xpnsl_popA=xpnsl$samplesA[23], xpnsl_popB=xpnsl$samplesB[23]),
    filter(gene.gff3, seqid==xpnsl$CHROM[24], start<=xpnsl$POS[24] & end>=xpnsl$POS[24]) |> mutate(xpnsl_chrom=xpnsl$CHROM[24], xpnsl_pos=xpnsl$POS[24], xpnsl_popA=xpnsl$samplesA[24], xpnsl_popB=xpnsl$samplesB[24]),
    filter(gene.gff3, seqid==xpnsl$CHROM[25], start<=xpnsl$POS[25] & end>=xpnsl$POS[25]) |> mutate(xpnsl_chrom=xpnsl$CHROM[25], xpnsl_pos=xpnsl$POS[25], xpnsl_popA=xpnsl$samplesA[25], xpnsl_popB=xpnsl$samplesB[25]),
    filter(gene.gff3, seqid==xpnsl$CHROM[26], start<=xpnsl$POS[26] & end>=xpnsl$POS[26]) |> mutate(xpnsl_chrom=xpnsl$CHROM[26], xpnsl_pos=xpnsl$POS[26], xpnsl_popA=xpnsl$samplesA[26], xpnsl_popB=xpnsl$samplesB[26]),
    filter(gene.gff3, seqid==xpnsl$CHROM[27], start<=xpnsl$POS[27] & end>=xpnsl$POS[27]) |> mutate(xpnsl_chrom=xpnsl$CHROM[27], xpnsl_pos=xpnsl$POS[27], xpnsl_popA=xpnsl$samplesA[27], xpnsl_popB=xpnsl$samplesB[27]),
    filter(gene.gff3, seqid==xpnsl$CHROM[28], start<=xpnsl$POS[28] & end>=xpnsl$POS[28]) |> mutate(xpnsl_chrom=xpnsl$CHROM[28], xpnsl_pos=xpnsl$POS[28], xpnsl_popA=xpnsl$samplesA[28], xpnsl_popB=xpnsl$samplesB[28]),
    filter(gene.gff3, seqid==xpnsl$CHROM[29], start<=xpnsl$POS[29] & end>=xpnsl$POS[29]) |> mutate(xpnsl_chrom=xpnsl$CHROM[29], xpnsl_pos=xpnsl$POS[29], xpnsl_popA=xpnsl$samplesA[29], xpnsl_popB=xpnsl$samplesB[29]),
    filter(gene.gff3, seqid==xpnsl$CHROM[30], start<=xpnsl$POS[30] & end>=xpnsl$POS[30]) |> mutate(xpnsl_chrom=xpnsl$CHROM[30], xpnsl_pos=xpnsl$POS[30], xpnsl_popA=xpnsl$samplesA[30], xpnsl_popB=xpnsl$samplesB[30]),
    filter(gene.gff3, seqid==xpnsl$CHROM[31], start<=xpnsl$POS[31] & end>=xpnsl$POS[31]) |> mutate(xpnsl_chrom=xpnsl$CHROM[31], xpnsl_pos=xpnsl$POS[31], xpnsl_popA=xpnsl$samplesA[31], xpnsl_popB=xpnsl$samplesB[31]),
    filter(gene.gff3, seqid==xpnsl$CHROM[32], start<=xpnsl$POS[32] & end>=xpnsl$POS[32]) |> mutate(xpnsl_chrom=xpnsl$CHROM[32], xpnsl_pos=xpnsl$POS[32], xpnsl_popA=xpnsl$samplesA[32], xpnsl_popB=xpnsl$samplesB[32]),
    filter(gene.gff3, seqid==xpnsl$CHROM[33], start<=xpnsl$POS[33] & end>=xpnsl$POS[33]) |> mutate(xpnsl_chrom=xpnsl$CHROM[33], xpnsl_pos=xpnsl$POS[33], xpnsl_popA=xpnsl$samplesA[33], xpnsl_popB=xpnsl$samplesB[33]),
    filter(gene.gff3, seqid==xpnsl$CHROM[34], start<=xpnsl$POS[34] & end>=xpnsl$POS[34]) |> mutate(xpnsl_chrom=xpnsl$CHROM[34], xpnsl_pos=xpnsl$POS[34], xpnsl_popA=xpnsl$samplesA[34], xpnsl_popB=xpnsl$samplesB[34]),
    filter(gene.gff3, seqid==xpnsl$CHROM[35], start<=xpnsl$POS[35] & end>=xpnsl$POS[35]) |> mutate(xpnsl_chrom=xpnsl$CHROM[35], xpnsl_pos=xpnsl$POS[35], xpnsl_popA=xpnsl$samplesA[35], xpnsl_popB=xpnsl$samplesB[35]),
    filter(gene.gff3, seqid==xpnsl$CHROM[36], start<=xpnsl$POS[36] & end>=xpnsl$POS[36]) |> mutate(xpnsl_chrom=xpnsl$CHROM[36], xpnsl_pos=xpnsl$POS[36], xpnsl_popA=xpnsl$samplesA[36], xpnsl_popB=xpnsl$samplesB[36]),
    filter(gene.gff3, seqid==xpnsl$CHROM[37], start<=xpnsl$POS[37] & end>=xpnsl$POS[37]) |> mutate(xpnsl_chrom=xpnsl$CHROM[37], xpnsl_pos=xpnsl$POS[37], xpnsl_popA=xpnsl$samplesA[37], xpnsl_popB=xpnsl$samplesB[37]),
    filter(gene.gff3, seqid==xpnsl$CHROM[38], start<=xpnsl$POS[38] & end>=xpnsl$POS[38]) |> mutate(xpnsl_chrom=xpnsl$CHROM[38], xpnsl_pos=xpnsl$POS[38], xpnsl_popA=xpnsl$samplesA[38], xpnsl_popB=xpnsl$samplesB[38]),
    filter(gene.gff3, seqid==xpnsl$CHROM[39], start<=xpnsl$POS[39] & end>=xpnsl$POS[39]) |> mutate(xpnsl_chrom=xpnsl$CHROM[39], xpnsl_pos=xpnsl$POS[39], xpnsl_popA=xpnsl$samplesA[39], xpnsl_popB=xpnsl$samplesB[39]),
    filter(gene.gff3, seqid==xpnsl$CHROM[40], start<=xpnsl$POS[40] & end>=xpnsl$POS[40]) |> mutate(xpnsl_chrom=xpnsl$CHROM[40], xpnsl_pos=xpnsl$POS[40], xpnsl_popA=xpnsl$samplesA[40], xpnsl_popB=xpnsl$samplesB[40]),
    filter(gene.gff3, seqid==xpnsl$CHROM[41], start<=xpnsl$POS[41] & end>=xpnsl$POS[41]) |> mutate(xpnsl_chrom=xpnsl$CHROM[41], xpnsl_pos=xpnsl$POS[41], xpnsl_popA=xpnsl$samplesA[41], xpnsl_popB=xpnsl$samplesB[41]),
    filter(gene.gff3, seqid==xpnsl$CHROM[42], start<=xpnsl$POS[42] & end>=xpnsl$POS[42]) |> mutate(xpnsl_chrom=xpnsl$CHROM[42], xpnsl_pos=xpnsl$POS[42], xpnsl_popA=xpnsl$samplesA[42], xpnsl_popB=xpnsl$samplesB[42]),
    filter(gene.gff3, seqid==xpnsl$CHROM[43], start<=xpnsl$POS[43] & end>=xpnsl$POS[43]) |> mutate(xpnsl_chrom=xpnsl$CHROM[43], xpnsl_pos=xpnsl$POS[43], xpnsl_popA=xpnsl$samplesA[43], xpnsl_popB=xpnsl$samplesB[43]),
    filter(gene.gff3, seqid==xpnsl$CHROM[44], start<=xpnsl$POS[44] & end>=xpnsl$POS[44]) |> mutate(xpnsl_chrom=xpnsl$CHROM[44], xpnsl_pos=xpnsl$POS[44], xpnsl_popA=xpnsl$samplesA[44], xpnsl_popB=xpnsl$samplesB[44]),
    filter(gene.gff3, seqid==xpnsl$CHROM[45], start<=xpnsl$POS[45] & end>=xpnsl$POS[45]) |> mutate(xpnsl_chrom=xpnsl$CHROM[45], xpnsl_pos=xpnsl$POS[45], xpnsl_popA=xpnsl$samplesA[45], xpnsl_popB=xpnsl$samplesB[45]),
    filter(gene.gff3, seqid==xpnsl$CHROM[46], start<=xpnsl$POS[46] & end>=xpnsl$POS[46]) |> mutate(xpnsl_chrom=xpnsl$CHROM[46], xpnsl_pos=xpnsl$POS[46], xpnsl_popA=xpnsl$samplesA[46], xpnsl_popB=xpnsl$samplesB[46]),
    filter(gene.gff3, seqid==xpnsl$CHROM[47], start<=xpnsl$POS[47] & end>=xpnsl$POS[47]) |> mutate(xpnsl_chrom=xpnsl$CHROM[47], xpnsl_pos=xpnsl$POS[47], xpnsl_popA=xpnsl$samplesA[47], xpnsl_popB=xpnsl$samplesB[47]),
    filter(gene.gff3, seqid==xpnsl$CHROM[48], start<=xpnsl$POS[48] & end>=xpnsl$POS[48]) |> mutate(xpnsl_chrom=xpnsl$CHROM[48], xpnsl_pos=xpnsl$POS[48], xpnsl_popA=xpnsl$samplesA[48], xpnsl_popB=xpnsl$samplesB[48]),
    filter(gene.gff3, seqid==xpnsl$CHROM[49], start<=xpnsl$POS[49] & end>=xpnsl$POS[49]) |> mutate(xpnsl_chrom=xpnsl$CHROM[49], xpnsl_pos=xpnsl$POS[49], xpnsl_popA=xpnsl$samplesA[49], xpnsl_popB=xpnsl$samplesB[49]),
    filter(gene.gff3, seqid==xpnsl$CHROM[50], start<=xpnsl$POS[50] & end>=xpnsl$POS[50]) |> mutate(xpnsl_chrom=xpnsl$CHROM[50], xpnsl_pos=xpnsl$POS[50], xpnsl_popA=xpnsl$samplesA[50], xpnsl_popB=xpnsl$samplesB[50]),
    filter(gene.gff3, seqid==xpnsl$CHROM[51], start<=xpnsl$POS[51] & end>=xpnsl$POS[51]) |> mutate(xpnsl_chrom=xpnsl$CHROM[51], xpnsl_pos=xpnsl$POS[51], xpnsl_popA=xpnsl$samplesA[51], xpnsl_popB=xpnsl$samplesB[51]),
    filter(gene.gff3, seqid==xpnsl$CHROM[52], start<=xpnsl$POS[52] & end>=xpnsl$POS[52]) |> mutate(xpnsl_chrom=xpnsl$CHROM[52], xpnsl_pos=xpnsl$POS[52], xpnsl_popA=xpnsl$samplesA[52], xpnsl_popB=xpnsl$samplesB[52]),
    filter(gene.gff3, seqid==xpnsl$CHROM[53], start<=xpnsl$POS[53] & end>=xpnsl$POS[53]) |> mutate(xpnsl_chrom=xpnsl$CHROM[53], xpnsl_pos=xpnsl$POS[53], xpnsl_popA=xpnsl$samplesA[53], xpnsl_popB=xpnsl$samplesB[53]),
    filter(gene.gff3, seqid==xpnsl$CHROM[54], start<=xpnsl$POS[54] & end>=xpnsl$POS[54]) |> mutate(xpnsl_chrom=xpnsl$CHROM[54], xpnsl_pos=xpnsl$POS[54], xpnsl_popA=xpnsl$samplesA[54], xpnsl_popB=xpnsl$samplesB[54]),
    filter(gene.gff3, seqid==xpnsl$CHROM[55], start<=xpnsl$POS[55] & end>=xpnsl$POS[55]) |> mutate(xpnsl_chrom=xpnsl$CHROM[55], xpnsl_pos=xpnsl$POS[55], xpnsl_popA=xpnsl$samplesA[55], xpnsl_popB=xpnsl$samplesB[55]),
    filter(gene.gff3, seqid==xpnsl$CHROM[56], start<=xpnsl$POS[56] & end>=xpnsl$POS[56]) |> mutate(xpnsl_chrom=xpnsl$CHROM[56], xpnsl_pos=xpnsl$POS[56], xpnsl_popA=xpnsl$samplesA[56], xpnsl_popB=xpnsl$samplesB[56]),
    filter(gene.gff3, seqid==xpnsl$CHROM[57], start<=xpnsl$POS[57] & end>=xpnsl$POS[57]) |> mutate(xpnsl_chrom=xpnsl$CHROM[57], xpnsl_pos=xpnsl$POS[57], xpnsl_popA=xpnsl$samplesA[57], xpnsl_popB=xpnsl$samplesB[57]),
    filter(gene.gff3, seqid==xpnsl$CHROM[58], start<=xpnsl$POS[58] & end>=xpnsl$POS[58]) |> mutate(xpnsl_chrom=xpnsl$CHROM[58], xpnsl_pos=xpnsl$POS[58], xpnsl_popA=xpnsl$samplesA[58], xpnsl_popB=xpnsl$samplesB[58]),
    filter(gene.gff3, seqid==xpnsl$CHROM[59], start<=xpnsl$POS[59] & end>=xpnsl$POS[59]) |> mutate(xpnsl_chrom=xpnsl$CHROM[59], xpnsl_pos=xpnsl$POS[59], xpnsl_popA=xpnsl$samplesA[59], xpnsl_popB=xpnsl$samplesB[59]),
    filter(gene.gff3, seqid==xpnsl$CHROM[60], start<=xpnsl$POS[60] & end>=xpnsl$POS[60]) |> mutate(xpnsl_chrom=xpnsl$CHROM[60], xpnsl_pos=xpnsl$POS[60], xpnsl_popA=xpnsl$samplesA[60], xpnsl_popB=xpnsl$samplesB[60]),
    filter(gene.gff3, seqid==xpnsl$CHROM[61], start<=xpnsl$POS[61] & end>=xpnsl$POS[61]) |> mutate(xpnsl_chrom=xpnsl$CHROM[61], xpnsl_pos=xpnsl$POS[61], xpnsl_popA=xpnsl$samplesA[61], xpnsl_popB=xpnsl$samplesB[61]),
    filter(gene.gff3, seqid==xpnsl$CHROM[62], start<=xpnsl$POS[62] & end>=xpnsl$POS[62]) |> mutate(xpnsl_chrom=xpnsl$CHROM[62], xpnsl_pos=xpnsl$POS[62], xpnsl_popA=xpnsl$samplesA[62], xpnsl_popB=xpnsl$samplesB[62]),
    filter(gene.gff3, seqid==xpnsl$CHROM[63], start<=xpnsl$POS[63] & end>=xpnsl$POS[63]) |> mutate(xpnsl_chrom=xpnsl$CHROM[63], xpnsl_pos=xpnsl$POS[63], xpnsl_popA=xpnsl$samplesA[63], xpnsl_popB=xpnsl$samplesB[63]),
    filter(gene.gff3, seqid==xpnsl$CHROM[64], start<=xpnsl$POS[64] & end>=xpnsl$POS[64]) |> mutate(xpnsl_chrom=xpnsl$CHROM[64], xpnsl_pos=xpnsl$POS[64], xpnsl_popA=xpnsl$samplesA[64], xpnsl_popB=xpnsl$samplesB[64]),
    filter(gene.gff3, seqid==xpnsl$CHROM[65], start<=xpnsl$POS[65] & end>=xpnsl$POS[65]) |> mutate(xpnsl_chrom=xpnsl$CHROM[65], xpnsl_pos=xpnsl$POS[65], xpnsl_popA=xpnsl$samplesA[65], xpnsl_popB=xpnsl$samplesB[65]),
    .id="outlier")
peaks.within.genes

top10 <- 
  bind_rows(
    filter(gene.gff3, seqid==xpnsl$CHROM[1], start>=xpnsl$POS[1]-50000 & end<=xpnsl$POS[1]+50000) |> mutate(xpnsl_chrom=xpnsl$CHROM[1], xpnsl_pos=xpnsl$POS[1], xpnsl_popA=xpnsl$samplesA[1], xpnsl_popB=xpnsl$samplesB[1]),
    filter(gene.gff3, seqid==xpnsl$CHROM[2], start>=xpnsl$POS[2]-20000 & end<=xpnsl$POS[2]+20000) |> mutate(xpnsl_chrom=xpnsl$CHROM[2], xpnsl_pos=xpnsl$POS[2], xpnsl_popA=xpnsl$samplesA[2], xpnsl_popB=xpnsl$samplesB[2]),
    filter(gene.gff3, seqid==xpnsl$CHROM[3], start>=xpnsl$POS[3]-20000 & end<=xpnsl$POS[3]+20000) |> mutate(xpnsl_chrom=xpnsl$CHROM[3], xpnsl_pos=xpnsl$POS[3], xpnsl_popA=xpnsl$samplesA[3], xpnsl_popB=xpnsl$samplesB[3]),
    filter(gene.gff3, seqid==xpnsl$CHROM[4], start>=xpnsl$POS[4]-10000 & end<=xpnsl$POS[4]+10000) |> mutate(xpnsl_chrom=xpnsl$CHROM[4], xpnsl_pos=xpnsl$POS[4], xpnsl_popA=xpnsl$samplesA[4], xpnsl_popB=xpnsl$samplesB[4]),
    filter(gene.gff3, seqid==xpnsl$CHROM[5], start>=xpnsl$POS[5]-90000 & end<=xpnsl$POS[5]+90000) |> mutate(xpnsl_chrom=xpnsl$CHROM[5], xpnsl_pos=xpnsl$POS[5], xpnsl_popA=xpnsl$samplesA[5], xpnsl_popB=xpnsl$samplesB[5]),
    filter(gene.gff3, seqid==xpnsl$CHROM[6], start>=xpnsl$POS[6]-100000 & end<=xpnsl$POS[6]+100000) |> mutate(xpnsl_chrom=xpnsl$CHROM[6], xpnsl_pos=xpnsl$POS[6], xpnsl_popA=xpnsl$samplesA[6], xpnsl_popB=xpnsl$samplesB[6]),
    filter(gene.gff3, seqid==xpnsl$CHROM[7], start>=xpnsl$POS[7]-70000 & end<=xpnsl$POS[7]+70000) |> mutate(xpnsl_chrom=xpnsl$CHROM[7], xpnsl_pos=xpnsl$POS[7], xpnsl_popA=xpnsl$samplesA[7], xpnsl_popB=xpnsl$samplesB[7]),
    filter(gene.gff3, seqid==xpnsl$CHROM[8], start>=xpnsl$POS[8]-9000 & end<=xpnsl$POS[8]+9000) |> mutate(xpnsl_chrom=xpnsl$CHROM[8], xpnsl_pos=xpnsl$POS[8], xpnsl_popA=xpnsl$samplesA[8], xpnsl_popB=xpnsl$samplesB[8]),
    filter(gene.gff3, seqid==xpnsl$CHROM[9], start>=xpnsl$POS[9]-35000 & end<=xpnsl$POS[9]+35000) |> mutate(xpnsl_chrom=xpnsl$CHROM[9], xpnsl_pos=xpnsl$POS[9], xpnsl_popA=xpnsl$samplesA[9], xpnsl_popB=xpnsl$samplesB[9]),
    filter(gene.gff3, seqid==xpnsl$CHROM[10], start>=xpnsl$POS[10]-150000 & end<=xpnsl$POS[10]+150000) |> mutate(xpnsl_chrom=xpnsl$CHROM[10], xpnsl_pos=xpnsl$POS[10], xpnsl_popA=xpnsl$samplesA[10], xpnsl_popB=xpnsl$samplesB[10]),
    filter(gene.gff3, seqid==xpnsl$CHROM[11], start<=xpnsl$POS[11] & end>=xpnsl$POS[11]) |> mutate(xpnsl_chrom=xpnsl$CHROM[11], xpnsl_pos=xpnsl$POS[11], xpnsl_popA=xpnsl$samplesA[11], xpnsl_popB=xpnsl$samplesB[11]),
    filter(gene.gff3, seqid==xpnsl$CHROM[12], start>=xpnsl$POS[12]-50000 & end<=xpnsl$POS[12]+50000) |> mutate(xpnsl_chrom=xpnsl$CHROM[12], xpnsl_pos=xpnsl$POS[12], xpnsl_popA=xpnsl$samplesA[12], xpnsl_popB=xpnsl$samplesB[12]),
    filter(gene.gff3, seqid==xpnsl$CHROM[13], start>=xpnsl$POS[13]-15000 & end<=xpnsl$POS[13]+15000) |> mutate(xpnsl_chrom=xpnsl$CHROM[13], xpnsl_pos=xpnsl$POS[13], xpnsl_popA=xpnsl$samplesA[13], xpnsl_popB=xpnsl$samplesB[13]),
    filter(gene.gff3, seqid==xpnsl$CHROM[14], start<=xpnsl$POS[14] & end>=xpnsl$POS[14]) |> mutate(xpnsl_chrom=xpnsl$CHROM[14], xpnsl_pos=xpnsl$POS[14], xpnsl_popA=xpnsl$samplesA[14], xpnsl_popB=xpnsl$samplesB[14]),
    filter(gene.gff3, seqid==xpnsl$CHROM[15], start<=xpnsl$POS[15] & end>=xpnsl$POS[15]) |> mutate(xpnsl_chrom=xpnsl$CHROM[15], xpnsl_pos=xpnsl$POS[15], xpnsl_popA=xpnsl$samplesA[15], xpnsl_popB=xpnsl$samplesB[15]),
    filter(gene.gff3, seqid==xpnsl$CHROM[16], start<=xpnsl$POS[16] & end>=xpnsl$POS[16]) |> mutate(xpnsl_chrom=xpnsl$CHROM[16], xpnsl_pos=xpnsl$POS[16], xpnsl_popA=xpnsl$samplesA[16], xpnsl_popB=xpnsl$samplesB[16]),
    filter(gene.gff3, seqid==xpnsl$CHROM[17], start<=xpnsl$POS[17] & end>=xpnsl$POS[17]) |> mutate(xpnsl_chrom=xpnsl$CHROM[17], xpnsl_pos=xpnsl$POS[17], xpnsl_popA=xpnsl$samplesA[17], xpnsl_popB=xpnsl$samplesB[17]),
    filter(gene.gff3, seqid==xpnsl$CHROM[18], start>=xpnsl$POS[18]-30000 & end<=xpnsl$POS[18]+30000) |> mutate(xpnsl_chrom=xpnsl$CHROM[18], xpnsl_pos=xpnsl$POS[18], xpnsl_popA=xpnsl$samplesA[18], xpnsl_popB=xpnsl$samplesB[18]),
    filter(gene.gff3, seqid==xpnsl$CHROM[19], start>=xpnsl$POS[19]-30000 & end<=xpnsl$POS[19]+30000) |> mutate(xpnsl_chrom=xpnsl$CHROM[19], xpnsl_pos=xpnsl$POS[19], xpnsl_popA=xpnsl$samplesA[19], xpnsl_popB=xpnsl$samplesB[19]),
    filter(gene.gff3, seqid==xpnsl$CHROM[20], start<=xpnsl$POS[20] & end>=xpnsl$POS[20]) |> mutate(xpnsl_chrom=xpnsl$CHROM[20], xpnsl_pos=xpnsl$POS[20], xpnsl_popA=xpnsl$samplesA[20], xpnsl_popB=xpnsl$samplesB[20]),
    filter(gene.gff3, seqid==xpnsl$CHROM[21], start>=xpnsl$POS[21]-10000 & end<=xpnsl$POS[21]+10000) |> mutate(xpnsl_chrom=xpnsl$CHROM[21], xpnsl_pos=xpnsl$POS[21], xpnsl_popA=xpnsl$samplesA[21], xpnsl_popB=xpnsl$samplesB[21]),
    filter(gene.gff3, seqid==xpnsl$CHROM[22], start>=xpnsl$POS[22]-105000 & end<=xpnsl$POS[22]+105000) |> mutate(xpnsl_chrom=xpnsl$CHROM[22], xpnsl_pos=xpnsl$POS[22], xpnsl_popA=xpnsl$samplesA[22], xpnsl_popB=xpnsl$samplesB[22]),
    filter(gene.gff3, seqid==xpnsl$CHROM[23], start>=xpnsl$POS[23]-10000 & end<=xpnsl$POS[23]+10000) |> mutate(xpnsl_chrom=xpnsl$CHROM[23], xpnsl_pos=xpnsl$POS[23], xpnsl_popA=xpnsl$samplesA[23], xpnsl_popB=xpnsl$samplesB[23]),
    filter(gene.gff3, seqid==xpnsl$CHROM[24], start>=xpnsl$POS[24]-10000 & end<=xpnsl$POS[24]+10000) |> mutate(xpnsl_chrom=xpnsl$CHROM[24], xpnsl_pos=xpnsl$POS[24], xpnsl_popA=xpnsl$samplesA[24], xpnsl_popB=xpnsl$samplesB[24]),
    filter(gene.gff3, seqid==xpnsl$CHROM[25], start>=xpnsl$POS[25]-20000 & end<=xpnsl$POS[25]+20000) |> mutate(xpnsl_chrom=xpnsl$CHROM[25], xpnsl_pos=xpnsl$POS[25], xpnsl_popA=xpnsl$samplesA[25], xpnsl_popB=xpnsl$samplesB[25]),
    filter(gene.gff3, seqid==xpnsl$CHROM[26], start>=xpnsl$POS[26]-20000 & end<=xpnsl$POS[26]+20000) |> mutate(xpnsl_chrom=xpnsl$CHROM[26], xpnsl_pos=xpnsl$POS[26], xpnsl_popA=xpnsl$samplesA[26], xpnsl_popB=xpnsl$samplesB[26]),
    filter(gene.gff3, seqid==xpnsl$CHROM[27], start<=xpnsl$POS[27] & end>=xpnsl$POS[27]) |> mutate(xpnsl_chrom=xpnsl$CHROM[27], xpnsl_pos=xpnsl$POS[27], xpnsl_popA=xpnsl$samplesA[27], xpnsl_popB=xpnsl$samplesB[27]),
    filter(gene.gff3, seqid==xpnsl$CHROM[28], start<=xpnsl$POS[28] & end>=xpnsl$POS[28]) |> mutate(xpnsl_chrom=xpnsl$CHROM[28], xpnsl_pos=xpnsl$POS[28], xpnsl_popA=xpnsl$samplesA[28], xpnsl_popB=xpnsl$samplesB[28]),
    filter(gene.gff3, seqid==xpnsl$CHROM[29], start<=xpnsl$POS[29] & end>=xpnsl$POS[29]) |> mutate(xpnsl_chrom=xpnsl$CHROM[29], xpnsl_pos=xpnsl$POS[29], xpnsl_popA=xpnsl$samplesA[29], xpnsl_popB=xpnsl$samplesB[29]),
    filter(gene.gff3, seqid==xpnsl$CHROM[30], start<=xpnsl$POS[30] & end>=xpnsl$POS[30]) |> mutate(xpnsl_chrom=xpnsl$CHROM[30], xpnsl_pos=xpnsl$POS[30], xpnsl_popA=xpnsl$samplesA[30], xpnsl_popB=xpnsl$samplesB[30]),
    filter(gene.gff3, seqid==xpnsl$CHROM[31], start>=xpnsl$POS[31]-20000 & end<=xpnsl$POS[31]+20000) |> mutate(xpnsl_chrom=xpnsl$CHROM[31], xpnsl_pos=xpnsl$POS[31], xpnsl_popA=xpnsl$samplesA[31], xpnsl_popB=xpnsl$samplesB[31]),
    filter(gene.gff3, seqid==xpnsl$CHROM[32], start>=xpnsl$POS[32]-50000 & end<=xpnsl$POS[32]+50000) |> mutate(xpnsl_chrom=xpnsl$CHROM[32], xpnsl_pos=xpnsl$POS[32], xpnsl_popA=xpnsl$samplesA[32], xpnsl_popB=xpnsl$samplesB[32]),
    filter(gene.gff3, seqid==xpnsl$CHROM[33], start>=xpnsl$POS[33]-50000 & end<=xpnsl$POS[33]+50000) |> mutate(xpnsl_chrom=xpnsl$CHROM[33], xpnsl_pos=xpnsl$POS[33], xpnsl_popA=xpnsl$samplesA[33], xpnsl_popB=xpnsl$samplesB[33]),
    filter(gene.gff3, seqid==xpnsl$CHROM[34], start<=xpnsl$POS[34] & end>=xpnsl$POS[34]) |> mutate(xpnsl_chrom=xpnsl$CHROM[34], xpnsl_pos=xpnsl$POS[34], xpnsl_popA=xpnsl$samplesA[34], xpnsl_popB=xpnsl$samplesB[34]),
    filter(gene.gff3, seqid==xpnsl$CHROM[35], start<=xpnsl$POS[35] & end>=xpnsl$POS[35]) |> mutate(xpnsl_chrom=xpnsl$CHROM[35], xpnsl_pos=xpnsl$POS[35], xpnsl_popA=xpnsl$samplesA[35], xpnsl_popB=xpnsl$samplesB[35]),
    filter(gene.gff3, seqid==xpnsl$CHROM[36], start>=xpnsl$POS[36]-100000 & end<=xpnsl$POS[36]+100000) |> mutate(xpnsl_chrom=xpnsl$CHROM[36], xpnsl_pos=xpnsl$POS[36], xpnsl_popA=xpnsl$samplesA[36], xpnsl_popB=xpnsl$samplesB[36]),
    filter(gene.gff3, seqid==xpnsl$CHROM[37], start<=xpnsl$POS[37] & end>=xpnsl$POS[37]) |> mutate(xpnsl_chrom=xpnsl$CHROM[37], xpnsl_pos=xpnsl$POS[37], xpnsl_popA=xpnsl$samplesA[37], xpnsl_popB=xpnsl$samplesB[37]),
    filter(gene.gff3, seqid==xpnsl$CHROM[38], start>=xpnsl$POS[38]-50000 & end<=xpnsl$POS[38]+50000) |> mutate(xpnsl_chrom=xpnsl$CHROM[38], xpnsl_pos=xpnsl$POS[38], xpnsl_popA=xpnsl$samplesA[38], xpnsl_popB=xpnsl$samplesB[38]),
    filter(gene.gff3, seqid==xpnsl$CHROM[39], start>=xpnsl$POS[39]-30000 & end<=xpnsl$POS[39]+30000) |> mutate(xpnsl_chrom=xpnsl$CHROM[39], xpnsl_pos=xpnsl$POS[39], xpnsl_popA=xpnsl$samplesA[39], xpnsl_popB=xpnsl$samplesB[39]),
    filter(gene.gff3, seqid==xpnsl$CHROM[40], start<=xpnsl$POS[40] & end>=xpnsl$POS[40]) |> mutate(xpnsl_chrom=xpnsl$CHROM[40], xpnsl_pos=xpnsl$POS[40], xpnsl_popA=xpnsl$samplesA[40], xpnsl_popB=xpnsl$samplesB[40]),
    filter(gene.gff3, seqid==xpnsl$CHROM[41], start>=xpnsl$POS[41]-105000 & end<=xpnsl$POS[41]+105000) |> mutate(xpnsl_chrom=xpnsl$CHROM[41], xpnsl_pos=xpnsl$POS[41], xpnsl_popA=xpnsl$samplesA[41], xpnsl_popB=xpnsl$samplesB[41]),
    filter(gene.gff3, seqid==xpnsl$CHROM[42], start>=xpnsl$POS[42]-20000 & end<=xpnsl$POS[42]+20000) |> mutate(xpnsl_chrom=xpnsl$CHROM[42], xpnsl_pos=xpnsl$POS[42], xpnsl_popA=xpnsl$samplesA[42], xpnsl_popB=xpnsl$samplesB[42]),
    filter(gene.gff3, seqid==xpnsl$CHROM[43], start>=xpnsl$POS[43]-4000 & end<=xpnsl$POS[43]+4000) |> mutate(xpnsl_chrom=xpnsl$CHROM[43], xpnsl_pos=xpnsl$POS[43], xpnsl_popA=xpnsl$samplesA[43], xpnsl_popB=xpnsl$samplesB[43]),
    filter(gene.gff3, seqid==xpnsl$CHROM[44], start<=xpnsl$POS[44] & end>=xpnsl$POS[44]) |> mutate(xpnsl_chrom=xpnsl$CHROM[44], xpnsl_pos=xpnsl$POS[44], xpnsl_popA=xpnsl$samplesA[44], xpnsl_popB=xpnsl$samplesB[44]),
    filter(gene.gff3, seqid==xpnsl$CHROM[45], start<=xpnsl$POS[45] & end>=xpnsl$POS[45]) |> mutate(xpnsl_chrom=xpnsl$CHROM[45], xpnsl_pos=xpnsl$POS[45], xpnsl_popA=xpnsl$samplesA[45], xpnsl_popB=xpnsl$samplesB[45]),
    filter(gene.gff3, seqid==xpnsl$CHROM[46], start>=xpnsl$POS[46]-100000 & end<=xpnsl$POS[46]+100000) |> mutate(xpnsl_chrom=xpnsl$CHROM[46], xpnsl_pos=xpnsl$POS[46], xpnsl_popA=xpnsl$samplesA[46], xpnsl_popB=xpnsl$samplesB[46]),
    filter(gene.gff3, seqid==xpnsl$CHROM[47], start>=xpnsl$POS[47]-100000 & end<=xpnsl$POS[47]+100000) |> mutate(xpnsl_chrom=xpnsl$CHROM[47], xpnsl_pos=xpnsl$POS[47], xpnsl_popA=xpnsl$samplesA[47], xpnsl_popB=xpnsl$samplesB[47]),
    filter(gene.gff3, seqid==xpnsl$CHROM[48], start>=xpnsl$POS[48]-100000 & end<=xpnsl$POS[48]+100000) |> mutate(xpnsl_chrom=xpnsl$CHROM[48], xpnsl_pos=xpnsl$POS[48], xpnsl_popA=xpnsl$samplesA[48], xpnsl_popB=xpnsl$samplesB[48]),
    filter(gene.gff3, seqid==xpnsl$CHROM[49], start>=xpnsl$POS[49]-20000 & end<=xpnsl$POS[49]+20000) |> mutate(xpnsl_chrom=xpnsl$CHROM[49], xpnsl_pos=xpnsl$POS[49], xpnsl_popA=xpnsl$samplesA[49], xpnsl_popB=xpnsl$samplesB[49]),
    filter(gene.gff3, seqid==xpnsl$CHROM[50], start>=xpnsl$POS[50]-100000 & end<=xpnsl$POS[50]+100000) |> mutate(xpnsl_chrom=xpnsl$CHROM[50], xpnsl_pos=xpnsl$POS[50], xpnsl_popA=xpnsl$samplesA[50], xpnsl_popB=xpnsl$samplesB[50]),
    filter(gene.gff3, seqid==xpnsl$CHROM[51], start<=xpnsl$POS[51] & end>=xpnsl$POS[51]) |> mutate(xpnsl_chrom=xpnsl$CHROM[51], xpnsl_pos=xpnsl$POS[51], xpnsl_popA=xpnsl$samplesA[51], xpnsl_popB=xpnsl$samplesB[51]),
    filter(gene.gff3, seqid==xpnsl$CHROM[52], start>=xpnsl$POS[52]-83000 & end<=xpnsl$POS[52]+83000) |> mutate(xpnsl_chrom=xpnsl$CHROM[52], xpnsl_pos=xpnsl$POS[52], xpnsl_popA=xpnsl$samplesA[52], xpnsl_popB=xpnsl$samplesB[52]),
    filter(gene.gff3, seqid==xpnsl$CHROM[53], start>=xpnsl$POS[53]-50000 & end<=xpnsl$POS[53]+50000) |> mutate(xpnsl_chrom=xpnsl$CHROM[53], xpnsl_pos=xpnsl$POS[53], xpnsl_popA=xpnsl$samplesA[53], xpnsl_popB=xpnsl$samplesB[53]),
    filter(gene.gff3, seqid==xpnsl$CHROM[54], start>=xpnsl$POS[54]-100000 & end<=xpnsl$POS[54]+100000) |> mutate(xpnsl_chrom=xpnsl$CHROM[54], xpnsl_pos=xpnsl$POS[54], xpnsl_popA=xpnsl$samplesA[54], xpnsl_popB=xpnsl$samplesB[54]),
    filter(gene.gff3, seqid==xpnsl$CHROM[55], start>=xpnsl$POS[55]-100000 & end<=xpnsl$POS[55]+100000) |> mutate(xpnsl_chrom=xpnsl$CHROM[55], xpnsl_pos=xpnsl$POS[55], xpnsl_popA=xpnsl$samplesA[55], xpnsl_popB=xpnsl$samplesB[55]),
    filter(gene.gff3, seqid==xpnsl$CHROM[56], start>=xpnsl$POS[56]-100000 & end<=xpnsl$POS[56]+100000) |> mutate(xpnsl_chrom=xpnsl$CHROM[56], xpnsl_pos=xpnsl$POS[56], xpnsl_popA=xpnsl$samplesA[56], xpnsl_popB=xpnsl$samplesB[56]),
    filter(gene.gff3, seqid==xpnsl$CHROM[57], start>=xpnsl$POS[57]-30000 & end<=xpnsl$POS[57]+30000) |> mutate(xpnsl_chrom=xpnsl$CHROM[57], xpnsl_pos=xpnsl$POS[57], xpnsl_popA=xpnsl$samplesA[57], xpnsl_popB=xpnsl$samplesB[57]),
    filter(gene.gff3, seqid==xpnsl$CHROM[58], start>=xpnsl$POS[58]-100000 & end<=xpnsl$POS[58]+100000) |> mutate(xpnsl_chrom=xpnsl$CHROM[58], xpnsl_pos=xpnsl$POS[58], xpnsl_popA=xpnsl$samplesA[58], xpnsl_popB=xpnsl$samplesB[58]),
    filter(gene.gff3, seqid==xpnsl$CHROM[59], start>=xpnsl$POS[59]-100000 & end<=xpnsl$POS[59]+100000) |> mutate(xpnsl_chrom=xpnsl$CHROM[59], xpnsl_pos=xpnsl$POS[59], xpnsl_popA=xpnsl$samplesA[59], xpnsl_popB=xpnsl$samplesB[59]),
    filter(gene.gff3, seqid==xpnsl$CHROM[60], start>=xpnsl$POS[60]-80000 & end<=xpnsl$POS[60]+80000) |> mutate(xpnsl_chrom=xpnsl$CHROM[60], xpnsl_pos=xpnsl$POS[60], xpnsl_popA=xpnsl$samplesA[60], xpnsl_popB=xpnsl$samplesB[60]),
    filter(gene.gff3, seqid==xpnsl$CHROM[61], start>=xpnsl$POS[61]-20000 & end<=xpnsl$POS[61]+20000) |> mutate(xpnsl_chrom=xpnsl$CHROM[61], xpnsl_pos=xpnsl$POS[61], xpnsl_popA=xpnsl$samplesA[61], xpnsl_popB=xpnsl$samplesB[61]),
    filter(gene.gff3, seqid==xpnsl$CHROM[62], start<=xpnsl$POS[62] & end>=xpnsl$POS[62]) |> mutate(xpnsl_chrom=xpnsl$CHROM[62], xpnsl_pos=xpnsl$POS[62], xpnsl_popA=xpnsl$samplesA[62], xpnsl_popB=xpnsl$samplesB[62]),
    filter(gene.gff3, seqid==xpnsl$CHROM[63], start>=xpnsl$POS[63]-150000 & end<=xpnsl$POS[63]+150000) |> mutate(xpnsl_chrom=xpnsl$CHROM[63], xpnsl_pos=xpnsl$POS[63], xpnsl_popA=xpnsl$samplesA[63], xpnsl_popB=xpnsl$samplesB[63]),
    filter(gene.gff3, seqid==xpnsl$CHROM[64], start>=xpnsl$POS[64]-83000 & end<=xpnsl$POS[64]+83000) |> mutate(xpnsl_chrom=xpnsl$CHROM[64], xpnsl_pos=xpnsl$POS[64], xpnsl_popA=xpnsl$samplesA[64], xpnsl_popB=xpnsl$samplesB[64]),
    filter(gene.gff3, seqid==xpnsl$CHROM[65], start>=xpnsl$POS[65]-40000 & end<=xpnsl$POS[65]+40000) |> mutate(xpnsl_chrom=xpnsl$CHROM[65], xpnsl_pos=xpnsl$POS[65], xpnsl_popA=xpnsl$samplesA[65], xpnsl_popB=xpnsl$samplesB[65]),
    .id="outlier")
top10

top10 <- 
  distinct(top10, id, PANTHER_accession, xpnsl_popA, .keep_all=TRUE)

top10 <- 
  rename(top10, peak=outlier, chrom=seqid, popA=xpnsl_popA, popB=xpnsl_popB) |>
  arrange(popA, popB, chrom, start)

top10 <- mutate(top10, loc=paste0(chrom, ":", start, "–", end))

write_tsv(x=top10, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.4/XP-nSL.gene.hits.peaks.tab")

saveRDS(object=top10, file="/Volumes/Tigrigobius/tgoby/genes/PANTHER.4/XP-nSL.gene.hits.peaks.RDS")

