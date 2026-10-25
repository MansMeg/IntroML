local({
  testthat::test_that("full gradient descent starts at zero and subtracts the mean gradient", {
    d <- .a1_checks$fixture()
    eta <- 0.03
    result <- gradient_descent(d$y, d$X, batch_size = nrow(d$X), eta = eta, epochs = 2)
    .a1_checks$history(result, d, 2)
    theta <- rep(0, ncol(d$X))
    for(j in 1:2){
      theta <- theta - eta * .a1_checks$derivative(function(t){
        .a1_checks$loss(d$y, d$X, t)
      }, theta)
      testthat::expect_equal(as.numeric(result[j, colnames(d$X)]), theta,
                            tolerance = 1e-7,
                            info = "Use one update per full batch; do not divide the mean gradient again.")
    }
  })

  testthat::test_that("all batch sizes make the right number of updates, including a smaller final batch", {
    # Identical rows make these checks independent of the chosen permutation.
    d <- .a1_checks$identical_rows()
    expected <- list(
      `23` = c(0.0298523485192, 0.0074630871298, -0.0149261742596),
      `10` = c(0.0878150263064, 0.0219537565766, -0.0439075131532),
      `1` = c(0.5598316407214, 0.1399579101804, -0.2799158203607)
    )
    for(b in c(23L, 10L, 1L)){
      set.seed(4711)
      result <- gradient_descent(d$y, d$X, batch_size = b, eta = 0.03, epochs = 2)
      .a1_checks$history(result, d, 2)
      testthat::expect_equal(as.numeric(result[2, colnames(d$X)]), expected[[as.character(b)]],
                            tolerance = 1e-7,
                            info = paste("Check updates for batch size", b, "on 23 observations."))
    }
  })

  testthat::test_that("stochastic epochs cover all observations and calls are reproducible", {
    d <- .a1_checks$fixture(20L)
    for(b in c(1L, 10L)){
      for(seed in c(17L, 4711L)){
        # At a tiny step size, ordering effects are much smaller than an omitted
        # or duplicated observation. All permutations are accepted.
        set.seed(seed)
        result <- gradient_descent(d$y, d$X, batch_size = b, eta = 1e-7, epochs = 1)
        expected <- -1e-7 * (nrow(d$X) / b) *
          .a1_checks$derivative(function(t) .a1_checks$loss(d$y, d$X, t), c(0, 0, 0))
        testthat::expect_true(max(abs(as.numeric(result[1, colnames(d$X)]) - expected)) < 1e-12,
                             info = "Use every observation exactly once in each epoch.")
      }
      set.seed(4711)
      first <- gradient_descent(d$y, d$X, batch_size = b, eta = 0.03, epochs = 3)
      set.seed(4711)
      second <- gradient_descent(d$y, d$X, batch_size = b, eta = 0.03, epochs = 3)
      .a1_checks$history(first, d, 3)
      testthat::expect_equal(first, second,
                            info = "Reset parameters each call and respect the random seed.")
    }
  })
})
