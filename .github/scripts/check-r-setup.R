# Run from the IntroML folder with Rscript .github/scripts/check-r-setup.R.
# The workflow supplies fresh cache directories; local runs can reuse a cache.
local({
  root <- normalizePath(getwd(), winslash = "/")
  setup_file <- file.path(root, "additional_material", "r_setup", "setup.R")
  legacy_file <- file.path(root, "additional_material", "supplementary_r_files", "Install_keras.R")
  stopifnot(file.exists(setup_file), file.exists(legacy_file))
  cache <- Sys.getenv("INTROML_SETUP_CACHE", unset = tempfile("introml-ci-"))
  Sys.setenv(INTROML_SETUP_CACHE = cache)
  report_dir <- file.path(cache, "reports")
  dir.create(report_dir, recursive = TRUE, showWarnings = FALSE)
  copy_report <- function(name) {
    stopifnot(file.copy(file.path(cache, "setup-report.txt"),
                       file.path(report_dir, name), overwrite = TRUE))
  }
  assert_pass <- function() {
    report <- readLines(file.path(cache, "setup-report.txt"))
    stopifnot(!is.null(getOption("introml.setup_ready")),
              "Result: PASS" %in% report,
              any(grepl("Checks: course data, MNIST, training, predictions, saving, and loading passed.",
                        report, fixed = TRUE)))
  }

  original_options <- options()[c("timeout", "install.packages.check.source")]
  set.seed(129L)
  original_seed <- .Random.seed
  source(setup_file)
  assert_pass()
  stopifnot(identical(options()[names(original_options)], original_options),
            identical(.Random.seed, original_seed))
  copy_report("installation.txt")

  setwd(file.path(root, "assignments"))
  tryCatch({
    source("../additional_material/r_setup/setup.R")
    assert_pass()
    copy_report("same-session.txt")
  }, finally = setwd(root))

  source(legacy_file)
  assert_pass()
  copy_report("legacy-installer.txt")

  # Exercise command-line discovery with spaces in the script path and a
  # different working folder. Reuse must work offline in a fresh R process.
  temporary_course <- tempfile("IntroML course with spaces ")
  temporary_setup <- file.path(temporary_course, "additional_material", "r_setup", "setup.R")
  dir.create(dirname(temporary_setup), recursive = TRUE)
  dir.create(file.path(temporary_course, "rpackage"))
  # The package was installed above; only its version metadata is needed here.
  # Avoid copying datasets and ignored local files into this temporary checkout.
  stopifnot(file.copy(setup_file, temporary_setup),
            file.copy(file.path(root, "rpackage", "DESCRIPTION"),
                      file.path(temporary_course, "rpackage", "DESCRIPTION")))
  old_dir <- getwd()
  old_offline <- Sys.getenv("UV_OFFLINE", unset = NA_character_)
  status <- tryCatch({
    setwd(tempdir())
    Sys.setenv(UV_OFFLINE = "1")
    system2(file.path(R.home("bin"), "Rscript"),
            c("--vanilla", shQuote(temporary_setup)))
  }, finally = {
    setwd(old_dir)
    if (is.na(old_offline)) Sys.unsetenv("UV_OFFLINE") else Sys.setenv(UV_OFFLINE = old_offline)
  })
  stopifnot(identical(status, 0L))
  copy_report("restarted-session.txt")
  stopifnot("Result: PASS" %in% readLines(file.path(cache, "setup-report.txt")))

  # Python cannot be safely switched after it has initialized in an R session.
  options(introml.setup_ready = NULL)
  error <- tryCatch({ source(setup_file); NULL }, error = identity)
  stopifnot(inherits(error, "error"),
            grepl("Python is already running", conditionMessage(error), fixed = TRUE),
            "Result: FAIL" %in% readLines(file.path(cache, "setup-report.txt")))
  copy_report("expected-session-conflict.txt")
  message("\nAll IntroML setup checks passed.")
})
