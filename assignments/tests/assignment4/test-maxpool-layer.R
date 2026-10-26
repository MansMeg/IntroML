local({
  testthat::test_that("maxpool_layer uses disjoint 2 by 2 windows and drops borders", {
    result <- maxpool_layer(.a4_checks$X)
    testthat::expect_equal(unname(result),
      matrix(c(7, 9, 17, 19), nrow = 2, byrow = TRUE))
    odd <- matrix(-1:-25, nrow = 5, byrow = TRUE)
    testthat::expect_equal(unname(maxpool_layer(odd)),
      matrix(c(-1, -3, -11, -13), nrow = 2, byrow = TRUE))
  })
})
