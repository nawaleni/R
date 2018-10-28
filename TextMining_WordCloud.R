text <- readLines("Review_NY_1.txt")
#cleaning characters which don't matter
text2 <- gsub(pattern = "\\W", replace = " ", text)
# replace numbers
text2 <- gsub(pattern = "\\d", replace = " ", text2)
#lower case
text3 <- tolower(text2)
install.packages("tm")
library(tm)
# stopwords - non significant words
stopwords()
text4 <- removeWords(text3, stopwords())
#remove 's' left after removal of punctuation or
#words of certain length (here 1) '\\b -> word starts with'
text5 <- gsub(pattern = "\\b[a-z]\\b{1}", replace = " ", text4)
# clean up extra whiteapce 
text5 <- stripWhitespace(text5)


install.packages("wordcloud")
library(wordcloud)
# split string to individual words
text_bag <- strsplit(text5, " ")
# convert to char -> unlist
text_bag <- unlist(text_bag)

#load positive and negative words
poswords <- readLines("positive-words.txt")
negwords <- readLines("negative-words.txt")

#match with positive
match(text_bag, poswords) 
!is.na(match(text_bag, poswords))
pos_score <- sum(!is.na(match(text_bag, poswords))) # sum of all positive owrd apearance
neg_score <- sum(!is.na(match(text_bag, negwords)))
score <- pos_score - neg_score
