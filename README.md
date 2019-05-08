### Programming Assignment 4: Getting And Cleaning Data  
The assignment concerns a series of operations to be executed with different data files in order to create one single and tidy dataset.
Involved operation are:

1. Loading the training and the test data files.
2. Narrowing the datasets by extracting only the measurements on the mean and standard deviation for each measurement.
3. Assigning descriptive activity names to name the activities in the data set
4. Assigning appropriately labels the data set with descriptive variable names.
5. Merging the test and training data sets into a single data set. 
6. From the data set in step 5, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

These operations will be executed by running the R script file **run_analysis.r** (also included).

IMPORTANT!

Only when the original data files (not included) are located in your R-Studion working directory (subfolder **"UCI HAR Dataset"**) the resultset can be reproduced!  

Following files are included:

**run_analysis.R**  
This is the R script file that must be run to generate the tidy dataset.   
The script itself contains comment for each step that has been taken and will explain how to obtain a resultset from gathering the raw data till assembling the final tidy dataset.  

**resultset.txt**  
This is the final dataset (mentioned by step 6). This is a space separated file which can be loaded in R studio.  

**Codebook.rmd**  
Dictionairy describing all data elements within the final dataset _(result.txt)_ 
