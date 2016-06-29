## Submission by Karan Rajwanshi
#  Course: Getting and Cleaning Data
#  

##### CREATING FUNCTIONS FOR EASIER READABILITY OF THE PROCESS

#  Using 'cbind' and 'rbind' to join the Training and Test datasets, the data at the end of this 
#  function contains 563 columns (561 variables, Subject and Activity Type)
merge_datasets <- function(data_X_train, data_y_train, data_X_test, data_y_test, Subject_train, Subject_test){
	
	data_train <- cbind(data_y_train, Subject_train, data_X_train)
	data_test <- cbind(data_y_test, Subject_test, data_X_test)
	merge_data <- rbind(data_test, data_train)
	return(merge_data)
	
}

######################################################
#  Using Regular Expressions in 'grep' to extract variables which represent either Mean or
#  Standard Deviation as is desired in the exercise (Point 2)
#  NOTE: The data.frame is here reduced to 83 columns (81 variables, Subject, Activity Type)
mean_sd_extract <- function(merged_data_frame, variable_names){

	req_variables <- grep(".*mean.*|.*std.*", variable_names[,2])	
	req_variables <- req_variables +2
	print(req_variables)
	merged_data_frame <- merged_data_frame[,c(1,2,req_variables)]
	temp_var_names <- variable_names[(req_variables-2),2] 
	temp_var_names<- gsub("-mean","Mean", temp_var_names)
	temp_var_names<- gsub("-std","StdDev", temp_var_names)
	temp_var_names<- gsub("[-()]","", temp_var_names)
	colnames(merged_data_frame) <- c("Activity_Names", "Subject",temp_var_names)
	return(merged_data_frame)
}
######################################################

#  Creating independent tiny dataset in the variable final_output (a data.frame), names are assigned
#  to the first 2 columns at the end, namely, Activity Names and Subject
avg_variables <- function(data_frame){
	
	print(names(data_frame))
	final_output <- NULL
	for(i in 1:30){
		data_temp <- data_frame[data_frame$Subject == i,]
		for(j in 1:6){
			if(j==1){
				data_temp2 <- data_temp[data_temp$Activity_Names==1,]
				temp <- colMeans(data_temp2[,3:81])
				act_name <- "WALKING"
			} else if(j==2){
				data_temp2 <- data_temp[data_temp$Activity_Names==2,]
				temp <- colMeans(data_temp2[,3:81])
				act_name <- "WALKING_UPSTAIRS"
			} else if(j==3){
				data_temp2 <- data_temp[data_temp$Activity_Names==3,]
				temp <- colMeans(data_temp2[,3:81])
				act_name <- "WALKING_DOWNSTAIRS"
			} else if(j==4){
				data_temp2 <- data_temp[data_temp$Activity_Names==4,]
				temp <- colMeans(data_temp2[,3:81])
				act_name <- "SITTING"
			} else if(j==5){
				data_temp2 <- data_temp[data_temp$Activity_Names==5,]
				temp <- colMeans(data_temp2[,3:81])
				act_name <- "STANDING"
			} else if(j==6){
				data_temp2 <- data_temp[data_temp$Activity_Names==6,]
				temp <- colMeans(data_temp2[,3:81])
				act_name <- "LAYING"
			}
			temp <- c(act_name, i, temp)
			final_output <- rbind(final_output,temp) 
		}
	}
	colnames(final_output)[1] <- "Activity Names"
	colnames(final_output)[2] <- "Subject"
	return(final_output)
}
######################################################


#  Libraries used
library(reshape2)
library(plyr)

#  Reading files as tables into variables for further processing
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
Sub_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
Sub_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
temp_variable <- read.table("./UCI HAR Dataset/features.txt")
activity_names <- read.table("./UCI HAR Dataset/activity_labels.txt") 

#  Step-1 Calling 'merge_datasets' function to merge all the datasets into one and saving it in a
#  temporary variable "x"
x <- merge_datasets(X_train, y_train, X_test, y_test, Sub_train, Sub_test)

#  Step-2 Extracting variables concerned with mean and standard deviation using 'mean_sd_extract' fn
z <- mean_sd_extract(x,temp_variable)

#  Step-3 Extracting average of each variable for each activity and each subject
b <- avg_variables(z)


### Writing the final tidy dataset evaluated in 'avg_variables' in a text file (tiny.txt), 
### excluding row_names
write.table(b,"tiny.txt", row.name=FALSE)

