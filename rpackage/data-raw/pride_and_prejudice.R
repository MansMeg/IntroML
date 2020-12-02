
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
rownames(tidy_pride) <- NULL
pride_and_prejudice <- tidy_pride
usethis::use_data(pride_and_prejudice, overwrite = TRUE)

