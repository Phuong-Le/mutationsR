test_that("get_signature_coordinate works", {

  tree_to_plot = ape::read.tree(text = "((PD1:10, PD2:15):2, PD3:20);")
  tree_df = ggtree::fortify(tree_to_plot)

  # getting input for signature_burden_by_branches
  signature_burden_by_branches = matrix(nrow = 0, ncol = 3)
  branch_PD1 = tree_df$node[which(tree_df$label == 'PD1')]
  signature_burden_by_branches = rbind(signature_burden_by_branches,
                                       c(branch_PD1, 'SBS1', 3),
                                       c(branch_PD1, 'SBS5', 7))

  branch_PD2 = tree_df$node[which(tree_df$label == 'PD2')]
  signature_burden_by_branches = rbind(signature_burden_by_branches,
                                       c(branch_PD2, 'SBS1', 5),
                                       c(branch_PD2, 'SBS3', 10))

  branch_PD3 = tree_df$node[which(tree_df$label == 'PD3')]
  signature_burden_by_branches = rbind(signature_burden_by_branches,
                                       c(branch_PD3, 'SBS1', 8),
                                       c(branch_PD3, 'SBS5', 10),
                                       c(branch_PD3, 'SBS3', 2))
  signature_burden_by_branches = as.data.frame(signature_burden_by_branches)
  colnames(signature_burden_by_branches) = c('branch', 'signature', 'exposure')
  signature_burden_by_branches$exposure = as.numeric(signature_burden_by_branches$exposure)

  # constructing expected coordinates
  # to simplify, we only have information for the tips
  expected = matrix(nrow = 0, ncol = 6)
  y_PD1 = tree_df$y[which(tree_df$label == 'PD1')]
  expected = rbind(expected,
                   c(branch_PD1, 'SBS1', 9, 12, y_PD1 - 0.1, y_PD1 + 0.1),
                   c(branch_PD1, 'SBS5', 2, 9, y_PD1 - 0.1, y_PD1 + 0.1)
                   )

  y_PD2 = tree_df$y[which(tree_df$label == 'PD2')]
  expected = rbind(expected,
                   c(branch_PD2, 'SBS1', 12, 17, y_PD2 - 0.1, y_PD2 + 0.1),
                   c(branch_PD2, 'SBS3', 2, 12, y_PD2 - 0.1, y_PD2 + 0.1)
                   )

  y_PD3 = tree_df$y[which(tree_df$label == 'PD3')]
  expected = rbind(expected,
                   c(branch_PD3, 'SBS1', 12, 20, y_PD3 - 0.1, y_PD3 + 0.1),
                   c(branch_PD3, 'SBS5', 2, 12, y_PD3 - 0.1, y_PD3 + 0.1),
                   c(branch_PD3, 'SBS3', 0, 2, y_PD3 - 0.1, y_PD3 + 0.1)
                  )
  expected = as.data.frame(expected)
  colnames(expected) = c('branch', 'signature', 'x_min', 'x_max', 'y_min', 'y_max')

  results = get_signature_coordinate(tree_to_plot, signature_burden_by_branches)
  results = results[results$branch == expected$branch,]


  expect_equal(results, expected)

})
