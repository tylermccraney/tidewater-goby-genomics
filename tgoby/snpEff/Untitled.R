library(tidyverse)

ann <- 
  read_tsv(file="/Volumes/Tigrigobius/tgoby/vcf/phased/segregating_sites.recode.ann.INFO")

ann <- 
  mutate(
    ann, 
    ANN=na_if(ANN, "?"),
    LOF=na_if(LOF, "?"),
    NMD=na_if(NMD, "?"),
    Gene_id=str_extract_all(string=ANN, pattern="STRG\\.\\d+")|>map_chr(last)|>gsub(pattern="\\.", replacement=""),
    ORF_type=str_extract_all(string=ANN, pattern="ORF_type:\\w+")|>map_chr(last)|>str_extract(pattern="ORF_type:(\\w+)_$", group=1),
    ANNOTATION=str_extract(string=ANN, pattern="^\\w\\|(\\w+\\&*\\w*)\\|", group=1),
    ANNOTATION_IMPACT=str_extract(string=ANN, pattern="^\\w\\|\\w+\\&*\\w*\\|(\\w+)\\|", group=1)) |>
  relocate(1:4, 8:10, 5:7)
ann

saveRDS(object=ann, file="/Volumes/Tigrigobius/tgoby/snpEff/annotations.RDS")

write_tsv(ann, file="/Volumes/Tigrigobius/tgoby/snpEff/annotations.tab", na="")

filter(ann, ORF_type=="complete") |> group_by(ANNOTATION) |> count(sort=TRUE) |> print(n=100)

filter(ann, ORF_type=="complete", CHROM=="JAPEHO010000013.1", between(POS, left=19600001, right=19700000)) |> group_by(ANNOTATION) |> count(sort=TRUE) |> print(n=1000)

filter(ann, is.na(STRG)) #|> count()
