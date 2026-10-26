local({
  testthat::test_that("multi-head attention concatenates heads before the projection", {
    f <- .a5_checks$transformer
    result <- multi_head_self_attention(f$embeddings[1:3, , drop = FALSE],
                                        f$Wq, f$Wk, f$Wv, f$W0)
    testthat::expect_equal(dim(result), c(3L, 3L))
    expected <- matrix(c(-.014189613, -.0040299008, -.006756286,
                         -.009963516, -.0010724342, -.001996524,
                         -.006394562, -.0006626115, -.002219108),
                       nrow = 3, byrow = TRUE)
    testthat::expect_equal(as.numeric(result), as.numeric(expected), tolerance = 1e-6)
    all_tokens <- multi_head_self_attention(f$embeddings, f$Wq, f$Wk, f$Wv, f$W0)
    testthat::expect_equal(dim(all_tokens), c(nrow(f$embeddings), 3L))
    testthat::expect_true(all(is.finite(all_tokens)))
    # Zeroing the final projection must zero the output of every head.
    zero <- multi_head_self_attention(f$embeddings, f$Wq, f$Wk, f$Wv, 0 * f$W0)
    testthat::expect_equal(as.numeric(zero), rep(0, length(zero)))
  })
})
