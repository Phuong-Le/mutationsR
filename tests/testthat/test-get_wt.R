test_that("get_wt_seq() gets the central mutation", {
  expect_equal(get_wt_seq('A[C>T]G'), 'ACG')
})
