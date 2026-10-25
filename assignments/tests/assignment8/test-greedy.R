local({
  testthat::test_that("greedy choices use the supplied initial estimates and sample averages", {
    d <- .a8_checks$greedy_fixture()
    result <- greedy_algorithm(d$Q1, d$probe$bandit)
    .a8_checks$bandit_result(result, d$probe)
    testthat::expect_equal(as.numeric(d$probe$log$actions), d$actions,
      info = "Choose the largest current estimate and update only the selected action.")
    testthat::expect_equal(as.numeric(result$Qt), d$Qt, tolerance = 1e-10,
      info = "Use each action's own sample mean; leave untried estimates unchanged.")
  })
})
