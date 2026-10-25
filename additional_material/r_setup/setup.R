install.packages(c("keras3", "tensorflow"), repos = "https://cloud.r-project.org")
keras3::install_keras(backend = "tensorflow", python_version = ">=3.9",
                      extra_packages = "numpy")
