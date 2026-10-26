local({
  testthat::test_that("mixture density uses pi for component two and sigmas as SDs", {
    f <- .a6_checks
    result <- d_uni_two_comp(as.numeric(f$mixture), f$theta)
    testthat::expect_length(result, 5L)
    testthat::expect_equal(as.numeric(result), c(.131284862307655, .170375105463211,
      .153682721342119, .0843468504898055, .0710299769513763))
    theta <- f$theta
    theta$pi <- 1
    testthat::expect_equal(as.numeric(d_uni_two_comp(3, theta)), .199471140200716)
  })
})
