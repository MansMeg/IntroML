# Install devtools if not already installed
if (!require("devtools")) install.packages("devtools")

# Remove existing keras and tensorflow if they're installed
remove.packages("keras")
remove.packages("tensorflow")

# Install specific versions, might have to run this twice in case it throws an error
devtools::install_version("keras", version = "2.13.0")

###
# Restart R session before running this
###
# After installation, load the libraries and create a fresh installation
library(keras)
install_keras(tensorflow = "2.13.0", method = "virtualenv")

###
# Restart R session again
###
# Check installed versions
tensorflow::tf_version()
# [1] '2.13'
packageVersion("keras")
# [1] '2.13.0'