# CodeBook

## Data Source
Data for this project can be found here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip   

## Project Progress
The run_analysis.R script does the following to the original data:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3.Uses descriptive activity names to name the activities in the data set
4.Appropriately labels the data set with descriptive variable names. 
5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Main Data variables
Throughout this script, the data from the source is manipulated, cleaned and consolidated. At the end of step 5, we are left with data that are focused on
the following variables:
- **Subject**: Denotes the subject whose data corresponds to the other values (valued between 1 and 30)
- **Activity**: Activity type the subject was performing (can range between any of the following: walking, walking upstairs, walking downstairs, sitting, standing,
and laying.
- **Accelerometer**: All data received from the acclerometer colleced while the subject was performing the activity 
- **Gyroscope**: All data recevied from the gyroscope collected while subject was performing the activity 

