## Simple CNN example implementation on CIFAR10 dataset


# libraries
library(tensorflow)
library(keras3)


########## import and prepare data ###############
cifar10 <- dataset_cifar10()

# access train and test data. Also scale train data
x_train <- cifar10$train$x/255
x_test <- cifar10$test$x/255
y_train <- cifar10$train$y
y_test <- cifar10$test$y



############ Parameters ############

batch_size <- 16
epochs <- 10



########## Define the model ###########


model <- keras_model_sequential(input_shape = c(32, 32, 3)) %>%
  # Start with hidden 2D convolutional layer being fed 32x32 pixel images
  layer_conv_2d(filter = 16, kernel_size = c(3,3), padding = "same", activation = "relu") %>%
  
  # Second hidden layer
  layer_conv_2d(filter = 32, kernel_size = c(3,3), activation = "relu") %>%
  
  # Use max pooling
  layer_max_pooling_2d(pool_size = c(2,2)) %>%
  
  # 2 additional hidden 2D convolutional layers
  layer_conv_2d(filter = 32, kernel_size = c(3,3), padding = "same", activation = "relu") %>%
  layer_conv_2d(filter = 64, kernel_size = c(3,3), activation = "relu") %>%
  
  # Use max pooling once more
  layer_max_pooling_2d(pool_size = c(2,2)) %>%
  layer_dropout(0.25) %>%
  
  # Flatten max filtered output into feature vector 
  # and feed into dense layer
  layer_flatten() %>%
  layer_dense(256, activation = "relu") %>%
  
  # Outputs from dense layer are projected onto 10 unit output layer
  layer_dense(10)


###### Optimizer and compilation #########

opt <- optimizer_adamax(learning_rate = 0.001)

model %>% compile(
  loss = loss_sparse_categorical_crossentropy(from_logits = TRUE),
  optimizer = opt,
  metrics = "accuracy"
)


########### Training #################
model %>% fit(
  x_train, y_train,
  batch_size = batch_size,
  epochs = epochs,
  validation_data = list(x_test, y_test),
  shuffle = TRUE
)

############ Model evaluation #######
# evulate model on test set
model %>% evaluate(x_test, y_test)

##### END #####



