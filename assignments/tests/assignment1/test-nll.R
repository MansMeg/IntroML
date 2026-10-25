local({
  testthat::test_that("nll uses the mean negative log-likelihood", {
    testthat::expect_true(is.function(nll))
    d <- .a1_checks$fixture()
    theta <- c(-0.7, 0.3, -0.4)
    testthat::expect_equal(as.numeric(nll(d$y, d$X, c(0, 0, 0))), log(2),
                          tolerance = 1e-8, info = "At zero parameters, the mean loss is log(2).")
    testthat::expect_equal(as.numeric(nll(d$y, d$X, theta)),
                          .a1_checks$loss(d$y, d$X, theta), tolerance = 1e-8)
    testthat::expect_equal(as.numeric(nll(rep(d$y, 2), rbind(d$X, d$X), theta)),
                          as.numeric(nll(d$y, d$X, theta)), tolerance = 1e-8,
                          info = "Duplicating the data must not change a mean loss.")
    testthat::expect_equal(as.numeric(nll(d$y[1], d$X[1, , drop = FALSE], theta)),
                          .a1_checks$loss(d$y[1], d$X[1, , drop = FALSE], theta),
                          tolerance = 1e-8)
  })
})
