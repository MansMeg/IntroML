set.seed(4711)

tokens <- c("the", "quick", "brown", "fox", "jumps", "over", "the", "lazy", "dog")
word_embeddings <- list()
for(i in seq_along(tokens)){
  word_embeddings[[i]] <- matrix(rnorm(5), nrow = 1)
}
word_embeddings <- do.call(rbind, word_embeddings)
rownames(word_embeddings) <- tokens
word_embeddings[7,] <- word_embeddings[1,]

Wq_mh <- array(rnorm(3*5*4), dim = c(5, 3, 4))/10
Wk_mh <- array(rnorm(3*5*4), dim = c(5, 3, 4))/10
Wv_mh <- array(rnorm(3*5*4), dim = c(5, 3, 4))/10
W0 <- t(array(rnorm(3*4*3), dim = c(3, 12))/10)

transformer_example <- list(embeddings = word_embeddings,
                            Wq = Wq_mh,
                            Wk = Wk_mh,
                            Wv = Wv_mh,
                            W0 = W0)

usethis::use_data(transformer_example, overwrite = TRUE)
