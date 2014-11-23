------------------------
##Loading the dataset##
------------------------
x_train <- read.table(file.choose(), sep = "")
y_train <- read.table(file.choose(), sep = "")
subject_train <- read.table(file.choose(), sep = "")
x_test <- read.table(file.choose(), sep = "")
y_test <- read.table(file.choose(), sep = "")
subject_test <- read.table(file.choose(), sep = "")
features <- read.table(file.choose(), sep = "", colClasses = c("character"))
activity_labels <- read.table(file.choose(), sep = "", col.names = c("ActivityId", "Activity"))

#Combining subject to the test and train#
x_test <- cbind(x_test,subject_test)
x_train <-cbind(x_train,subject_train)

x_test <- cbind(x_test,y_test)
x_train <-cbind(x_train,y_train)

#1.Merges the training and the test sets to create one data set.

Data<-rbind(x_test,x_train)
#Duplication 
finalData=Data
header<-rbind(features, c(562, "Subject"))
header<-rbind(header, c(563, "ActivityId"))
names(finalData) <- header[,2]

View(finalData)


#2.Extracts only the measurements on the mean and standard deviation for each measurement. 

mean_std_data <- finalData[ , grep("mean|std|Subject|ActivityId", names(finalData))]


#3.Uses descriptive activity names to name the activities in the data set

data_with_activity <- merge(mean_std_data, activity_labels, by.x="ActivityId", by.y="ActivityId")


#4.Appropriately labels the data set with descriptive variable names. 

data_with_activity$Activity <- as.factor(data_with_activity$Activity)
data_with_activity$Subject <- as.factor(data_with_activity$Subject)


#5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

tidy_data = aggregate(data_with_activity, by=list(Activity = data_with_activity$Activity , Subject=data_with_activity$Subject), mean)
tidy_data=tidy_data[,-3]
tidy_data=tidy_data[,-83]
tidy_data=tidy_data[,-82]

--------------------------
  ## Write to txt file ##
--------------------------

write.table(tidy_data, "tidy.txt", sep="\t", row.name=FALSE)
