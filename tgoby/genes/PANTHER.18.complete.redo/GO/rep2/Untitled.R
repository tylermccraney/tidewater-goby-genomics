library(tidyverse)
library(ggthemes)

setwd(dir="/Volumes/Tigrigobius/tgoby/genes/PANTHER.18.complete.redo/GO/rep2/")

"%!in%" <- negate(`%in%`)

BiolProc_names <- 
  c("PANTHER_GO_Slim_Biological_Process", "REFLIST", "observed", "expected", "over_under", "fold_Enrichment", "raw_Pvalue", "FDR")
ProClass_names <- 
  c("PANTHER_Protein_Class", "REFLIST", "observed", "expected", "over_under", "fold_Enrichment", "raw_Pvalue", "FDR")

ihs_NorteHumboldt_ProClass <- 
  read_tsv(file="analysis (18).txt", skip=12, col_names=ProClass_names)
nsl_SantaBarbara_BiolProc <- 
  read_tsv(file="analysis (19).txt", skip=12, col_names=BiolProc_names)
xpnsl_SantaBarbara_NorteHumboldt_BiolProc <- 
  read_tsv(file="analysis (20).txt", skip=12, col_names=BiolProc_names)
xpclr_NorteHumboldt_Mendocino_ProClass <- 
  read_tsv(file="analysis (21).txt", skip=12, col_names=ProClass_names)
xpclr_NorteHumboldt_SantaBarbara_BiolProc <- 
  read_tsv(file="analysis (22).txt", skip=12, col_names=BiolProc_names)
xpclr_NorteHumboldt_SantaBarbara_ProClass <- 
  read_tsv(file="analysis (23).txt", skip=12, col_names=ProClass_names)
NorteHumboldt_top10_ProClass <- 
  read_tsv(file="analysis (24).txt", skip=12, col_names=ProClass_names)
Mendocino_top10_ProClass <- 
  read_tsv(file="analysis (25).txt", skip=12, col_names=ProClass_names)

#
ihs_scores_NorteHumboldt_ProClass <-
  read_tsv(file="analysis (1).txt", skip=4)

ihs_scores_Mendocino_ProClass <-
  read_tsv(file="analysis (2).txt", skip=4)

ihs_scores_SantaBarbara_ProClass <-
  read_tsv(file="analysis (3).txt", skip=4)

nsl_scores_NorteHumboldt_ProClass <-
  read_tsv(file="analysis (4).txt", skip=4)

nsl_scores_Mendocino_ProClass <-
  read_tsv(file="analysis (5).txt", skip=4)

nsl_scores_SantaBarbara_ProClass <-
  read_tsv(file="analysis (6).txt", skip=4)

xpnsl_scores_NorteHumboldt_SantaBarbara_ProClass <-
  read_tsv(file="analysis (7).txt", skip=4)

xpnsl_scores_Mendocino_NorteHumboldt_BiolProc <-
  read_tsv(file="analysis (8).txt", skip=4)

xpnsl_scores_Mendocino_SantaBarbara_ProClass <-
  read_tsv(file="analysis (9).txt", skip=4)

xpnsl_scores_SantaBarbara_NorteHumboldt_BiolProc <-
  read_tsv(file="analysis (10).txt", skip=4)

xpnsl_scores_SantaBarbara_NorteHumboldt_ProClass <-
  read_tsv(file="analysis (11).txt", skip=4)

xpnsl_scores_SantaBarbara_Mendocino_BiolProc <-
  read_tsv(file="analysis (12).txt", skip=4)

xpnsl_scores_SantaBarbara_Mendocino_ProClass <-
  read_tsv(file="analysis (13).txt", skip=4)

xpclr_scores_NorteHumboldt_Mendocino_ProClass <-
  read_tsv(file="analysis (14).txt", skip=4)

xpclr_scores_Mendocino_NorteHumboldt_BiolProc <-
  read_tsv(file="analysis (15).txt", skip=4)

