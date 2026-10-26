local({
  testthat::test_that("qkv returns three distinct projections, one token per row", {
    X <- matrix(c(1, 2, 3, -1, 0, 2), nrow = 2, byrow = TRUE)
    Wq <- matrix(c(1, 0, 0, 1, 1, -1), ncol = 2, byrow = TRUE)
    Wk <- matrix(c(0, 1, 1, 0, -1, 2), ncol = 2, byrow = TRUE)
    Wv <- matrix(c(2, 0, 1, -1, 0, 1), ncol = 2, byrow = TRUE)
    result <- qkv(X, Wq, Wk, Wv)
    testthat::expect_type(result, "list")
    testthat::expect_equal(unname(result$Q), matrix(c(4, -1, 1, -2),
      nrow = 2, byrow = TRUE))
    testthat::expect_equal(unname(result$K), matrix(c(-1, 7, -2, 3),
      nrow = 2, byrow = TRUE))
    testthat::expect_equal(unname(result$V), matrix(c(4, 1, -2, 2),
      nrow = 2, byrow = TRUE))
  })
})
