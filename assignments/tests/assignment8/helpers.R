# Fixed-reward fixtures, without a reference implementation of any algorithm.
.a8_checks <- local({
  probe <- function(reward) {
    log <- new.env(parent = emptyenv())
    log$actions <- integer()
    log$times <- integer()
    log$rewards <- numeric()
    bandit <- function(a, t) {
      value <- reward(a, t)
      log$actions <- c(log$actions, a)
      log$times <- c(log$times, t)
      log$rewards <- c(log$rewards, value)
      value
    }
    list(bandit = bandit, log = log)
  }
  bandit_result <- function(result, fixture, estimate = "Qt") {
    testthat::expect_type(result, "list")
    testthat::expect_equal(as.numeric(fixture$log$times), 1:1000,
      info = "Request one reward per step using bandit(a, t = i).")
    testthat::expect_equal(length(result$Rt), 1000L)
    testthat::expect_equal(as.numeric(result$Rt), fixture$log$rewards,
      info = "Rt must contain the rewards actually returned by the bandit.")
    testthat::expect_equal(as.numeric(result$Nt),
      as.numeric(tabulate(fixture$log$actions, nbins = 5L)),
      info = "Count each chosen action once, including its first selection.")
    testthat::expect_equal(as.numeric(result$R_bar), mean(fixture$log$rewards),
      info = "R_bar is the mean of all 1000 rewards.")
    testthat::expect_equal(length(result[[estimate]]), 5L)
    testthat::expect_true(all(is.finite(result[[estimate]])))
  }
  greedy_fixture <- function() {
    list(Q1 = c(10, 4, -10, -20, -30),
      probe = probe(function(a, t) if (a == 1L) 0 else if (t %% 2L == 0L) 2 else 4),
      actions = c(1L, rep(2L, 999L)),
      Qt = c(0, (500 * 2 + 499 * 4) / 999, -10, -20, -30))
  }
  robot <- function(p_high, p_low) {
    # A standalone transition table, so these tests do not need uuml or a network.
    data.frame(
      s = c("high", "high", "low", "low", "high", "high", "low", "low", "low", "low"),
      s_next = rep(c("high", "low"), 5),
      a = c(rep("search", 4), rep("wait", 4), rep("recharge", 2)),
      p_s_next = c(p_high, 1 - p_high, 1 - p_low, p_low, 1, 0, 0, 1, 1, 0),
      r_s_a_s_next = c(1, 1, -3, 1, 0.1, 0.1, 0.1, 0.1, 0, 0),
      stringsAsFactors = FALSE
    )
  }
  policy_result <- function(result, counts, reward) {
    testthat::expect_type(result, "list")
    testthat::expect_setequal(names(result$Nt), c("high", "low"))
    testthat::expect_equal(as.numeric(result$Nt[c("high", "low")]), counts,
      info = "Start in high and count the state BEFORE each of the 1000 actions.")
    testthat::expect_equal(as.numeric(result$R_bar), reward,
      info = "Average the rewards from the selected action and resulting transition.")
  }
  list(probe = probe, bandit_result = bandit_result,
       greedy_fixture = greedy_fixture, robot = robot, policy_result = policy_result)
})
