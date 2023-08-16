test_that("rv_context() outputs the reverse complementary mutation context", {
    expect_equal(rv_context("A[C>G]T"), "A[G>C]T")
})

test_that("strand_symmetric() outputs the reverse complementary mutation context if starting base is A or G", {
    expect_equal(strand_symmetric("A[C>G]T"), "A[C>G]T")
    expect_equal(strand_symmetric("A[A>G]T"), "A[T>C]T")
})
