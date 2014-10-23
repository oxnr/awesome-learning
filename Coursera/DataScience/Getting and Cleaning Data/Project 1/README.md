# Coursera - Getting and Cleaning Course Project

## Assignment

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit:

1. A tidy data set as described below
2. A link to a Github repository with your script for performing the analysis
3. A code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

## Data

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## Script functionality

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## CodeBook

The CodeBook for this project can be found [here](CodeBook.md). It explains the transformations performed and the resulting data and variables in detail.

## Prerequisite

The [UCI HAR Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) data needs to be unpacked and provided in the folder ```UCI HAR Dataset```.
Alternativaly you can just clone this repository where all the data is already provided.

## Run this project

1. Set your working directory in R to where these project files are (or copy to project files to your working directory) using the ```setwd()``` function
2. Run ```source("run_analysis.R")``` to executre the analysis
3. Find a new file called ```tiny_data.txt``` in your working directory

## Dependencies

R needs to be installed on your environment. There no other dependencies for this project.

