local({
  testthat::test_that("EM history records each updated parameter vector", {
    f <- .a6_checks
    printed <- capture.output(result <- em_uni_two_comp(f$mixture, f$theta, iter = 2))
    testthat::expect_type(result, "list")
    testthat::expect_equal(dim(result$history), c(2L, 5L))
    testthat::expect_equal(colnames(result$history), f$parameter_names)
    expected <- matrix(c(-.958007595889767, 3.04491530518098,
      1.01373042479872, 1.38059408557000, .439180978334485,
      -1.02345930256894, 3.35702520248738, .814856904836461,
      .862654463806057, .416268862602790), nrow = 2, byrow = TRUE)
    testthat::expect_equal(unname(result$history), expected)
    testthat::expect_equal(as.numeric(unlist(result$theta[f$parameter_names])),
                           expected[2, ])
    testthat::expect_true(length(printed) >= 1L,
      info = "Print the current log-likelihood while running EM.")
  })
})
