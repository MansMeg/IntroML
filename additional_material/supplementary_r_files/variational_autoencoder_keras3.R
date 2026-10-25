# Assignment 7: feed-forward VAE with keras3 and the TensorFlow backend.
# Complete the course R setup and its training check before running this file:
# https://github.com/MansMeg/IntroML/tree/master/additional_material/r_setup
library(tensorflow)
library(keras3)

batch_size <- 100L
original_dim <- 784L
latent_dim <- 2L
intermediate_dim <- 200L
epochs <- 50L
set_random_seed(4711)

# Encoder: one hidden layer, followed by the two latent-distribution parameters.
x <- layer_input(shape = c(original_dim), name = "image")
h <- layer_dense(x, units = intermediate_dim, activation = "relu")
z_mean <- layer_dense(h, units = latent_dim, name = "z_mean")
z_log_var <- layer_dense(h, units = latent_dim, name = "z_log_var")

# Sampling and KL loss stay inside a Keras layer, so they are part of the graph.
Sampling <- new_layer_class(
  classname = "Sampling",
  call = function(inputs) {
    z_mean <- inputs[[1]]
    z_log_var <- inputs[[2]]
    epsilon <- tf$random$normal(shape = tf$shape(z_mean))
    z <- z_mean + op_exp(0.5 * z_log_var) * epsilon
    # Sum over latent dimensions; average over observations in the batch.
    kl_loss <- -0.5 * op_sum(
      1 + z_log_var - op_square(z_mean) - op_exp(z_log_var), axis = -1L
    )
    self$add_loss(op_mean(kl_loss))
    z
  }
)
z <- Sampling(list(z_mean, z_log_var), name = "sampling")

# Reuse the decoder layers to obtain a generator with the same trained weights.
decoder_h <- layer_dense(units = intermediate_dim, activation = "relu")
decoder_mean <- layer_dense(units = original_dim, activation = "sigmoid")
x_decoded <- decoder_mean(decoder_h(z))
vae <- keras_model(x, x_decoded, name = "dense_vae")
encoder <- keras_model(x, z_mean, name = "dense_encoder")
decoder_input <- layer_input(shape = c(latent_dim))
generator <- keras_model(decoder_input,
                         decoder_mean(decoder_h(decoder_input)),
                         name = "dense_decoder")

# Binary cross-entropy is averaged over pixels; multiplying sums over the image.
recon_loss <- function(x, x_decoded) {
  original_dim * loss_binary_crossentropy(x, x_decoded)
}
compile(vae, optimizer = optimizer_rmsprop(learning_rate = 0.0001), loss = recon_loss)
summary(vae)

mnist <- dataset_mnist()
y_train <- mnist$train$y
y_test <- mnist$test$y
x_train <- array_reshape(mnist$train$x / 255,
                          c(length(y_train), original_dim), order = "F")
x_test <- array_reshape(mnist$test$x / 255,
                         c(length(y_test), original_dim), order = "F")

history <- fit(vae, x_train, x_train, shuffle = TRUE, epochs = epochs,
               batch_size = batch_size,
               validation_data = list(x_test, x_test), verbose = 2L)

# The encoder returns the mean of each image's latent distribution.
x_test_encoded <- predict(encoder, x_test, batch_size = batch_size, verbose = 0L)
library(ggplot2)
latent_plot <- data.frame(z1 = x_test_encoded[, 1],
                          z2 = x_test_encoded[, 2], digit = factor(y_test))
print(ggplot(latent_plot, aes(z1, z2, colour = digit)) +
        geom_point(alpha = 0.5) + theme_bw())

# Decode a grid of latent coordinates in one batch.
n <- 15L
digit_size <- 28L
grid_x <- seq(-4, 4, length.out = n)
grid_y <- seq(-4, 4, length.out = n)
latent_grid <- as.matrix(expand.grid(z1 = grid_x, z2 = grid_y))
generated <- predict(generator, latent_grid, verbose = 0L)
canvas <- matrix(0, n * digit_size, n * digit_size)
for (i in seq_len(n)) {
  for (j in seq_len(n)) {
    idx <- (i - 1L) * n + j
    image_rows <- ((n - i) * digit_size + 1L):((n - i + 1L) * digit_size)
    image_cols <- ((j - 1L) * digit_size + 1L):(j * digit_size)
    canvas[image_rows, image_cols] <- matrix(generated[idx, ], nrow = digit_size)
  }
}
plot(as.raster(canvas))
