GettingAndCleaningData - CourseProject

This is the "Getting and Cleaning Data Coursera" course project. The R script, run_analysis.R, does the following:

Note: Since this is not officially part of the assignment, the R script does not show how contents have been downloaded and unzipped.
This pre-processing has been done previously and data has been extracted and stored in
./UCI HAR Dataset

The overall description of the script has been included into the codeBook, together with steps for obtaining the data and variables.

1. Load feature info, training and test datasets into dataframes. These have been merged to create one data set.
Subject, activity and features have been merged by column for both training and test.
Training and test dataframes have been merged by row to cerate one uniform data set.

2. Extracts only the measurements on the mean and standard deviation for each measurement.
According to features_info.txt: 
The set of variables that were estimated from these signals are: 
 mean(): Mean value
 std(): Standard deviation
Therefore, this "mean()" and "std()" are searched, and not just [Mm]ean|[Ss]td e.g. vars:
 "angle(Z,gravityMean)" or
 "fBodyBodyGyroJerkMag-meanFreq()"
should not be considered

3. activity_labels.txt data has been loaded and used to set descriptive activity names to name the activities in the data set.

4. Variable names have been appropriately labeled to describe them more clearly.

5. An new tidy data set with the average of each variable for each activity and each subject has been created.
For that, activity and subject columns have been used as factors.
The end result is shown in the file final_tidy_data.txt.
