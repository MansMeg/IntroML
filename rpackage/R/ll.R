#' The log-likelihood for logistic regression
#'
#' @param y a vector of binary variables
#' @param X a design matrix with the same length as y
#' @param theta a vector of parameter values
#'
#' @description
#' The function computes the log likelihood for logistic regression given a
#' set of parameter values \code{theta}.
#'
#' @export
ll <- function(y, X, theta){
  checkmate::assert_integerish(y, lower = 0, upper = 1, any.missing = FALSE)
  checkmate::assert_matrix(X, mode = "numeric", nrows = length(y))
  checkmate::assert_vector(theta, len = ncol(X))
  Xtheta <- as.matrix(X %*% theta)
  ll_i <- y * Xtheta - log(1 + exp(Xtheta))
  sum(ll_i)
}
