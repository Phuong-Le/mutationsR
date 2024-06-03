

#' get signature coordinates to be plotted on the phylogenetic tree
#'
#' @param tree a phylogenetic tree with each branch length being the load of mutations corresponding to that branch
#' @param signature_burden_by_branches a dataframe with the following required columns: 'branch' - branch/node of the tree in numeric (e.g. 1), 'signature' - the name mutational signatures  (e.g. 'SBS1'), 'exposure' - the mutation load by the corresponding signature in the corresponding branch
#'
#' @return a dataframe of signature coordinates to plot on the phylogenetic tree
#' @export
get_signature_coordinate = function(tree, signature_burden_by_branches, bar_size = 0.1) {
  branches = unique(signature_burden_by_branches$branch)
  tree_df = ggtree::fortify(tree)

  sig_coordinates = matrix(nrow = 0, ncol = 6)
  branches_with_sig = branches[branches %in% tree_df$node]
  for (branch in branches_with_sig) {
    branch_exposure = signature_burden_by_branches[signature_burden_by_branches$branch == branch,]
    sigs = branch_exposure$signature
    x_max = tree_df$x[tree_df$node == branch]
    y = tree_df$y[tree_df$node == branch]
    y_max = y + bar_size
    y_min = y - bar_size
    branchlength = tree_df$branch.length[tree_df$node == branch]
    for (sig in sigs) {
      sig_contribution = branch_exposure$exposure[branch_exposure$signature == sig]
      x_min = x_max - sig_contribution
      sig_coordinates = rbind(sig_coordinates, c(branch, sig, x_min, x_max, y_min, y_max))
      x_max = x_min
    }
  }
  sig_coordinates = as.data.frame(sig_coordinates)
  colnames(sig_coordinates) = c('branch', 'signature', 'x_min', 'x_max', 'y_min', 'y_max')
  return(sig_coordinates)
}


#' plot signatures on a phylogenetic tree given a matrix of mutation load
#'
#' @param tree a phylogenetic tree with each branch length being the load of mutations corresponding to that branch
#' @param signature_burden_by_branches a dataframe with the following required columns: 'branch' - branch/node of the tree in numeric (e.g. 1), 'signature' - the name mutational signatures  (e.g. 'SBS1'), 'exposure' - the mutation load by the corresponding signature in the corresponding branch
#' @param signature_colours a vector of signature colours, named by the signatures, default to NULL (ggplot default colour pallete)
#' @param burden whether to display the burden axis, default to TRUE
#'
#' @return a ggplot/ggtree object of phylogenetic trees with signatures annotated
#'
#' @import ggplot2
#' @export
plot_signature_by_branches = function(tree, signature_burden_by_branches, signature_colours = NULL, burden = TRUE) {
  sig_coordinates = get_signature_coordinate(tree, signature_burden_by_branches)
  p = ggtree::ggtree(tree) +
    ggtree::geom_tiplab() +
    geom_rect(data = sig_coordinates, inherit.aes = FALSE,
              mapping = aes(xmin=as.numeric(x_min),
                            xmax=as.numeric(x_max),
                            ymin=as.numeric(y_min),
                            ymax=as.numeric(y_max),
                            fill = signature)) +
    coord_cartesian(clip="off")

  if (!is.null(signature_colours)) {
    p = p + scale_fill_manual(values = signature_colours)
  }

  if (burden == TRUE) {
    p = p + ggtree::theme_tree2()
  }

  return(p)
}


