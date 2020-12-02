#' Extract parameters from a LDA_Gibbs topic model
#'
#' @param x a \code{LDA_Gibbs} topic model
#'
#' @description
#' The functions extracts the \code{phi} and \code{theta} parameters from
#' a \code{LDA_Gibbs} topic model.
#'
#' In addition, the functions can also be used to extract the log likelihood values
#' per kept iteration.
#'
#' @export
extract_phi <- function(x){
  checkmate::assert_class(x, "LDA_Gibbs")
  phi <- exp(x@beta)
  colnames(phi) <- x@terms
  phi
}

#' @rdname extract_phi
#' @export
extract_theta <- function(x){
  checkmate::assert_class(x, "LDA_Gibbs")
  theta <- x@gamma
  rownames(theta) <- x@documents
  theta
}

#' @rdname extract_phi
#' @export
extract_log_liks <- function(x){
  checkmate::assert_class(x, "LDA_Gibbs")
  x@logLiks
}
