#' The root mean squared error between y and x
#'
#' @param y a vector
#' @param x a vector
#'
#' @description
#' The function computes the root mean squared error between \code{y} and \code{x}.
#'
#' @export
rmse <- function(x, y){
  checkmate::assert_numeric(x, any.missing = FALSE)
  checkmate::assert_numeric(y, any.missing = FALSE, len = length(x))
  sqrt(mean((x-y)^2))
}
