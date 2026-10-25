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

# fit(..., validation_split = 0.3) reserves the last 30% before shuffling.
# Access those same rows for validation evaluation and error analysis.
split_at <- as.integer(nrow(x_train) * (1 - 0.3))
validation_rows <- seq.int(split_at + 1L, nrow(x_train))
x_val <- x_train[validation_rows, , , drop = FALSE]
y_val <- y_train[validation_rows]
# Keep x_test and y_test for the final model evaluation in Task 1.8.


############# Build model #############

# Build the Assignment 3 baseline model by stacking layers.
# For each Task 1.4 variant, reset the seed and construct/compile a fresh model.
set_random_seed(123)
model <- keras_model_sequential(input_shape = c(28, 28)) |>
  layer_flatten() |>
  layer_dense(16, activation = "sigmoid") |>
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
# Use plain SGD for the baseline. The later Adam experiment (as in Assignment 1) uses
# optimizer_adam(learning_rate = 0.001).

model |> compile(
  optimizer = optimizer_sgd(learning_rate = 0.05, momentum = 0),
  loss = loss_fn,
  metrics = "accuracy"
)


######### Train the model #########

# now the model can be trained using "fit()"
# To train a new model from scratch, recreate its layers and compile it again.
# Recompiling an existing model does not reset its learned layer weights.
history <- model |> fit(x_train, y_train, epochs = 3, batch_size = 128,
                       validation_split = 0.3)
plot(history)
# Task 1.4 requires learning curves for the baseline and final variant only.

# For Tasks 1.3 and 1.4, report both metrics from the final epoch.
# Collect the baseline and six Task 1.4 variants in one comparison table.
# Loss is sparse categorical cross-entropy, not classification error (1 - accuracy).
validation_metrics <- c(
  accuracy = tail(history$metrics$val_accuracy, 1),
  loss = tail(history$metrics$val_loss, 1)
)
validation_metrics


  
######### Evaluate the model #############
# Evaluate the retained model on validation data. For fixed-epoch training,
# these results match the final epoch's validation metrics (up to rounding).
# If early stopping restores earlier weights, use this evaluation to report
# the restored model's metrics rather than those from the last logged epoch.
model |> evaluate(x_val, y_val, verbose = 2)

# Task 1.7: use these x_val/y_val rows with your selected network for error analysis.

# Task 1.8 only: after model selection is complete, evaluate the selected model once.
# test_metrics <- model |> evaluate(x_test, y_test, verbose = 2)

##### END #####

