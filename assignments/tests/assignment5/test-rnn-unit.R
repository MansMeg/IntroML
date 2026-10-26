local({
  testthat::test_that("rnn_unit combines input, previous state, and bias", {
    result <- rnn_unit(matrix(c(1, -2), ncol = 1), matrix(c(2, 0, -1), nrow = 1),
      W = matrix(c(1, 2, -1, .5), nrow = 2, byrow = TRUE),
      U = matrix(c(1, 2, 3, 0, -1, 2), nrow = 2, byrow = TRUE),
      b = matrix(c(.5, -1), ncol = 1))
    testthat::expect_equal(dim(result), c(2L, 1L))
    testthat::expect_equal(as.numeric(result), c(-3.5, -5))
  })
})
