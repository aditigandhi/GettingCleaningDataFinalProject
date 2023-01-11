#Load required packages
library(tidyr)
library(dplyr)

#Read the data in

#FEATURE
features <- read.table("UCI HAR Dataset/features.txt", 
                       col.names = c("number", "feature"))

#ACTIVITY
activities <- read.table("UCI HAR Dataset/activity_labels.txt", 
                       col.names = c("number", "activity"))

# TEST

X_test <- read.table("UCI HAR Dataset/test/X_test.txt", 
                     col.names = features$feature)

y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "activity")

# TRAIN

X_train <- read.table("UCI HAR Dataset/train/X_train.txt", 
                      col.names = features$feature)

y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "activity")

# SUBJECT
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", 
                           col.names = c("subject"))
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", 
                            col.names = c("subject"))

# Merge the training and test datasets to make one dataset
all_X <- rbind(X_test, X_train)
all_Y <- rbind(y_test, y_train)
all_Subject <- rbind(subject_test, subject_train)
data <- data.frame(all_Subject, all_Y, all_X)


#Extracts only the measurements on the mean and standard deviation for 
#each measurement. 
mean_std_cols <- grep("mean|std", colnames(data), value = TRUE)
parsed <- select(data, subject, activity, all_of(mean_std_cols))


#Uses descriptive activity names to name the activities in the data set
parsed$activity <- activities[parsed$activity, "activity"]

#Appropriately labels the data set with descriptive variable names. 
colnames(parsed)[1] <- "Subject"
colnames(parsed)[2] <- "Activity"
colnames(parsed) <- gsub("Acc", "Accelerometer", colnames(parsed) )
colnames(parsed) <- gsub("mean", "Mean", colnames(parsed) )
colnames(parsed) <- gsub("std", "StandardDeviation", colnames(parsed) )
colnames(parsed) <- gsub("Gyro", "Gyroscope", colnames(parsed) )
colnames(parsed) <- gsub("Mag", "Magnitude", colnames(parsed) )
colnames(parsed) <- gsub("Freq", "Frequency", colnames(parsed) )
colnames(parsed) <-  gsub("^t", "Time", colnames(parsed) )
colnames(parsed) <-  gsub("^f", "Frequency", colnames(parsed) )
colnames(parsed) <-  gsub("BodyBody", "Body", colnames(parsed) )


#From the data set in step 4, creates a second, independent tidy data set 
#with the average of each variable for each activity and each subject.

grouped <- group_by(parsed, Subject, Activity)
groupedMean <- summarize_all(grouped, mean)

# Write out to table for submission
write.table(groupedMean, "ProjectSubmission.txt", row.name=FALSE)

