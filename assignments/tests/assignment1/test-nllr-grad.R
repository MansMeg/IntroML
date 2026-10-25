local({
  testthat::test_that("nllr_grad differentiates the mean loss plus the unpenalized-intercept ridge penalty", {
    testthat::expect_true(is.function(nllr_grad))
    d <- .a1_checks$fixture()
    theta <- c(-0.7, 0.3, -0.4)
    cases <- list(
      list(lambda = 0,
           gradient = c(0.02457928742085774, 0.02144450941072137, -0.02338376113952356),
           one = c(0.3045886246065694, 0.2563024899089727, 0.2878231365904299)),
      list(lambda = 0.6,
           gradient = c(0.02457928742085774, 0.2014445094107214, -0.2633837611395236),
           one = c(0.3045886246065694, 0.4363024899089727, 0.04782313659042986)),
      list(lambda = 1,
           gradient = c(0.02457928742085774, 0.3214445094107213, -0.4233837611395236),
           one = c(0.3045886246065694, 0.5563024899089727, -0.1121768634095702))
    )
    for(case in cases){
      lambda <- case$lambda
      testthat::expect_equal(as.numeric(nllr_grad(d$y, d$X, theta, lambda)), case$gradient,
                            tolerance = 1e-7,
                            info = "Check penalty scaling, sign, and the unpenalized intercept.")
      testthat::expect_equal(as.numeric(nllr_grad(rep(d$y, 2), rbind(d$X, d$X), theta, lambda)),
                            case$gradient, tolerance = 1e-7)
      testthat::expect_equal(as.numeric(nllr_grad(d$y[1], d$X[1, , drop = FALSE], theta, lambda)),
                            case$one, tolerance = 1e-7)
    }
  })
})
