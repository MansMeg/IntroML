# Run from the IntroML folder. Keep the smoke test separate from installation.
source("additional_material/r_setup/setup.R")
library(keras3)
library(tensorflow)

x <- matrix(c(0, 0, 1, 1, 0, 1, 0, 1), ncol = 2)
y <- c(0, 1, 1, 2)
model <- keras_model_sequential(input_shape = c(2L)) |>
  layer_dense(units = 1L)
compile(model, optimizer = "sgd", loss = "mse")
history <- fit(model, x, y, epochs = 1L, verbose = 0L)
prediction <- predict(model, x, verbose = 0L)
stopifnot(all(is.finite(unlist(history$metrics))),
          identical(dim(prediction), c(4L, 1L)), all(is.finite(prediction)))
