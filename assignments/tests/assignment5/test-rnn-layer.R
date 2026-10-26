local({
  testthat::test_that("rnn_layer carries hidden states forward and returns token rows", {
    f <- .a5_checks$rnn
    result <- rnn_layer(f$embeddings[1:3, , drop = FALSE],
                        f$W, f$V, f$U, f$b, f$c)
    testthat::expect_type(result, "list")
    testthat::expect_equal(dim(result$ht), c(3L, 4L))
    testthat::expect_equal(dim(result$yhat), c(3L, 3L))
    expected_h <- matrix(c(.52405551, -.97882227, -.5656013, .9031762,
      -.05951368, .03988226, .8241800, -.6562744,
      -.08984008, .92822217, -.1563247, -.6657626), nrow = 3, byrow = TRUE)
    expected_y <- matrix(c(.3063613, .2930885, .4005502,
      .2838013, .3490452, .3671536,
      .2878002, .3666877, .3455121), nrow = 3, byrow = TRUE)
    testthat::expect_equal(as.numeric(result$ht), as.numeric(expected_h), tolerance = 1e-6)
    testthat::expect_equal(as.numeric(result$yhat), as.numeric(expected_y), tolerance = 1e-6)
    one <- rnn_layer(f$embeddings[1, , drop = FALSE], f$W, f$V, f$U, f$b, f$c)
    testthat::expect_equal(dim(one$ht), c(1L, 4L))
    testthat::expect_equal(as.numeric(one$ht), expected_h[1, ], tolerance = 1e-6)
  })
})
