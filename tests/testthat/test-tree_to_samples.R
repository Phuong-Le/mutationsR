
test_that("tree_to_samples recovers sample values correctly from branches", {
  branches = mut_by_branch
  branches$node = branches$node = sapply(rownames(branches), function(x) strsplit(x, '_')[[1]][2])
  results = tree_to_samples(branches, mut_tree)
  expected = mut_by_sample # internal data, saved in R/sysdata.rda
  results = dplyr::arrange(results, match(sample_id, rownames(expected)))
  results = dplyr::select(results, colnames(expected))
  rownames(results) = rownames(expected)
  expect_equal(results, expected)
})
