#' The Hitters Dataset
#'
#' @description
#' Major League Baseball Data from the 1986 and 1987 seasons.
#'
#' @details
#' The dataset has been taken from the ISLR R package dataset with
#' the same name. Please refer to the original dataset for details.
#'
#' @source
#' The ISLR R package.
#'
"Hitters"


#' The Binary Dataset
#'
#' @description
#' A hypothetical Admission dataset.
#'
#' @details
#' The dataset is a generated dataset used to fit logistic regression models.
#'
#' @source
#' \url{https://stats.idre.ucla.edu/r/dae/logit-regression/}
#'
"binary"



#' The Prob2 Dataset
#'
#' @description
#' A simulated dataset for ridge regression.
#'
#' @details
#' The package contain a training set with 240 covariates, one dependent variable  and 200 observations.
#' In addition, a separately simulated test set with 50 observations is also included.
#'
#' @source
#' \url{https://stats.idre.ucla.edu/r/dae/logit-regression/}
#'
"prob2_train"

#' @rdname prob2_train
"prob2_test"


#' The Email Dataset
#'
#' @description
#' The data consists of 4601 emails.
#' There are 58 columns in the file.
#' The first 57 columns are predictors, while the last column is a binary
#' response variable with 1 indicating \emph{spam} and 0 \emph{not spam}.
#' The 57 predictors can be divided into three types.
#' Predictors 1-48 are the proportion of certain words.
#' For example, the first column is \code{make}, which shows the proportion of
#' the word ``make'' in the email.
#'
#' Predictors 49-54 are the proportion of characters. For example, the 49th column is
#' \code{semi.colon}, which shows the proportion of the character ``;'' in the email.
#'
#' Predictors 55-57 are concerned with capital letters in the email. The 55th column is
#' \code{average}, which shows the average length of uninterrupted sequences of capital letters. The
#' 56th column is \code{longest}, which shows the length of the longest uninterrupted sequences of capital
#' letters. The 57th column is \code{sum}, which shows the total number of capital letters in the email.
#'
"Email"

