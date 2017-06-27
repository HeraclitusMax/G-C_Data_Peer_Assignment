library(reshape2)

filename <- "getdata_dataset.zip"

## Download and unzip the data set:
if (!file.exists(filename)){
        fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
        download.file(fileURL, filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
        unzip(filename) 
}

# Read/load activity labels and features datasets - saved as characters in a dataframe
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# The assignment calls only for the data on mean and standard deviation - extract these using grep() and gsub() to create a character vector
selectFeatures <- grep(".*mean.*|.*std.*", features[,2])
selectFeatures.names <- features[selectFeatures,2]
selectFeatures.names = gsub('-mean', 'Mean', selectFeatures.names)
selectFeatures.names = gsub('-std', 'Std', selectFeatures.names)
selectFeatures.names <- gsub('[-()]', '', selectFeatures.names)

# Load/read the "train" data sets
train <- read.table("UCI HAR Dataset/train/X_train.txt")[selectFeatures]
trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")

# Combine the three "train" data sets
train <- cbind(trainSubjects, trainActivities, train)

# Load/read the "test" datasets
test <- read.table("UCI HAR Dataset/test/X_test.txt")[selectFeatures]
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")

# Combine the three "test" data sets
test <- cbind(testSubjects, testActivities, test)

# Merge all data sets with rbind() and add appropriate labels
FullData <- rbind(train, test)
colnames(FullData) <- c("subject", "activity", selectFeatures.names)

# Convert activities & subjects from characters to factors and then apply data melt
FullData$activity <- factor(FullData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
FullData$subject <- as.factor(FullData$subject)

FullData.melted <- melt(FullData, id = c("subject", "activity"))
FullData.mean <- dcast(FullData.melted, subject + activity ~ variable, mean)

# Create a second tidy data set with the average of each variable for each activity and each subject. Write to new text file. 

write.table(FullData.mean, "tidy.txt", row.names = FALSE, quote = FALSE)