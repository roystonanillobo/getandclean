# Loading required packages
library(dplyr)

# Creating UCI HAR Dataset flolder and downloading the raw data files.
# And unzipping the zip file

filename <- "Raw_data.zip"

if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}  

if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}



# Reading all data to R
features = read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities = read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

subject_test = read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
subject_train = read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")

x_test = read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test = read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")

x_train = read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train = read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")


# Step 1: Merging the training and testing datasets to one data set.

x_merged = rbind(x_train, x_test)
y_merged = rbind(y_train, y_test)
subject_merged = rbind(subject_train, subject_test)
all_merged_data = cbind(subject_merged, y_merged, x_merged)


# Step 2: Extracting the means and standard deviation.

data_m_sd = all_merged_data %>% select(subject, code, contains("mean"), contains("std"))

# Step 3: Using the descriptive activity names to name the activities in the data set.

data_m_sd$code <- activities[data_m_sd$code, 2]

# Step 4: Appropriately labels the data set with descriptive variable names.
names(data_m_sd)[2] = "activity"
names(data_m_sd) = gsub("Acc", "Accelerometer", names(data_m_sd))
names(data_m_sd) = gsub("Gyro", "Gyroscope", names(data_m_sd))
names(data_m_sd) = gsub("BodyBody", "Body", names(data_m_sd))
names(data_m_sd) = gsub("Mag", "Magnitude", names(data_m_sd))
names(data_m_sd) = gsub("^t", "Time", names(data_m_sd))
names(data_m_sd) = gsub("^f", "Frequency", names(data_m_sd))
names(data_m_sd) = gsub("tBody", "TimeBody", names(data_m_sd))
names(data_m_sd) = gsub("-mean()", "Mean", names(data_m_sd), ignore.case = TRUE)
names(data_m_sd) = gsub("-std()", "Std_deviation", names(data_m_sd), ignore.case = TRUE)
names(data_m_sd) = gsub("-freq()", "Frequency", names(data_m_sd), ignore.case = TRUE)
names(data_m_sd) = gsub("angle", "Angle", names(data_m_sd))
names(data_m_sd) = gsub("gravity", "Gravity", names(data_m_sd))



# Step 5: From the data set in step 4, 
# creates a second, independent tidy data set with 
# the average of each variable for each activity and each subject

final_clean_data = data_m_sd %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))

# Step 6: Writing final dataset to file

write.table(final_clean_data, "Final_Data.txt", row.name=FALSE)
