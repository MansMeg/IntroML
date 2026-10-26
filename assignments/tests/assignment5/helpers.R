# Published course data and small fixtures; no training or downloads.
.a5_checks <- local({
  data("transformer_example", package = "uuml", envir = environment())
  data("rnn_example", package = "uuml", envir = environment())
  list(transformer = transformer_example, rnn = rnn_example)
})
