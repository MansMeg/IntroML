local({
  testthat::test_that("random forest returns B usable random-feature trees", {
    d <- .a2_vg$repeated()
    for(m in c(1L, 2L)){
      for(B in c(1L, 3L)){
        set.seed(4711)
        trees <- .a2_vg$bounded(function(){
          random_forest(d$X, d$y, l = 2L, B = B, m = m)
        })
        testthat::expect_true(is.list(trees), info = "Return a list of B grown trees.")
        testthat::expect_length(trees, B)
        for(tree in trees){
          result <- .a2_vg$bounded(function() predict_with_tree(d$X, tree))
          testthat::expect_true(is.numeric(result))
          testthat::expect_length(result, nrow(d$X))
          testthat::expect_true(all(is.finite(result)))
          testthat::expect_true(all(result >= min(d$y) & result <= max(d$y)))
        }
        result <- .a2_vg$bounded(function(){
          predict_with_bagged_trees(d$X[1, , drop = FALSE], trees)
        })
        testthat::expect_length(result, 1L)
        testthat::expect_true(all(is.finite(result)),
          info = "Reuse your ensemble prediction function with the returned trees.")
      }
    }
  })

  testthat::test_that("bootstrap samples vary and unsplittable data give usable leaves", {
    X <- matrix(1, nrow = 4, ncol = 1)
    y <- c(0, 0, 0, 8)
    set.seed(4711)
    trees <- .a2_vg$bounded(function(){
      random_forest(X, y, l = 2L, B = 20L, m = 1L)
    })
    testthat::expect_length(trees, 20L)
    predictions <- vapply(trees, function(tree){
      result <- .a2_vg$bounded(function(){
        predict_with_tree(X[1, , drop = FALSE], tree)
      })
      testthat::expect_length(result, 1L)
      as.numeric(result)
    }, numeric(1))
    testthat::expect_true(all(is.finite(predictions)))
    testthat::expect_true(all(predictions %in% c(0, 2, 4, 6, 8)),
      info = "Each unsplittable tree predicts its bootstrap sample's mean response.")
    testthat::expect_true(length(unique(predictions)) > 1L,
      info = "Draw a fresh size-n bootstrap sample with replacement for each tree.")
  })
})
