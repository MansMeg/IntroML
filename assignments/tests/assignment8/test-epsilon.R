local({
  testthat::test_that("epsilon zero reduces to greedy sample-average updates", {
    d <- .a8_checks$greedy_fixture()
    result <- epsilon_algorithm(d$Q1, d$probe$bandit, epsilon = 0)
    .a8_checks$bandit_result(result, d$probe)
    testthat::expect_equal(as.numeric(d$probe$log$actions), d$actions,
      info = "With epsilon = 0, always choose a greedy action.")
    testthat::expect_equal(as.numeric(result$Qt), d$Qt, tolerance = 1e-10,
      info = "Epsilon-greedy retains the sample-average value updates.")
  })
})
