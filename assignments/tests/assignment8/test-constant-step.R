local({
  testthat::test_that("constant-step updates use alpha and rewards at the current step", {
    for (alpha in c(0, 0.2, 0.7)) {
      d <- .a8_checks$probe(function(a, t) if (t %% 2L == 0L) 2 else 0)
      Q1 <- c(4, -2, -3, -4, -5)
      result <- nonstationary_algorithm(Q1, d$bandit, epsilon = 0, alpha = alpha)
      .a8_checks$bandit_result(result, d)
      testthat::expect_equal(as.numeric(result$Rt), rep(c(0, 2), 500))
      # Closed form after 500 pairs of rewards 0, 2; no algorithm replay.
      limit <- 2 / (2 - alpha)
      expected <- Q1
      expected[1] <- limit + (Q1[1] - limit) * (1 - alpha)^1000
      testthat::expect_equal(as.numeric(result$Qt), expected, tolerance = 1e-10,
        info = "Use Q <- Q + alpha * (reward - Q); alpha = 0 leaves Q unchanged.")
    }
  })
})
