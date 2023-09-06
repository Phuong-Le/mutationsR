#' recover values (mutations/exposure) that have been split into branches
#' back to original samples
#' by aggregating all values from one tip/leaf to the root
#' for every tip/leaf
#'
#' @param branches a dataframe of values, with a column called 'node' that corresponds to the input tree
#' @param tree a phylogenetic tree of Newick format, where the tip/leaf labels are the same as the original samples
#' @param included_columns the columns in `branches` to be aggregated, default to all except the column 'node'
#' @return a dataframe that contains values for the original samples, these samples are the tips/leaves of the input tree
#' @export
#'
#' @examples
#' # the example will use `mut_by_branch` and `mut_tree` incorporated in this package,
#' # original source https://github.com/YichenWang1/small_bowel
#' library(mutationsR)
#' branches = mut_by_branch
#' branches$node = branches$node = sapply(rownames(branches), function(x) strsplit(x, '_')[[1]][2]) # in branches, the node ID is incorporated in its rowname
#' tree_to_samples(branches, mut_tree)
tree_to_samples = function(branches, tree, included_columns = NULL) {
  # convert tree to dataframe format
  tree = ggtree::fortify(tree)

  # processing branches
  if (is.null(included_columns))
    included_columns = colnames(branches)[colnames(branches) != 'node']
  available_nodes = as.numeric(branches$node)
  branches = dplyr::select(branches, all_of(included_columns))
  samples = as.data.frame(matrix(
    0,
    nrow = length(which(tree$isTip)),
    ncol = length(included_columns)
  ))
  colnames(samples) = included_columns
  sample_names = c()
  for (sample in which(tree$isTip)) {
    node = tree$node[sample]
    parent = tree$parent[tree$node == node]
    if (node %in% available_nodes) {
      sample_values = branches[available_nodes == node, ]
    } else {
      sample_values = matrix(0, nrow = 1, ncol = length(included_columns))
    }
    while (parent != node) {
      if (parent %in% available_nodes) {
        sample_values = sample_values + branches[available_nodes == parent, ]
      }
      node = parent
      parent = tree$parent[tree$node == node]
    }
    samples[sample, ] = sample_values
    sample_names = c(sample_names, tree$label[tree$node == sample])
  }
  samples$sample_id = sample_names
  samples = dplyr::select(samples, c('sample_id', included_columns))
  return(samples)
}