xpclr_scores_SantaBarbara_NorteHumboldt_BiolProc <-
  read_tsv(file="analysis (16).txt", skip=4)

xpclr_scores_SantaBarbara_Mendocino_ProClass <-
  read_tsv(file="analysis (17).txt", skip=4)


#
BiolProc_scores <- 
  bind_rows(
    list(
      `Mendocino (Del Norte-Humboldt)`=xpnsl_scores_Mendocino_NorteHumboldt_BiolProc|>mutate(stat="XP-nSL"), 
      `Santa Barbara (Del Norte-Humboldt)`=xpnsl_scores_SantaBarbara_NorteHumboldt_BiolProc|>mutate(stat="XP-nSL"),
      `Santa Barbara (Mendocino)`=xpnsl_scores_SantaBarbara_Mendocino_BiolProc|>mutate(stat="XP-nSL"), 
      `Mendocino (Del Norte-Humboldt)`=xpclr_scores_Mendocino_NorteHumboldt_BiolProc|>mutate(stat="XP-CLR"), 
      `Santa Barbara (Del Norte-Humboldt)`=xpclr_scores_SantaBarbara_NorteHumboldt_BiolProc|>mutate(stat="XP-CLR")), 
    .id="pop") |> 
  mutate(
    term=str_split_i(string=`PANTHER GO-Slim Biological Process`, pattern=" \\(", i=1), 
    annotation_set="Biological Process", 
    id=str_extract(string=`PANTHER GO-Slim Biological Process`, pattern="GO:\\d{7}")) |> 
  select(-`PANTHER GO-Slim Biological Process`) |> 
  relocate(annotation_set, term, id, .after=pop)

ProClass_scores <- 
  bind_rows(
    list(
      `Del Norte-Humboldt`=ihs_scores_NorteHumboldt_ProClass|>mutate(stat="iHS"), 
      `Mendocino`=ihs_scores_Mendocino_ProClass|>mutate(stat="iHS"),
      `Santa Barbara`=ihs_scores_SantaBarbara_ProClass|>mutate(stat="iHS"),
      `Del Norte-Humboldt`=nsl_scores_NorteHumboldt_ProClass|>mutate(stat="nSL"), 
      `Mendocino`=nsl_scores_Mendocino_ProClass|>mutate(stat="nSL"),
      `Santa Barbara`=nsl_scores_SantaBarbara_ProClass|>mutate(stat="nSL"),
      `Del Norte-Humboldt (Santa Barbara)`=xpnsl_scores_NorteHumboldt_SantaBarbara_ProClass |>mutate(stat="XP-nSL"), 
      `Mendocino (Santa Barbara)`=xpnsl_scores_Mendocino_SantaBarbara_ProClass|>mutate(stat="XP-nSL"),
      `Santa Barbara (Del Norte-Humboldt)`=xpnsl_scores_SantaBarbara_NorteHumboldt_ProClass|>mutate(stat="XP-nSL"),
      `Santa Barbara (Mendocino)`=xpnsl_scores_SantaBarbara_Mendocino_ProClass|>mutate(stat="XP-nSL"), 
      `Del Norte-Humboldt (Mendocino)`=xpclr_scores_NorteHumboldt_Mendocino_ProClass|>mutate(stat="XP-CLR"), 
      `Santa Barbara (Mendocino)`=xpclr_scores_SantaBarbara_Mendocino_ProClass|>mutate(stat="XP-CLR")), 
    .id="pop") |> 
  mutate(
    term=str_split_i(string=`PANTHER Protein Class`, pattern=" \\(", i=1), 
    annotation_set="Protein Class", 
    id=str_extract(string=`PANTHER Protein Class`, pattern="PC\\d{5}")) |> 
  select(-`PANTHER Protein Class`) |> 
  relocate(annotation_set, term, id, .after=pop)

