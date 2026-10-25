# Assignment 7: convolutional VAE (VG) with keras3 and TensorFlow.
# Complete the course R setup and its training check before running this file:
# https://github.com/MansMeg/IntroML/tree/master/additional_material/r_setup
library(tensorflow)
library(keras3)

img_rows <- 28L
img_cols <- 28L
img_chns <- 1L
original_dim <- img_rows * img_cols
original_img_size <- c(img_rows, img_cols, img_chns)
filters <- 50L
num_conv <- 3L
latent_dim <- 2L
intermediate_dim <- 100L
batch_size <- 100L
epochs <- 5L
set_random_seed(4711)

# Encoder: four convolutional layers, each with 50 filters.
x <- layer_input(shape = original_img_size, name = "image")
conv_1 <- layer_conv_2d(x, filters = filters, kernel_size = c(2L, 2L),
                        strides = c(1L, 1L), padding = "same", activation = "relu")
conv_2 <- layer_conv_2d(conv_1, filters = filters, kernel_size = c(2L, 2L),
                        strides = c(2L, 2L), padding = "same", activation = "relu")
conv_3 <- layer_conv_2d(conv_2, filters = filters, kernel_size = c(num_conv, num_conv),
                        padding = "same", activation = "relu")
conv_4 <- layer_conv_2d(conv_3, filters = filters, kernel_size = c(num_conv, num_conv),
                        padding = "same", activation = "relu")
hidden <- layer_dense(layer_flatten(conv_4), units = intermediate_dim,
                       activation = "relu")
z_mean <- layer_dense(hidden, units = latent_dim, name = "z_mean")
z_log_var <- layer_dense(hidden, units = latent_dim, name = "z_log_var")

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

# Share every decoder layer between the VAE and the generator.
decoder_shape <- c(14L, 14L, filters)
decoder_hidden <- layer_dense(units = intermediate_dim, activation = "relu")
decoder_upsample <- layer_dense(units = prod(decoder_shape), activation = "relu")
decoder_reshape <- layer_reshape(target_shape = decoder_shape)
decoder_deconv_1 <- layer_conv_2d_transpose(
  filters = filters, kernel_size = c(num_conv, num_conv),
  padding = "same", activation = "relu")
decoder_deconv_2 <- layer_conv_2d_transpose(
  filters = filters, kernel_size = c(num_conv, num_conv),
  padding = "same", activation = "relu")
decoder_deconv_3 <- layer_conv_2d_transpose(
  filters = filters, kernel_size = c(3L, 3L), strides = c(2L, 2L),
  padding = "valid", activation = "relu")
decoder_output <- layer_conv_2d(
  filters = img_chns, kernel_size = c(2L, 2L), padding = "valid",
  activation = "sigmoid")
decode <- function(z) {
  z |> decoder_hidden() |> decoder_upsample() |> decoder_reshape() |>
    decoder_deconv_1() |> decoder_deconv_2() |> decoder_deconv_3() |>
    decoder_output()
}
vae <- keras_model(x, decode(z), name = "conv_vae")
encoder <- keras_model(x, z_mean, name = "conv_encoder")
decoder_input <- layer_input(shape = c(latent_dim))
generator <- keras_model(decoder_input, decode(decoder_input), name = "conv_decoder")

# Flatten each image separately: sum pixel losses, retaining the batch dimension.
recon_loss <- function(x, x_decoded) {
  x <- op_reshape(x, c(-1L, original_dim))
  x_decoded <- op_reshape(x_decoded, c(-1L, original_dim))
  original_dim * loss_binary_crossentropy(x, x_decoded)
}
compile(vae, optimizer = optimizer_rmsprop(learning_rate = 0.0001), loss = recon_loss)
summary(vae)

mnist <- dataset_mnist()
y_train <- mnist$train$y
y_test <- mnist$test$y
x_train <- array_reshape(mnist$train$x / 255, c(length(y_train), original_img_size))
x_test <- array_reshape(mnist$test$x / 255, c(length(y_test), original_img_size))

history <- fit(vae, x_train, x_train, shuffle = TRUE, epochs = epochs,
               batch_size = batch_size,
               validation_data = list(x_test, x_test), verbose = 2L)

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
    canvas[image_rows, image_cols] <- generated[idx, , , 1]
  }
}
plot(as.raster(canvas))
