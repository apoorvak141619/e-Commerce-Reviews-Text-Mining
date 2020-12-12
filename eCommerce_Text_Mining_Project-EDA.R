---
title: "e-Commerce Text Mining Project - Capstone Project"
Author: "Apoorva K"
output: html_notebook
---

Import Datasets 

```{r}
setwd('C:/Users/keshavaa/Documents/R_Working_Apoorva/Capstone')

rm(list = ls())

ecommerce = read.csv("Womens Clothing E-Commerce Reviews-UploadIntoR.csv")

ecommerce
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
```

#### EDA ####
REVIEW TEXT 
Moving the review text to another dataset

```{r}
text = ecommerce[, 5]
head(text,10)
```

Creating a simple vector for the review text 

```{r}
text_corpus = Corpus(VectorSource(text))
TDM_text = TermDocumentMatrix(text_corpus)
```

Create a matrix 

```{r}
matrix_text = as.matrix(TDM_text)
sorted_matrix_text = sort(rowSums(matrix_text), decreasing = TRUE)
dataframe_text = data.frame(word = names(sorted_matrix_text), freq = sorted_matrix_text)
head(dataframe_text, 10)
```

Removing the stop words and stemming the rest 

```{r}
cleaned_text = tm_map(text_corpus, removeWords, stopwords("english"))
cleaned_text = tm_map(cleaned_text, stemDocument, language = "english")
cleaned_text = tm_map(cleaned_text, removePunctuation)
cleaned_text = tm_map(cleaned_text, content_transformer(tolower))
cleaned_text = tm_map(cleaned_text, content_transformer(removeNumbers))
cleaned_text = tm_map(cleaned_text, stripWhitespace)
```

Matrix creation for Cleaned Data 

```{r}
TDM_text2 = TermDocumentMatrix(cleaned_text)
matrix_text2 = as.matrix(TDM_text2)
sorted_matrix_text2 = sort(rowSums(matrix_text2), decreasing = TRUE)
dataframe_text2 = data.frame(word = names(sorted_matrix_text2), 
                                    freq = sorted_matrix_text2)
head(dataframe_text2, 10)
```

TDM Vs DTM

```{r}
DTM_text2 = DocumentTermMatrix(cleaned_text)

dim(TDM_text2)
dim(DTM_text2)
```

Plot the most commonly used words based on frequency

```{r}
barplot(sorted_matrix_text2[1:10], las = 2, col = "blue")
```

To Create word cloud, we need the least and max times a word is repeated 

```{r}
summary(sorted_matrix_text2)
```


As per the summary, the total number of words exceeds 11K. 
I will create a word cloud with the first 5000 words that are used. 

```{r}
 wordcloud(cleaned_text, scale = c(5, 0.5), max.words = 500, 
          random.order = FALSE, rot.per = 0.35, use.r.layout = FALSE,
          colors = brewer.pal(8, "PiYG"))
```

REVIEW TITLE 
Moving the title into another dataset.

```{r}
review_title = ecommerce[, 4]
head(review_title,10)
```


Creating a simple vector for the review title 

```{r}
review_title_corpus = Corpus(VectorSource(review_title))
TDM_title = TermDocumentMatrix(review_title_corpus)
```

Create a matrix 

```{r}
matrix_review_title = as.matrix(TDM_title)
sorted_matrix_title = sort(rowSums(matrix_review_title), decreasing = TRUE)
dataframe_review_title = data.frame(word = names(sorted_matrix_title), 
                                    freq = sorted_matrix_title)
head(dataframe_review_title, 10)
```

Removing the stop words and stemming the rest of the title

```{r}
cleaned_review_title = tm_map(review_title_corpus, removeWords, stopwords("english"))
cleaned_review_title = tm_map(cleaned_review_title, stemDocument, language = "english")
cleaned_review_title = tm_map(cleaned_review_title, removePunctuation)
cleaned_review_title = tm_map(cleaned_review_title, content_transformer(tolower))
cleaned_review_title = tm_map(cleaned_review_title, content_transformer(removeNumbers))
cleaned_review_title = tm_map(cleaned_review_title, stripWhitespace)
```

TDM Vs DTM for title

```{r}
TDM_title2 = TermDocumentMatrix(cleaned_review_title)
DTM_title2 = DocumentTermMatrix(cleaned_review_title)

dim(TDM_title2)
dim(DTM_title2)
```

Matrix for cleaned Title data

```{r}
matrix_review_title2 = as.matrix(TDM_title2)
sorted_matrix_title2 = sort(rowSums(matrix_review_title2), decreasing = TRUE)
dataframe_review_title2 = data.frame(word = names(sorted_matrix_title2), 
                                    freq = sorted_matrix_title2)
head(dataframe_review_title2, 10)
```

Plot the title of the most commonly used words 

```{r}
barplot(sorted_matrix_title2[1:10], las = 2, col = "green")

```

Summary for title 

```{r}
summary(sorted_matrix_title2)
```

Word Clouds for most used 1000 words in the Title 

```{r}
wordcloud(cleaned_review_title, scale = c(5, 0.5), max.words = 300, 
          random.order = FALSE, rot.per = 0.35, use.r.layout = FALSE,
          colors = brewer.pal(8, "Accent"))
```


UNIVARIATE ANALYSIS 

```{r}
library(esquisse)

esquisser(ecommerce)

```

Age 

```{r}
library(ggplot2)

ggplot(ecommerce) +
 aes(x = Age) +
 geom_histogram(bins = 30L, fill = "#fdc926") +
 theme_minimal()

```

Age Buckets

```{r}

library(ggplot2)

ggplot(ecommerce) +
 aes(x = Age.Buckets) +
 geom_bar(fill = "#74c476") +
 theme_minimal()

```

Clothing ID 

```{r}
library(ggplot2)

ggplot(ecommerce) +
 aes(x = Clothing.ID) +
 geom_histogram(bins = 30L, fill = "#9c179e") +
 theme_minimal()

```

Rating 

```{r}
ggplot(ecommerce) +
 aes(x = "", y = Rating) +
 geom_violin(adjust = 1.5, scale = "area", fill = "#fba29d") +
 labs(x = "Count of Reviews") +
 theme_minimal()

```

Rating Buckets

```{r}
ggplot(ecommerce) +
 aes(x = Rating.Buckets) +
 geom_density(adjust = 1L, fill = "#bdbdbd") +
 theme_minimal()

```

BIVARIATE ANALYSIS 

Division 

```{r}

library(ggplot2)

ggplot(ecommerce) +
 aes(x = Clothing.ID, y = Age, colour = Division.Name) +
 geom_point(size = 1L) +
 scale_color_hue() +
 theme_minimal() +
 facet_wrap(vars(Division.Name))
```

Department 

```{r}

ggplot(ecommerce) +
 aes(x = Clothing.ID, y = Age, colour = Department.Name) +
 geom_point(size = 1L) +
 scale_color_hue() +
 theme_minimal() +
 facet_wrap(vars(Department.Name))
```
