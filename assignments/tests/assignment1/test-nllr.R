local({
  testthat::test_that("nllr adds the ridge penalty without penalizing the intercept", {
    testthat::expect_true(is.function(nllr))
    d <- .a1_checks$fixture()
    theta <- c(-0.7, 0.3, -0.4)
    for(lambda in c(0, 0.6, 1)){
      expected <- .a1_checks$loss(d$y, d$X, theta) + lambda * sum(theta[-1]^2) / 2
      testthat::expect_equal(as.numeric(nllr(d$y, d$X, theta, lambda)), expected,
                            tolerance = 1e-8,
                            info = "Use the mean NLL plus lambda/2 times squared slopes; omit the intercept.")
      testthat::expect_equal(as.numeric(nllr(rep(d$y, 2), rbind(d$X, d$X), theta, lambda)),
                            expected, tolerance = 1e-8,
                            info = "Do not divide the loss or the penalty by n again.")
    }
    testthat::expect_equal(as.numeric(nllr(d$y, d$X, c(2, 0, 0), 1)),
                          .a1_checks$loss(d$y, d$X, c(2, 0, 0)), tolerance = 1e-8)
  })
})
