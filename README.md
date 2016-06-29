# Getting_and_Cleaning_Data
Project- Getting and Cleaning data obtained from Samsung for Galaxy s2 motion sensor

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
Link: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

This project uses the data from link : https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Instructions for the R-code to run:
1. Download the above zip file and unzip it
2. Save the run_analysis.R file in the same directory as the extracted folder from the zip file
3. Make sure you have 3.3.0 or higher version of R installed on your computer
4. You should have reshape2 and plyr libraries installed into your computer
5. Run the R files in the R terminal (cli), the output tiny.txt file will be created in the same directory containing the clean data


The R-code in run_analysis.R does the following:-
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
