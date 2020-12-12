---
title: "Supervised Learning"
output: html_notebook
---

Importing Dataset

```{r}
setwd("C:/Users/keshavaa/Documents/R_Working_Apoorva/Capstone")

ecommerce = read.csv("Womens Clothing E-Commerce Reviews-UploadIntoR.csv")

```

Setting Libraries 

```{r}
library(irlba)
library(e1071)
library(caret)
library(randomForest)
library(rpart)
library(rpart.plot)
library(ggplot2)
library(SnowballC)
library(RColorBrewer)
library(wordcloud)
library(biclust)
library(igraph)
library(fpc)
library(quanteda)
library(tm)
```

Converting into corpus

```{r}
allreviewdata = ecommerce[,5]

allreviewdata_corpus = Corpus(VectorSource(allreviewdata))
allreviewdata_corpus = tm_map(allreviewdata_corpus, PlainTextDocument)
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

Create dependent variable 

```{r}
ecommerce$Recommended.IND = as.factor(ecommerce$Recommended.IND)

table(ecommerce$Recommended.IND)
```

DTM creation

```{r}
frequencies = DocumentTermMatrix(cleaned_reviewdata)

inspect(frequencies)
```

Check & Remove Sparcity 

```{r}
findFreqTerms(frequencies, lowfreq = 2000)

sparse = removeSparseTerms(frequencies, 0.98)
```

Convert to Data Frame and add Recommended (Y - Dependent Variable)

```{r}
reviewsparse = as.data.frame(as.matrix(sparse))
colnames(reviewsparse) = make.names(colnames(reviewsparse))

reviewsparse$recommended = ecommerce$Recommended.IND
```

Divide Data into Train & Test

```{r}
library(caTools)

split = sample.split(reviewsparse$recommended, SplitRatio = 0.7)

ReviewTrain = subset(reviewsparse, split == TRUE)
ReviewTest = subset(reviewsparse, split == FALSE)
```

### SUPERVISED LEARNING ###

# Model 1 - CART #

```{r}
ReviewCART = rpart(formula = recommended~., data = reviewsparse, method = "class",
                   control = rpart.control(minsplit = 200, minbucket = 30, cp = 0.0001))

printcp(ReviewCART)
plotcp(ReviewCART)
```

Prune Tree

```{r}
bestcp = ReviewCART$cptable[which.min(ReviewCART$cptable[, "xerror"]), "CP"]
bestcp

pCART = prune(ReviewCART, cp= bestcp)

rpart.plot(pCART, cex = 0.6)
prp(pCART, faclen = 0, cex = 0.5, extra = 2)
```

Size and length are the issues that reviewers are unhappy about. 

# Model 2 - Random Forest #

```{r}
library(randomForest)

reviewRF = randomForest(recommended~., data = reviewsparse)
varImpPlot(reviewRF, cex = 0.7)
```

























