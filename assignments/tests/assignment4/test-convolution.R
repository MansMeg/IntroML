local({
  testthat::test_that("convolution uses stride one, no padding, and no kernel flip", {
    f <- .a4_checks
    result <- convolution(f$X, f$K)
    testthat::expect_equal(unname(result), f$response)
    testthat::expect_equal(unname(convolution(f$X, matrix(2, 1, 1))), 2 * f$X)
    testthat::expect_equal(dim(convolution(matrix(1:9, 3), matrix(1, 3, 3))),
                           c(1L, 1L))
    testthat::expect_equal(as.numeric(convolution(matrix(1:9, 3),
      matrix(1, 3, 3))), 45)
  })
})
