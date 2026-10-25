local({
  testthat::test_that("alpha zero freezes preferences but the agent still receives rewards", {
    d <- .a8_checks$probe(function(a, t) t / 1000)
    set.seed(4711)
    result <- gradient_bandit_algorithm(d$bandit, alpha = 0)
    .a8_checks$bandit_result(result, d, estimate = "Ht")
    testthat::expect_equal(as.numeric(result$Ht), rep(0, 5))
    testthat::expect_equal(as.numeric(result$pit), rep(0.2, 5))
    testthat::expect_equal(as.numeric(result$Rt), (1:1000) / 1000)
    testthat::expect_equal(as.numeric(result$R_bar), 0.5005)
  })

  testthat::test_that("the previous-reward baseline gives the worked preference update", {
    # Only step 2 has a nonzero advantage: 3 - 1 = 2. Later baselines equal 2.
    d <- .a8_checks$probe(function(a, t) if (t == 1L) 1 else if (t == 2L) 3 else 2)
    set.seed(4711)
    result <- gradient_bandit_algorithm(d$bandit, alpha = 0.1)
    .a8_checks$bandit_result(result, d, estimate = "Ht")
    chosen <- d$log$actions[2]
    preferences <- rep(-0.04, 5)
    preferences[chosen] <- 0.16
    probabilities <- rep(1 / (4 + exp(0.2)), 5)
    probabilities[chosen] <- exp(0.2) / (4 + exp(0.2))
    testthat::expect_equal(as.numeric(result$Ht), preferences, tolerance = 1e-10,
      info = "Skip the first update and use the mean of PREVIOUS rewards as baseline.")
    testthat::expect_equal(as.numeric(result$pit), probabilities, tolerance = 1e-10,
      info = "Return softmax probabilities computed from the updated preferences.")
  })
})
