local({
  testthat::test_that("tree_split finds the best valid predictor and partitions the supplied rows", {
    d <- .a2_checks$two_groups()
    .a2_checks$split(tree_split(d$X, d$y, l = 2L), d$X, 2L, best_ss = 4,
                      optimal_left = list(c(2L, 4L, 6L)))
    # Reordering must also reorder the local row indices.
    order <- c(6L, 1L, 4L, 2L, 5L, 3L)
    X <- d$X[order, , drop = FALSE]
    y <- d$y[order]
    .a2_checks$split(tree_split(X, y, l = 3L), X, 3L, best_ss = 4,
                      optimal_left = list(c(1L, 3L, 4L)))
  })

  testthat::test_that("tree_split accepts tied minima and keeps repeated values together", {
    X <- cbind(a = 1:4, b = 1:4)
    y <- c(0, 1, 1, 0)
    # Either tied predictor and either optimal endpoint split is acceptable.
    .a2_checks$split(tree_split(X, y, l = 1L), X, 1L, best_ss = 2 / 3,
                      optimal_left = list(1L, c(1L, 2L, 3L)))
    X <- matrix(c(0, 0, 1, 1), ncol = 1)
    y <- c(0, 1, 0, 1)
    .a2_checks$split(tree_split(X, y, l = 2L), X, 2L, best_ss = 1,
                      optimal_left = list(c(1L, 2L)))
    X <- matrix(c(2, 1), ncol = 1)
    y <- c(5, 1)
    .a2_checks$split(tree_split(X, y, l = 1L), X, 1L, best_ss = 0,
                      optimal_left = list(2L))
  })

  testthat::test_that("tree_split returns NULL whenever no candidate satisfies both child sizes", {
    cases <- list(
      list(X = matrix(1, 6, 2), y = 1:6, l = 2L),
      list(X = matrix(1:3, ncol = 1), y = c(1, 5, 9), l = 2L),
      list(X = matrix(c(0, 0, 0, 1), ncol = 1), y = 1:4, l = 2L),
      list(X = matrix(7, 1, 1), y = 3, l = 1L)
    )
    for(d in cases){
      testthat::expect_null(tree_split(d$X, d$y, l = d$l),
        info = "Return NULL for constant predictors, too few rows, or unbalanced repeated values.")
    }
  })
})
