local({
  testthat::test_that("nll_grad agrees with numerical derivatives of the mean loss", {
    testthat::expect_true(is.function(nll_grad))
    d <- .a1_checks$fixture()
    for(theta in list(c(0, 0, 0), c(-0.7, 0.3, -0.4))){
      gradient <- nll_grad(d$y, d$X, theta)
      testthat::expect_length(gradient, ncol(d$X))
      expected <- .a1_checks$derivative(function(t) .a1_checks$loss(d$y, d$X, t), theta)
      testthat::expect_equal(as.numeric(gradient), expected, tolerance = 1e-7,
                            info = "Check the sign and average over the supplied observations.")
      testthat::expect_equal(as.numeric(nll_grad(rep(d$y, 2), rbind(d$X, d$X), theta)),
                            as.numeric(gradient), tolerance = 1e-8)
      one <- .a1_checks$derivative(function(t){
        .a1_checks$loss(d$y[1], d$X[1, , drop = FALSE], t)
      }, theta)
      testthat::expect_equal(as.numeric(nll_grad(d$y[1], d$X[1, , drop = FALSE], theta)),
                            one, tolerance = 1e-7,
                            info = "A batch of one must remain a matrix.")
    }
  })
})
