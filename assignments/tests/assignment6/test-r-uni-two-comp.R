local({
  testthat::test_that("mixture draws use standard deviations and pi for component two", {
    set.seed(6301)
    theta <- list(mu_1 = -4, mu_2 = 6, sigma_1 = 2, sigma_2 = .5, pi = .25)
    result <- r_uni_two_comp(6000, theta)
    testthat::expect_true(is.numeric(result))
    testthat::expect_null(dim(result))
    testthat::expect_length(result, 6000L)
    testthat::expect_true(all(is.finite(result)))
    testthat::expect_lt(abs(mean(result) - (-1.5)), .35)
    testthat::expect_lt(abs(stats::var(result) - 21.8125), 1.5)
    for (pi in c(0, 1)) {
      theta$pi <- pi
      result <- r_uni_two_comp(3000, theta)
      testthat::expect_lt(abs(mean(result) - c(-4, 6)[pi + 1]), .2)
      testthat::expect_lt(abs(stats::sd(result) - c(2, .5)[pi + 1]), .15)
    }
  })
})
