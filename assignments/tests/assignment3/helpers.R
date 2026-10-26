# Small numerical fixtures, not a reference implementation.
.a3_checks <- list(
  X = matrix(c(-1, 2, 0, 0, 2, -1), ncol = 2, byrow = TRUE),
  W = matrix(c(1, -1, 2, .5), ncol = 2, byrow = TRUE),
  c = matrix(rep(c(.5, -.25), 3), ncol = 2, byrow = TRUE),
  w = matrix(c(2, -3), ncol = 1), b = .75
)
