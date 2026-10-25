local({
  testthat::test_that("nll_grad matches fixed reference gradients of the mean loss", {
    testthat::expect_true(is.function(nll_grad))
    d <- .a1_checks$fixture()
    cases <- list(
      list(theta = c(0, 0, 0),
           gradient = c(0.1956521739130435, 0.000725938944407471, 0.03384311736311213),
           one = c(0.5, 0.4207354924039483, 0.4724784731573689)),
      list(theta = c(-0.7, 0.3, -0.4),
           gradient = c(0.02457928742085774, 0.02144450941072137, -0.02338376113952356),
           one = c(0.3045886246065694, 0.2563024899089727, 0.2878231365904299))
    )
    for(case in cases){
      theta <- case$theta
      gradient <- nll_grad(d$y, d$X, theta)
      testthat::expect_length(gradient, ncol(d$X))
      testthat::expect_equal(as.numeric(gradient), case$gradient, tolerance = 1e-7,
                            info = "Check the sign and average over the supplied observations.")
      testthat::expect_equal(as.numeric(nll_grad(rep(d$y, 2), rbind(d$X, d$X), theta)),
                            as.numeric(gradient), tolerance = 1e-8)
      testthat::expect_equal(as.numeric(nll_grad(d$y[1], d$X[1, , drop = FALSE], theta)),
                            case$one, tolerance = 1e-7,
                            info = "A batch of one must remain a matrix.")
    }
  })
})
