# Getting-and-Cleaning-Data
For Coursera class, Getting and Cleaning Data

The script, run_analysis.R, performs the following actions on Human Activity Recognition data (details here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) downloaded from this link: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip , unzipped and in the working directory of R.

This script has 5 requirements:
    1. Merge the training and the test sets to create one data set.
    2. Extract only the measurements on the mean and standard deviation for each measurement. 
    3. Uses descriptive activity names to name the activities in the data set
    4. Appropriately labels the data set with descriptive variable names. 
    5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each           activity and each subject.
   
   The fulfillment of each of these requirements are noted within this steps of this file.
   
The script reads the following tables into R:
  features.txt
  activity_labels.txt
  subject_train.txt (found in the "train" folder)
  x_train.txt (found in the "train" folder)
  y_train.txt (found in the "train" folder)
  subject_text.txt (found in the "test" folder)
  x_test.txt  (found in the "test" folder)
  y_test.txt  (found in the "test" folder)
  
For readibility, the features.txt is used to label the appropriate columns in the imported x_train.txt and x_test.txt files and column names are changed in the imported activity_labels.txt, subject_test.txt, subject_train.txt, y_test.txt and y_train.txt files.  

The "train" set of data is joined together to produce a data frame with  data, the subject id of the subject tested, and the activity tested into one data frame of 7352 rows and 563 columns.  The same is done for the "test" set of data resulting in a data frame of 2947 rows and 563 columns.
Requirement 1: 
The "train" and "test" set of data are joined into one data set of 10,299 rows and 563 columns.
Requirement 2: 
A subset of this data set is created, filtering for those columns that contain a mean or standard deviation result.  This results in a data frame of 10,299 rows and 20 columns.
Requirement 3:
The activity labels are merged into this subset using the activity_id, creating a data frame of 10,299 rows and 21 columns.
Requirement 4:
In order to "clean up" the column names, a list of column names is generated from this set and modified to remove "illegal" characters and improve readability. The column names from the data set are then replaced by the "cleaned up" version of the column names.
Requirement 5:
The means for each of the activities is calculated into a new data frame, as is the means for each subject.  These two data frames are joined into one final data set.  This data set is then exported without row names as "finalData.txt" into the working directory.







