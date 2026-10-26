# Small fixtures, kept independent of the student's implementations.
.a6_checks <- list(
  X = matrix(c(0, 0, 2, 4, 8, 6, 10, 10, 12, 8), ncol = 2, byrow = TRUE),
  C = c(1L, 1L, 2L, 2L, 2L),
  means = matrix(c(1, 2, 10, 8), ncol = 2, byrow = TRUE),
  mixture = matrix(c(-2, -1, 0, 3, 4), ncol = 1),
  theta = list(mu_1 = -1, mu_2 = 3, sigma_1 = 1.5, sigma_2 = 2, pi = .4),
  parameter_names = c("mu_1", "mu_2", "sigma_1", "sigma_2", "pi")
)
