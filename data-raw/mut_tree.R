## code to prepare `mut_tree` dataset goes here

mut_tree = ape::read.tree("./data-raw/PD28690_snp_tree_with_branch_length.tree")
usethis::use_data(mut_tree, overwrite = TRUE)
