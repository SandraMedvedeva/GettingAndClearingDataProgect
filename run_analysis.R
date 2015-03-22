library(dplyr)


# Step 1
# Read and clear labels for activities and measurments
###############################################################################

#read activity labels, rename columns
activity_labels <- read.table('activity_labels.txt')
activity_labels <- rename(activity_labels, id_activity = V1, activity = V2)

#read measurment labels, clear inappropriate symbols
measurment_labels <- read.table('features.txt')
measurment_labels <- measurment_labels[,2]
measurment_labels <- gsub('-','_',measurment_labels)
measurment_labels <- gsub('[)]','',measurment_labels)
measurment_labels <- gsub('[(]','',measurment_labels)


# Step 2
# Read and clear training data set
###############################################################################

#read subjects, rename column
train_subject <- read.table('train/subject_train.txt')
train_subject <- rename(train_subject, id_subject = V1)

#read activities, rename column, merge with labels, drop id_activity
train_activity <- read.table('train/y_train.txt')
train_activity <- rename(train_activity, id_activity = V1)
train_activity <- merge(train_activity, activity_labels)
train_activity <- train_activity[,2]

#read train data
train_measurment_temp <- read.table('train/X_train.txt')
names(train_measurment_temp) <- measurment_labels
#sum(is.na(train_measurment))
#[1] 0

#extract only required columns
train_measurment_mean <- train_measurment_temp[, grep('_mean', names(train_measurment_temp))]
train_measurment_mean <- train_measurment_mean[, -(grep('_meanFreq', names(train_measurment_mean)))]
train_measurment_std <- train_measurment_temp[, grep('_std', names(train_measurment_temp))]
train_measurment <- cbind(train_measurment_mean,train_measurment_std)

#construct the train dataset into one table, rename column
train <- cbind(train_subject, train_activity, train_measurment)
train <- rename(train, activity = train_activity)


# Step 3
# Read and clear testing data set
###############################################################################

#read subjects, rename column
test_subject <- read.table('test/subject_test.txt')
test_subject <- rename(test_subject, id_subject = V1)

#read activities, rename column, merge with labels, drop id_activity
test_activity <- read.table('test/y_test.txt')
test_activity <- rename(test_activity, id_activity = V1)
test_activity <- merge(test_activity, activity_labels)
test_activity <- test_activity[,2]

#read test data
test_measurment_temp <- read.table('test/X_test.txt')
names(test_measurment_temp) <- measurment_labels
#sum(is.na(test_measurment))
#[1] 0

#extract only required columns
test_measurment_mean <- test_measurment_temp[, grep('_mean', names(test_measurment_temp))]
test_measurment_mean <- test_measurment_mean[, -(grep('_meanFreq', names(test_measurment_mean)))]
test_measurment_std <- test_measurment_temp[, grep('_std', names(test_measurment_temp))]
test_measurment <- cbind(test_measurment_mean,test_measurment_std)

#construct the train dataset into one table, rename column
test <- cbind(test_subject, test_activity, test_measurment)
test <- rename(test, activity = test_activity)


# Step 4
# Merge train and test data
###############################################################################
HAR_dataset <- rbind(train, test)


# Step 5
# Create a tidy, summarised dataset
###############################################################################

#group dataset, summarise
HAR_grouping <- group_by(HAR_dataset, activity, id_subject)
tidy_set <- summarise_each(HAR_grouping, funs(mean))

#upload table to file
write.table(tidy_set, "HAR_avg_set.txt", row.name=FALSE)