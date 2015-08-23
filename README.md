# Getting and Cleaning Data

* The training dataset was processed as follows:

  * The columns representing the mean and standard deviation measurements were extracted from train/X_train.txt.
  * The names of the columns were assigned by extracting them from features.txt (NOTE: I deem them descriptive enough to use without any further editing).
  * The single column from train/y_train.txt was added to the resulting data frame, under the name “Activity”.
  * The single column from train/subject_train.txt was added to the resulting data frame, under the name “Subject”.

* The same was also done for the test dataset.

* The resulting data frames for the train and test datasets were combined with rbind.

* The activity codes (1 through 6) were replaced with the descriptive names, obtained from activity_labels.txt.

* The means of all measurement columns were obtained for each activity/subject pair, and the resulting data frame was saved as grouped_means.txt.
