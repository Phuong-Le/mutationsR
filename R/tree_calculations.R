library(ggtree)

#' get all ancestral nodes from a tree of a particular node
#'
#' @param tree: a phylo object, eg input from ape::read.tree from a Newick tree
#' @param node: numeric, a node of interest
#' @return a vector of all ancestral nodes for the selected node
#' @export
#'
#' @examples
#' #' # the example will use `mut_by_branch` and `mut_tree` incorporated in this package,
#' # original source https://github.com/YichenWang1/small_bowel
#' library(mutationsR)
#' library(ggtree)
#'
#' ggtree(mut_tree) + geom_text(aes(label = node), nudge_y = 0.1, colour = 'blue') + geom_tiplab() # get the sense of what the tree looks like
#'
#' get_all_ancestors(mut_tree, node = 16)
#' get_all_ancestors(mut_tree, node = 39)
get_all_ancestors = function(tree, node) {
  tree = ggtree::fortify(tree)
  parent = tree$parent[tree$node == node]
  ancestors = c()
  while (parent != node) {
    ancestors = c(ancestors, parent)
    node = parent
    parent = tree$parent[tree$node == node]
  }
  return(ancestors)
}

#' get all ancestral nodes from a tree of a particular tip
#'
#' @param tree: a phylo object, eg input from ape::read.tree from a Newick tree
#' @param tip: string, the tip of the tree of interest
#' @return a vector of all ancestral nodes for the selected tip
#' @export
#'
#' @examples
#' #' # the example will use `mut_by_branch` and `mut_tree` incorporated in this package,
#' # original source https://github.com/YichenWang1/small_bowel
#' library(mutationsR)
#' library(ggtree)
#'
#' ggtree(mut_tree) + geom_text(aes(label = node), nudge_y = 0.1, colour = 'blue') + geom_tiplab() # get the sense of what the tree looks like
#'
#' get_all_ancestors_from_tips(mut_tree, tip = "PD28690bt_SB3_C5")
get_all_ancestors_from_tips = function(tree, tip) {
  tree = ggtree::fortify(tree)
  node = tree$node[tree$label == tip]
  return(get_all_ancestors(tree, node))
}


