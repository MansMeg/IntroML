local({
  testthat::test_that("glmnet_cv uses the supplied ten folds and averages validation RMSE", {
    testthat::expect_true(is.function(glmnet_cv))
    testthat::expect_true(requireNamespace("glmnet", quietly = TRUE),
                          info = "Install glmnet before checking the regression task.")
    i <- seq_len(31)
    X <- cbind(x1 = sin(i / 3), x2 = cos(i / 5))
    y <- 2 + 1.3 * X[, 1] - 0.8 * X[, 2] + sin(i) / 5
    fold <- rep(1:10, length.out = length(i))
    # Unequal fold sizes distinguish the mean fold RMSE from pooled RMSE.
    # The large penalty leaves intercept-only fits, giving a simple check.
    expected <- mean(vapply(1:10, function(k){
      sqrt(mean((y[fold == k] - mean(y[fold != k]))^2))
    }, numeric(1)))
    result <- glmnet_cv(fold = fold, X = X, y = y, lambda = 1e6)
    testthat::expect_length(result, 1L)
    testthat::expect_equal(as.numeric(result), expected, tolerance = 1e-7,
                          info = "Fit only on the other nine folds; average the ten held-out RMSEs.")
    # A nonzero-slope fixture also checks lambda and the lasso fit.
    result <- glmnet_cv(fold = fold, X = X, y = matrix(y, ncol = 1), lambda = 0.03)
    testthat::expect_equal(as.numeric(result), 0.1686038862721, tolerance = 1e-5)
    order <- rev(seq_along(y))
    reordered <- glmnet_cv(fold = fold[order], X = X[order, ],
                           y = y[order], lambda = 0.03)
    testthat::expect_equal(as.numeric(reordered), as.numeric(result), tolerance = 1e-7,
                          info = "Use the supplied folds rather than drawing new ones inside the function.")
  })
})
