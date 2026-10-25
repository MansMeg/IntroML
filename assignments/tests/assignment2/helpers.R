# Small fixtures and checks; no assumption about the representation of a grown tree.
.a2_checks <- local({
  two_groups <- function(){
    list(X = cbind(constant = rep(0, 6), z = c(4, 1, 6, 2, 5, 3)),
         y = c(9, 1, 11, 3, 10, 2))
  }
  four_groups <- function(){
    list(X = cbind(z = c(3, 1, 4, 2, 3, 1, 4, 2), constant = 0),
         y = c(9, 1, 20, 5, 11, 3, 22, 7),
         fitted = c(10, 2, 21, 6, 10, 2, 21, 6))
  }
  split <- function(result, X, l, best_ss, optimal_left){
    valid <- is.list(result) && all(c("j", "s", "R1", "R2") %in% names(result))
    testthat::expect_true(valid, info = "Return j, s, R1 and R2 for a valid split.")
    if(!valid) return(invisible(NULL))
    j <- result$j
    s <- result$s
    valid <- is.numeric(j) && length(j) == 1L && is.finite(j) &&
      j == as.integer(j) && j >= 1L && j <= ncol(X) &&
      is.numeric(s) && length(s) == 1L && is.finite(s)
    testthat::expect_true(valid, info = "j is a predictor column number; s is one finite split value.")
    if(!valid) return(invisible(NULL))
    left <- result$R1
    right <- result$R2
    indices <- c(left, right)
    valid <- is.numeric(left) && is.numeric(right) &&
      length(indices) == nrow(X) && all(is.finite(indices)) &&
      all(indices == as.integer(indices)) &&
      identical(sort(as.integer(indices)), seq_len(nrow(X)))
    testthat::expect_true(valid,
      info = "R1 and R2 must partition the supplied rows: no omitted, duplicated, or out-of-range indices.")
    if(!valid) return(invisible(NULL))
    testthat::expect_true(length(left) >= l && length(right) >= l,
      info = "BOTH child nodes must contain at least l observations.")
    testthat::expect_true(all(X[left, j] <= s),
      info = "R1 uses <= and indices relative to the supplied X.")
    testthat::expect_true(all(X[right, j] > s),
      info = "R2 uses >; keep equal predictor values in the same child.")
    # The tiny fixtures supply their optimal partitions; no split-score
    # implementation is included in the public checking helper.
    optimal <- any(vapply(optimal_left, function(rows){
      identical(sort(as.integer(left)), sort(as.integer(rows)))
    }, logical(1)))
    testthat::expect_true(optimal,
      info = "Choose a valid split with the smallest total within-child sum of squares.")
    if(!is.null(result$SS)){
      testthat::expect_equal(as.numeric(result$SS), best_ss, tolerance = 1e-8,
        info = "If returned, SS must be the sum of squares for the selected split.")
    }
  }
  bounded <- function(f){
    # Interrupt common non-terminating R loops in growth or pointer traversal.
    setTimeLimit(elapsed = 5, transient = TRUE)
    on.exit(setTimeLimit(cpu = Inf, elapsed = Inf, transient = FALSE))
    f()
  }
  grow <- function(X, y, l){
    bounded(function() grow_tree(X, y, l = l))
  }
  predictions <- function(X, tree, expected, info){
    result <- bounded(function() predict_with_tree(new_data = X, tree = tree))
    testthat::expect_true(is.numeric(result), info = "Return numeric predictions.")
    testthat::expect_equal(length(result), nrow(X), info = "Return one prediction per supplied row.")
    testthat::expect_equal(as.numeric(result), as.numeric(expected),
      tolerance = 1e-8, info = info)
  }
  list(two_groups = two_groups, four_groups = four_groups,
       split = split, grow = grow, predictions = predictions)
})
