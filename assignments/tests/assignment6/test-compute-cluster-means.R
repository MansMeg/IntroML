local({
  testthat::test_that("cluster means contain measurements only and use label order", {
    f <- .a6_checks
    testthat::expect_equal(unname(compute_cluster_means(f$X, f$C)), f$means)
    testthat::expect_equal(unname(compute_cluster_means(f$X, 3L - f$C)),
                           f$means[2:1, , drop = FALSE])
    testthat::expect_equal(dim(compute_cluster_means(f$X[, 1, drop = FALSE], f$C)),
                           c(2L, 1L))
  })
})
