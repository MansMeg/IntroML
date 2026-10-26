local({
  testthat::test_that("activation is elementwise tanh and preserves dimensions", {
    result <- activation(matrix(c(-2, 0, .5, 1), nrow = 2))
    testthat::expect_equal(dim(result), c(2L, 2L))
    testthat::expect_equal(as.numeric(result),
      c(-.964027580075817, 0, .462117157260010, .761594155955765))
  })
})
