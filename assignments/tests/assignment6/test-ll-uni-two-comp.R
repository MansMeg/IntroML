local({
  testthat::test_that("mixture log-likelihood sums log densities without underflow", {
    f <- .a6_checks
    testthat::expect_equal(as.numeric(ll_uni_two_comp(f$mixture, f$theta)),
                           -10.79047470773065)
    equal <- list(mu_1 = 0, mu_2 = 0, sigma_1 = 1, sigma_2 = 1, pi = .3)
    testthat::expect_equal(as.numeric(ll_uni_two_comp(c(-1000, 1000), equal)),
                           -1000001.8378770664)
  })
})
