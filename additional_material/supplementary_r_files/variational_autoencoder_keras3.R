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

# Expose both encoder parameter heads for the loss-inspection exercise.
encoder_parameters <- keras_model(x, list(z_mean, z_log_var),
                                   name = "dense_encoder_parameters")

# Evaluate both terms with supplied noise so before/after results are comparable.
# This is a diagnostic only: it does not update weights or train another model.
vae_loss_components <- function(images, epsilon, encoder_parameters, generator) {
  parameters <- predict(encoder_parameters, images, verbose = 0L)
  mu <- parameters[[1]]
  log_var <- parameters[[2]]
  z <- mu + exp(0.5 * log_var) * epsilon
  reconstructed <- predict(generator, z, verbose = 0L)
  reconstruction <- ncol(images) * loss_binary_crossentropy(
    op_array(images, dtype = "float32"),
    op_array(reconstructed, dtype = "float32")
  )
  reconstruction <- mean(as.array(reconstruction))
  kl <- mean(-0.5 * rowSums(1 + log_var - mu^2 - exp(log_var)))
  c(reconstruction = reconstruction, kl = kl, total = reconstruction + kl)
}

# Inspect gradients with respect to the encoder outputs, not its shared weights.
# This diagnostic never updates weights. Disconnected gradients are shown as 0.
vae_gradient_components <- function(images, epsilon, encoder_parameters, generator,
                                    sample_latent = TRUE) {
  pixel_count <- ncol(images)
  images <- op_array(images, dtype = "float32")
  epsilon <- op_array(epsilon, dtype = "float32")
  parameters <- encoder_parameters(images, training = FALSE)
  z_mean <- parameters[[1]]
  z_log_var <- parameters[[2]]
  with(tf$GradientTape(persistent = TRUE) %as% tape, {
    tape$watch(list(z_mean, z_log_var))
    z <- if (sample_latent) {
      z_mean + op_exp(0.5 * z_log_var) * epsilon
    } else {
      z_mean
    }
    reconstructed <- generator(z, training = FALSE)
    reconstruction <- op_mean(pixel_count * loss_binary_crossentropy(images, reconstructed))
    kl <- op_mean(-0.5 * op_sum(
      1 + z_log_var - op_square(z_mean) - op_exp(z_log_var), axis = -1L))
    total <- reconstruction + kl
  })
  losses <- list(reconstruction = reconstruction, kl = kl, total = total)
  gradients <- lapply(losses, function(loss) tape$gradient(loss,
    list(z_mean, z_log_var)))
  gradient_norm <- function(g) {
    if (is.null(g)) return(0)
    sqrt(sum(as.array(g)^2))
  }
  data.frame(
    mode = if (sample_latent) "sampled" else "mean_only",
    loss = names(losses),
    grad_mu = vapply(gradients, function(g) gradient_norm(g[[1]]), numeric(1)),
    grad_log_var = vapply(gradients, function(g) gradient_norm(g[[2]]), numeric(1)),
    row.names = NULL
  )
}

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

# Save one fixed batch and one fixed draw of noise before the existing fit().
fixed_batch <- x_train[1:100, , drop = FALSE]
fixed_noise <- matrix(rnorm(nrow(fixed_batch) * latent_dim), ncol = latent_dim)
# Compare gradient paths before training, using the same weights and noise.
gradient_table_before <- rbind(
  vae_gradient_components(fixed_batch, fixed_noise, encoder_parameters, generator,
                           sample_latent = TRUE),
  vae_gradient_components(fixed_batch, fixed_noise, encoder_parameters, generator,
                           sample_latent = FALSE)
)
print(gradient_table_before)

loss_before <- vae_loss_components(fixed_batch, fixed_noise,
                                   encoder_parameters, generator)

history <- fit(vae, x_train, x_train, shuffle = TRUE, epochs = epochs,
               batch_size = batch_size,
               validation_data = list(x_test, x_test), verbose = 2L)

# Reuse the same images and noise after training; do not run fit() again.
loss_after <- vae_loss_components(fixed_batch, fixed_noise,
                                  encoder_parameters, generator)
loss_table <- rbind(before = loss_before, after = loss_after)
print(loss_table)

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
