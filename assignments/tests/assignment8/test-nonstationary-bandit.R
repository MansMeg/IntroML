local({
  testthat::test_that("only action one's reward mean changes with time", {
    set.seed(8201)
    for (t in c(1, 1000)) {
      means <- c(-3 + .01 * t, 1.20, .70, .72, 2.03)
      for (a in 1:5) {
        draws <- replicate(3000, nonstationary_bandit(a, t = t))
        testthat::expect_true(is.numeric(draws))
        testthat::expect_equal(length(draws), 3000L)
        testthat::expect_lt(abs(mean(draws) - means[a]), .15)
        testthat::expect_lt(abs(stats::sd(draws) - 1), .12)
      }
    }
  })
})
