## code to prepare `mut_by_sample` dataset goes here

mut_by_sample = read.table("./data-raw/sbs_small_bowel_persample.txt", header = T, check.names = F)

# allowing just one donor
mut_by_sample = mut_by_sample[grep("PD28690", rownames(mut_by_sample)),]

# change column names
to_cosmic_muts = function(mut) {
  center = strsplit(mut, ",")[[1]][1]
  flanks = strsplit(mut, ",")[[1]][2]
  flank1 = strsplit(flanks, "-")[[1]][1]
  flank2 = strsplit(flanks, "-")[[1]][2]
  return(paste0(flank1, "[", center, "]", flank2, sep = ""))
}
colnames(mut_by_sample) = sapply(colnames(mut_by_sample), to_cosmic_muts)


usethis::use_data(mut_by_sample, internal = TRUE)
usethis::use_data(mut_by_sample, overwrite = TRUE)
