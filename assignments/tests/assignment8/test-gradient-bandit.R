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

  testthat::test_that("the current-reward baseline gives the worked preference update", {
    # Only step 2 has a nonzero advantage: 3 - mean(1, 3) = 1.
    # Step 1 has zero advantage, and later rewards and baselines equal 2.
    d <- .a8_checks$probe(function(a, t) if (t == 1L) 1 else if (t == 2L) 3 else 2)
    set.seed(4711)
    result <- gradient_bandit_algorithm(d$bandit, alpha = 0.1)
    .a8_checks$bandit_result(result, d, estimate = "Ht")
    chosen <- d$log$actions[2]
    preferences <- rep(-0.02, 5)
    preferences[chosen] <- 0.08
    probabilities <- rep(1 / (4 + exp(0.1)), 5)
    probabilities[chosen] <- exp(0.1) / (4 + exp(0.1))
    testthat::expect_equal(as.numeric(result$Ht), preferences, tolerance = 1e-10,
      info = "Include the CURRENT reward in the baseline before updating preferences.")
    testthat::expect_equal(as.numeric(result$pit), probabilities, tolerance = 1e-10,
      info = "Return softmax probabilities computed from the updated preferences.")
  })

  testthat::test_that("the baseline is updated again before the third preference update", {
    # Rewards 1, 3, 8 give baselines 1, 2, 4 and advantages 0, 1, 4.
    # Every subsequent reward is 4, so preferences then remain unchanged.
    d <- .a8_checks$probe(function(a, t) {
      if (t == 1L) 1 else if (t == 2L) 3 else if (t == 3L) 8 else 4
    })
    set.seed(4711)
    result <- gradient_bandit_algorithm(d$bandit, alpha = 0.1)
    .a8_checks$bandit_result(result, d, estimate = "Ht")
    after_second <- rep(-0.02, 5)
    after_second[d$log$actions[2]] <- 0.08
    second_probabilities <- rep(1 / (4 + exp(0.1)), 5)
    second_probabilities[d$log$actions[2]] <- exp(0.1) / (4 + exp(0.1))
    expected <- after_second - 0.4 * second_probabilities
    expected[d$log$actions[3]] <- expected[d$log$actions[3]] + 0.4
    testthat::expect_equal(as.numeric(result$Ht), expected, tolerance = 1e-10,
      info = "At step 3 use baseline mean(1, 3, 8) = 4 and pre-update probabilities.")
    testthat::expect_equal(as.numeric(result$pit),
      exp(expected) / sum(exp(expected)), tolerance = 1e-10)
  })
})
