local({
  testthat::test_that("stationary rewards have the correct action means and unit SD", {
    set.seed(8101)
    means <- c(1.62, 1.20, .70, .72, 2.03)
    for (a in 1:5) {
      draws <- replicate(3000, stationary_bandit(a))
      testthat::expect_true(is.numeric(draws))
      testthat::expect_equal(length(draws), 3000L)
      testthat::expect_lt(abs(mean(draws) - means[a]), .15)
      testthat::expect_lt(abs(stats::sd(draws) - 1), .12)
    }
    # Time is accepted for compatibility with the algorithms, but ignored.
    set.seed(8102)
    early <- replicate(3000, stationary_bandit(1, t = 1))
    set.seed(8102)
    late <- replicate(3000, stationary_bandit(1, t = 1000))
    testthat::expect_lt(abs(mean(early) - mean(late)), .15)
  })
})
