local({
  testthat::test_that("nllr_grad differentiates the mean loss plus the unpenalized-intercept ridge penalty", {
    testthat::expect_true(is.function(nllr_grad))
    d <- .a1_checks$fixture()
    theta <- c(-0.7, 0.3, -0.4)
    for(lambda in c(0, 0.6, 1)){
      expected <- .a1_checks$derivative(function(t){
        .a1_checks$loss(d$y, d$X, t) + lambda * sum(t[-1]^2) / 2
      }, theta)
      testthat::expect_equal(as.numeric(nllr_grad(d$y, d$X, theta, lambda)), expected,
                            tolerance = 1e-7,
                            info = "Check penalty scaling, sign, and the unpenalized intercept.")
      testthat::expect_equal(as.numeric(nllr_grad(rep(d$y, 2), rbind(d$X, d$X), theta, lambda)),
                            expected, tolerance = 1e-7)
      one <- .a1_checks$derivative(function(t){
        .a1_checks$loss(d$y[1], d$X[1, , drop = FALSE], t) + lambda * sum(t[-1]^2) / 2
      }, theta)
      testthat::expect_equal(as.numeric(nllr_grad(d$y[1], d$X[1, , drop = FALSE], theta, lambda)),
                            one, tolerance = 1e-7)
    }
  })
})
