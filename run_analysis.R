#Programming assignment Getting And Cleaning Data

#install packages when needed

#install.packages("dplyr")
#install.packages("tidyr")

library(dplyr)
library(tidyr)

# STEP 1 GATHER DATA

#get features (column names)
file <- "UCI HAR Dataset/features.txt"
features <- read.delim(file, header = FALSE, sep = " ")

#rename columns and add extra column containing readable descriptions of the concerning feature  
features <- rename(features, col_id = V1, colname_org = V2) %>% mutate(colname= gsub("[()|,]", "", colname_org))

#get activity labels
file <- "UCI HAR Dataset/activity_labels.txt"
act_labels <- read.delim(file, header = FALSE, sep = " ", stringsAsFactors = FALSE) %>%
rename(activity_id = V1, activity = V2)

#get test subject id
file <- "UCI HAR Dataset/test/subject_test.txt"
subject_test <- read.delim(file, header = FALSE, sep = " ", stringsAsFactors = FALSE) %>%
rename(subject_id = V1)

#get test activity, and rename the only column and merge activity labels
file <- "UCI HAR Dataset/test/y_test.txt"
activity_test <- read.delim(file, header = FALSE, sep = " ", stringsAsFactors = FALSE) %>%
rename(activity_id = V1) %>% merge(act_labels, by = "activity_id")

#get test data and rename columns
file <- "UCI HAR Dataset/test/x_test.txt"
data_test <- read.table(file)
colnames(data_test) <- features$colname

#get training subject id
file <- "UCI HAR Dataset/train/subject_train.txt"
subject_train <- read.delim(file, header = FALSE, sep = " ", stringsAsFactors = FALSE) %>%
rename(subject_id = V1)


#get training activity, rename the only column and merge activity labels
file <- "UCI HAR Dataset/train/y_train.txt"
activity_train <- read.delim(file, header = FALSE, sep = " ", stringsAsFactors = FALSE) %>%
rename(activity_id = V1) %>% merge(act_labels, by = "activity_id")

#get training data and rename columns 
file <- "UCI HAR Dataset/train/x_train.txt"
data_train <- read.table(file)
colnames(data_train) <- features$colname

#STEP 2 - NARROW DATASETS 

#determine columns to select
selected_cols <- grep('mean|std', features[,3])

#narrow both datasets  
data_test <- data_test[, selected_cols]
data_train <- data_train[, selected_cols]

#STEP 3 - ADD SUBJECT AND ACTIVITY

#add activity labels and subject id's
data_test <- cbind(subject_id = subject_test$subject_id, activity = activity_test$activity, data_test)
data_train <- cbind(subject_id = subject_train$subject_id, activity = activity_train$activity, data_train)

#STEP 4 - rename columns
#already achieved in step 1 

#merge rows
data <- rbind(data_test, data_train)

#STEP 5 - group by subject and activity and calculate averages

#group data and summarize 
data_avg <-    
    gather(data, var, value, -subject_id, -activity) %>%
    group_by(subject_id, activity, var) %>% 
    summarise(avg = mean(value, na.rm=T)) %>%
    spread(var, avg)

#resultset as data frame
data_avg_fr <- as.data.frame(data_avg)

#write resultset to working directory
#write.table(data_avg_fr, "resultset.txt", row.names = FALSE)