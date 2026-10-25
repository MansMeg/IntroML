# R setup

This setup is first needed for assignment 3 and is reused for later assignments involving TensorFlow and Keras.

Use R 4.3 or later and the [course setup script](setup.R). Download and unzip the complete repository, open the `IntroML` folder in RStudio, and run this in a fresh R session, before loading TensorFlow or Keras:

```r
source("additional_material/r_setup/setup.R")
```

If your working folder is `assignments/`, use `source("../additional_material/r_setup/setup.R")` instead. From this `r_setup/` folder, use `source("setup.R")`.

The first run downloads the required packages and Python environment, which may take several minutes. The script uses a separate course R library and a managed Python environment, with fixed versions of the main packages. It keeps your other R libraries and Conda environments. The setup uses the CPU; no GPU configuration is needed.

The script checks course data, loads MNIST, trains a small model, and checks predictions and model saving and loading. Wait for **“IntroML setup is ready”** before starting the assignment. Run the script at the start of each new R session to select the same environment again; downloaded packages and data are reused.

Use `library(keras3)` in your assignment code. If setup fails, send the `setup-report.txt` file at the location printed by the script to a teaching assistant. Older links to `Install_keras.R` now forward to the same setup script.

## Automatic setup checks

The [R setup workflow](../../.github/workflows/r-setup.yaml) runs on pushes and pull requests that change the setup folder, its tests, the compatibility installer, or the course data package. It can also be started manually from GitHub's Actions tab.

Each job starts without a course package cache and uses R 4.5 on Windows, Linux, or macOS. Both Intel and Apple Silicon Macs are included. The checks exercise installation, training, model saving and loading, repeated use, the older installer link, and reuse in a fresh R session without network access. A separate check verifies the restart message when Python is already running outside the setup.

Diagnostic reports are attached to the workflow run, including on failure. The workflow does not test Colab or GPU support.
