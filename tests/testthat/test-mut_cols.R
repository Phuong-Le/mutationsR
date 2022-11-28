test_that("mut_cols() outputs the right colours", {
  result = 'red'; names(result) = 'C>T'
  expect_equal(mut_cols('A[C>T]G'), result)

  result = 'plum2'; names(result) = 'T>G'
  expect_equal(mut_cols('CT[T>G]AA'), result)
})
