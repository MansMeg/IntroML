# Shared test fixtures and independent numerical checks, loaded by markmyassignment.
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
  loss <- function(y, X, theta){
    # Independent probability calculation on small, moderate-valued fixtures.
    p <- plogis(drop(X %*% theta))
    -mean(y * log(p) + (1 - y) * log1p(-p))
  }
  derivative <- function(f, theta){
    vapply(seq_along(theta), function(j){
      h <- rep(0, length(theta))
      h[j] <- 1e-5
      (f(theta + h) - f(theta - h)) / (2e-5)
    }, numeric(1))
  }
  history <- function(result, data, epochs){
    testthat::expect_true(is.matrix(result), info = "Return the results matrix shown in the scaffold.")
    testthat::expect_equal(dim(result), c(as.integer(epochs), ncol(data$X) + 2L))
    testthat::expect_identical(colnames(result), c("epoch", "nll", colnames(data$X)))
    testthat::expect_true(all(is.finite(result)), info = "These small test runs should have finite results.")
    testthat::expect_equal(as.numeric(result[, "epoch"]), seq_len(epochs))
    for(j in seq_len(epochs)){
      testthat::expect_equal(as.numeric(result[j, "nll"]),
        loss(data$y, data$X, result[j, colnames(data$X)]), tolerance = 1e-7,
        info = "Record the mean loss on ALL observations after the complete epoch.")
    }
  }
  list(fixture = fixture, identical_rows = identical_rows,
       loss = loss, derivative = derivative, history = history)
})
