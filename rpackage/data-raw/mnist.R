library(keras)
mnist_raw <- dataset_mnist()

mnist_example <- list()
for(i in c(0:9)){
  idx <- which(mnist_raw$train$y == i)[1]
  mnist_example[[as.character(i)]] <- t(apply(mnist_raw$train$x[idx,,], 2, rev))
}

usethis::use_data(mnist_example, overwrite = TRUE)

