---
title: "e-Commerce - Models2"
output: html_notebook
---

Install libraries

```{r}
library(dplyr)
library(tm)
library(wordcloud)
library(plotrix)
library(dendextend)
library(ggplot2)
library(ggthemes)
library(reshape2)
library(quanteda)
```

Importing data 

```{r}
setwd("C:/Users/keshavaa/OneDrive - Hewlett Packard Enterprise/Misc/Data Analytics/Projects/Project10-CAPSTONE/E-Commerce-Text_Mining/RawDataFromWebsite")
getwd()
review=read.csv("Womens Clothing E-Commerce Reviews.csv", stringsAsFactors = FALSE)
names(review)

```

Text Processing

```{r}
corpus_review=Corpus(VectorSource(review$Review.Text))
corpus_review=tm_map(corpus_review, tolower)
corpus_review=tm_map(corpus_review, removePunctuation)
corpus_review=tm_map(corpus_review, removeWords, stopwords("english"))
words = c("also", "usual", "much", "bit", "realli", "littl", "bought", "one", "tri", "can", "run", "back", 
          "this", "that", "just", "i", "company", "get", "like", "made", "im", "work", "well", "wear",
          "look", "wed", "knee", "can", "order")
corpus_review_all = tm_map(corpus_review, removeWords, words)
corpus_review=tm_map(corpus_review, stemDocument)
##Viewing the corpus content
corpus_review[[8]][1]

review_dtm <- DocumentTermMatrix(corpus_review)
review_tdm <- TermDocumentMatrix(corpus_review)

review_m <- as.matrix(review_tdm)
# Sum rows and frequency data frame
review_term_freq <- rowSums(review_m)
# Sort term_frequency in descending order
review_term_freq <- sort(review_term_freq, decreasing = T)
# View the top 10 most common words
review_term_freq[1:10]

```

Recommended - No Database

```{r}
setwd("C:/Users/keshavaa/OneDrive - Hewlett Packard Enterprise/Misc/Data Analytics/Projects/Project10-CAPSTONE/E-Commerce-Text_Mining/RawDataFromWebsite")
getwd()
recommend_no=read.csv("Reccomend-No.csv", stringsAsFactors = FALSE)
names(recommend_no)

corpus_recommend_no=Corpus(VectorSource(recommend_no$Review.Text))
corpus_recommend_no=tm_map(corpus_recommend_no, tolower)
corpus_recommend_no=tm_map(corpus_recommend_no, removePunctuation)
corpus_recommend_no=tm_map(corpus_recommend_no, removeWords, stopwords("english"))
corpus_review_all = tm_map(corpus_recommend_no, removeWords, words)
corpus_recommend_no=tm_map(corpus_recommend_no, stemDocument)
##Viewing the corpus content
corpus_recommend_no[[8]][1]

recommend_no_dtm <- DocumentTermMatrix(corpus_recommend_no)
recommend_no_tdm <- TermDocumentMatrix(corpus_recommend_no)

recommend_no_m <- as.matrix(recommend_no_tdm)
# Sum rows and frequency data frame
recommend_no_term_freq <- rowSums(recommend_no_m)
# Sort term_frequency in descending order
recommend_no_term_freq <- sort(recommend_no_term_freq, decreasing = T)
# View the top 10 most common words
recommend_no_term_freq[1:10]

```

Recommend - Yes Database

```{r}
recommend_yes=read.csv("Reccomend-Yes.csv", stringsAsFactors = FALSE)
names(recommend_yes)

corpus_recommend_yes=Corpus(VectorSource(recommend_yes$Review.Text))
corpus_recommend_yes=tm_map(corpus_recommend_yes, tolower)
corpus_recommend_yes=tm_map(corpus_recommend_yes, removePunctuation)
corpus_recommend_yes=tm_map(corpus_recommend_yes, removeWords, stopwords("english"))
corpus_review_all = tm_map(corpus_recommend_yes, removeWords, words)
corpus_recommend_yes=tm_map(corpus_recommend_yes, stemDocument)
##Viewing the corpus content
corpus_recommend_yes[[8]][1]

recommend_yes_dtm <- DocumentTermMatrix(corpus_recommend_yes)
recommend_yes_tdm <- TermDocumentMatrix(corpus_recommend_yes)

recommend_yes_m <- as.matrix(recommend_yes_tdm)
# Sum rows and frequency data frame
recommend_yes_term_freq <- rowSums(recommend_yes_m)
# Sort term_frequency in descending order
recommend_yes_term_freq <- sort(recommend_yes_term_freq, decreasing = T)
# View the top 10 most common words
recommend_yes_term_freq[1:10]

```

Bar Graphs  

```{r}
barplot(review_term_freq[1:20], col = "steel blue", las = 2)
barplot(recommend_no_term_freq[1:20], col = "red", las = 2)
barplot(recommend_yes_term_freq[1:20], col = "green", las = 2)

```

Word Frequency

```{r}
review_word_freq <- data.frame(term = names(review_term_freq),
  num = review_term_freq)
recommend_no_freq <- data.frame(term = names(recommend_no_term_freq),
  num = recommend_no_term_freq)
recommend_yes_word_freq <- data.frame(term = names(recommend_yes_term_freq),
  num = recommend_yes_term_freq)

```

