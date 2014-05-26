cleanData<- function(){
  # Read data from various files
  X.train <- read.table("UCI HAR Dataset\\train\\X_train.txt")
  subject.train <- read.table("UCI HAR Dataset\\train\\subject_train.txt")
  subject.test <- read.table("UCI HAR Dataset\\test\\subject_test.txt")
  X.test <- read.table("UCI HAR Dataset\\test\\X_test.txt")
  y.train <- read.table("UCI HAR Dataset\\train\\y_train.txt")
  y.test <- read.table("UCI HAR Dataset\\test\\y_test.txt")
  features<- read.table("UCI HAR Dataset\\features.txt",stringsAsFactors=F)
  activity.labels <- read.table("UCI HAR Dataset\\activity_labels.txt")
  
  names(activity.labels)<- c("Id","Desc")
  
  # Associate subject data with training set
  X.train<- cbind(X.train,subject.train)
  
  # Associate subject data with test set
  X.test <- cbind(X.test,subject.test)
  
  # Associate Activity Names
  X.train <- cbind(X.train,y.train)
  X.test <- cbind(X.test,y.test)
  
  #STEP 1. Merge two training and test dataset into one
  X.totalSet <- rbind(X.train,X.test)
  
  # Transpose feature names
  feature.names <- as.character(t(features$V2))
  
  # Add Subject ID and Activity.Id
  feature.names <- append(feature.names,"Subject.ID")
  feature.names <- append(feature.names,"Activity.ID")
  

  
  
  # STEP 4: Appropriately labels the data set with descriptive activity names. 
  # Making the relevent features that are listed in the "features.txt" file more descriptive/readable.
  
  # Remove Hyphens and replaced with a dot
  feature.names<- gsub("-",".",feature.names)
  # Remove () 
  feature.names<- gsub("\\(\\)","",feature.names)
  #Abbreviate Features
  feature.names<- gsub("f","Frequency.",feature.names)
  # Remove Ts for all strings that start with t
  feature.names.Three.Dim <- substring(feature.names[1:265], 2)
  feature.names[1:265] <- feature.names.Three.Dim

  
  names(X.totalSet) <- feature.names
  
  #STEP 2 Get All Means and Std deviations
  means.stds.index.list <- sapply(feature.names, function(x) grep("mean()|std()",x))
  means.stds.index <- sapply(means.stds.index.list,'[',1)
  means.stds.index[is.na(means.stds.index)] <- 0
  means.stds.index <- as.numeric(means.stds.index)
  means.stds <- X.totalSet[,means.stds.index]
 
  # STEP 3 : set all  descriptive activity names to name the activities in the data set
  # This code replaces the numeric activity Codes into Labels for the dataset
  X.totalSet.activity<- merge(X.totalSet,activity.labels,by.x="Activity.ID",by.y="Id")
 
  # Step 4 : GIVEN ABOVE
  
  #Step 5: Creates a second, independent tidy data set with the average of each variable for each activity and each subject
  
  clean.data<-melt(X.totalSet.activity,id=c("Desc","Subject.ID"),measure.vars=feature.names[means.stds.index])
  write.table(clean.data,file="data.txt")
  
}
