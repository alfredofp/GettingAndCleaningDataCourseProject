
# Preconditions
# Zip has been downloaded and extracted into ./UCI HAR Dataset
#

# loading package
library(dplyr)

##############
# STEP1 Merges the training and the test sets to create one data set.

# Reading contents
datafeatures <- read.table("./UCI HAR Dataset/features.txt", 
                           col.names = c("n","features"))

# reading training (70% subjects, i.e. 21)
subject_training <- read.table("./UCI HAR Dataset/train/subject_train.txt",
                              col.names = "subject")
# dim(subject_train)
# dim 7352, values between 1 to 30, identifies only 21 subjects

training_features <- read.table("./UCI HAR Dataset/train/X_train.txt")
names(training_features)<-datafeatures$features

# dim (train_set)
# 7352 561
# identifies the value of each feature for every subject

training_activities <- read.table("./UCI HAR Dataset/train/y_train.txt",
                                  col.names = "activity")
# dim(training_activities)
# 7352
# Values from 1 to 6
# identifies the activity for each measure for every subject

# merge training datasets
training_data <- cbind(subject_training, training_activities, training_features)

# reading test (30% subjects, i.e. 9)
# same structure than before with training
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", 
                           col.names = "subject")
# dim(subject_test)
# dim 2947, values between 1 to 30, identifies only 9 subjects

test_features <- read.table("./UCI HAR Dataset/test/X_test.txt")
names(test_features)<-datafeatures$features

# dim(test_features)
# 2947  561
# identifies the value of each measure for every subject

test_activities <- read.table("./UCI HAR Dataset/test/y_test.txt",
                              col.names = "activity")
# dim(test_activities)
# 2947
# Values from 1 to 6
# identifies the activity for each measure for every subject

# merge test datasets by column
test_data <- cbind(subject_test, test_activities, test_features)

# merge training and test datasets, but by rows (columns must match)
dataset <- rbind(training_data, test_data)

#dim(dataset)
#10299   563
#where training data is above and test data is appended below

##############
# Step 2. Extracts only the measurements on the mean and standard 
# deviation for each measurement.

# We keep subject and activity, apart from the mean and std measurements

# According to features_info.txt: 
# The set of variables that were estimated from these signals are: 
# mean(): Mean value
# std(): Standard deviation
# ...

# Therefore, this "mean()" and "std()" are searched, 
# and not just [Mm]ean|[Ss]td e.g. vars:
# "angle(Z,gravityMean)" or
# "fBodyBodyGyroJerkMag-meanFreq()"
# should not be considered

reduced_dataset <- dataset[,grep("subject|activity|[Mm]ean\\(\\)|[Ss]td\\(\\)", 
                                 names(dataset))]

##############
# Step 3. Uses descriptive activity names to name the activities in
# the data set

# reading correspondence
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt",
                              col.names = c("code", "activity"))

# replacing codes (i.e. index) by activity names
reduced_dataset$activity<-factor(reduced_dataset$activity, 
                                 levels = activity_labels$code, 
                                 labels = activity_labels$activity)

##############
# Step 4. Appropriately labels the data set with descriptive variable names.

reduced_names <- names(reduced_dataset)

reduced_names <- gsub("^t", "time", reduced_names)
reduced_names <- gsub("^f", "frequency", reduced_names)
reduced_names <- gsub("Acc", "Accelerometer", reduced_names)
reduced_names <- gsub("Gyro", "Gyroscope", reduced_names)
reduced_names <- gsub("Mag", "Magnitude", reduced_names)
reduced_names <- gsub("BodyBody", "Body", reduced_names)

# apply reduced_names to dataset
names(reduced_dataset) <- reduced_names

##############
# Step 5. From the data set in step 4, creates a second, independent tidy data
# set with the average of each variable for each activity and each subject.

new_dataset <- aggregate(. ~subject + activity, reduced_dataset, mean)
new_dataset <- new_dataset[order(new_dataset$subject,new_dataset$activity),]
write.table(new_dataset, file = "final_tidy_data.txt",row.name=FALSE)

# all files to upload are stored within gettingAndCleaningDataProject dir.

