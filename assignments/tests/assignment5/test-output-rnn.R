local({
  testthat::test_that("output_rnn applies the output weights and output bias", {
    result <- output_rnn(matrix(c(1, -2), ncol = 1),
      matrix(c(1, 2, 0, -1, -2, .5), nrow = 3, byrow = TRUE),
      matrix(c(.5, -1, 2), ncol = 1))
    testthat::expect_equal(dim(result), c(3L, 1L))
    testthat::expect_equal(as.numeric(result), c(-2.5, 1, -1))
  })
})
