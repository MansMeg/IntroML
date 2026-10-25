local({
  testthat::test_that("always-search follows transitions and counts the current state", {
    # Search alternates high -> low (reward 1) and low -> high (reward -3).
    result <- always_search_policy(.a8_checks$robot(0, 0))
    .a8_checks$policy_result(result, c(500, 500), -1)
    # One high-state action, then 999 low-state actions, all with reward 1.
    result <- always_search_policy(.a8_checks$robot(0, 1))
    .a8_checks$policy_result(result, c(1, 999), 1)
  })
})
