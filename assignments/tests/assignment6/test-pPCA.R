local({
  testthat::test_that("pPCA returns observations with the specified mean and covariance", {
    set.seed(6201)
    b <- c(.5, 2, -1)
    exact <- pPCA(matrix(0, 3, 2), b, 0)
    testthat::expect_null(dim(exact))
    testthat::expect_equal(as.numeric(exact), b)
    W <- matrix(c(1, 0, 0, 2, 1, -1), nrow = 3, byrow = TRUE)
    draws <- replicate(6000, pPCA(W, b, sigma2 = 4))
    testthat::expect_equal(dim(draws), c(3L, 6000L))
    testthat::expect_true(all(is.finite(draws)))
    testthat::expect_true(all(abs(rowMeans(draws) - b) < .2),
      info = "The observation mean should be b, not zero.")
    expected_cov <- matrix(c(5, 0, 1, 0, 8, -2, 1, -2, 6), nrow = 3)
    testthat::expect_true(all(abs(stats::cov(t(draws)) - expected_cov) < .8),
      info = "Use independent latent coordinates and noise with variance sigma2.")
  })
})
