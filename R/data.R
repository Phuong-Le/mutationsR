#' Single base substitution (SBS) mutation matrix
#'
#' @description
#' an SBS matrix that has been mapped to the tree nodes (branches)
#' from the small intestine of one patient.
#' The tree is stored in `mut_tree`
#'
#' @format ## `SBS mutation matrix`
#' A data frame with 33 rows and 96 columns,
#' with columns representing the mutations
#' and rows representing the tree nodes (branches)
#'
#' @source <https://github.com/YichenWang1/small_bowel/blob/main/data/mutation_matrices/sbs_mapped_to_branches.txt>
"mut_by_branch"


#' Single base substitution (SBS) mutation matrix
#'
#' @description
#' an SBS matrix from the small intestine of one patient.
#' The tree is stored in `mut_tree`
#'
#' @format ## `SBS mutation matrix`
#' A data frame with 21 rows and 96 columns,
#' with columns representing the mutations
#' and rows representing the samples.
#' This dataset is used to test
#' whether `tree_to_sample` can reconstruct
#' the original samples from
#' information that has been split to branches/nodes and its tree structure.
#'
#' @source <https://github.com/YichenWang1/small_bowel/blob/main/data/mutation_matrices/sbs_small_bowel_persample.txt>
"mut_by_sample"



#' Mutation tree
#'
#' @description
#' a phylogenetic tree describing how samples
#' from one donor are related to each other.
#' The "tips/leaves" of the tree are the sample names
#' where as the nodes (branches) are estimated by MPBoot
#'
#'
#' @format ## `Newick tree`
#'
#' @source <https://github.com/YichenWang1/small_bowel/blob/main/data/phylogenetic_trees/PD28690_snp_tree_with_branch_length.tree>
"mut_tree"


#' Mutational signature exposure on the branches
#'
#' @description
#' an SBS matrix that has been mapped to the tree nodes (branches)
#' from the small intestine of one patient.
#' The tree is stored in `mut_tree`
#' The mutation burden used to calculate this object was from `mut_by_branch`
#'
#' @format ## `exposure in long format`
#' A data frame with 220 rows and 3 columns,
#' with columns being the branch_id, the signature name, and the exposure by that signature on that branch
#'
#' @source <https://github.com/YichenWang1/small_bowel/blob/main/data/mutation_matrices/sbs_mapped_to_branches.txt>
"exposure_by_branch"
