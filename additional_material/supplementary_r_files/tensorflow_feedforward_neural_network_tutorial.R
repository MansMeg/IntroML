### This is a brief tutorial on how to set up and train a feedforward neural network using tensorflow and keras3



# Libraries
library(tensorflow)
library(keras3)


###### Data preparation ############

# import mnist data
mnist <- dataset_mnist()
# assign to simpler names
x_train <- mnist$train$x
y_train <- mnist$train$y
x_test <- mnist$test$x
y_test <- mnist$test$y

# scale pixel values
x_train <- x_train / 255
x_test <-  x_test / 255


############# Build model #############

# build model by stacking layers
model <- keras_model_sequential(input_shape = c(28, 28)) %>%
  layer_flatten() %>%
  layer_dense(128, activation = "relu") %>%
  layer_dropout(0.2) %>%
  layer_dense(10)

# For each observation in the dataset, the model returns a vector of logits or log-odds scores, one for each class.
predictions <- predict(model, x_train[1:2, , ])
predictions


# The tf$nn$softmax function converts these logits to probabilities for each class:
tf$nn$softmax(predictions)
  

#### Now define loss function ###
# Set from_logits to FALSE if using softmax in output layer (this is the preset)
loss_fn <- loss_sparse_categorical_crossentropy(from_logits = TRUE) 


############# Compile model ################
# before training the model needs to be configured and compiled with loss function, optimizer and evaluation metric.
# the learning rate can be set manually by using for example: optimizer = optimizer_adam(learning_rate = 0.001)

model %>% compile(
  optimizer = "adam",
  loss = loss_fn,
  metrics = "accuracy"
)


######### Train the model #########

# now the model can be trained using "fit()"
# if refitting the entire model later, remember to also re-compile it so that the weights are reset.
model %>% fit(x_train, y_train, epochs = 5)



  
######### Evaluate the model #############
# The evaluate() method checks the models performance, usually on a Validation-set or Test-set.
model %>% evaluate(x_test,  y_test, verbose = 2)

##### END #####

