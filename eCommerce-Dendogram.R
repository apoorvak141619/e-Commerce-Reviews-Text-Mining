---
title: "e-Commerce Text Mining Project - Capstone Project - Modelling"
Author: "Apoorva K"
output: html_notebook
---

Import Datasets 

```{r}
setwd('C:/Users/keshavaa/Documents/R_Working_Apoorva/Capstone')

ecommerce = read.csv("Womens Clothing E-Commerce Reviews-UploadIntoR.csv")
```

Import Libraries 

```{r}
library(ggplot2)
library(esquisse)
library(DataExplorer)
library(SmartEDA)
library(tm)
library(caret)
library(dplyr)
library(SnowballC)
library(wordcloud)
library(RColorBrewer)
library(ngram)
library(expss)
library(tidyverse)
library(tidytext)
library(purrr)
library(stringr)
library(igraph)
library(ggraph)
library(topicmodels)
library(quanteda)
```

### Modelling ###
Adding in the Review Title & Review Text together

```{r}
allreviewdata = ecommerce[,6]

allreviewdata_corpus = Corpus(VectorSource(allreviewdata))
words = c("also", "usual", "much", "bit", "realli", "littl", "bought", "one", "tri", "can", "run", "back", 
          "this", "that", "just", "i", "company", "get", "like", "made", "im", "work", "well", "wear",
          "look", "wed", "knee")
cleaned_reviewdata = tm_map(allreviewdata_corpus, removeWords, stopwords("english"))
cleaned_reviewdata = tm_map(cleaned_reviewdata, stemDocument, language = "english")
cleaned_reviewdata = tm_map(cleaned_reviewdata, removeWords, words)
cleaned_reviewdata = tm_map(cleaned_reviewdata, removePunctuation)
cleaned_reviewdata = tm_map(cleaned_reviewdata, content_transformer(tolower))
cleaned_reviewdata = tm_map(cleaned_reviewdata, content_transformer(removeNumbers))
cleaned_reviewdata = tm_map(cleaned_reviewdata, stripWhitespace)
```

converting the corpus into a dataframe. 

```{r}
TDM_reviewdata = TermDocumentMatrix(cleaned_reviewdata)

TDM_sparsedata = removeSparseTerms(TDM_reviewdata, sparse = 0.9)
sparsedata_matrix = as.matrix(TDM_sparsedata)
sorted_sparsedata_matrix = sort(rowSums(sparsedata_matrix), decreasing = TRUE)
dataframe_sparcedata = data.frame(word = names(sorted_sparsedata_matrix),
                                  freq = sorted_sparsedata_matrix)

```

## Unsupervised Learning ## 

# Model 1: Dendogram 

```{r}
distance = dist(dataframe_sparcedata, method = "euclidean")
dendogram = hclust(distance)

plot(dendogram)
rect.hclust(dendogram, k = 5, border = "blue")

```

Conclusion of Dendogram is that 5 clusters are created. 


# Model 2: LDA

Building & plotting a model first with 5 topics 

```{r}
library(topicmodels)

DTM_reviewdata = DocumentTermMatrix(cleaned_reviewdata)
DTM_sparsedata = removeSparseTerms(DTM_reviewdata, sparse = 0.9)
rowTotals = apply(DTM_sparsedata, 1, sum)
DTM_sparsedata = DTM_sparsedata[rowTotals>0, ]

text_lda5 = LDA(DTM_sparsedata, k = 5, method = "Gibbs", control = list(seed = 100))

word_probablity5 = text_lda5 %>% tidy(matrix = "beta")
text_lda5 %>% tidy(matrix = "beta") %>% arrange(desc(beta))

words5 = word_probablity5 %>% 
  group_by(topic) %>%
  top_n(5, beta) %>% 
  ungroup() %>% 
  mutate(term5 = fct_reorder(term, beta)) %>% 
  ggplot(aes(x = term5, y = beta, fill = as.factor(topic))) +
  geom_col() + facet_wrap(~ topic, scale = "free_y") +
  coord_flip()

words5
```

Building & plotting a model first with 4 topics 

