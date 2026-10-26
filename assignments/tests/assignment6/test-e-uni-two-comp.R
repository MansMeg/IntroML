local({
  testthat::test_that("E-step responsibilities are probabilities for component two", {
    f <- .a6_checks
    result <- e_uni_two_comp(f$mixture, f$theta)
    testthat::expect_length(result, 5L)
    testthat::expect_equal(as.numeric(result), c(.0267026985220771, .0633789383330376,
      .168551928980445, .945956554595125, .991314771241743))
    equal <- list(mu_1 = 0, mu_2 = 0, sigma_1 = 1, sigma_2 = 1, pi = .3)
    extreme <- e_uni_two_comp(matrix(c(-1000, 1000), ncol = 1), equal)
    testthat::expect_equal(as.numeric(extreme), c(.3, .3), tolerance = 1e-8,
      info = "Normalise in log space to avoid underflow for extreme observations.")
  })
})