scores <- 
  bind_rows(BiolProc_scores, ProClass_scores) |> 
  filter(
    overUnder=="+",
    term%!in%c("biological_process", "protein class"), 
    !is.na(id))

scores_ <- 
  pivot_wider(data=scores, names_from=pop, values_from=fdr, id_cols=c(annotation_set, term, id, stat)) |> 
  arrange(annotation_set, term, stat) |> 
  relocate(`Del Norte-Humboldt (Mendocino)`, `Del Norte-Humboldt (Santa Barbara)`, `Mendocino (Del Norte-Humboldt)`, `Mendocino (Santa Barbara)`, `Mendocino`, `Santa Barbara (Del Norte-Humboldt)`, `Santa Barbara (Mendocino)`, `Santa Barbara`, .after=id)
scores__ <- 
  pivot_wider(data=scores, names_from=pop, values_from=overUnder, id_cols=c(annotation_set, term, id, stat)) |> 
  arrange(annotation_set, term, stat) |> 
  relocate(`Del Norte-Humboldt (Mendocino)`, `Del Norte-Humboldt (Santa Barbara)`, `Mendocino (Del Norte-Humboldt)`, `Mendocino (Santa Barbara)`, `Mendocino`, `Santa Barbara (Del Norte-Humboldt)`, `Santa Barbara (Mendocino)`, `Santa Barbara`, .after=id)

left_join(x=scores_, y=scores__, by=join_by(annotation_set, term, id, stat), suffix=c(" FDR", " overUnder")) |> 
  mutate(
    `Del Norte-Humboldt (Mendocino)`=paste0(`Del Norte-Humboldt (Mendocino) overUnder`, " (", `Del Norte-Humboldt (Mendocino) FDR`, ")"), 
    `Del Norte-Humboldt (Santa Barbara)`=paste0(`Del Norte-Humboldt (Santa Barbara) overUnder`, " (", `Del Norte-Humboldt (Santa Barbara) FDR`, ")"), 
#    `Del Norte-Humboldt`=paste0(`Del Norte-Humboldt overUnder`, " (", `Del Norte-Humboldt FDR`, ")"), 
    `Mendocino (Del Norte-Humboldt)`=paste0(`Mendocino (Del Norte-Humboldt) overUnder`, " (", `Mendocino (Del Norte-Humboldt) FDR`, ")"),
    `Mendocino (Santa Barbara)`=paste0(`Mendocino (Santa Barbara) overUnder`, " (", `Mendocino (Santa Barbara) FDR`, ")"), 
    `Mendocino`=paste0(`Mendocino overUnder`, " (", `Mendocino FDR`, ")"), 
    `Santa Barbara (Del Norte-Humboldt)`=paste0(`Santa Barbara (Del Norte-Humboldt) overUnder`, " (", `Santa Barbara (Del Norte-Humboldt) FDR`, ")"),
    `Santa Barbara (Mendocino)`=paste0(`Santa Barbara (Mendocino) overUnder`, " (", `Santa Barbara (Mendocino) FDR`, ")"),
    `Santa Barbara`=paste0(`Santa Barbara overUnder`, " (", `Santa Barbara FDR`, ")")) |>
  select(-4:-11, -13:-20) |>
  mutate(
    `Del Norte-Humboldt (Mendocino)`=if_else(condition=`Del Norte-Humboldt (Mendocino)`=="NA (NA)", true=NA, false=`Del Norte-Humboldt (Mendocino)`),
    `Del Norte-Humboldt (Santa Barbara)`=if_else(condition=`Del Norte-Humboldt (Santa Barbara)`=="NA (NA)", true=NA, false=`Del Norte-Humboldt (Santa Barbara)`),
#    `Del Norte-Humboldt`=if_else(condition=`Del Norte-Humboldt`=="NA (NA)", true=NA, false=`Del Norte-Humboldt`),
    `Mendocino (Del Norte-Humboldt)`=if_else(condition=`Mendocino (Del Norte-Humboldt)`=="NA (NA)", true=NA, false=`Mendocino (Del Norte-Humboldt)`),
    `Mendocino (Santa Barbara)`=if_else(condition=`Mendocino (Santa Barbara)`=="NA (NA)", true=NA, false=`Mendocino (Santa Barbara)`),
    `Mendocino`=if_else(condition=`Mendocino`=="NA (NA)", true=NA, false=`Mendocino`),
    `Santa Barbara (Del Norte-Humboldt)`=if_else(condition=`Santa Barbara (Del Norte-Humboldt)`=="NA (NA)", true=NA, false=`Santa Barbara (Del Norte-Humboldt)`),
    `Santa Barbara (Mendocino)`=if_else(condition=`Santa Barbara (Mendocino)`=="NA (NA)", true=NA, false=`Santa Barbara (Mendocino)`),
    `Santa Barbara`=if_else(condition=`Santa Barbara`=="NA (NA)", true=NA, false=`Santa Barbara`)) ->
  scoresw

