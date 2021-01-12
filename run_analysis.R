library(reshape2)
library(tidyr)
library(dplyr)

filename <- "getdata_projectfiles_UCI HAR Dataset.zip"

if (!file.exists("UCI Har Dataset"){
  unzip(filename)
}

volActiveLabels <- read.table("UCI Har Dataset//activity_labels.txt")
volFeatures <- read.table("UCI Har Dataset//features.txt")

volFeaturesNeeded <- grep(".mean.*|.std.*, volFeatures)
volFeaturesNeeded = gsub('-mean', 'Mean', volFeaturesNeeded)
volFeaturesNeeded = gsub('-std', 'STD', volFeaturesNeeded)

train <- read.table("UCI HAR Dataset//train//X_train.txt")
trainActivities <- read.table("UCI HAR Dataset//train//Y_train.txt")
trainSubjects <- read.table(UCI HAR Dataset//train//subject_train.txt")
train <- cbind(trainSubjects, trainActivities, train)

test <- read.table("UCI HAR Dataset//test//X_test.txt")
testActivites <- read.table("UCI HAR Dataset//test//Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset//test//subject_test.txt")
test <- cbind(testActivites, testSubjects, test)

combinedSets <- rbind(train, test)
colnames(combinedSets) <- c("Subject", Activity", volFeaturesNeeded)
combinedSets$Subject <- as.factor(combinedSets$Subject)
combinedSets$Activity <- as.factor(combinedSets$Activity)
combinedSets.melted <- melt(combinedSets, id = c("Subject", "Activity"))
combinedSets.mean <- dcast(combinedSets.melted, Subject+Activity ~ variable, mean)

write.table(combinedSets.mean, "tidy.txt", row.names=FALSE, quote=FALSE)
