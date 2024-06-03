library(reshape2)
library(dplyr)
library(mutationsR)

## code to prepare `exposure_by_branch` dataset goes here, assuming mutation burden from `mut_by_branch` dataset already created

exposure_by_branch = read.table("./data-raw/exposure_matrix_branches.txt", header = T, check.names = F)

# allowing just one donor PD28690
exposure_by_branch = exposure_by_branch[grep("PD28690", rownames(exposure_by_branch)),]
signatures = colnames(exposure_by_branch)
branch_id = rownames(exposure_by_branch)

# assuming burden from mut_by_branch
mut_burdens = rowSums(mut_by_branch)
mut_burdens = mut_burdens[rownames(exposure_by_branch)]
exposure_by_branch = exposure_by_branch * mut_burdens
exposure_by_branch$branch = sapply(rownames(exposure_by_branch), function(x) strsplit(x, '_')[[1]][2])
exposure_by_branch = select(exposure_by_branch, all_of(c('branch', signatures)))


# get the long format
exposure_by_branch = melt(exposure_by_branch)
colnames(exposure_by_branch) = c('branch', 'signature', 'exposure')

usethis::use_data(exposure_by_branch, overwrite = TRUE)




