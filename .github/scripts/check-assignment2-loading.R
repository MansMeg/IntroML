# Run from the IntroML root. An optional argument selects a published YAML URL.
args <- commandArgs(trailingOnly = TRUE)
stopifnot(length(args) <= 1L)
config <- if(length(args)) args[1] else
  "assignments/tests/assignment2/assignment2.yml"
loaded <- markmyassignment::set_assignment(config)
stopifnot(setequal(markmyassignment::show_tasks(),
                   c("tree_split", "grow_tree", "predict_with_tree")))

# Inspect the downloaded copies, including relative helper paths. This checks
# loading and syntax without publishing or requiring the private teacher solution.
assignment <- yaml::read_yaml(loaded)
files <- unlist(lapply(c(assignment$tasks, assignment$run_code),
                       function(task) task$local_tmp_path), use.names = FALSE)
stopifnot(length(files) == 4L, all(file.exists(files)))
for(file in files) parse(file = file)
markmyassignment::remove_assignment()
cat("Assignment 2 YAML, three test files, and helper loaded and parsed:", config, "\n")
