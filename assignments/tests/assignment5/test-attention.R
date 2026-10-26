local({
  testthat::test_that("attention scales scores and normalises separately by row", {
    Q <- matrix(c(1, 0, 1, 1), ncol = 2, byrow = TRUE)
    K <- diag(2)
    V <- matrix(c(1, 2, -1, 3, 5, 2), nrow = 2, byrow = TRUE)
    result <- attention(Q, K, V)
    testthat::expect_type(result, "list")
    testthat::expect_equal(unname(result$attention),
      matrix(c(.669761549326657, .330238450673343, .5, .5),
             nrow = 2, byrow = TRUE), tolerance = 1e-10)
    testthat::expect_equal(unname(result$Z),
      matrix(c(1.66047690134669, 2.99071535202003, -.00928464797997064,
               2, 3.5, .5), nrow = 2, byrow = TRUE), tolerance = 1e-10)
  })
})
