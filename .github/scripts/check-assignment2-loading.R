# Run from the IntroML root. An optional argument selects a published YAML URL.
args <- commandArgs(trailingOnly = TRUE)
stopifnot(length(args) <= 1L)
basic <- if(length(args)) args[1] else
  "assignments/tests/assignment2/assignment2.yml"
stopifnot(grepl("assignment2.yml$", basic))
configs <- c(basic, sub("assignment2.yml$", "assignment2-vg.yml", basic))
tasks <- list(c("tree_split", "grow_tree", "predict_with_tree"),
              c("train_bagged_trees", "predict_with_bagged_trees", "grow_tree_m"))

# Inspect the downloaded copies, including relative helper paths. This checks
# loading and syntax without publishing or requiring the private teacher solution.
for(i in seq_along(configs)){
  loaded <- markmyassignment::set_assignment(configs[i])
  stopifnot(setequal(markmyassignment::show_tasks(), tasks[[i]]))
  assignment <- yaml::read_yaml(loaded)
  files <- unlist(lapply(c(assignment$tasks, assignment$run_code),
                         function(task) task$local_tmp_path), use.names = FALSE)
  stopifnot(length(files) == 4L, all(file.exists(files)))
  for(file in files) parse(file = file)
  markmyassignment::remove_assignment()
  cat("Assignment 2 YAML, three test files, and helper loaded and parsed:", configs[i], "\n")
}
