### This is a brief tutorial on how to set up and train a feedforward neural network using tensorflow and keras3



# Libraries
library(tensorflow)
library(keras3)
use_backend("tensorflow")


###### Data preparation ############

# import mnist data
mnist <- dataset_mnist()
# assign to simpler names
x_train <- mnist$train$x
y_train <- mnist$train$y
x_test <- mnist$test$x
y_test <- mnist$test$y

# Scale pixel values once. Keep images as (n, 28, 28) arrays;
# layer_flatten() will flatten each image inside the model.
x_train <- x_train / 255
x_test <- x_test / 255


############# Build model #############

# build model by stacking layers
model <- keras_model_sequential(input_shape = c(28, 28)) |>
  layer_flatten() |>
  layer_dense(128, activation = "relu") |>
  layer_dropout(0.2) |>
  layer_dense(10, activation = "softmax")

# Softmax returns probabilities for digits 0 to 9, one column per digit.
predictions <- predict(model, x_train[1:2, , , drop = FALSE])
predictions


# The probabilities for each image sum to one.
rowSums(predictions)
  

#### Now define loss function ###
# Labels are integers 0 to 9. The softmax output contains probabilities,
# so use sparse categorical cross-entropy with from_logits = FALSE.
loss_fn <- loss_sparse_categorical_crossentropy(from_logits = FALSE)


############# Compile model ################
# before training the model needs to be configured and compiled with loss function, optimizer and evaluation metric.
# the learning rate can be set manually by using for example: optimizer = optimizer_adam(learning_rate = 0.001)

model |> compile(
  optimizer = "adam",
  loss = loss_fn,
  metrics = "accuracy"
)


######### Train the model #########

# now the model can be trained using "fit()"
# To train a new model from scratch, recreate its layers and compile it again.
# Recompiling an existing model does not reset its learned layer weights.
model |> fit(x_train, y_train, epochs = 5)



  
######### Evaluate the model #############
# The evaluate() method checks the models performance, usually on a Validation-set or Test-set.
model |> evaluate(x_test, y_test, verbose = 2)

##### END #####

