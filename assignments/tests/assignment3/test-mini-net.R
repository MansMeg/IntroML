local({
  testthat::test_that("mini_net applies ReLU, both biases, and the output weights", {
    f <- .a3_checks
    result <- mini_net(f$X, f$W, f$c, f$w, f$b)
    testthat::expect_equal(dim(result), c(3L, 1L))
    testthat::expect_equal(as.numeric(result), c(2.5, 1.75, 1.75))
    testthat::expect_equal(as.numeric(mini_net(f$X, f$W, f$c, f$w, 0)),
                           c(1.75, 1, 1))
  })
})
