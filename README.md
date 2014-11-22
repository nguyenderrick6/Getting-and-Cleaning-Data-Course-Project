Getting-and-Cleaning-Data-Course-Project
========================================
The data represented is collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The data for the project was downloaded from this url:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The download and unzip of the file has been commented out of the run_analysis.R script.

The R script called run_analysis.R does the following.
-Reads all the training files into a list, and all the test files into a list.
-Row binds the elements of the training and the test list to create one list with long elements.
-Extracts only the measurements on the mean and standard deviation for each measurement. 
-Use activity_labels.txt to name the activities in the data set located in y.
-Appropriately use features.txt with descriptive variable names to label all x_test and x_train.
-Column binds the elements of the list together to get one data frame of x, subject, and activities.
-From that data, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
-the second independent tidy data set is created with write.table()
