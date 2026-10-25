local({
  testthat::test_that("grow_tree stops with the mean response when the root cannot split", {
    cases <- list(
      list(X = matrix(1, 6, 2), y = c(1, 3, 4, 7, 8, 13), l = 2L, fitted = 6),
      list(X = matrix(1:3, ncol = 1), y = c(1, 5, 9), l = 2L, fitted = 5),
      list(X = matrix(c(0, 0, 0, 1), ncol = 1), y = c(1, 2, 4, 9), l = 2L, fitted = 4)
    )
    for(d in cases){
      tree <- .a2_checks$grow(d$X, d$y, d$l)
      .a2_checks$predictions(d$X, tree, rep(d$fitted, nrow(d$X)),
        "An unsplittable root is a leaf predicting its mean response.")
    }
  })

  testthat::test_that("grow_tree respects the minimum leaf size in both children", {
    d <- .a2_checks$two_groups()
    tree <- .a2_checks$grow(d$X, d$y, l = 3L)
    .a2_checks$predictions(d$X, tree, c(10, 2, 10, 2, 10, 2),
      "Each child has three rows and must remain a leaf when l = 3.")
  })

  testthat::test_that("grow_tree maps subset indices back to data rows at deeper nodes", {
    d <- .a2_checks$four_groups()
    for(order in list(seq_len(nrow(d$X)), c(8L, 3L, 6L, 1L, 7L, 4L, 2L, 5L))){
      X <- d$X[order, , drop = FALSE]
      tree <- .a2_checks$grow(X, d$y[order], l = 2L)
      .a2_checks$predictions(X, tree, d$fitted[order],
        paste("Check local-to-original indices and child links at every level;",
              "leaf means must use only the observations reaching that leaf."))
    }
  })
})
