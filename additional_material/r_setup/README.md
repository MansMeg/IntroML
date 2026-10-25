# R setup

Install Keras and TensorFlow before assignment 3. In a fresh R session, run:

```r
source("additional_material/r_setup/setup.R")
```

From the `assignments/` folder, use `source("../additional_material/r_setup/setup.R")` instead.

The script contains just two installation commands:

```r
install.packages(c("keras3", "tensorflow"), repos = "https://cloud.r-project.org")
keras3::install_keras(backend = "tensorflow", python_version = ">=3.9",
                      extra_packages = "numpy")
```

The second command installs the Python dependencies too, following the [official Keras installation instructions](https://keras3.posit.co/articles/getting_started.html#installation). Installation may take several minutes. Restart R afterwards. In subsequent sessions, load the packages with `library(keras3)` and `library(tensorflow)`; you do not need to rerun the installer.

The arguments allow newer Python versions, including Colab's Python 3.13, and let the package installer choose a compatible NumPy version. This avoids the Keras installer's older defaults of Python 3.11 or earlier and NumPy below 2.

Install other course packages as directed in the assignments.

## Google Colab

Open [setup_r_colab.ipynb in Colab](https://colab.research.google.com/github/MansMeg/IntroML/blob/master/additional_material/colab_nb/setup_r_colab.ipynb), save a copy in Drive, and run its setup cell first in a fresh R session:

```r
install.packages(c("keras3", "tensorflow"), repos = "https://cloud.r-project.org")
Sys.setenv(RETICULATE_PYTHON = "managed")
library(keras3)
library(tensorflow)
keras3::use_backend("tensorflow")
```

This uses reticulate's [managed Python environment](https://rstudio.github.io/reticulate/reference/py_require.html#details) to avoid Colab's failing `python -m venv` installation step. Python and its packages are downloaded when the training check first uses them. Run that check and wait for **“PASS: training and prediction work”** before starting the assignment.

If an earlier setup attempt failed, restart the R session before running the new setup cell. Run the cell at the start of each R session; downloads are reused while the runtime keeps them. Save your notebook and results in Drive.

## Automatic check

[GitHub Actions](../../.github/workflows/r-setup.yaml) checks the local installer by installing the packages and training a tiny model on Linux, Windows, and macOS (Intel and Apple Silicon).

A separate Linux job runs the Colab notebook's setup and training cells using managed Python. This checks the notebook independently of the local installer. Testing in Google's hosted Colab runtime remains a manual step.
