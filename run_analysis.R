# Download the data, unzip it, and change the working directory to the unzipped folder.
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "project.zip", method = "curl")
unzip("project.zip")
setwd("./UCI HAR Dataset")

# Construct the vector of column indices that represent the mean and std deviation columns.
extract <- c(1:6, 41:46, 81:86, 121:126, 161:166, 201:202, 214:215,
             227:228, 240:241, 253:254, 266:271, 345:350, 424:429,
             503:504, 516:517, 529:530, 542:543, 555:561)

# Read the activity labels and the measurement feature names (for means and std only).
labels <- read.table("activity_labels.txt")[,2]
features <- as.vector(read.table("features.txt")[,2][extract])

# Read the files related to the train dataset.
train_activities <- read.csv("train/y_train.txt", sep = "")
train_subjects <- read.csv("train/subject_train.txt", sep = "")
train_measurements <- read.csv("train/X_train.txt", sep = "")[,extract]

# Label the names of the train data frame.
names(train_activities) <- c("Activity")
names(train_subjects) <- c("Subject")
names(train_measurements) <- features

# Read the files related to the test dataset.
test_activities <- read.csv("test/y_test.txt", sep = "")
test_subjects <- read.csv("test/subject_test.txt", sep = "")
test_measurements <- read.csv("test/X_test.txt", sep = "")[,extract]

# Label the names of the test data frame.
names(test_activities) <- c("Activity")
names(test_subjects) <- c("Subject")
names(test_measurements) <- features

# Produce the train and test datasets by combining the measurements with subjects and activities.
train_set <- cbind(train_subjects, train_activities, train_measurements)
test_set <- cbind(test_subjects, test_activities, test_measurements)

# Combine the train and test datasets.
data <- rbind(train_set, test_set)

# Replace the activity codes with descriptive names.
data$Activity <- as.factor(data$Activity)
levels(data$Activity) <- labels

# Produce the derivative dataset, with means of all measurements for each activity/subject pair.
means <- aggregate(data[,features], list(data$Activity, data$Subject), mean)
names(means)[1:2] <- names(data)[1:2] # Restore the grouped column names.

# Save the combined dataset and the derivate dataset.
write.table(data, "dataset.txt", row.name = FALSE)
write.table(means, "grouped_means.txt", row.name = FALSE)
means
