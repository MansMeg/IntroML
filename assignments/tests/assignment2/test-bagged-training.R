local({
  testthat::test_that("bagging training returns B usable trees with repeated observations", {
    d <- .a2_vg$repeated()
    for(B in c(1L, 3L)){
      trees <- .a2_vg$bounded(function(){
        train_bagged_trees(d$X, d$y, l = 2L, B = B)
      })
      testthat::expect_true(is.list(trees), info = "Return an R list of grown trees.")
      testthat::expect_length(trees, B)
      for(tree in trees){
        result <- .a2_vg$bounded(function() predict_with_tree(d$X, tree))
        testthat::expect_true(is.numeric(result))
        testthat::expect_length(result, nrow(d$X))
        testthat::expect_true(all(is.finite(result)),
          info = "Every returned tree must work with your prediction function.")
        testthat::expect_true(all(result >= min(d$y) & result <= max(d$y)),
          info = "Regression-tree predictions are means of training responses.")
      }
    }
  })

  testthat::test_that("bagging handles a one-predictor matrix and unsplittable bootstrap data", {
    X <- matrix(1, 4, 1)
    trees <- .a2_vg$bounded(function(){
      train_bagged_trees(X, rep(7, 4), l = 2L, B = 3L)
    })
    testthat::expect_length(trees, 3L)
    for(tree in trees){
      result <- .a2_vg$bounded(function() predict_with_tree(X, tree))
      .a2_vg$prediction(result, rep(7, 4),
        "Keep predictor subsets as matrices and create a mean-response leaf when no split exists.")
    }
  })
})
