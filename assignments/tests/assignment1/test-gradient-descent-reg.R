local({
  testthat::test_that("ridge descent records the penalized loss after complete epochs", {
    # Identical rows accept any valid shuffling scheme. With 23 observations,
    # batch size 10 must also process a smaller final batch.
    d <- .a1_checks$identical_rows()
    expected_theta <- list(
      `23` = rbind(c(0.015, 0.00375, -0.0075),
                   c(0.0298523485190832, 0.00735058712977080, -0.0147011742595416)),
      `10` = rbind(c(0.0445595813354124, 0.0108068777199600, -0.0216137554399200),
                   c(0.0878353106472172, 0.0203587024066299, -0.0407174048132599))
    )
    expected_loss <- list(
      `23` = c(0.683387035734539, 0.673952475958577),
      `10` = c(0.664826492797077, 0.639144820374011)
    )
    for(b in c(23L, 10L)){
      set.seed(4711)
      result <- gradient_descent_reg(d$y, d$X, batch_size = b,
                                    eta = 0.03, epochs = 2, lambda = 1)
      testthat::expect_true(is.matrix(result))
      testthat::expect_equal(dim(result), c(2L, ncol(d$X) + 2L))
      testthat::expect_identical(colnames(result), c("epoch", "nllr", colnames(d$X)))
      testthat::expect_true(all(is.finite(result)))
      testthat::expect_equal(as.numeric(result[, "epoch"]), c(1, 2))
      for(epoch in 1:2){
        testthat::expect_equal(as.numeric(result[epoch, colnames(d$X)]),
          expected_theta[[as.character(b)]][epoch, ], tolerance = 1e-7,
          info = "Use the mean penalized gradient, leave the intercept unpenalized, and process every batch.")
      }
      testthat::expect_equal(as.numeric(result[, "nllr"]),
        expected_loss[[as.character(b)]], tolerance = 1e-7,
        info = "Record the full-data penalized loss after each complete epoch.")
    }
  })

  testthat::test_that("lambda zero gives the unpenalized full-batch updates", {
    d <- .a1_checks$fixture()
    result <- gradient_descent_reg(d$y, d$X, batch_size = nrow(d$X),
                                  eta = 0.03, epochs = 2, lambda = 0)
    testthat::expect_equal(as.numeric(result[2, colnames(d$X)]),
      c(-0.0116942697913163, -0.0000411342415793750, -0.00202203170755958),
      tolerance = 1e-7)
    testthat::expect_equal(as.numeric(result[, "nllr"]),
      c(0.691968945054989, 0.690808707071561), tolerance = 1e-7)
  })
})
