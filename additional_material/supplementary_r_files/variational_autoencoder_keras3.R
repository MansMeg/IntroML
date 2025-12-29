# Guide for VAE in R with tensorflow and keras3 (note, migth not work for "keras")

# libraries
library(tensorflow)
library(keras3)

#### Parameters ####
batch_size <- 100L
original_dim <- 784L
latent_dim <- 2L
intermediate_dim <- 256L
epochs <- 50L
epsilon_std <- 1.0

#### Model Construction ####
x <- layer_input(shape = c(original_dim))

# Encoder
h <- layer_dense(x, units = intermediate_dim, activation = "relu")
z_mean <- layer_dense(h, units = latent_dim)
z_log_var <- layer_dense(h, units = latent_dim)

# Sampling layer with KL loss inside
Sampling <- new_layer_class(
  classname = "Sampling",
  
  call = function(inputs) {
    z_mean <- inputs[[1]]
    z_log_var <- inputs[[2]]
    
    epsilon <- tf$random$normal(shape = tf$shape(z_mean))
    z <- z_mean + tf$exp(0.5 * z_log_var) * epsilon
    
    kl_loss <- -0.5 * op_mean(
      1 + z_log_var - op_square(z_mean) - op_exp(z_log_var),
      axis = -1L
    )
    
    self$add_loss(op_mean(kl_loss))
    z
  }
)

z <- Sampling()(list(z_mean, z_log_var))

# Decoder
decoder_h <- layer_dense(units = intermediate_dim, activation = "relu")
decoder_mean <- layer_dense(units = original_dim, activation = "sigmoid")

h_decoded <- decoder_h(z)
x_decoded_mean <- decoder_mean(h_decoded)

# VAE model
vae <- keras_model(x, x_decoded_mean)

# Encoder model
encoder <- keras_model(x, z_mean)

# Generator model
decoder_input <- layer_input(shape = latent_dim)
h_decoded_2 <- decoder_h(decoder_input)
x_decoded_mean_2 <- decoder_mean(h_decoded_2)
generator <- keras_model(decoder_input, x_decoded_mean_2)

# Reconstruction loss
recon_loss <- function(x, x_decoded) {
  original_dim * loss_binary_crossentropy(x, x_decoded)
}

# compile the model
vae %>% compile(
  optimizer = "rmsprop",
  loss = recon_loss
)

summary(vae)


#### Data Preparation ####
mnist <- dataset_mnist()
x_train <- mnist$train$x / 255
x_test  <- mnist$test$x / 255

x_train <- array_reshape(x_train, c(nrow(x_train), original_dim), order = "F")
x_test  <- array_reshape(x_test,  c(nrow(x_test), original_dim), order = "F")

#### Model Fitting ####
vae %>% fit(
  x_train, x_train,
  shuffle = TRUE,
  epochs = epochs,
  batch_size = batch_size,
  validation_data = list(x_test, x_test)
)


#### Visualization ###
library(ggplot2)
library(dplyr)

## display a 2D plot of the digit classes in the latent space
x_test_encoded <- predict(encoder, x_test, batch_size = batch_size)
x_test_encoded %>%
  as.data.frame() %>%
  mutate(class = as.factor(mnist$test$y)) %>%
  ggplot(aes(x = V1, y = V2, colour = class)) + geom_point()

## display a 2D manifold of the digits
n <- 15  # figure with 15x15 digits
digit_size <- 28

# we will sample n points within [-4, 4] standard deviations
grid_x <- seq(-4, 4, length.out = n)
grid_y <- seq(-4, 4, length.out = n)

rows <- NULL
for(i in 1:length(grid_x)){
  column <- NULL
  for(j in 1:length(grid_y)){
    z_sample <- matrix(c(grid_x[i], grid_y[j]), ncol = 2)
    column <- rbind(column, predict(generator, z_sample) %>% matrix(ncol = digit_size))
  }
  rows <- cbind(rows, column)
}
rows %>% as.raster() %>% plot()
