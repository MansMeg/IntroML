# Shared fixtures and result checks, loaded by markmyassignment.
# Numerical references are fixed toy-case outputs, not solution implementations.
# Keep these names separate from the functions students implement.
.a1_checks <- local({
  fixture <- function(n = 23L){
    i <- seq_len(n)
    list(X = cbind("(Intercept)" = 1, z1 = sin(i), z2 = cos(i / 3)),
         y = as.numeric(i %% 3 == 0))
  }
  identical_rows <- function(){
    list(X = cbind("(Intercept)" = rep(1, 23), z1 = rep(0.25, 23),
                   z2 = rep(-0.5, 23)), y = rep(1, 23))
  }
  history <- function(result, data, epochs, expected_nll = NULL){
    testthat::expect_true(is.matrix(result), info = "Return the results matrix shown in the scaffold.")
    testthat::expect_equal(dim(result), c(as.integer(epochs), ncol(data$X) + 2L))
    testthat::expect_identical(colnames(result), c("epoch", "nll", colnames(data$X)))
    testthat::expect_true(all(is.finite(result)), info = "These small test runs should have finite results.")
    testthat::expect_equal(as.numeric(result[, "epoch"]), seq_len(epochs))
    # Fixed histories check the loss independently. For runs accepting any
    # valid shuffling scheme, check consistency with the student's own nll().
    # Check nll() first with its separate fixed-reference task.
    for(j in seq_len(epochs)){
      expected <- if(is.null(expected_nll)){
        nll(data$y, data$X, result[j, colnames(data$X)])
      } else expected_nll[j]
      testthat::expect_equal(as.numeric(result[j, "nll"]),
        as.numeric(expected), tolerance = 1e-7,
        info = "Record the mean loss on ALL observations after the complete epoch.")
    }
  }
  list(fixture = fixture, identical_rows = identical_rows,
       history = history)
})
