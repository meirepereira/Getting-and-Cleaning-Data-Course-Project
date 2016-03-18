# Read training and testing data, and combine them
training<-read.delim("UCI HAR Dataset/train/X_train.txt", header=FALSE, sep="")
testing<-read.delim("UCI HAR Dataset/test/X_test.txt", header=FALSE, sep="")
all_X <-rbind(training, testing)

# Read the subjects from training and test data, and combine them
training_sub<-read.delim("UCI HAR Dataset/train/subject_train.txt", header=FALSE, sep="")
testing_sub<-read.delim("UCI HAR Dataset/test/subject_test.txt", header=FALSE, sep="")
all_sub <-rbind(training_sub, testing_sub)


# Read the labels for training and testing data, and combine them
training_Y<-read.delim("UCI HAR Dataset/train/Y_train.txt", header=FALSE, sep="")
testing_Y<-read.delim("UCI HAR Dataset/test/Y_test.txt", header=FALSE, sep="")
all_Y<-rbind(training_Y, testing_Y)

#combine X and Y variables
all_data <- cbind(all_X, all_sub, all_Y)

# Get column names, remove duplicates, and select only mean() and std() columns, plus actvity
names = read.delim("UCI HAR Dataset/features.txt", header=FALSE, sep="")
names$V2<-as.character(names$V2)
all_names<-rbind(names, c(562, "subject_id"))
all_names<-rbind(all_names, c(563, "activity"))
colnames(all_data)<-all_names$V2
all_data<-all_data[,!duplicated(colnames(all_data))]
all_data<-select(all_data, contains("mean()"), contains("std()"), subject_id, activity)

# Read in labels
labels<-read.delim("UCI HAR Dataset/activity_labels.txt", header=FALSE, sep="")
colnames(labels)<-c("activity", "activity_label")
labeled_data<-inner_join(all_data, labels, by="activity")
labeled_data<-select(labeled_data, -activity)

# Create 2nd data set for the average of each variable for each activity and each subject.
temp<- group_by(labeled_data,subject_id, activity_label)
subject_activity_mean<-data.frame(summarise_each(temp, funs(mean)))
write.table(subject_activity_mean, "subject_activity_mean.txt", row.name=FALSE)
