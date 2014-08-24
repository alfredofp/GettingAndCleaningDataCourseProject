## run_analysis.R
## Getting and Cleaning Data course assignment.
##
## 1.Merges the training and the test sets to create one data set.
## 2.Extracts only the measurements on the mean and standard deviation for each
## measurement. 
## 3.Uses descriptive activity names to name the activities in the data set
## 4.Appropriately labels the data set with descriptive variable names. 
## 5.Creates a second, independent tidy data set with the average of each 
## variable for each activity and each subject. 

## library used to apply mean function to the tidy dataset, ddply function
library(plyr)

## data is read
dataTest <- read.table("./UCIHARDataset/test/X_test.txt")
dataTrain<- read.table("./UCIHARDataset/train/X_train.txt")

##variable names
variableNames <- readLines("./UCIHARDataset/features.txt")

## variableNames corresponds to the names of columns within datasets, so 
## for the sake of clarity, the column names are changed

## before changing the name, we obtain a tidy name from the variableNames
## strings splitted by " ", we retain the second element
properNames <- sapply(strsplit(variableNames, " "), function(x){x[2]})
names(dataTest) <- properNames
names(dataTrain) <- properNames

## test and training labels are read
testLabels <- as.numeric (readLines("./UCIHARDataset/test/y_test.txt"))
trainLabels <- as.numeric (readLines("./UCIHARDataset/train/y_train.txt"))

## and so are their names, by removing their numbers
activityLabels <- readLines("./UCIHARDataset/activity_labels.txt")
activityLabels <- sapply(strsplit(activityLabels, " "), function(x){x[2]})

## numbers in testLabels and trainLabels corresponds to activities
## described within activityLabels, we are going to replace the numbers 
## for the corresponding activity
replacebyname <- function(x, names){names[x]}
testActivityLabels <- sapply (testLabels, replacebyname, names=activityLabels)
trainActivityLabels <- sapply (trainLabels, replacebyname, names=activityLabels)
## a column is added to each dataset including the activity
dataTest$activity <-testActivityLabels
dataTrain$activity <-trainActivityLabels


## subject Id labels are read
subjectTest <- readLines("./UCIHARDataset/test/subject_test.txt")
subjectTrain <- readLines("./UCIHARDataset/train/subject_train.txt")

## and added as another column.
dataTest$subject <-subjectTest
dataTrain$subject<- subjectTrain


## only columns related to mean or std are maintained in tidy dataset
tidyTest <- dataTest[grep(".*[mM]ean.*|.*[sS]td.*|activity|subject", 
                          names(dataTest))]
tidyTrain <- dataTrain[grep(".*[mM]ean.*|.*[sS]td.*|activity|subject", 
                          names(dataTrain))]

##and data is joined into one dataset.
tidyData<- rbind (tidyTrain, tidyTest)

## the mean for each variable, subject and activity is obtained
result <- ddply(tidyData, .(activity, subject), numcolwise(mean))

## the result is stored into a .txt file
write.table(result, file="./tidymeanstd.txt",row.name=FALSE, sep = "\t", append=F)
