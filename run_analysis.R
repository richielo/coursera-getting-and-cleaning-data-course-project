#Downloading the file to the data directory
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

# Unzip the dataset to the data directory
unzip(zipfile="./data/Dataset.zip",exdir="./data")

#Task 1 Merges the training and the test sets to create one data set
    #1.1 reading in data
      #reading training data
      X_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
      Y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
      subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
      #reading testing data
      x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
      y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
      subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
      #reading feature vector
      features <- read.table('./data/UCI HAR Dataset/features.txt')
    
    #1.2 Assigning names to columns
      colnames(subject_train) <- "subjectId"
      colnames(X_train) <- features[, 2]
      colnames(Y_train) <- "activityId"
      colnames(subject_test) <- "subjectId"
      colnames(X_test) <- features[, 2]
      colnames(Y_test) <- "activityId"
      
    #1.3 Merging datasets
      #Merging training data sets into one
        aggregate_train <- cbind(subject_train, Y_train, X_train)
      #Merging testing data sets into one
        aggregate_test <- cbind(subject_test, Y_test, X_test)
      #Merging the aggregate data of training and testing into one
        all_combined <- rbind(aggregate_train, aggregate_test)
        
#Task 2 Extracts only the measurements on the mean and standard deviation for each measurement.
    #2.1 Extracting column names
      colNames <- colnames(all_combined)
        
    #2.2 Creating a boolean vector indicating which columns are measuring on the mean or standard deviation, while retaining the column of subjectId and activityId
      mean_std_vec <- (grepl("subjectId" , colNames) | grepl("activityId" , colNames) | grepl("mean.." , colNames) | grepl("std.." , colNames))
        
    #2.3 Subsetting the dataset we need with thr boolean vector
      mean_std_combined <- all_combined[, mean_std_vec == TRUE]
        
#Task 3 Uses descriptive activity names to name the activities in the data set
    #3.1 reading in the activity labels
      activityLabels = read.table('./data/UCI HAR Dataset/activity_labels.txt')
    
    #3.2 assigning names to columns of activityLabels
      colnames(activityLabels) = c("activityId", "activityName")
    #3.3 Merging mean_std_combined with the activityLabels
      mergedWithActivityName <- merge(mean_std_combined, activityLabels, by = "activityId", all.x = TRUE)

#Task 4 Appropriately labels the data set with descriptive variable names.
      #Done in previous steps
      
#Task 5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
    #5.1 load the reshape2 library, use "install.packages" first if the library is not installed
      library(reshape2)
      
    #5.2 Melt the mergedWithActivityName dataset with subjectId, activityId and activityName as Id
      tidyData <- melt(mergedWithActivityName, id.vars = c("subjectId", "activityId", "activityName"))
      
    #5.3 Use dcast to find the average of each variable for each activity and each subject
      tidyData <- dcast(tidyData, subjectId + activityId + activityName ~ variable, mean)
    #5.4 Write the data to a text file
      write.table(tidyData, "tidyData.txt", row.name=FALSE)
        