# A non-symmetric kernel distinguishes CNN cross-correlation from flipping.
.a4_checks <- list(
  X = matrix(1:20, nrow = 4, byrow = TRUE),
  K = matrix(c(1, 2, 0, -1), nrow = 2, byrow = TRUE),
  response = matrix(c(-2, 0, 2, 4, 8, 10, 12, 14, 18, 20, 22, 24),
                    nrow = 3, byrow = TRUE)
)
