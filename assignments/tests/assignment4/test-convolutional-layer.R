local({
  testthat::test_that("convolutional_layer adds bias before a scalar activation", {
    f <- .a4_checks
    result <- convolutional_layer(f$X, f$K, -10, function(x) max(0, x))
    testthat::expect_equal(unname(result),
      matrix(c(0, 0, 0, 0, 0, 0, 2, 4, 8, 10, 12, 14),
             nrow = 3, byrow = TRUE))
    testthat::expect_equal(unname(convolutional_layer(f$X, f$K, 2,
      function(x) x^2)), (f$response + 2)^2)
    small <- convolutional_layer(matrix(1:4, 2), matrix(1, 2, 2),
                                  -3, function(x) max(0, x))
    testthat::expect_equal(dim(small), c(1L, 1L))
    testthat::expect_equal(as.numeric(small), 7)
  })
})
