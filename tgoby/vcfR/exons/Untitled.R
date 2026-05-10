library(vcfR)
library(ape)
library(tidyverse)

setwd(dir="/Volumes/Tigrigobius/tgoby/vcfR/exons/")

dna <- read.dna(file="/Volumes/Tigrigobius/tgoby1/vcfR/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna", format="fasta")

dna <- dna[c(1,112,223,334,445,556,667,778,810,2,13,24,35,46,57,68,79,90,101,113,124,135)]

names(dna) <- gsub(pattern=" .+", replacement="", x=names(dna))

gff <- read.table(file="exons.tab", sep="\t", quote="")

row.names(gff) <- paste0(gff$V2, "_", gff$V3, "_", gff$V4, "_", gff$V5)

DNA <- NULL
for(i in names(dna)){DNA[[i]] <- as.matrix.DNAbin(dna[i])}

get_fasta <- function(exon){
  VCF <- read.vcfR(file=paste0("/Volumes/Tigrigobius/tgoby/vcf/exons/", exon, ".recode.vcf"))
  GFF <- gff[exon,]
  REF <- GFF[[1]]
  CDS <- vcfR2DNAbin(x=VCF, consensus=FALSE, extract.haps=TRUE, ref.seq=DNA[[REF]][GFF[[3]]:GFF[[4]]], start.pos=GFF[[3]], verbose=FALSE)
  write.FASTA(x=CDS, file=paste0("fasta/", exon, ".fas"))}

exons <- row.names(gff)

for(exon in exons){get_fasta(exon=exon)}