print(scoresw, n=100)

write_tsv(scores, file="scores.long.tsv", na="")
write_tsv(scoresw, file="scores.wide.tsv", na="")

write_tsv(scores_, file="scores_.tsv", na="")
write_tsv(scores__, file="scores__.tsv", na="")


#
BiolProc_lists <- 
  bind_rows(
    list(
      `Santa Barbara`=nsl_SantaBarbara_BiolProc|>mutate(stat="nSL"), 
      `Santa Barbara (Del Norte-Humboldt)`=xpnsl_SantaBarbara_NorteHumboldt_BiolProc|>mutate(stat="XP-nSL"), 
      `Del Norte-Humboldt (Santa Barbara)`=xpclr_NorteHumboldt_SantaBarbara_BiolProc|>mutate(stat="XP-CLR")), 
    .id="pop") |> 
  mutate(
    term=str_split_i(string=PANTHER_GO_Slim_Biological_Process, pattern=" \\(", i=1), 
    annotation_set="Biological Process", 
    id=str_extract(string=PANTHER_GO_Slim_Biological_Process, pattern="GO:\\d{7}")) |> 
  select(-PANTHER_GO_Slim_Biological_Process) |> 
  relocate(annotation_set, term, id, .after=pop)

#
ProClass_lists <- 
  bind_rows(
    list(
      `Del Norte-Humboldt`=ihs_NorteHumboldt_ProClass|>mutate(stat="iHS"), 
      `Del Norte-Humboldt (Mendocino)`=xpclr_NorteHumboldt_Mendocino_ProClass|>mutate(stat="XP-CLR"), 
      `Del Norte-Humboldt (Santa Barbara)`=xpclr_NorteHumboldt_SantaBarbara_ProClass|>mutate(stat="XP-CLR"), 
      `Del Norte-Humboldt`=NorteHumboldt_top10_ProClass|>mutate(stat="top10"),
      `Mendocino`=Mendocino_top10_ProClass|>mutate(stat="top10")), 
    .id="pop") |> 
  mutate(
    term=str_split_i(string=PANTHER_Protein_Class, pattern=" \\(", i=1), 
    annotation_set="Protein Class", 
    id=str_extract(string=PANTHER_Protein_Class, pattern="PC\\d{5}")) |> 
  select(-PANTHER_Protein_Class) |> 
  relocate(annotation_set, term, id, .after=pop)


lists <- 
  bind_rows(BiolProc_lists, ProClass_lists) |> 
  filter(
    fold_Enrichment>1, 
    term%!in%c("biological_process", "protein class"), 
    !is.na(id))


lists_ <- 
  pivot_wider(data=lists, names_from=pop, values_from=FDR, id_cols=c(annotation_set, term, id, stat)) |> 
  arrange(annotation_set) |> 
  relocate(
    `Del Norte-Humboldt (Mendocino)`, 
    `Del Norte-Humboldt (Santa Barbara)`, 
    `Del Norte-Humboldt`, 
#    `Mendocino (Del Norte-Humboldt)`, 
#    `Mendocino (Santa Barbara)`, 
    `Mendocino`, 
    `Santa Barbara (Del Norte-Humboldt)`, 
#    `Santa Barbara (Mendocino)`, 
    `Santa Barbara`, 
    .after=id)
