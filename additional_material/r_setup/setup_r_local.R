# IntroML: R setup on your own computer
# Save your own copy and open it in R or RStudio. Read the comments and run
# the code one section at a time before starting assignment 3.
# Local setup guide:
# https://github.com/MansMeg/IntroML/blob/master/additional_material/r_setup/README.md

# 1. Install Keras and TensorFlow (run once) ----
# Start with a fresh R session and 64-bit Python 3.13 installed
# (Python 3.11 on an Intel Mac).
# Install the R packages:
install.packages(c("keras3", "tensorflow"), repos = "https://cloud.r-project.org")
# Install their Python dependencies. This may take several minutes:
keras3::install_keras(backend = "tensorflow", python_version = ">=3.9,<3.14",
                      extra_packages = "numpy")

# Restart R after installation, then continue below.
# In later R sessions, start at section 2; installation is only needed once.

# 2. Load the packages (run in each R session) ----
library(keras3)
library(tensorflow)

# 3. Check the installation ----
# Run this small training and prediction check. Wait for
# "PASS: training and prediction work" before starting your assignment.
x <- matrix(c(0, 0, 1, 1, 0, 1, 0, 1), ncol = 2)
y <- c(0, 1, 1, 2)
model <- keras_model_sequential(input_shape = c(2L)) |>
  layer_dense(units = 1L)
compile(model, optimizer = "sgd", loss = "mse")
history <- fit(model, x, y, epochs = 1L, verbose = 0L)
prediction <- predict(model, x, verbose = 0L)
stopifnot(all(is.finite(unlist(history$metrics))),
          identical(dim(prediction), c(4L, 1L)), all(is.finite(prediction)))
cat("PASS: training and prediction work\n")

# 4. Start your assignment ----
# Use the student assignment template for your report:
# https://github.com/MansMeg/IntroML/blob/master/templates/assignment_template.rmd
# Follow its required sections and keep the report anonymous.
# Install other course packages as directed in the assignments.
# Add your assignment code below in your own copy, and save your work.
