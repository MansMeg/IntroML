local({
  testthat::test_that("using all predictors agrees with ordinary growth on an unambiguous split", {
    d <- .a2_vg$two_groups()
    ordinary <- .a2_vg$bounded(function() grow_tree(d$X, d$y, l = 3L))
    tree <- .a2_vg$bounded(function(){
      grow_tree_m(d$X, d$y, l = 3L, m = ncol(d$X))
    })
    expected <- .a2_vg$bounded(function() predict_with_tree(d$X, ordinary))
    .a2_vg$prediction(expected, d$fitted, "Check your ordinary growth function first.")
    result <- .a2_vg$bounded(function() predict_with_tree(d$X, tree))
    .a2_vg$prediction(result, expected,
      "With m = p, search all predictors and store original predictor column numbers.")
  })

  testthat::test_that("random-feature growth handles one predictor and an unsplittable root", {
    d <- .a2_vg$two_groups()
    X <- d$X[, 2, drop = FALSE]
    tree <- .a2_vg$bounded(function() grow_tree_m(X, d$y, l = 3L, m = 1L))
    result <- .a2_vg$bounded(function() predict_with_tree(X, tree))
    .a2_vg$prediction(result, d$fitted,
      "A single selected predictor must remain a matrix.")
    X <- matrix(1, 4, 1)
    tree <- .a2_vg$bounded(function(){
      grow_tree_m(X, c(2, 4, 8, 10), l = 2L, m = 1L)
    })
    result <- .a2_vg$bounded(function() predict_with_tree(X[1, , drop = FALSE], tree))
    .a2_vg$prediction(result, 6,
      "When no selected predictor admits a valid split, predict the node's mean response.")
  })
})
