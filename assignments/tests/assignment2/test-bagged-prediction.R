local({
  testthat::test_that("bagged predictions average the supplied trees", {
    X <- matrix(1, 4, 1)
    trees <- lapply(c(2, 6), function(value){
      .a2_vg$bounded(function() grow_tree(X, rep(value, 4), l = 2L))
    })
    for(new_X in list(matrix(c(-1, 0, 2), ncol = 1), matrix(5, 1, 1))){
      result <- .a2_vg$bounded(function(){
        predict_with_bagged_trees(new_data = new_X, trees = trees)
      })
      .a2_vg$prediction(result, rep(4, nrow(new_X)),
        "Average across trees: trees predicting 2 and 6 must give 4.")
      result <- .a2_vg$bounded(function(){
        predict_with_bagged_trees(new_data = new_X, trees = trees[1])
      })
      .a2_vg$prediction(result, rep(2, nrow(new_X)),
        "With one tree, return that tree's predictions.")
    }
  })

  testthat::test_that("bagged predictions preserve new-data row order", {
    X <- matrix(c(0, 0, 2, 2), ncol = 1)
    trees <- lapply(list(c(0, 2, 8, 10), c(2, 4, 4, 6)), function(y){
      .a2_vg$bounded(function() grow_tree(X, y, l = 2L))
    })
    new_X <- matrix(c(3, 0, -1, 2), ncol = 1)
    result <- .a2_vg$bounded(function(){
      predict_with_bagged_trees(new_data = new_X, trees = trees)
    })
    .a2_vg$prediction(result, c(7, 2, 2, 7),
      "Average each observation's predictions across trees, retaining the new-data row order.")
  })
})
