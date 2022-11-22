test_that("get_mut() gets the central mutation", {
  expect_equal(get_mut('A[C>T]G'), 'C>T')
})