Word Clouds 

```{r}
## Combine both corpora: all reviews
all_yes <- paste(corpus_recommend_yes, collapse = "")
all_no <- paste(corpus_recommend_no, collapse = "")
all_combine <- c(all_yes, all_no)
## Creating corpus for combination
corpus_review_all=Corpus(VectorSource(all_combine)) 
## Pre-processing corpus - all
#Convert to lower-case
corpus_review_all=tm_map(corpus_review_all, tolower)
#Remove punctuation
corpus_review_all=tm_map(corpus_review_all, removePunctuation)
#Remove stopwords
corpus_review_all=tm_map(corpus_review_all, removeWords, stopwords("english"))
corpus_review_all = tm_map(corpus_review_all, removeWords, words)
#Stem document
corpus_review_all=tm_map(corpus_review_all, stemDocument)
review_tdm_all <- TermDocumentMatrix(corpus_review_all)
all_m=as.matrix(review_tdm_all)
colnames(all_m)=c("Yes","No")
#Sum rows and frequency data frame
review_term_freq_all <- rowSums(all_m)
review_word_freq_all <- data.frame(term=names(review_term_freq_all), num = review_term_freq_all)
#Make commonality cloud
commonality.cloud(all_m, 
                  colors = rainbow(7),
                  max.words = 50)

# Create comparison cloud
comparison.cloud(all_m,
                 colors = c("pink", "purple"),
                 max.words = 50)
```

Finding Common Words 

```{r}
# Identify terms shared by both documents
common_words <- subset(all_m, all_m[, 1] > 0 & all_m[, 2] > 0)
# calculate common words and difference
difference <- abs(common_words[, 1] - common_words[, 2])
common_words <- cbind(common_words, difference)
common_words <- common_words[order(common_words[, 3],
                                   decreasing = T), ]
head(common_words, 10)
```

Polarized Plot Tag

```{r}
top10_df <- data.frame(x = common_words[1:10, 1],
                       y = common_words[1:10, 2],
                       labels = rownames(common_words[1:10, ]))
# Make pyramid plot
pyramid.plot(top10_df$x, top10_df$y,
             labels = top10_df$labels, 
             main = "Sentiment Difference Between Common Words",
             gap = 2000,
             laxlab = NULL,
             raxlab = NULL, 
             unit = NULL,
             top.labels = c("Recommended",
                            "Words",
                            "Not Recommended")
             )
```

# WORD ASSOCIATIONS #

Dress

```{r}
# Create associations
associations <- findAssocs(review_tdm, "dress", 0.08)
# Create associations_df
associations_df <- list_vect2df(associations)[, 2:3]
# Plot the associations_df values 
ggplot(associations_df, aes(y = associations_df[, 1])) + 
  geom_point(aes(x = associations_df[, 2]), 
             data = associations_df, size = 3) + 
  ggtitle("Word Associations to 'Dress'") + 
  theme_gdocs()

```

Bottoms 

```{r}
# Create associations
associations <- findAssocs(review_tdm, "bottom", 0.08)
# Create associations_df
associations_df <- list_vect2df(associations)[, 2:3]
# Plot the associations_df values 
ggplot(associations_df, aes(y = associations_df[, 1])) + 
  geom_point(aes(x = associations_df[, 2]), 
             data = associations_df, size = 2) + 
  ggtitle("Word Associations to 'Bottoms'") + 
  theme_gdocs()
```

Jackets

```{r}
# Create associations
associations <- findAssocs(review_tdm, "jacket", 0.08)
# Create associations_df
associations_df <- list_vect2df(associations)[, 2:3]
# Plot the associations_df values 
ggplot(associations_df, aes(y = associations_df[, 1])) + 
  geom_point(aes(x = associations_df[, 2]), 
             data = associations_df, size = 3) + 
  ggtitle("Word Associations to 'Jacket'") + 
  theme_gdocs()
```

Tops 

```{r}
# Create associations
associations <- findAssocs(review_tdm, "top", 0.075)
# Create associations_df
associations_df <- list_vect2df(associations)[, 2:3]
# Plot the associations_df values 
ggplot(associations_df, aes(y = associations_df[, 1])) + 
  geom_point(aes(x = associations_df[, 2]), 
             data = associations_df, size = 3) + 
  ggtitle("Word Associations to 'Tops'") + 
  theme_gdocs()
```

Trend

```{r}
# Create associations
associations <- findAssocs(review_tdm, "trend", 0.11)
# Create associations_df
associations_df <- list_vect2df(associations)[, 2:3]
# Plot the associations_df values 
ggplot(associations_df, aes(y = associations_df[, 1])) + 
  geom_point(aes(x = associations_df[, 2]), 
             data = associations_df, size = 3) + 
  ggtitle("Word Associations to 'Trend") + 
  theme_gdocs()
```

# BIGRAMS 

```{r}
##Create bi-grams
review_bigram <- tokens(review$Review.Text) %>%
    tokens_remove("\\p{P}", valuetype = "regex", padding = TRUE) %>%
    tokens_remove(stopwords("english"), padding  = TRUE) %>%
    tokens_ngrams(n = 2) %>%
    dfm()
top25 = topfeatures(review_bigram, 25)

top25
```













