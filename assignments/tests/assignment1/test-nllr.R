local({
  testthat::test_that("nllr adds the ridge penalty without penalizing the intercept", {
    testthat::expect_true(is.function(nllr))
    d <- .a1_checks$fixture()
    theta <- c(-0.7, 0.3, -0.4)
    cases <- list(
      list(lambda = 0, expected = 0.6201621712308754),
      list(lambda = 0.6, expected = 0.6951621712308753),
      list(lambda = 1, expected = 0.7451621712308754)
    )
    for(case in cases){
      lambda <- case$lambda
      expected <- case$expected
      testthat::expect_equal(as.numeric(nllr(d$y, d$X, theta, lambda)), expected,
                            tolerance = 1e-8,
                            info = "Check loss and penalty scaling; omit the intercept from the penalty.")
      testthat::expect_equal(as.numeric(nllr(rep(d$y, 2), rbind(d$X, d$X), theta, lambda)),
                            expected, tolerance = 1e-8,
                            info = "Do not divide the loss or the penalty by n again.")
    }
    testthat::expect_equal(as.numeric(nllr(d$y, d$X, c(2, 0, 0), 1)),
                          1.518232358869059, tolerance = 1e-8)
  })
})
