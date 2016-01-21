run_analysis<-function()
{ 
  # file name set up
  fXTrain<-"./UCI HAR Dataset/train/X_train.txt"
  fYTrain<-"./UCI HAR Dataset/train/y_train.txt"
  fXTest<-"./UCI HAR Dataset/test/X_test.txt"
  fYTest<-"./UCI HAR Dataset/test/y_test.txt"
  fileColNames<-"./UCI HAR Dataset/features.txt"
  fileSubjectTest<-"./UCI HAR Dataset/test/subject_test.txt"
  fileSubjectTrain<-"./UCI HAR Dataset/train/subject_train.txt"
  fileActivityLabel<-"./UCI HAR Dataset/activity_labels.txt"
  
  # read the data
  xTrainDt<-read.table(file=fXTrain) 
  yTrainDt<-read.table(file=fYTrain) 
  xTestDt<-read.table(file=fXTest) 
  yTestDt<-read.table(file=fYTest) 
  subjectTestDt<-read.table(file=fileSubjectTest) 
  subjectTrainDt<-read.table(file=fileSubjectTrain) 
  subjectTrainDt<-read.table(file=fileSubjectTrain) 
  activityLabels<-read.table(file=fileActivityLabel) 
  
  colNames<-read.table(file=fileColNames) 

  #  
  colnames(xTrainDt)<-colNames[[2]]
  colnames(xTestDt)<-colNames[[2]]
  colnames(yTrainDt)<-c("labelID")
  colnames(yTestDt)<-c("labelID")
  colnames(subjectTestDt)<-c("subjectID")
  colnames(subjectTrainDt)<-c("subjectID")
  colnames(activityLabels)<-c("labelID","activityLabel")
  
  # merge x and y data
  xTrainDt <- cbind(xTrainDt, yTrainDt[1],subjectTrainDt )
  xTestDt <- cbind(xTestDt, yTestDt[1], subjectTestDt)
  
  # Merges the training and the test sets to create one data set.
  combinedDt<-rbind(xTrainDt, xTestDt)
  
  # Extracts only the measurements on the mean and standard deviation for each measurement. 
  meanStdData<-combinedDt[,grep('*-mean|*-std|labelID|subjectID',names(combinedDt))]
  
 # creates a second independent tidy data set with the average of 
 # each variable for each activity and each subject. 
  cleanData<-aggregate(. ~ subjectID + labelID, 
                data = as.data.frame(lapply(meanStdData,as.numeric)) , mean, na.rm=T)
  
  #  Uses descriptive activity names to name the activities in the data set
  cleanData<-merge(cleanData,activityLabels)
 
  write.table(cleanData,"./result.txt", row.name=FALSE)

}
