## Types of Machine Learning

1. Supervised learning (we teach the computer how to learn)
  Regression: Predict a continuous valued output.
  Linear regression with one variable aka. Univariate linear regression.
    Goal is to minimize cost function -> Gradient descent (optimize local minimum)

  Classification: Discrete valued output (0 or 1).

2. Unsupervised learning (the computer learns itself)
  Clustering: Clustering news or market segments

3. Reinforcement learning

4. Recommender systems

## Features scaling

Make features fit into a rang between -1 and 1 so they converge faster

To do so divide them by the maximum possible value in the featureset

A range between -3 and 3  or -1/3 and 1/3 seems ok

## Mean normalization

Make features have approximately 0 mean

## Classification with Logistic regression

Predict a discrete valued variable (0[negative] or 1[positive])

Linear regression not suitable for several reasons (i.e. h0(x) can be > 1 or < 0)

Logistic regression is one of the most popular techniques which suits this kind of problem

Logistic regression is a classification algorithm

### Hypothesis representation

Logistic regression wants 0 <= h0(x) <= 1

Based on Sigmoid function aka. logistic function

#### Interpretation of Hypothesis output

h0(x) = estimated probability that y = 1 on input x

h0(x) = 0.7

Chance of 70% of beeing positive (1)

Probability that y = 0 + y = 1 must add up to 1

### Optimization algorithms

* Gradient descent

* Conjugate gradient
* BFGS
* L-BFGS

Advantages

* No need to manually pick alpha (clever inner-loop)
* Converge often fast than gradient descent

Disadvantages

* More complex

### Multiclass classification

* Automatic categorization (work, friends, family, hobby)
* Weather categorization (sunny, cloudy, rain, snow)

## Regularization

Problem of underfitting and high bias (linear regression)

Problem of overfitting and high variance (high order polynomio functions)

### Overfitting

If we have too many features, the learned hyptohesis may fit training set very well, but fail to generalize to new exampes (predict prices on new exampes)

#### Addressing overfitting

1. Reduce number of features

* Manually select which features to keep
* Model selection algorithm

2. Regularization

* Keep all the features, but reduce magnitude/values of parameters 0j
* Works well when we have a lot of features, each of which contributes a bit to predicting y

Small values for parameters, correspond in having a **simpler hypothesis**

## Neuronal Networks

Complex non-linear hypothesis become to complex and big when n is large

Neuronal networks was originally motivated by the goal of having algorithms mimic the brain

The "one learning algorithm" hypothesis like different cortex in the brain







