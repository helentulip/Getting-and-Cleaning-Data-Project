## Merge the training and the test sets to create one dataset
setwd("~/Desktop/getting and cleaning data/UCI HAR Dataset")
testData <- read.table("test/X_test.txt")
trainData <- read.table("train/X_train.txt")
X <- rbind(testData, trainData)
rm(testData)
rm(trainData)
testSub <- read.table("test/subject_test.txt")
trainSub <- read.table("train/subject_train.txt")
S <- rbind(testSub, trainSub)
rm(testSub)
rm(trainSub)
testLabel <- read.table("test/y_test.txt")
trainLabel <- read.table("train/y_train.txt")
Y <- rbind(testLabel, trainLabel)
rm(testLabel)
rm(trainLabel)
features <- read.table("features.txt", stringsAsFactors=FALSE)
features <- features$V2

## Extracts only the measuremnets on the mean and standard deviation for each measurement
keeplogic <- grepl("(std|mean[^F])", features, perl=TRUE)
X <- X[, keeplogic]
names(X) <- features[keeplogic]
names(X) <- gsub("\\(|\\)", "", names(X))
names(X) <- tolower(names(X))

## Use descriptive activity names to name the acitivities in the data set
activities <- read.table("activity_labels.txt")
activities[,2] <- gsub("_", "", tolower(as.character(activities[,2])))
Y[,1] <- activities[Y[,1], 2]
names(Y) <- "activity" 

## label the data set with descriptive variable names
names(S) <- "subject"
tidyData <- cbind(S, Y, X)
write.table(tidyData, "tidyData.txt",row.name=FALSE)

## Create second tiny data set with the average of each variable for each activity and each subject
uniqueS <- unique(S)[,1]
num_uniqueS<- length(uniqueS)
num_Activity <- length(activities[,1])
num_Col <- length(names(tidyData))
td <- tidyData[ 1:(nS*nA), ]
row = 1
for (i in 1:num_uniqueS) {
    for (t in 1:num_Activity) {
        td[row,1] = uniqueS[i]
        td[row,2] = activities[t, 2]
        tmp <- tidyData[tidyData$subject==i & tidyData$activity==activities[t,2],]
        td[row, 3:num_Col] <- colMeans(tmp[, 3:num_Col])
        row = row + 1
    }
}
write.table(td, "tidyData2.txt",row.name=FALSE)