local({
  testthat::test_that("mini_net_loss is the mean squared prediction error", {
    f <- .a3_checks
    result <- mini_net_loss(c(1, 0, 3), f$X, f$W, f$c, f$w, f$b)
    testthat::expect_length(result, 1L)
    testthat::expect_equal(as.numeric(result), 6.875 / 3)
    testthat::expect_equal(as.numeric(mini_net_loss(c(2.5, 1.75, 1.75),
      f$X, f$W, f$c, f$w, f$b)), 0)
  })
})
