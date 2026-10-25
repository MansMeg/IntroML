# VG checks use the student's own tree builders and prediction functions.
.a2_vg <- local({
  bounded <- function(f){
    setTimeLimit(elapsed = 5, transient = TRUE)
    on.exit(setTimeLimit(cpu = Inf, elapsed = Inf, transient = FALSE))
    f()
  }
  prediction <- function(result, expected, info){
    testthat::expect_true(is.numeric(result), info = "Return numeric predictions.")
    testthat::expect_equal(length(result), length(expected),
                          info = "Return one prediction per new-data row.")
    testthat::expect_equal(as.numeric(result), as.numeric(expected),
                          tolerance = 1e-8, info = info)
  }
  repeated <- function(){
    list(X = cbind(z = c(0, 1, 0, 2, 1, 2), constant = 0),
         y = c(2, 6, 2, 10, 6, 10))
  }
  two_groups <- function(){
    list(X = cbind(constant = rep(0, 6), z = c(4, 1, 6, 2, 5, 3)),
         y = c(9, 1, 11, 3, 10, 2), fitted = c(10, 2, 10, 2, 10, 2))
  }
  list(bounded = bounded, prediction = prediction,
       repeated = repeated, two_groups = two_groups)
})
