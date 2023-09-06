## code to prepare `mut_by_branch` dataset goes here

mut_by_branch = read.table("./data-raw/sbs_mapped_to_branches.txt", header = T, check.names = F)

# allowing just one donor
mut_by_branch = mut_by_branch[grep("PD28690", rownames(mut_by_branch)),]

# change column names
to_cosmic_muts = function(mut) {
  center = strsplit(mut, ",")[[1]][1]
  flanks = strsplit(mut, ",")[[1]][2]
  flank1 = strsplit(flanks, "-")[[1]][1]
  flank2 = strsplit(flanks, "-")[[1]][2]
  return(paste0(flank1, "[", center, "]", flank2, sep = ""))
}
colnames(mut_by_branch) = sapply(colnames(mut_by_branch), to_cosmic_muts)

usethis::use_data(mut_by_branch, overwrite = TRUE)
