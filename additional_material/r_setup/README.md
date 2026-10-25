# R setup

Install Keras and TensorFlow before assignment 3. In a fresh R session, run:

```r
source("additional_material/r_setup/setup.R")
```

From the `assignments/` folder, use `source("../additional_material/r_setup/setup.R")` instead.

The script contains just two installation commands:

```r
install.packages(c("keras3", "tensorflow"), repos = "https://cloud.r-project.org")
keras3::install_keras(backend = "tensorflow")
```

The second command installs the Python dependencies too, following the [official Keras installation instructions](https://keras3.posit.co/articles/getting_started.html#installation). Installation may take several minutes. Restart R afterwards. In subsequent sessions, load the packages with `library(keras3)` and `library(tensorflow)`; you do not need to rerun the installer.

Install other course packages as directed in the assignments.

## Google Colab

Open the [course R notebook in Colab](https://colab.research.google.com/github/MansMeg/IntroML/blob/master/additional_material/colab_nb/RandTensorFlow.ipynb), save a copy in Drive, and run its setup cell. It sources the same setup script. Run the installer once per new Colab runtime, then add your R assignment code below. Save your notebook and results in Drive.

## Automatic check

[GitHub Actions](../../.github/workflows/r-setup.yaml) installs the packages and trains a tiny model on Linux, Windows, and macOS (Intel and Apple Silicon). 
