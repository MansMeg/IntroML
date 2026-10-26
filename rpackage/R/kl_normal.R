#' KL divergence between two univariate normal distributions
#'
#' @param mu Mean of the first distribution, q.
#' @param sigma Positive standard deviation of q, not its variance.
#' @param mu_0 Mean of the reference distribution, p.
#' @param sigma_0 Positive standard deviation of p, not its variance.
#' @return The KL divergence D_KL(q || p), in natural-log units (nats).
#'   Arguments are vectorised: each must have length one or the common length.
#' @details For q = N(mu, sigma^2) and p = N(mu_0, sigma_0^2), the divergence is
#'   \deqn{\log(\sigma_0/\sigma) +
#'   (\sigma^2 + (\mu - \mu_0)^2)/(2\sigma_0^2) - 1/2.}
#'   The divergence is directional; reversing q and p generally changes it.
#' @examples
#' kl_normal(mu = c(0, 2, 0), sigma = c(1, 1, 2), mu_0 = 0, sigma_0 = 1)
#' kl_normal(mu = 1, sigma = 2, mu_0 = -0.5, sigma_0 = 1.5)
#' @export
kl_normal <- function(mu, sigma, mu_0, sigma_0) {
  checkmate::assert_numeric(mu, finite = TRUE, any.missing = FALSE)
  checkmate::assert_numeric(sigma, finite = TRUE, any.missing = FALSE)
  checkmate::assert_numeric(mu_0, finite = TRUE, any.missing = FALSE)
  checkmate::assert_numeric(sigma_0, finite = TRUE, any.missing = FALSE)
  if (any(sigma <= 0) || any(sigma_0 <= 0)) {
    stop("sigma and sigma_0 must be positive standard deviations.")
  }
  sizes <- vapply(list(mu, sigma, mu_0, sigma_0), length, integer(1))
  if (any(!sizes %in% c(1L, max(sizes)))) {
    stop("Arguments must have length one or a common length.")
  }
  log(sigma_0 / sigma) +
    (sigma^2 + (mu - mu_0)^2) / (2 * sigma_0^2) - 0.5
}
