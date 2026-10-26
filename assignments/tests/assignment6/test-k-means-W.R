local({
  testthat::test_that("WPS includes the cluster-size weights in Equation 14.31", {
    f <- .a6_checks
    # Cluster SSEs are 10 and 16; their sizes are 2 and 3.
    testthat::expect_equal(as.numeric(k_means_W(f$X, f$C)), 68)
    testthat::expect_equal(as.numeric(k_means_W(f$X, 3L - f$C)), 68)
    testthat::expect_equal(as.numeric(k_means_W(matrix(rep(c(1, 2), 4),
      ncol = 2, byrow = TRUE), rep(1, 4))), 0)
  })
})
