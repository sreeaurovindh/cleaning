## Code Book

The following are the variables that has been used in the codebase

 * X.train - Data obtained from "UCI HAR Dataset\\train\\X_train.txt")
 * subject.train - Data obtained from "UCI HAR Dataset\\train\\subject_train.txt"
  * subject.test - Data obtained from "UCI HAR Dataset\\test\\subject_test.txt"
  * X.test - Data obtained from "UCI HAR Dataset\\test\\X_test.txt"
  * y.train - Data obtained from "UCI HAR Dataset\\train\\y_train.txt"
  * y.test - Data obtained from "UCI HAR Dataset\\test\\y_test.txt"
  * features -Data obtained from UCI HAR Dataset\\features.txt",stringsAsFactors=F)
  * activity.labels <-Data obtained from "UCI HAR Dataset\\activity_labels.txt"
  
  Data Transformations
  
  * Subjects of both training and the test sets are grouped into single dataset.
  * Activity Names are then associated with the training and test datasets
  * Merging of both X.train,X.test are performed
  * Feature Vector is transformed into rows so that the data frame can be renamed
  * Subject Id  and activity Id as associated with it
  * Cleaning of the variables in the feature vector is done by replacing each hypens with dots and then renaming variables by frequency
  * Data is merged so that Activity ids are replaced by its labels
  * Data is then melted by name value pairs of Description and Subject ID and written to disk