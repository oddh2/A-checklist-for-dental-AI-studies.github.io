#Task: Add wordcloud visualisation

# OBJECTIVES: 
# 1: Read in the text
# 2: Housekeeping of text
# 3: Create wordcloud


# Call the relevant R libraries
library(plyr); library(dplyr)
library(tidyverse)
library(tm) # take your text as a corpus
library(wordcloud2)


# OBJECTIVE 1: Read in the text
# The text can be pasted in a .txt file and loaded into R
text<- read_file("text.txt")


 
#  OBJECTIVE 2: Housekeeping of text
# Create a corpus  
docs <- Corpus(VectorSource(text))

# Clean the text of punctuations, common words, etc.
docs <- docs %>%  tm_map(removeNumbers) %>%  tm_map(removePunctuation) %>%  tm_map(stripWhitespace)
docs <- tm_map(docs, content_transformer(tolower))
docs <- tm_map(docs, removeWords, stopwords("english"))

# Create a document-term-matrix (dataframe containing each word in your first column and their frequency in the second column)
dtm <- TermDocumentMatrix(docs) 
matrix <- as.matrix(dtm) 
words <- sort(rowSums(matrix),decreasing=TRUE) 
df <- data.frame(word = names(words),freq=words)

 
#  OBJECTIVE 3: Create wordcloud
wordcloud2(data=df, size=0.7, shape='diamond')
