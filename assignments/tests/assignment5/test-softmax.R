local({
  testthat::test_that("softmax returns probabilities and handles large common offsets", {
    expected <- c(.0900305731703805, .244728471054798, .665240955774822)
    for (offset in c(0, 1000, -1000)) {
      result <- softmax(c(-1, 0, 1) + offset)
      testthat::expect_equal(as.numeric(result), expected)
      testthat::expect_equal(sum(result), 1)
    }
    testthat::expect_equal(as.numeric(softmax(matrix(c(2, 2, 2), ncol = 1))),
                           rep(1 / 3, 3))
  })
})
