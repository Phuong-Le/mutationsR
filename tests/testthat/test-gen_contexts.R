test_that("gen_context(1) returns just the central mutation", {
    expect_equal(gen_contexts(1), c("C>A", "C>G", "C>T", "T>A", "T>C", "T>G"))
})

test_that("gen_context(2) should raise an error as 2 is not an odd number", {
    expect_error(gen_contexts(2), "k is an odd number", fixed = T)
})

test_that("gen_context(k) returns a vector with 6*4^(k-1) contexts", {
    expect_equal(length(unique(gen_contexts(3))), 6 * 4^(3 - 1))
    expect_equal(length(unique(gen_contexts(5))), 6 * 4^(5 - 1))
})
