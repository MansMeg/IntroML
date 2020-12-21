#' Create a MDP based on the Recycling robot example of Sutton and Barto (2017)
#'
#' @param alpha see Sutton and Barto (2017, Example 3.7)
#' @param beta see Sutton and Barto (2017, Example 3.7)
#' @param r_wait see Sutton and Barto (2017, Example 3.7)
#' @param r_search see Sutton and Barto (2017, Example 3.7)
#'
#' @export
recycling_mdp <- function(alpha, beta, r_wait, r_search){
  checkmate::assert_number(alpha, lower = 0, upper = 1)
  checkmate::assert_number(beta, lower = 0, upper = 1)
  checkmate::assert_number(r_wait, upper = r_search)
  checkmate::assert_number(r_search, lower = r_wait)

  data.frame(s = c("high", "high", "low", "low", "high", "high", "low", "low", "low", "low"),
             s_next = c("high", "low", "high", "low", "high", "low", "high", "low", "high", "low"),
             a = c("search", "search", "search", "search", "wait", "wait", "wait", "wait", "recharge", "recharge"),
             p_s_next = c(alpha, 1-alpha, 1-beta, beta, 1, 0, 0, 1, 1, 0),
             r_s_a_s_next = c(r_search, r_search, -3, r_search, r_wait, r_wait, r_wait, r_wait, 0, 0))
}
