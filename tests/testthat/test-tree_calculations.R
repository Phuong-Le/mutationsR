test_that("get_all_ancestors works", {
  expected = c(39, 38, 30, 29, 28, 23, 22)
  expect_equal(get_all_ancestors(mut_tree, node = 16), expected)

  expected = c(38, 30, 29, 28, 23, 22)
  expect_equal(get_all_ancestors(mut_tree, node = 39), expected)
})


test_that("get_all_ancestors_from_tips works", {
  expected = c(39, 38, 30, 29, 28, 23, 22)
  expect_equal(get_all_ancestors_from_tips(mut_tree, tip = "PD28690bt_SB3_C5"), expected)
})
