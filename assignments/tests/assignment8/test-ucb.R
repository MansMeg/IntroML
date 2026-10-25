local({
  testthat::test_that("UCB tries every action and balances identical zero-reward arms", {
    d <- .a8_checks$probe(function(a, t) 0)
    result <- ucb_algorithm(c(10, -20, -30, -40, -50), d$bandit, c = 2)
    .a8_checks$bandit_result(result, d)
    testthat::expect_true(setequal(d$log$actions[1:5], 1:5),
      info = "Prioritize untried actions, irrespective of their initial estimates.")
    testthat::expect_equal(as.numeric(result$Qt), rep(0, 5),
      info = "Sample-average estimates become zero after observing zero rewards.")
    testthat::expect_equal(as.numeric(result$Nt), rep(200, 5),
      info = "With equal estimates, UCB favors the least-tried action; any tie order is valid.")
  })
})
