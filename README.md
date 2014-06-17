Tidy Data Project
===============

The run_analysis.R script assumes that the zip file containing the data has been downloaded and extracted. It must be run from the directory that contains the top level directory created during decompression (UCI HAR Dataset). The script performs the following functions:

1. Reads the X_test.txt and X_train.txt data files and combines them into a single data.frame

2. Extracts only those columns that contain either "mean()" or "std()" in their column name

3. Applies those column names to the subsetted data.frame

4. Reads the y_test.txt and y_train.txt files containing the activity IDs, combines them into a single named column, and adds the column to the front of the data.frame

5. Replaces the activity IDs with the appropriate activity name as listed in the activity_labels.txt file

6. Reads the subject_test.txt and subject_train.txt files containing the subject IDs, combines them into a single named column, and adds the column to the front of the data.frame

7. Aggregates the variables in the data.frame by subject ID and activity, and calculates the mean of each subject/activity combination for each variable

8. Writes out the new tidy data.frame to tidy_means.txt
