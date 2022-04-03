---
title: "CodeBook"
author: "alfredofp"
date: "03 4 2022"
output: html_notebook
---

This code book summarizes the results obtained in the tidy data set of the project, as well as any other summaries calculated.

The script run_analysis.R uses data from "UCI Machine Learning Repository", merges the training and test sets to create one data set,
replaces "activity" values in the dataset with descriptive activity names.
This script extracts only the measurements (features) on the mean and standard deviation for each measurement, appropriately labels the columns with descriptive names, and creates a second, independent tidy dataset with an average of each variable for each each activity and each subject. In other words, same type of measurements for a particular subject and activity are averaged into one value and the tidy data set contains these mean values only. The processed tidy data set is also exported as csv file.

All the steps mentioned above are integrated within the script and performed sequentially. The script also assumes that "dplyr" library is already installed.

The original data set is split into training and test sets (70% and 30%, respectively) where each partition is also split into three files that contain measurements from the accelerometer and gyroscope
activity label identifier of the subject.

# Main variables
. datafeatures, character vector[2x561] containing tidy measurement names for each observation. 

TRAINING INFORMATION:
. subject_training, character vector [7352x1](containing integers) that contain the subject of the observation from 1 to 30.
. training_features, dataframe [7352x561] containing observations for each feature for training subjects and different activities
. training_activities, character vector [7352x1], being 7352 the number of training observations containing the activity corresponding to each observation, within activityLabels range.
. training_data, dataframe [7352x563] containing training data. i.e. subject_training, training_activities and training_features

TEST INFORMATION:
. subject_test, character vector [2947x1](containing integers) that contain the subject of the observation from 1 to 30.
. test_features, dataframe [2947x561] containing observations for each feature for test subjects and different activities
. test_activities, character vector [2947x1], being 2947 the number of test observations containing the activity corresponding to each observation, within activityLabels range.
. test_data, dataframe [2947x563] containing test data. i.e. test_training, test_activities and test_features

MERGING DATASETS:
After the merge operation, mean and standard deviation features are extracted for further processing. 
. dataset, dataframe [10299x563], merge of both training_data and test_data containing all the observations. Both dataframes are compatible with the same columns with the same names.

FILTERING DATASET:
. reduced_dataset, dataframe dataset filtered by column to elements which contain either mean() or std().
Please note only "mean()" and "std()" are searched, and not just [Mm]ean|[Ss]td e.g. vars "angle(Z,gravityMean)" or "fBodyBodyGyroJerkMag-meanFreq()" are not considered.

. activityLabels, character vector[2x6] containing tidy labels for every activity.

. reduced_names, temporal character vector used to adequately set up descriptions of variables

## NEW TIDY DATASET
. new_dataset, new dataframe [180x68] containing the mean for each variable, factorized by subject and activity.
Since there are 30 subjects and 6 activities, there are 180 rows.
The number of columns, 68, corresponds to the number of filtered features previously in reduced_dataset.

Data is exported to final_tidy_data.txt
