local({
  testthat::test_that("M-step returns weighted means, SDs, and mixing weight", {
    f <- .a6_checks
    result <- max_uni_two_comp(f$mixture, c(.1, .2, .4, .8, .9))
    testthat::expect_type(result, "list")
    testthat::expect_true(all(f$parameter_names %in% names(result)))
    testthat::expect_equal(as.numeric(unlist(result[f$parameter_names])),
      c(-.615384615384615, 2.33333333333333, 1.61904347537301,
        1.95078331845327, .48))
  })
})
