
## Kim Taylor
## Getting and Cleaning Data Course Project
## The following script performs instructions listed below:

##  NOTE:
#  Working directory must include the unzipped files from UCI downloadable here:
#  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 


######################################################################################
#   
#    INSTRUCTIONS:
#
#     You should create one R script called run_analysis.R that does the following. 
#
#     1. Merges the training and the test sets to create one data set.
#     2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#     3. Uses descriptive activity names to name the activities in the data set
#     4. Appropriately labels the data set with descriptive variable names. 
#     5. From the data set in step 4, creates a second, independent tidy data set with the 
#         average of each variable for each activity and each subject.
#
######################################################################################

## Read the files into R
features <- read.table("features.txt")
activity <- read.table("activity_labels.txt")
subjecttrain <- read.table("train/subject_train.txt")
xtrain   <- read.table("train/x_train.txt")
ytrain   <- read.table("train/y_train.txt")
subjecttest <- read.table("test/subject_test.txt")
xtest    <- read.table("test/X_test.txt")
ytest    <- read.table("test/Y_test.txt")

##  Add column names from features data frame:
colnames(xtrain) <- features[,2]
colnames(xtest)  <- features[,2]

## Add column names to activity and ytrain
colnames(activity)  <- c("activity_id", "activity")
colnames(ytrain)    <- c("activity_id")
colnames(ytest)     <- c("activity_id")
colnames(subjecttest) <- "subject_id"
colnames(subjecttrain) <- "subject_id"

#Add the activity_id col (y data frames) to train data (x data frames) and create new data frames
xytrain <-cbind(ytrain, subjecttrain, xtrain)
xytest  <-cbind(ytest, subjecttest, xtest)


#### Requirement 1.Merge the training and the test sets to create one data set:

#combine the two data frames into one 
har_data <- rbind(xytrain, xytest)

columns <- colnames(har_data)

#### Requirement 2. Extract only the measurements on the mean and standard deviation for each measurement:

## Create a logical vector for mean/std column names = TRUE
keep <- (grepl("activity..",columns) | grepl("subject..", columns) | grepl("-mean..",columns) & !grepl("-meanFreq..",columns) & !grepl("mean..-",columns) | grepl("-std..",columns) & !grepl("-std()..-",columns));

#filter for mean and standard deviation columns w logical vector
all_har_data <- har_data[keep==TRUE]

#####  Requirement 3. Use descriptive activity names to name the activities in the data set:

# Add activity names to data set by merging activity table with data set on activity_id
all_har_data = merge(activity, all_har_data, by='activity_id');


####  Requirement 4: Appropriately label the data set with descriptive variable names: 

## Get the current list of column names:
columns <- colnames(all_har_data)

##  Loop through column name list to delete incorrect characters and make the column names more readable.  
##  Left the "time" and "freq", as well as the "mean", and "std" lowercase and added the underscore so they stand out.

for (i in 1:length(columns)) 
{
  columns[i] = gsub("\\()","",columns[i])
  columns[i] = gsub("-std","_stdDev",columns[i])
  columns[i] = gsub("-mean","_mean",columns[i])
  columns[i] = gsub("^(t)","time_",columns[i])
  columns[i] = gsub("^(f)","freq_",columns[i])
  columns[i] = gsub("(BodyBody)","Body",columns[i])
  columns[i] = gsub("Mag","Magnitude",columns[i])
  
}

## Replace column names with edited column names:
colnames(all_har_data) = columns


####  Requirement 5. From the data set in step 4, creates a second, independent tidy data set with the 
####  average of each variable for each activity and each subject:

## Calculate the mean for the activity:
activityMean<-aggregate(all_har_data[,4:21], list(all_har_data$activity), mean)
## calculate the mean for each subject:
subjectMean<-aggregate(all_har_data[,4:21], list(all_har_data$subject_id), mean)

## change column names for clarity:
colnames(activityMean)[names(activityMean)=="Group.1"] = "Observations"
colnames(subjectMean)[names(subjectMean)=="Group.1"] = "Observations"

## make sure observations column in subjectMeans is factor
subjectMean$Observations <- as.factor(subjectMean$Observations)

## join two sets of observation means:
finalData <- rbind(activityMean, subjectMean)

## export finaldata set:
write.table(finalData, file="finalData.txt", row.name = FALSE)


