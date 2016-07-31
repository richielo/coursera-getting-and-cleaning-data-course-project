## Getting and Cleaning Data Project

Author: Richie Lo

This is the Repo for the submission of the course project for the Johns Hopkins Getting and Cleaning Data course.

### Overview
This project serves to demonstrate the collection and cleaning of a tidy data set that can be used for subsequent
analysis. A full description of the data used in this project can be found at [The UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

[The source data for this project can be found here.](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

### Project Summary
The following is a summary description of the project instructions

You should create one R script called run_analysis.R that does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

### Script Summary
The required script of R Code "run_analysis.R" perform the tasks as described in the project summary:
0. Downloading and upzipping the datasets
1. Merges the training and the test sets to create one data set
	1. reading in data(including the training set, testing set and features vector)
	2. Assigning names to columns
	3. Merging datasets
2. Extracts only the measurements on the mean and standard deviation for each measurement.
    1. Extracting column names
	2. Creating a boolean vector indicating which columns are measuring on the mean or standard deviation, while retaining the column of subjectId and activityId
	3. Subsetting the dataset we need with thr boolean vector
3. Uses descriptive activity names to name the activities in the data set
    1. reading in the activity labels
	2. assigning names to columns of activityLabels
	3. Merging the resulting dataset of task 2 with the activityLabels by activityId
4. Appropriately labels the data set with descriptive variable names.
    ##Done in previous steps
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
    1. load the reshape2 library, use "install.packages" first if the library is not installed
	2. Melt the resulting dataset of task 4 with subjectId, activityId and activityName as Id
	3. Use dcast to find the average of each variable for each activity and each subject
	4. Write the data to a text file withe a name tidyData.txt

### Additional Information
You can find additional information about the variables, data and transformations in the CodeBook.MD file.
