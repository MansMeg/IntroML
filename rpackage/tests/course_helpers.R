library(uuml)

expect_error <- function(expression) {
  stopifnot(inherits(tryCatch(force(expression), error = identity), "error"))
}

# Check finite arithmetic, numerical extremes, and the infinity conventions.
stopifnot(isTRUE(all.equal(log_sum_exp(log(2), log(3)), log(5))),
          isTRUE(all.equal(log_sum_exp(1000, 1000), 1000 + log(2))),
          isTRUE(all.equal(log_sum_exp(-1000, -1000), -1000 + log(2))),
          identical(log_sum_exp(-Inf, -Inf), -Inf),
          identical(log_sum_exp(Inf, -Inf), Inf),
          identical(log_sum_exp(Inf, Inf), Inf),
          isTRUE(all.equal(log_sum_exp(log(c(1, 2, 3)), 0), log(c(2, 3, 4)))))
expect_error(log_sum_exp(1:2, 1:3))
expect_error(log_sum_exp(NA_real_, 0))

# Known Gaussian KL values and an independent density-integral calculation.
stopifnot(isTRUE(all.equal(
  kl_normal(c(0, 2, 0), c(1, 1, 2), 0, 1), c(0, 2, (3 - log(4)) / 2))),
  identical(kl_normal(2, 3, 2, 3), 0))
integrated_kl <- integrate(function(x) {
  dnorm(x, 1, 2) * (dnorm(x, 1, 2, log = TRUE) -
                     dnorm(x, -0.5, 1.5, log = TRUE))
}, lower = -15, upper = 17)$value
stopifnot(abs(kl_normal(1, 2, -0.5, 1.5) - integrated_kl) < 1e-8)
expect_error(kl_normal(0, 0, 0, 1))
expect_error(kl_normal(0, 1, 0, -1))
expect_error(kl_normal(NA_real_, 1, 0, 1))
expect_error(kl_normal(1:2, 1:3, 0, 1))

# Constant tiles make latent-coordinate placement independently visible.
decoder <- function(z) matrix(rep(z[, 1] + z[, 2], 4), ncol = 4)
canvas <- plot_vae_grid(decoder, c(0, 0.1), c(0, 0.2), c(2, 2), plot = FALSE)
expected <- rbind(c(0.2, 0.2, 0.3, 0.3), c(0.2, 0.2, 0.3, 0.3),
                  c(0, 0, 0.1, 0.1), c(0, 0, 0.1, 0.1))
stopifnot(isTRUE(all.equal(canvas, expected)))

# Non-square images check the flattened-image convention and both array forms.
flat_decoder <- function(z) {
  matrix(rep(seq(0.1, 0.6, by = 0.1), nrow(z)), nrow = nrow(z), byrow = TRUE)
}
tile <- rbind(c(0.1, 0.3, 0.5), c(0.2, 0.4, 0.6))
array_decoder <- function(z) {
  images <- array(0, c(nrow(z), 2, 3))
  for (i in seq_len(nrow(z))) images[i, , ] <- tile
  images
}
channel_decoder <- function(z) array(array_decoder(z), c(nrow(z), 2, 3, 1))
for (generator in list(flat_decoder, array_decoder, channel_decoder)) {
  result <- plot_vae_grid(generator, 0, 0, c(2, 3), plot = FALSE)
  stopifnot(isTRUE(all.equal(result, tile)))
}
expect_error(plot_vae_grid(decoder, numeric(), 0, c(2, 2), plot = FALSE))
expect_error(plot_vae_grid(decoder, 0, 0, c(2, 3), plot = FALSE))
expect_error(plot_vae_grid(function(z) matrix(2, nrow(z), 4),
                           0, 0, c(2, 2), plot = FALSE))
expect_error(plot_vae_grid(function(z) matrix(NA_real_, nrow(z), 4),
                           0, 0, c(2, 2), plot = FALSE))
grDevices::pdf(NULL)
visible <- withVisible(plot_vae_grid(decoder, 0, 0, c(2, 2)))
grDevices::dev.off()
stopifnot(!visible$visible, identical(dim(visible$value), c(2L, 2L)))
