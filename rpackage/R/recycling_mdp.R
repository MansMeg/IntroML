#' Create a MDP based on the Recycling robot example of Sutton and Barto (2017)
#'
#' @param p_high Probability of remaining at high energy after searching from
#'   high energy, between 0 and 1.
#' @param p_low Probability of remaining at low energy after searching from
#'   low energy, between 0 and 1.
#' @param r_wait Expected reward for waiting, no greater than `r_search`.
#' @param r_search Expected reward for searching without requiring rescue,
#'   no less than `r_wait`.
#'
#' @details `p_high` and `p_low` correspond to the transition probabilities
#'   \eqn{\alpha} and \eqn{\beta} in Sutton and Barto (2017, Example 3.7).
#' @return A data frame with current state `s`, next state `s_next`, action `a`,
#'   transition probability `p_s_next`, and reward `r_s_a_s_next`.
#' @examples
#' recycling_mdp(p_high = 0.5, p_low = 0.8, r_wait = 0.1, r_search = 1)
#'
#' @export
recycling_mdp <- function(p_high, p_low, r_wait, r_search){
  checkmate::assert_number(p_high, lower = 0, upper = 1)
  checkmate::assert_number(p_low, lower = 0, upper = 1)
  checkmate::assert_number(r_wait, upper = r_search)
  checkmate::assert_number(r_search, lower = r_wait)

  data.frame(s = c("high", "high", "low", "low", "high", "high", "low", "low", "low", "low"),
             s_next = c("high", "low", "high", "low", "high", "low", "high", "low", "high", "low"),
             a = c("search", "search", "search", "search", "wait", "wait", "wait", "wait", "recharge", "recharge"),
             p_s_next = c(p_high, 1-p_high, 1-p_low, p_low, 1, 0, 0, 1, 1, 0),
             r_s_a_s_next = c(r_search, r_search, -3, r_search, r_wait, r_wait, r_wait, r_wait, 0, 0))
}
