## Requirements

Simplicity
Interpretability
Accuracy
Scalability
Fast / Speed
# Week 1

## Overview

Signal (what you want to predict) vs. noise (random variation in data set)
Goal = find signal and ignore noise
Problem of overfitting when creating a perfect in-sample prediction

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
