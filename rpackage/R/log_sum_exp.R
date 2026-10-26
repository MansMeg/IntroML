#' Add two numbers represented on the log scale
#'
#' @param a,b Numeric vectors of log values. They must have equal lengths,
#'   or one must have length one. Infinite values are allowed.
#' @return A numeric vector containing `log(exp(a) + exp(b))`, computed
#'   elementwise without exponentiating large log values directly.
#' @details Subtracting the larger log value before exponentiation avoids
#'   overflow and reduces underflow. Two negative infinities return negative
#'   infinity; either positive infinity gives positive infinity.
#' @examples
#' log_sum_exp(log(2), log(3))
#' log_sum_exp(1000, 1000)
#' log_sum_exp(c(-Inf, 0), -Inf)
#' @export
log_sum_exp <- function(a, b) {
  checkmate::assert_numeric(a, any.missing = FALSE)
  checkmate::assert_numeric(b, any.missing = FALSE)
  if (length(a) != length(b) && length(a) != 1L && length(b) != 1L) {
    stop("Use equal-length vectors or one scalar.")
  }
  m <- pmax(a, b)
  value <- m + log(exp(a - m) + exp(b - m))
  ifelse(is.infinite(m), m, value)
}
