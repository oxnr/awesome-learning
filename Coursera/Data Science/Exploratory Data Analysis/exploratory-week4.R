# Load dataset
load("data/samsungData.rda")
names(samsungData)[1:12]

table(samsungData$activity)

# Plotting average acceleration for fist subject
par(mfrow = c(1, 2), mar = c(5, 4, 1, 1))
samsungData <- transform(samsungData, activity = factor(activity))
sub1 <- subset(samsungData, subject == 1)
plot(sub1[, 1], col = sub1$activity, ylab = names(sub1)[1])
plot(sub1[, 2], col = sub1$activity, ylab = names(sub)[2])
legend("bottomright", legend = unique(sub1$activity), col = unique(sub1$activity), pch = 1)

source("myplclust.R")
distanceMatrix <- dist(sub1[, 1:3])
hclustering <- hclust(distanceMatrix)
myplclust(hclustering, lab.col = unclass(sub1$activity))