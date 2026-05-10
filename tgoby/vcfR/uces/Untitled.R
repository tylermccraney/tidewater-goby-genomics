library(vcfR)
library(ape)
library(tidyverse)

setwd(dir="/home/wtm3/tgoby/vcfR/uces/")

dna <- read.dna(file="/home/wtm3/tgoby1/vcfR/GCA_026437365.1_fEucNew1.0.hap1_genomic.fna", format="fasta")

names(dna)

dna <- dna[c(1,112,223,334,445,556,667,778,810,2,13,24,35,46,57,68,79,90,101,113,124,135)]

names(dna) <- gsub(pattern=" .+", replacement="", x=names(dna))

gff <- read.table(file="fEucNew1_0_hap1_genomic.uces.gff", sep="\t", quote="")

row.names(gff) <- gsub(pattern="ID=uce-", replacement="", x=gff$V9)

DNA <- NULL
for(i in names(dna)){DNA[[i]] <- as.matrix.DNAbin(dna[i])}

get_fasta <- function(uce){
  VCF <- read.vcfR(file=paste0("/home/wtm3/tgoby/vcf/uces/uce-", uce, ".recode.vcf"))
  GFF <- gff[as.character(uce),]
  REF <- GFF[[1]]
  UCE <- vcfR2DNAbin(x=VCF, consensus=FALSE, extract.haps=TRUE, ref.seq=DNA[[REF]][GFF[[4]]:GFF[[5]]], start.pos=GFF[[4]], verbose=FALSE)
  write.FASTA(x=UCE, file=paste0("fasta/uce-", uce, ".fas"))}

uces <- read_table(file="uce-snps.tab")

snps <- filter(uces, snps!=0) |> pull(locus)

for(uce in snps){get_fasta(uce=uce)}
