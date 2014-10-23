# Assuming the data has been downloaded and extracted, this file
# will read the data, merge it, extract only relevant subsets, label it
# and finally provide a tidy-data set to run further analysis on.

# Load training data

training = read.csv("UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE)
training[,562] = read.csv("UCI HAR Dataset/train/Y_train.txt", sep="", header=FALSE)
training[,563] = read.csv("UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)

# Load testing data
testing = read.csv("UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)
testing[,562] = read.csv("UCI HAR Dataset/test/Y_test.txt", sep="", header=FALSE)
testing[,563] = read.csv("UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)

# Load activity labels
activityLabels = read.csv("UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)

# Load features
features = read.csv("UCI HAR Dataset/features.txt", sep="", header=FALSE)
features[,2] = gsub('-mean', 'Mean', features[,2])
features[,2] = gsub('-std', 'Std', features[,2])
features[,2] = gsub('[-()]', '', features[,2])

# Merges the training and the test sets to create one data set.
allData = rbind(training, testing)

# Extracts only the measurements on the mean and standard deviation for each measurement.
cols <- grep(".*Mean.*|.*Std.*", features[,2])

# Uses descriptive activity names to name the activities in the data set.

# First reduce the features table to what we want
features <- features[cols,]

# Now add the last two columns (subject and activity)
cols <- c(cols, 562, 563)

# And remove the unwanted columns from allData
allData <- allData[,cols]

# Add the column names (features) to allData
colnames(allData) <- c(features$V2, "Activity", "Subject")
colnames(allData) <- tolower(colnames(allData))

currentActivity = 1
for (currentActivityLabel in activityLabels$V2) {
  allData$activity <- gsub(currentActivity, currentActivityLabel, allData$activity)
  currentActivity <- currentActivity + 1
}

allData$activity <- as.factor(allData$activity)
allData$subject <- as.factor(allData$subject)

tidy_data = aggregate(allData, by=list(activity = allData$activity, subject=allData$subject), mean)

# Remove the subject and activity column, since a mean of those has no use
tidy_data[,90] = NULL
tidy_data[,89] = NULL

# Write tidy_data
write.table(tidy_data, "tidy_data.txt", sep="\t", row.names=FALSE)