
## Description
The run_analysis.R script performs the following functions:
- Loading required packages.
- Downloading dataseta and unzipping it.
- Loading the files in R. 
- Performing the 5 steps as described in the project’s description.
- Writing the tidy data to test file.
The details of each functions is describe below

### Functions of the script

1. Loading packages
- The script loads the `dplyr` required for manipulating the tabular dataset

2. Downloading the dataset
- The script checks for the existance of folder named `UCI HAR Dataset`,  if it is not present it is created.
- The dataset is downloaded from the url provided and the data is extracted in the folder `UCI HAR Dataset`.

3. Loading files in to R
- `features` = features.txt : 561 rows, 2 columns
    - The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
- `activities` = activity_labels.txt : 6 rows, 2 columns
    - List of activities performed when the corresponding measurements were taken and its codes (labels)
- `subject_test` = test/subject_test.txt : 2947 rows, 1 column
    - contains test data of 9/30 volunteer test subjects being observed
- `x_test` = test/X_test.txt : 2947 rows, 561 columns
    - contains recorded features test data
- `y_test` = test/y_test.txt : 2947 rows, 1 columns
    - contains test data of activities’code labels
- `subject_train` = test/subject_train.txt : 7352 rows, 1 column
    - contains train data of 21/30 volunteer subjects being observed
- `x_train` = test/X_train.txt : 7352 rows, 561 columns
    - contains recorded features train data
- `y_train` = test/y_train.txt : 7352 rows, 1 columns
    - contains train data of activities’code labels

4. Performing steps required for assignment
    1. _Merging the training and testing datasets to one data set_
    - `x_merged` (10299 rows, 561 columns) is created by merging `x_train` and `x_test` using rbind() function
    - `y_merged` (10299 rows, 1 column) is created by merging `y_train` and `y_test` using rbind() function
    - `subject_merged` (10299 rows, 1 column) is created by merging `subject_train` and `subject_test` using rbind() function
    - `all_merged_data` (10299 rows, 563 column) is created by merging `subject_merged`, `y_merged` and `x_merged` using cbind() function

    2. _Extracts only the measurements on the mean and standard deviation for each measurement_
    - `data_m_sd` (10299 rows, 88 columns) is created by subsetting the columns: subject, code and the measurements on the mean and standard deviation (std) for each measurement, from `all_merged_data`

    3. _Uses descriptive activity names to name the activities in the data set_
    - The numbers in code column of the `all_merged_data` replaced with corresponding activity taken from second column of the `activities` variable

    4. _Appropriately labels the data set with descriptive variable names_
    - code column in `all_merged_data` renamed into activities using the names function
    - All Acc in column’s name replaced by Accelerometer
    - All Gyro in column’s name replaced by Gyroscope
    - All BodyBody in column’s name replaced by Body
    - All Mag in column’s name replaced by Magnitude
    - All start with character f in column’s name replaced by Frequency
    - All start with character t in column’s name replaced by Time
    - All tBody in column’s name replaced by TimeBody
    - All -mean() in column’s name replaced by Mean
    - All -std() in column’s name replaced by Std_deviation
    - All -freq() in column’s name replaced by Frequency
    - All angle in column’s name replaced by Angle
    - All gravity in column’s name replaced by Gravity
    
    5. _From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject_
    - `final_clean_data` (180 rows, 88 columns) is created by sumarizing `all_merged_data` taking the means of each variable for each activity and each subject

    6. _Export FinalData into text file_
    - `final_clean_data` is exported to a text file named `Final_Data.txt` using write.table function

