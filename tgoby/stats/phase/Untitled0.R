library(tidyverse)

filename <- dir(pattern="*.diff.indv.switch")

indv_switch <- filename |> map(\(filename) read_tsv(file=filename) |> mutate(LOCUS=gsub(".mac.diff.indv.switch", "", filename))) |> reduce(rbind)

indv_switch <- mutate(indv_switch, POP=gsub(pattern="\\d\\d$", replacement="", x=INDV))

SWITCH_ERROR_LOCUS <- group_by(indv_switch, LOCUS) |> summarize(SWITCH_ERROR_RATE=mean(SWITCH))

SWITCH_ERROR_POP <- group_by(indv_switch, POP) |> summarize(SWITCH_ERROR_RATE=mean(SWITCH))

SWITCH_ERROR_POP_LOCUS <- group_by(indv_switch, POP, LOCUS) |> summarize(SWITCH_ERROR_RATE=mean(SWITCH))

write_csv(SWITCH_ERROR_LOCUS, file="phase-switch-errors-chrom.csv")

write_csv(SWITCH_ERROR_POP, file="phase-switch-errors-pop.csv")

write_csv(SWITCH_ERROR_POP_LOCUS, file="phase-switch-errors-pop-chrom.csv")
