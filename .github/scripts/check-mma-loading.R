# Run from the IntroML root. This checks local configuration coverage and loading;
# numerical results are checked against solutions in the private teacher repo.
expected <- list(
  assignment1 = c("nll_grad", "gradient_descent", "glmnet_cv", "nllr_grad", "nllr",
                  "gradient_descent_reg", "adam"),
  assignment2 = c("tree_split", "grow_tree", "predict_with_tree", "train_bagged_trees",
                  "predict_with_bagged_trees", "grow_tree_m", "random_forest"),
  assignment3 = c("mini_net", "mini_net_loss"),
  assignment4 = c("convolution", "convolutional_layer", "maxpool_layer"),
  assignment5 = c("qkv", "attention", "multi_head_self_attention", "rnn_unit",
                  "activation", "output_rnn", "softmax", "rnn_layer"),
  assignment6 = c("compute_cluster_means", "compute_cluster_encoding", "k_means",
                  "k_means_W", "pPCA", "r_uni_two_comp", "d_uni_two_comp",
                  "e_uni_two_comp", "max_uni_two_comp", "ll_uni_two_comp",
                  "em_uni_two_comp"),
  # Assignment 7 supplies its helpers and has no separate function-writing tasks.
  assignment8 = c("stationary_bandit", "nonstationary_bandit", "greedy_algorithm",
                  "epsilon_algorithm", "nonstationary_algorithm",
                  "always_search_policy", "charge_when_low_policy",
                  "ucb_algorithm", "gradient_bandit_algorithm")
)
configs <- sort(list.files("assignments/tests", pattern = "\\.ya?ml$",
                           recursive = TRUE, full.names = TRUE))
stopifnot(length(configs) > 0L)
observed <- setNames(rep(list(character()), length(expected)), names(expected))
for (config in configs) {
  assignment <- basename(dirname(config))
  stopifnot(assignment %in% names(expected))
  loaded <- markmyassignment::set_assignment(config)
  tasks <- markmyassignment::show_tasks()
  observed[[assignment]] <- c(observed[[assignment]], tasks)
  parsed <- yaml::read_yaml(loaded)
  files <- unlist(lapply(c(parsed$tasks, parsed$run_code),
                        function(task) task$local_tmp_path), use.names = FALSE)
  stopifnot(length(files) >= length(tasks), all(file.exists(files)))
  for (file in files) parse(file = file)
  markmyassignment::remove_assignment()
  cat("Loaded and parsed:", config, "(", length(tasks), "tasks )\n")
}
for (assignment in names(expected)) {
  supplied <- if (assignment == "assignment1") "nll" else character()
  stopifnot(!anyDuplicated(observed[[assignment]]),
            setequal(observed[[assignment]], c(expected[[assignment]], supplied)))
}
cat("Coverage verified:", sum(lengths(expected)),
    "required functions, plus the supplied nll example, in", length(configs),
    "configurations.\n")