```{r}
library(topicmodels)

text_lda4 = LDA(DTM_sparsedata, k = 4, method = "Gibbs", control = list(seed = 100))

word_probablity4 = text_lda4 %>% tidy(matrix = "beta")
text_lda4 %>% tidy(matrix = "beta") %>% arrange(desc(beta))

words4 = word_probablity4 %>% 
  group_by(topic) %>%
  top_n(5, beta) %>% 
  ungroup() %>% 
  mutate(term4 = fct_reorder(term, beta)) %>% 
  ggplot(aes(x = term4, y = beta, fill = as.factor(topic))) +
  geom_col() + facet_wrap(~ topic, scale = "free_y") +
  coord_flip()

words4
```


Building & plotting a model first with 3 topics 

```{r}
library(topicmodels)

text_lda3 = LDA(DTM_sparsedata, k = 3, method = "Gibbs", control = list(seed = 100))

word_probablity3 = text_lda3 %>% tidy(matrix = "beta")
text_lda3 %>% tidy(matrix = "beta") %>% arrange(desc(beta))

words3 = word_probablity3 %>% 
  group_by(topic) %>%
  top_n(5, beta) %>% 
  ungroup() %>% 
  mutate(term3 = fct_reorder(term, beta)) %>% 
  ggplot(aes(x = term3, y = beta, fill = as.factor(topic))) +
  geom_col() + facet_wrap(~ topic, scale = "free_y") +
  coord_flip()

words3
```

# WORD ASSOCIATION # 

Dress

```{r}
# Create associations
associations <- findAssocs(TDM_reviewdata, "dress", 0.08)
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
associations <- findAssocs(TDM_reviewdata, "bottom", 0.08)
# Create associations_df
associations_df <- list_vect2df(associations)[, 2:3]
# Plot the associations_df values 
ggplot(associations_df, aes(y = associations_df[, 1])) + 
  geom_point(aes(x = associations_df[, 2]), 
             data = associations_df, size = 3) + 
  ggtitle("Word Associations to 'Bottoms'") + 
  theme_gdocs()
```

Jackets

```{r}
# Create associations
associations <- findAssocs(TDM_reviewdata, "jacket", 0.09)
# Create associations_df
associations_df <- list_vect2df(associations)[, 2:3]
# Plot the associations_df values 
ggplot(associations_df, aes(y = associations_df[, 1])) + 
  geom_point(aes(x = associations_df[, 2]), 
             data = associations_df, size = 3) + 
  ggtitle("Word Associations to 'Jackets'") + 
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

# Model 3: Comparision Cloud 

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

Cleaning Data 

```{r}
## Combine both corpora: all reviews
all_yes <- paste(corpus_recommend_yes, collapse = "")
all_no <- paste(corpus_recommend_no, collapse = "")
all_combine <- c(all_yes, all_no)
corpus_review_all=Corpus(VectorSource(all_combine)) 

## Pre-processing corpus - all
corpus_review_all=tm_map(corpus_review_all, tolower)
corpus_review_all=tm_map(corpus_review_all, removePunctuation)
corpus_review_all=tm_map(corpus_review_all, removeWords, stopwords("english"))
corpus_review_all = tm_map(corpus_review_all, removeWords, words)
corpus_review_all=tm_map(corpus_review_all, stemDocument)
review_tdm_all <- TermDocumentMatrix(corpus_review_all)
all_m=as.matrix(review_tdm_all)
colnames(all_m)=c("Recommended","Not Recommended")

#Sum rows and frequency data frame
review_term_freq_all <- rowSums(all_m)
review_word_freq_all <- data.frame(term=names(review_term_freq_all), num = review_term_freq_all)
```

Comparision Cloud

```{r}
comparison.cloud(all_m,
                 colors = c("green", "red"),
                 max.words = 50)
```

# Model4: Polarized Plot Tag

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
             gap = 1500,
             laxlab = NULL,
             raxlab = NULL, 
             unit = NULL,
             top.labels = c("Recommended",
                            "Words",
                            "Not Recommended")
             )
```






  