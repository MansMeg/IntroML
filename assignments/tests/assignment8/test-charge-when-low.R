local({
  testthat::test_that("charge-when-low searches when high and recharges when low", {
    # Alternate search (reward 1) and recharge (reward 0).
    result <- charge_when_low_policy(.a8_checks$robot(0, 0))
    .a8_checks$policy_result(result, c(500, 500), 0.5)
    # If search always leaves energy high, never recharge.
    result <- charge_when_low_policy(.a8_checks$robot(1, 0))
    .a8_checks$policy_result(result, c(1000, 0), 1)
  })
})