lists__ <- 
  pivot_wider(data=lists, names_from=pop, values_from=fold_Enrichment, id_cols=c(annotation_set, term, id, stat)) |> 
  arrange(annotation_set) |> 
  relocate(
    `Del Norte-Humboldt (Mendocino)`, 
    `Del Norte-Humboldt (Santa Barbara)`, 
    `Del Norte-Humboldt`, 
    #    `Mendocino (Del Norte-Humboldt)`, 
    #    `Mendocino (Santa Barbara)`, 
    `Mendocino`, 
    `Santa Barbara (Del Norte-Humboldt)`, 
    #    `Santa Barbara (Mendocino)`, 
    `Santa Barbara`, 
    .after=id)

print(lists_, n=100)

left_join(x=lists_, y=lists__, by=join_by(annotation_set, term, id, stat), suffix=c(" FDR", " fold_Enrichment")) |> 
  mutate(
    `Del Norte-Humboldt (Mendocino)`=paste0(`Del Norte-Humboldt (Mendocino) fold_Enrichment`|>round(digits=1), " (", `Del Norte-Humboldt (Mendocino) FDR`, ")"), 
    `Del Norte-Humboldt (Santa Barbara)`=paste0(`Del Norte-Humboldt (Santa Barbara) fold_Enrichment`|>round(digits=1), " (", `Del Norte-Humboldt (Santa Barbara) FDR`, ")"), 
    `Del Norte-Humboldt`=paste0(`Del Norte-Humboldt fold_Enrichment`|>round(digits=1), " (", `Del Norte-Humboldt FDR`, ")"), 
    `Mendocino`=paste0(`Mendocino fold_Enrichment`|>round(digits=1), " (", `Mendocino FDR`, ")"), 
    `Santa Barbara (Del Norte-Humboldt)`=paste0(`Santa Barbara (Del Norte-Humboldt) fold_Enrichment`|>round(digits=1), " (", `Santa Barbara (Del Norte-Humboldt) FDR`, ")"),
    `Santa Barbara`=paste0(`Santa Barbara fold_Enrichment`|>round(digits=1), " (", `Santa Barbara FDR`, ")")) |>
  select(-4:-9, -11:-16) |>
  mutate(
    `Del Norte-Humboldt (Mendocino)`=if_else(condition=`Del Norte-Humboldt (Mendocino)`=="NA (NA)", true=NA, false=`Del Norte-Humboldt (Mendocino)`),
    `Del Norte-Humboldt (Santa Barbara)`=if_else(condition=`Del Norte-Humboldt (Santa Barbara)`=="NA (NA)", true=NA, false=`Del Norte-Humboldt (Santa Barbara)`),
    `Del Norte-Humboldt`=if_else(condition=`Del Norte-Humboldt`=="NA (NA)", true=NA, false=`Del Norte-Humboldt`),
    `Mendocino`=if_else(condition=`Mendocino`=="NA (NA)", true=NA, false=`Mendocino`),
    `Santa Barbara (Del Norte-Humboldt)`=if_else(condition=`Santa Barbara (Del Norte-Humboldt)`=="NA (NA)", true=NA, false=`Santa Barbara (Del Norte-Humboldt)`),
    `Santa Barbara`=if_else(condition=`Santa Barbara`=="NA (NA)", true=NA, false=`Santa Barbara`)) ->
  listsw

print(listsw, n=100)

write_tsv(lists, file="lists.long.tsv", na="")
write_tsv(listsw, file="lists.wide.tsv", na="")


write_tsv(lists_, file="lists_.tsv", na="")
write_tsv(lists__, file="lists__.tsv", na="")

#
