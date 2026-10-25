# IntroML setup: from the course folder, run
# source("additional_material/r_setup/setup.R") in a fresh R session.
# The first run downloads R packages, Python, and TensorFlow. Later runs reuse
# the cached environment. Existing R libraries and Conda environments are kept.
#
# Staff: change the versions together, then test on fresh student machines.
# options(introml.setup_cache = "/path/to/cache") selects a separate test cache;
# options(introml.setup_check = FALSE) skips the model and data checks.
# TensorFlow 2.16.2 also provides wheels for Intel Macs (later versions do not).
# https://www.tensorflow.org/install/pip
# https://rstudio.github.io/reticulate/reference/py_require.html

local({
  r_versions <- c(reticulate = "1.47.0", tensorflow = "2.20.0", keras3 = "1.5.1")
  python_version <- "3.11.13"
  python_versions <- c(keras = "3.15.1", tensorflow = "2.16.2", numpy = "1.26.4")
  dependency_cutoff <- "2026-10-25"
  cran <- "https://cloud.r-project.org"

  # Locate the checkout whether called with source() or Rscript, from any folder.
  source_files <- vapply(sys.frames(), function(frame) {
    if (is.character(frame$ofile)) frame$ofile[[1L]] else ""
  }, character(1))
  script_args <- sub("^--file=", "", grep("^--file=", commandArgs(), value = TRUE))
  script_args <- gsub("~+~", " ", script_args, fixed = TRUE)
  candidates <- c(script_args, source_files)
  candidates <- candidates[basename(candidates) == "setup.R" & file.exists(candidates)]
  if (!length(candidates)) {
    candidates <- c(file.path(getwd(), "additional_material", "r_setup", "setup.R"),
                    file.path(getwd(), "..", "additional_material", "r_setup", "setup.R"),
                    file.path(getwd(), "setup.R"))
    candidates <- candidates[file.exists(candidates)]
  }
  if (!length(candidates)) stop("Cannot locate additional_material/r_setup/setup.R in the course checkout.")
  setup_file <- normalizePath(tail(candidates, 1L), winslash = "/")
  course_root <- normalizePath(file.path(dirname(setup_file), "..", ".."), winslash = "/")
  current_dir <- normalizePath(getwd(), winslash = "/")
  setup_command <- if (identical(current_dir, course_root)) {
    'source("additional_material/r_setup/setup.R")'
  } else if (identical(current_dir, file.path(course_root, "assignments"))) {
    'source("../additional_material/r_setup/setup.R")'
  } else if (identical(current_dir, dirname(setup_file))) {
    'source("setup.R")'
  } else {
    paste0("source(", encodeString(setup_file, quote = '"'), ")")
  }

  cache <- getOption("introml.setup_cache", Sys.getenv(
    "INTROML_SETUP_CACHE", unset = tools::R_user_dir("introml", "cache")
  ))
  library_dir <- file.path(cache, paste0("R-", getRversion()), R.version$platform)
  dir.create(library_dir, recursive = TRUE, showWarnings = FALSE)
  if (!dir.exists(library_dir) || file.access(library_dir, 2L) != 0L) {
    stop("Cannot write the IntroML cache: ", cache, call. = FALSE)
  }
  report_file <- file.path(cache, "setup-report.txt")
  report <- c("IntroML setup report", paste("Started:", Sys.time()),
              paste("R:", getRversion()), paste("Platform:", R.version$platform),
              paste("Course R library:", library_dir))
  phase <- "checking prerequisites"
  record <- function(...) {
    report <<- c(report, paste(...))
    writeLines(report, report_file)
  }
  progress <- function(text) {
    phase <<- text
    record("Step:", text)
    message("\nIntroML: ", text)
  }
  package_version <- function(package) {
    path <- find.package(package, quiet = TRUE)
    if (!length(path)) return(NA_character_)
    unname(read.dcf(file.path(path, "DESCRIPTION"), fields = "Version")[[1L]])
  }

  tryCatch({
    record("Requested R packages:", paste(names(r_versions), r_versions, collapse = "; "))
    record("Requested Python:", python_version)
    record("Requested Python packages:",
           paste(names(python_versions), python_versions, collapse = "; "))
    if (getRversion() < "4.3.0") {
      stop("Please install R 4.3 or later, restart R, and run setup.R again.")
    }
    course_package <- file.path(course_root, "rpackage")
    if (!file.exists(file.path(course_package, "DESCRIPTION"))) {
      stop("Download the complete IntroML repository before running setup.R; rpackage/ is missing.")
    }
    course_version <- read.dcf(file.path(course_package, "DESCRIPTION"), fields = "Version")[[1L]]
    r_versions <- c(r_versions, uuml = course_version)
    setup_id <- paste(c(r_versions, python_version, python_versions, dependency_cutoff),
                      collapse = ";")
    if ("keras" %in% loadedNamespaces()) {
      stop("Legacy keras is loaded. Restart R and run setup.R before loading any Keras packages.")
    }
    for (package in names(r_versions)) {
      if (package %in% loadedNamespaces() &&
          as.character(getNamespaceVersion(package)) != r_versions[[package]]) {
        stop(package, " is already loaded with a different version. Restart R and run setup.R first.")
      }
    }
    python_started <- "reticulate" %in% loadedNamespaces() && reticulate::py_available()
    if (python_started && !identical(getOption("introml.setup_ready"), setup_id)) {
      stop("Python is already running outside this setup. Restart R and run setup.R first.")
    }

    # Only install into the course library; never upgrade a user's other library.
    .libPaths(c(library_dir, .libPaths()))
    old_options <- options(timeout = max(600, getOption("timeout", 60)),
                           install.packages.check.source = "no")
    on.exit(options(old_options), add = TRUE)
    available <- NULL
    install_pinned <- function(package, version) {
      if (identical(package_version(package), version)) return(invisible(NULL))
      progress(paste("installing R package", package, version))
      type <- if (.Platform$OS.type == "windows" || Sys.info()[["sysname"]] == "Darwin") {
        "binary"
      } else {
        "source"
      }
      if (is.null(available)) {
        available <<- utils::available.packages(repos = cran, type = type)
      }
      if (package %in% rownames(available) && available[package, "Version"] == version) {
        utils::install.packages(package, lib = library_dir, repos = cran, type = type)
      } else {
        # CRAN archives keep older pinned versions when the current release moves on.
        # Installing a compiled package from source may require R build tools.
        if (is.na(package_version("remotes"))) {
          utils::install.packages("remotes", lib = library_dir, repos = cran, type = type)
        }
        remotes::install_version(package, version = version, lib = library_dir,
                                 repos = cran, upgrade = "never", dependencies = NA)
      }
      if (!identical(package_version(package), version)) {
        stop("Could not install ", package, " ", version,
             ". Check the installation messages above and send the setup report to a TA.")
      }
    }
    progress("checking R packages")
    for (package in setdiff(names(r_versions), "uuml")) {
      install_pinned(package, r_versions[[package]])
    }
    if (!identical(package_version("uuml"), course_version)) {
      if (is.na(package_version("checkmate"))) {
        utils::install.packages("checkmate", lib = library_dir, repos = cran)
      }
      progress("installing the course data package")
      utils::install.packages(course_package, lib = library_dir, repos = NULL, type = "source")
      if (!identical(package_version("uuml"), course_version)) {
        stop("The course data package uuml could not be installed.")
      }
    }

    progress("selecting the course Python environment (CPU)")
    if (!python_started) {
      # These settings affect this R session only. Set them before importing Python.
      Sys.unsetenv(c("KERAS_PYTHON", "RETICULATE_PYTHON_ENV", "TF_USE_LEGACY_KERAS"))
      Sys.setenv(RETICULATE_PYTHON = "managed", RETICULATE_USE_MANAGED_VENV = "yes",
                 KERAS_BACKEND = "tensorflow-cpu", CUDA_VISIBLE_DEVICES = "-1",
                 TF_CPP_MIN_LOG_LEVEL = "2", KERAS_HOME = file.path(cache, "keras"))
    }
    suppressPackageStartupMessages(library(keras3))
    suppressPackageStartupMessages(library(tensorflow))
    suppressPackageStartupMessages(library(uuml))
    if (!python_started) {
      keras3::use_backend("tensorflow", gpu = FALSE)
      # Match keras3's CPU backend package name on Linux.
      tf_package <- if (Sys.info()[["sysname"]] == "Linux") "tensorflow-cpu" else "tensorflow"
      requirements <- c(paste0("keras==", python_versions[["keras"]]),
                        paste0(tf_package, "==", python_versions[["tensorflow"]]),
                        paste0("numpy==", python_versions[["numpy"]]))
      reticulate::py_require(requirements, python_version = paste0("==", python_version),
                            exclude_newer = dependency_cutoff)
    }
    config <- reticulate::py_config()
    record(capture.output(print(config)))
    actual_python <- reticulate::import("platform")$python_version()
    record("Python version:", actual_python)
    if (!identical(actual_python, python_version)) {
      stop("The selected Python version does not match the course version. Restart R and rerun setup.R.")
    }
    metadata <- reticulate::import("importlib.metadata")
    for (package in names(python_versions)) {
      distribution <- if (package == "tensorflow" && Sys.info()[["sysname"]] == "Linux") {
        "tensorflow-cpu"
      } else {
        package
      }
      actual <- metadata$version(distribution)
      record("Python package:", package, actual)
      if (!identical(actual, python_versions[[package]])) {
        stop("Unexpected ", package, " version: ", actual)
      }
    }
    if (keras3::config_backend() != "tensorflow") stop("The Keras backend is not TensorFlow.")

    check_setup <- function() {
      # Restore the student's R random-number state after the check.
      old_seed <- get0(".Random.seed", envir = .GlobalEnv, inherits = FALSE)
      on.exit({
        if (is.null(old_seed)) {
          if (exists(".Random.seed", envir = .GlobalEnv, inherits = FALSE)) {
            rm(".Random.seed", envir = .GlobalEnv)
          }
        } else {
          assign(".Random.seed", old_seed, envir = .GlobalEnv)
        }
        keras3::clear_session()
      }, add = TRUE)
      progress("checking course data")
      course_data <- new.env(parent = emptyenv())
      utils::data("Hitters", package = "uuml", envir = course_data)
      stopifnot(is.data.frame(course_data$Hitters), nrow(course_data$Hitters) > 0L)
      progress("loading MNIST and training a small model")
      keras3::set_random_seed(129L)
      mnist <- keras3::dataset_mnist()
      x <- mnist$train$x[1:256, , , drop = FALSE] / 255
      y <- mnist$train$y[1:256]
      model <- keras3::keras_model_sequential(input_shape = c(28L, 28L)) |>
        keras3::layer_flatten() |>
        keras3::layer_dense(units = 16L, activation = "relu") |>
        keras3::layer_dense(units = 10L, activation = "softmax")
      keras3::compile(model, optimizer = "adam",
                      loss = "sparse_categorical_crossentropy", metrics = "accuracy")
      history <- keras3::fit(model, x, y, epochs = 1L, batch_size = 32L, verbose = 0L)
      stopifnot(all(is.finite(unlist(history$metrics))))
      prediction <- predict(model, x[1:4, , , drop = FALSE], verbose = 0L)
      stopifnot(identical(dim(prediction), c(4L, 10L)), all(is.finite(prediction)),
                max(abs(rowSums(prediction) - 1)) < 1e-5)
      progress("checking model saving and loading")
      model_file <- tempfile(fileext = ".keras")
      on.exit(unlink(model_file), add = TRUE)
      keras3::save_model(model, model_file)
      restored <- keras3::load_model(model_file)
      restored_prediction <- predict(restored, x[1:4, , , drop = FALSE], verbose = 0L)
      stopifnot(isTRUE(all.equal(prediction, restored_prediction, tolerance = 1e-6)))
      record("Checks: course data, MNIST, training, predictions, saving, and loading passed.")
    }
    if (isTRUE(getOption("introml.setup_check", TRUE))) {
      check_setup()
    } else {
      record("Model and data checks skipped via options(introml.setup_check = FALSE).")
    }
    record(c("\nR session:", capture.output(utils::sessionInfo())))
    record(c("\nResolved Python packages:", reticulate::py_eval(
      "sorted(d.metadata['Name'] + '==' + d.version for d in __import__('importlib.metadata', fromlist=['distributions']).distributions())"
    )))
    options(introml.setup_ready = setup_id)
    record("\nResult: PASS")
    message("\nIntroML setup is ready. Use library(keras3) for the assignments.",
            "\nRun ", setup_command, " again when you start a new R session.",
            "\nSetup report: ", report_file)
  }, error = function(error) {
    options(introml.setup_ready = NULL)
    record(c("\nResult: FAIL", paste("Failed step:", phase),
           paste("Error:", conditionMessage(error)),
           "\nR session:", capture.output(utils::sessionInfo())))
    stop("IntroML setup failed while ", phase, ":\n", conditionMessage(error),
         "\n\nSend this report to a teaching assistant: ", report_file, call. = FALSE)
  })
})
