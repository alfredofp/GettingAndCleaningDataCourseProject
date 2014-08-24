##Introduction

The script run_analysis.R

* downloads the data from "UCI Machine Learning Repository"
* merges the training and test sets to create one data set
* replaces "activity" values in the dataset with descriptive activity names
* extracts only the measurements (features) on the mean and standard deviation for each measurement
* appropriately labels the columns with descriptive names
* creates a second, independent tidy dataset with an average of each variable for each each activity and each subject. In other words, same type of measurements for a particular subject and activity are averaged into one value and the tidy data set contains these mean values only. The processed tidy data set is also exported as csv file.

##run_analysis.R
All the steps mentioned above are integrated within the script and performed sequentially. The script also assumes that "plyr" library is already installed.

##The original data set
The original data set is split into training and test sets (70% and 30%, respectively) where each partition is also split into three files that contain

* measurements from the accelerometer and gyroscope
* activity label
* identifier of the subject

##Main variables
* activityLabels, character vector[1x6] containing tidy labels for activity.
* properNames, character vector[1x561] containing tidy measurement names for each observation.
* [test/train]ActivityLabels, character vector[1xlength(number of observations for dataset)] containing the activity corresponding to each observation, within activityLabels range.
* data[Test/Train], dataframes [2947x563], [7352x563] containing observations for each measurement, two rows have been added to these dataframes, measurement name and subject.
* tidy[Test/Train], dataframes [2947x88], [7352x88],obtained from both previous, in which only measurements related to mean or sdv are maintained.
* tidyData, dataframe merge of both previous, [2947x88].
* result, vector[180x88] containing the mean for each variable contained in tidyData by subject and activity.

##Getting and cleaning data
If the data is not already available in the data directory, it is downloaded from UCI repository.

The first step is to obtaining data from files, and add descriptive names to column names, also activity labels are replaced with descriptive activity names, defined in "activity_labels.txt" in the original data folder.

The next step of the preprocessing is to merge the training and test sets. Two sets combined, there are approximately 10,000 observations where each instance contains 561 features (560 measurements and subject identifier). After the merge operation the resulting data, the table contains 562 columns (560 measurements, subject identifier and activity label have been added).

After the merge operation, mean and standard deviation features are extracted for further processing. Out of 560 measurement features, mean and standard deviations features are extracted, yielding a data frame with 88 features (additional two features are subject identifier and activity label).

The final step creates a tidy data set with the average of each variable for each activity and each subject. All observations are split into groups (the number of groups  depends on the number of subjects and activities) and mean and standard deviation features are averaged for each group. The resulting data table has 54 rows and 88 columns.