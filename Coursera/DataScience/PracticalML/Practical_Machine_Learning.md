# Week 1

## Overview

Signal (what you want to predict) vs. noise (random variation in data set)
Goal = find signal and ignore noise
Problem of overfitting when creating a perfect in-sample prediction

## Requirements

Simplicity
Interpretability
Accuracy
Scalability
Fast / Speed

## Prediction design

1. Define error rate
2. Split data into Training, Testing and Validation
3. Pick training datas features (cross validation)
4. Pick training datas prediction function (cross validation)
5. Apply test set and refine / apply 1x to validation

## Data size splitting

large data
60% training
20% test
20% validation

medium data
60% training
40% tessting

## Result types

positive = identified
negative = rejected

True positives = correctly identified
False positive = incorrectly identified
True negative = correclty rejected
False negative = incorrectly rejected

## Cross validation approach

1. Use the training set
2. Split it into training/test sets
3. Build a model on the training set
4. Evaluate on the test set
5. Repeat and average the estimated errors

Useful for picking varliables in the model, pick the prediction function, pick the parameters in the prediction function and compare it all.

Approaches to split training data in training and test data.

- Random subsampling
- K-fold
- Leave one out

For time series data, data must be used in "chunks"

# Week 3

## Predicting with trees

### Load data
data(iris); library(ggplot2)
names(iris)

### Split in training and testing
inTrain <- createDataPartition(y=iris$Species,
                              p=0.7, list=FALSE)
training <- iris[inTrain,]
testing <- iris[-inTrain,]

### Fit model
library(caret)
modFit <- train(Species ~ .,method="rpart",data=training)

### Plot pretty
library(rattle)
fancyRpartPlot(modFit$finalModel)

### Predict new values
predict(modFit,newdata=testing)

## Bagging

### Load data
library(ElemStatLearn); data(ozone,package="ElemStatLearn")
ozone <- ozone[order(ozone$ozone),]

### Bagged loess
ll <- matrix(NA,nrow=10,ncol=155)
for(i in 1:10){
  ss <- sample(1:dim(ozone)[1],replace=T)
  ozone0 <- ozone[ss,]; ozone0 <- ozone0[order(ozone0$ozone),]
  loess0 <- loess(temperature ~ ozone,data=ozone0,span=0.2)
  ll[i,] <- predict(loess0,newdata=data.frame(ozone=1:155))
}

plot(ozone$ozone,ozone$temperature,pch=19,cex=0.5)
for(i in 1:10){lines(1:155,ll[i,],col="grey",lwd=2)}
lines(1:155,apply(ll,2,mean),col="red",lwd=2)

### Custom bagging

plot(ozone$ozone,temperature,col='lightgrey',pch=19)
points(ozone$ozone,predict(treebag$fits[[1]]$fit,predictors),pch=19,col="red")
points(ozone$ozone,predict(treebag,predictors),pch=19,col="blue")

## Random forest

### Load Data
data(iris)
library(ggplot2)

### Split in training and testing
inTrain <- createDataPartition(y=iris$Species,
                              p=0.7, list=FALSE)
training <- iris[inTrain,]
testing <- iris[-inTrain,]

### Random forest model
library(caret)
modFit <- train(Species~ .,data=training,method="rf",prox=TRUE)
modFit

### Predict new values
pred <- predict(modFit,testing); testing$predRight <- pred==testing$Species
table(pred,testing$Species)
qplot(Petal.Width,Petal.Length,colour=predRight,data=testing,main="newdata Predictions")

## Boosting

### Load data
library(ISLR)
data(Wage)
library(ggplot2)
library(caret)
Wage <- subset(Wage,select=-c(logwage))

### Split training and testing
inTrain <- createDataPartition(y=Wage$wage,
                              p=0.7, list=FALSE)
training <- Wage[inTrain,]
testing <- Wage[-inTrain,]

### Fit model
modFit <- train(wage ~ ., method="gbm",data=training,verbose=FALSE)
qplot(predict(modFit,testing),wage,data=testing)

## Model based prediction

### Load data
data(iris)
library(ggplot2)
names(iris)

### Split in training and testing
inTrain <- createDataPartition(y=iris$Species,
                              p=0.7, list=FALSE)
training <- iris[inTrain,]
testing <- iris[-inTrain,]

### Build predictors
modlda = train(Species ~ .,data=training,method="lda")
modnb = train(Species ~ ., data=training,method="nb")
plda = predict(modlda,testing); pnb = predict(modnb,testing)
table(plda,pnb)

### Compare results
equalPredictions = (plda==pnb)
qplot(Petal.Width,Sepal.Width,colour=equalPredictions,data=testing)
