local({
  testthat::test_that("Adam uses bias-corrected moments for every mini-batch update", {
    d <- .a1_checks$identical_rows()
    # Identical rows accept every shuffling scheme. The 23-row fixture also
    # checks a smaller final batch, and the second epoch checks moment carry-over.
    expected <- list(
      `23` = c(0.0599765540043, 0.0599765503819, -0.0599765527968),
      `10` = c(0.1793125441468, 0.1793125330239, -0.1793125404392),
      `1` = c(1.1378665505110, 1.1378664608160, -1.1378665206127)
    )
    for(b in c(23L, 10L, 1L)){
      set.seed(4711)
      result <- adam(d$y, d$X, sample_size = b, eta = 0.03,
                     beta1 = 0.9, beta2 = 0.999, epochs = 2)
      .a1_checks$history(result, d, 2)
      testthat::expect_equal(as.numeric(result[2, colnames(d$X)]), expected[[as.character(b)]],
                            tolerance = 1e-6,
                            info = "Advance the bias-correction step for EACH batch; retain moments across epochs.")
    }
  })

  testthat::test_that("Adam respects beta values and stores a reproducible full-data mean-loss history", {
    d <- .a1_checks$fixture()
    set.seed(4711)
    first <- adam(d$y, d$X, sample_size = 10, eta = 0.01,
                  beta1 = 0.8, beta2 = 0.95, epochs = 3)
    set.seed(4711)
    second <- adam(d$y, d$X, sample_size = 10, eta = 0.01,
                   beta1 = 0.8, beta2 = 0.95, epochs = 3)
    .a1_checks$history(first, d, 3)
    testthat::expect_equal(first, second)
    # With beta1 = beta2 = 0 and a full batch, the first step is a
    # coordinate-wise normalized gradient, independently of any permutation.
    result <- adam(d$y, d$X, sample_size = nrow(d$X), eta = 0.01,
                   beta1 = 0, beta2 = 0, epochs = 1)
    g <- .a1_checks$derivative(function(t) .a1_checks$loss(d$y, d$X, t), c(0, 0, 0))
    testthat::expect_equal(as.numeric(result[1, colnames(d$X)]),
                          -0.01 * g / (abs(g) + 1e-8), tolerance = 1e-6)
    # Two full-batch steps distinguish each beta parameter from a hard-coded
    # default. References were calculated independently on identical rows.
    d <- .a1_checks$identical_rows()
    settings <- list(
      list(beta1 = 0.8, beta2 = 0.999,
           theta = c(0.0599532287856, 0.0599532251647, -0.0599532275786)),
      list(beta1 = 0.9, beta2 = 0.95,
           theta = c(0.0599865780552, 0.0599865744316, -0.0599865768473))
    )
    for(setting in settings){
      result <- adam(d$y, d$X, sample_size = nrow(d$X), eta = 0.03,
                     beta1 = setting$beta1, beta2 = setting$beta2, epochs = 2)
      testthat::expect_equal(as.numeric(result[2, colnames(d$X)]), setting$theta,
                            tolerance = 1e-7,
                            info = "Use the supplied beta1 and beta2 rather than hard-coded defaults.")
    }
  })
})
