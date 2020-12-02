
library(janeaustenr)
library(tidytext)
library(dplyr)

data("prideprejudice")

# Pride and
dat <- data.frame(text = prideprejudice, paragraph = 0, chapter = 0, stringsAsFactors = FALSE)

# Add paragraphs and chapter sID
paragraph_indication <- as.integer(dat$text == "")
dat$paragraph <- cumsum(paragraph_indication)

chapter_indication <- as.integer(grepl(stringr::str_trim(tolower(dat$text)), pattern = "^chapter [0-9]+$"))
dat$chapter <- cumsum(chapter_indication)

# Remove chapter titles
dat <- dat[!chapter_indication,]

# Tidy data
tidy_pride <- unnest_tokens(dat, word, text)

# Cleanup
tidy_pride$word <- stringr::str_replace_all(tidy_pride$word, pattern = "_", replacement = "")
tidy_pride <- tidy_pride[tidy_pride$chapter>0,]
tidy_pride$paragraph <- as.integer(as.factor(tidy_pride$paragraph))
tidy_pride$word <- as.factor(tidy_pride$word)

rownames(tidy_pride) <- NULL
pride_and_prejudice <- tidy_pride

usethis::use_data(pride_and_prejudice, overwrite = TRUE)

stopwords <- tidytext::stop_words
usethis::use_data(stopwords, overwrite = TRUE)
