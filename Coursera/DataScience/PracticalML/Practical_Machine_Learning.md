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

```
data(iris)
library(ggplot2)
names(iris)
```

### Split in training and testing

```
inTrain <- createDataPartition(y=iris$Species,
                              p=0.7, list=FALSE)
training <- iris[inTrain,]
testing <- iris[-inTrain,]
```

### Fit model

```
library(caret)
modFit <- train(Species ~ .,method="rpart",data=training)
```

### Plot pretty

```
library(rattle)
fancyRpartPlot(modFit$finalModel)
```

### Predict new values

```
predict(modFit,newdata=testing)
```

## Bagging

### Load data

```
library(ElemStatLearn)
data(ozone,package="ElemStatLearn")
ozone <- ozone[order(ozone$ozone),]
```

### Bagged loess

```
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
```

### Custom bagging

```
plot(ozone$ozone,temperature,col='lightgrey',pch=19)
points(ozone$ozone,predict(treebag$fits[[1]]$fit,predictors),pch=19,col="red")
points(ozone$ozone,predict(treebag,predictors),pch=19,col="blue")
```

## Random forest

### Load Data

```
data(iris)
library(ggplot2)
```

### Split in training and testing

```
inTrain <- createDataPartition(y=iris$Species,
                              p=0.7, list=FALSE)
training <- iris[inTrain,]
testing <- iris[-inTrain,]
```

### Random forest model

```
library(caret)
modFit <- train(Species~ .,data=training,method="rf",prox=TRUE)
modFit
```

### Predict new values

```
pred <- predict(modFit,testing); testing$predRight <- pred==testing$Species
table(pred,testing$Species)
qplot(Petal.Width,Petal.Length,colour=predRight,data=testing,main="newdata Predictions")
```

## Boosting

### Load data

```
library(ISLR)
data(Wage)
library(ggplot2)
library(caret)
Wage <- subset(Wage,select=-c(logwage))
```

### Split training and testing

```
inTrain <- createDataPartition(y=Wage$wage,
                              p=0.7, list=FALSE)
training <- Wage[inTrain,]
testing <- Wage[-inTrain,]

### Fit model
modFit <- train(wage ~ ., method="gbm",data=training,verbose=FALSE)
qplot(predict(modFit,testing),wage,data=testing)
```

## Model based prediction

### Load data

```
data(iris)
library(ggplot2)
names(iris)
```

### Split in training and testing

```
inTrain <- createDataPartition(y=iris$Species,
                              p=0.7, list=FALSE)
training <- iris[inTrain,]
testing <- iris[-inTrain,]

### Build predictors
modlda = train(Species ~ .,data=training,method="lda")
modnb = train(Species ~ ., data=training,method="nb")
plda = predict(modlda,testing); pnb = predict(modnb,testing)
table(plda,pnb)
```

### Compare results

```
equalPredictions = (plda==pnb)
qplot(Petal.Width,Sepal.Width,colour=equalPredictions,data=testing)
```

# Week 4

## Combine predictors

### Load data

```
library(ISLR)
data(Wage)
library(ggplot2)
library(caret)

Wage <- subset(Wage,select=-c(logwage))
```

### Split in training and testing

```
# Create a building data set and validation set
inBuild <- createDataPartition(y=Wage$wage,
                              p=0.7, list=FALSE)
validation <- Wage[-inBuild,]
buildData <- Wage[inBuild,]

inTrain <- createDataPartition(y=buildData$wage,
                              p=0.7, list=FALSE)
training <- buildData[inTrain,]; testing <- buildData[-inTrain,]
```

### Fit models

```
mod1 <- train(wage ~.,method="glm",data=training)
mod2 <- train(wage ~.,method="rf",
              data=training, 
              trControl = trainControl(method="cv"),number=3)
```

### Perform predicition (on testing)

```
pred1 <- predict(mod1,testing)
pred2 <- predict(mod2,testing)
qplot(pred1,pred2,colour=wage,data=testing)
```

### Combine predictors

```
predDF <- data.frame(pred1,pred2,wage=testing$wage)
combModFit <- train(wage ~.,method="gam",data=predDF)
combPred <- predict(combModFit,predDF)
```

### Test errors (on testing)

```
sqrt(sum((pred1-testing$wage)^2))
sqrt(sum((pred2-testing$wage)^2))
sqrt(sum((combPred-testing$wage)^2))
```

### Perform predicition (on validation)

```
pred1V <- predict(mod1,validation); pred2V <- predict(mod2,validation)
predVDF <- data.frame(pred1=pred1V,pred2=pred2V)
combPredV <- predict(combModFit,predVDF)
```

### Test errors (on validation)

```
sqrt(sum((pred1V-validation$wage)^2))
sqrt(sum((pred2V-validation$wage)^2))
sqrt(sum((combPredV-validation$wage)^2))
```

## Forecasting

### Load data

```
library(quantmod)
from.dat <- as.Date("01/01/08", format="%m/%d/%y")
to.dat <- as.Date("12/31/13", format="%m/%d/%y")
getSymbols("GOOG", src="google", from = from.dat, to = to.dat)
```

### Transform

```
mGoog <- to.monthly(GOOG)
googOpen <- Op(mGoog)
ts1 <- ts(googOpen,frequency=12)
plot(ts1,xlab="Years+1", ylab="GOOG")
```

### Decompose

```
plot(decompose(ts1),xlab="Years+1")
```

### Split in training and testing

```
ts1Train <- window(ts1,start=1,end=5)
ts1Test <- window(ts1,start=5,end=(7-0.01))
ts1Train
```

### Forecast

#### Simple moving average

```
plot(ts1Train)
lines(ma(ts1Train,order=3),col="red")
```

#### Expontential smoothing

```
ets1 <- ets(ts1Train,model="MMM")
fcast <- forecast(ets1)
plot(fcast)
lines(ts1Test,col="red")
```

### Forecast accuracy

```
accuracy(fcast,ts1Test)
```

### Unsupervised prediction

1. Create clusters
2. Name clusters
3. Build predictor for clusters

### Load data

```
data(iris)
library(ggplot2)
inTrain <- createDataPartition(y=iris$Species,
                              p=0.7, list=FALSE)
training <- iris[inTrain,]
testing <- iris[-inTrain,]
dim(training); dim(testing)
```

### Cluster with k-means

```
kMeans1 <- kmeans(subset(training,select=-c(Species)),centers=3)
training$clusters <- as.factor(kMeans1$cluster)
qplot(Petal.Width,Petal.Length,colour=clusters,data=training)
```

### Compare clusters to labels

```
table(kMeans1$cluster,training$Species)
```

### Fit model

```
modFit <- train(clusters ~.,data=subset(training,select=-c(Species)),method="rpart")
table(predict(modFit,training),training$Species)
```

### Perform prediction

```
testClusterPred <- predict(modFit,testing) 
table(testClusterPred ,testing$Species)
``
