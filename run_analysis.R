install.packages("reshape")
library(reshape)
library(tidyr)
library(dplyr)

#Loading information
volActiveLabels <- read.table("UCI Har Dataset/readme/activity_labels.txt")
volFeatures <- read.table("UCI Har Dataset/readme/features.txt")

#Extracting data and mean
volFeaturesNeeded <- grep(".mean.*|.std.*", volFeatures)
volFeaturesNeeded = gsub('-mean', 'Mean', volFeaturesNeeded)
volFeaturesNeeded = gsub('-std', 'STD', volFeaturesNeeded)

#Loading both datasets
train <- read.table("UCI HAR Dataset/train/X_train.txt")
trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainActivities, train)

test <- read.table("UCI HAR Dataset/test/X_test.txt")
testActivites <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testActivites, testSubjects, test)

#Combining the sets
combinedSets <- rbind(train, test)
colnames(combinedSets) <- c("subject", "activity", volFeaturesNeeded)

#Factoring the sets
combinedSets$subject <- as.factor(combinedSets$subject)
combinedSets$activity <- as.factor(combinedSets$activity)

#Melting data
meltedData <- melt(combinedSets, id=c("subject", "activity"))
tidyData <- dcast(meltedData, Subject + Activity ~ variable, mean)

#Writing to the tidy.txt file
write.table(combinedSets, "tidy.txt", row.names=FALSE, quote=FALSE)
