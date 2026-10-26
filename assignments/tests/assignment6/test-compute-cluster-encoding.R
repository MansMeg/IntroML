local({
  testthat::test_that("encoding chooses the closest cluster mean for each row", {
    f <- .a6_checks
    testthat::expect_equal(as.numeric(compute_cluster_encoding(f$X, f$means)), f$C)
    testthat::expect_equal(as.numeric(compute_cluster_encoding(f$X,
      f$means[2:1, , drop = FALSE])), 3L - f$C)
    testthat::expect_equal(as.numeric(compute_cluster_encoding(
      matrix(c(-1, 2, 8), ncol = 1), matrix(c(0, 9), ncol = 1))), c(1, 1, 2))
  })
})
