local({
  testthat::test_that("predict_with_tree routes new observations and returns them in input order", {
    X <- matrix(c(0, 0, 2, 2), ncol = 1)
    tree <- .a2_checks$grow(X, c(2, 4, 8, 10), l = 2L)
    new_X <- matrix(c(3, 0, -1, 2), ncol = 1)
    expected <- c(9, 3, 3, 9)
    .a2_checks$predictions(new_X, tree, expected,
      "Route every row independently, including values equal to the left group's split value.")
    for(i in seq_len(nrow(new_X))){
      .a2_checks$predictions(new_X[i, , drop = FALSE], tree, expected[i],
        "A single new observation must work as a one-row matrix.")
    }
  })

  testthat::test_that("predict_with_tree handles a tree consisting of one leaf", {
    X <- matrix(1, 4, 1)
    tree <- .a2_checks$grow(X, c(2, 4, 8, 10), l = 2L)
    .a2_checks$predictions(matrix(c(-10, 1, 20), ncol = 1), tree, c(6, 6, 6),
      "Check for a leaf before following a child pointer.")
    tree <- .a2_checks$grow(matrix(5, 1, 1), y = 7, l = 1L)
    .a2_checks$predictions(matrix(99, 1, 1), tree, 7,
      "A tree trained on one observation predicts that response.")
  })
})
