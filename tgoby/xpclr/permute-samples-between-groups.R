library(tidyverse)

dat <- 
  bind_rows(
    read_tsv(file="../pops/NorteHumboldt", col_names="INDV") |> 
      mutate(POP="NorteHumboldt"), 
    read_tsv(file="../pops/Mendocino", col_names="INDV") |> 
      mutate(POP="Mendocino"), 
    read_tsv(file="../pops/SantaBarbara", col_names="INDV") |> 
      mutate(POP="SantaBarbara"))

NorteHumboldt_Mendocino <- filter(dat, POP%in%unique(POP)[-3])$INDV
NorteHumboldt_SantaBarbara <- filter(dat, POP%in%unique(POP)[-2])$INDV
Mendocino_SantaBarbara <- filter(dat, POP%in%unique(POP)[-1])$INDV

permuterAB <- function(test, n_samplesA, permutations=1000, samplesA, samplesB){
  for(i in 1:permutations){
    perm <- as.list(rep(NA, permutations))
    sample(test) -> perm[[i]]
    write_lines(x=perm[[i]][1:n_samplesA], file=paste0(samplesA,"_",i,".txt"))
    write_lines(x=perm[[i]][(1+n_samplesA):length(test)], file=paste0(samplesB,"_",i,".txt"))}}

setwd(dir="NorteHumboldt_Mendocino/")
permuterAB(test=NorteHumboldt_Mendocino, n_samplesA=36, samplesA="NorteHumboldt", samplesB="Mendocino")

setwd(dir="../NorteHumboldt_SantaBarbara/")
permuterAB(test=NorteHumboldt_SantaBarbara, n_samplesA=36, samplesA="NorteHumboldt", samplesB="SantaBarbara")

setwd(dir="../Mendocino_SantaBarbara/")
permuterAB(test=Mendocino_SantaBarbara, n_samplesA=24, samplesA="Mendocino", samplesB="SantaBarbara")



## generate perms for global between-group stats (e.g., global FST)
setwd(dir="../NorteHumboldt_Mendocino_SantaBarbara/")

permuterABC <- function(test=dat$INDV, n_samplesA=36, n_samplesB=24, n_samplesC=24, permutations=1000, samplesA="NorteHumboldt", samplesB="Mendocino", samplesC="SantaBarbara"){
  for(i in 1:permutations){
    perm <- as.list(rep(NA, permutations))
    sample(test) -> perm[[i]]
    write_lines(x=perm[[i]][1:n_samplesA], file=paste0(samplesA,"_",i,".txt"))
    write_lines(x=perm[[i]][(1+n_samplesA):(n_samplesA+n_samplesB)], file=paste0(samplesB,"_",i,".txt"))
    write_lines(x=perm[[i]][(1+n_samplesA+n_samplesB):(n_samplesA+n_samplesB+n_samplesC)], file=paste0(samplesC,"_",i,".txt"))}}

permuterABC()



permuterABCD <- function(test, n_samplesA=6, n_samplesB=6, n_samplesC=12, n_samplesD=12, permutations=1000, samplesA="Tillas", samplesB="Earl", samplesC="Stone", samplesD="Big"){
  for(i in 1:permutations){
    perm <- as.list(rep(NA, permutations))
    sample(test) -> perm[[i]]
    write_lines(x=perm[[i]][1:n_samplesA], file=paste0(samplesA,"_",i,".txt"))
    write_lines(x=perm[[i]][(1+n_samplesA):(n_samplesA+n_samplesB)], file=paste0(samplesB,"_",i,".txt"))
    write_lines(x=perm[[i]][(1+n_samplesA+n_samplesB):(n_samplesA+n_samplesB+n_samplesC)], file=paste0(samplesC,"_",i,".txt"))
    write_lines(x=perm[[i]][(1+n_samplesA+n_samplesB+n_samplesC):(n_samplesA+n_samplesB+n_samplesC+n_samplesD)], file=paste0(samplesD,"_",i,".txt"))}}

setwd(dir="../NorteHumboldt/")
permuterABCD(test=filter(dat, POP=="NorteHumboldt")|>pull(INDV))

setwd(dir="../SantaBarbara/")
permuterABCD(test=filter(dat, POP=="SantaBarbara")|>pull(INDV), n_samplesC=6, n_samplesD=6, samplesA="Antonio", samplesB="Ynez", samplesC="Burro", samplesD="Paredon")

setwd(dir="../Mendocino/")
permuterAB(test=filter(dat, POP=="Mendocino")|>pull(INDV), n_samplesA=12, samplesA="Virgin", samplesB="Pudding")


