Getting-and-Cleaning-Data
=========================

This repo contains the assignments for the getting and cleaning data class from the John Hopkins-Coursera Data Science program

The fie run_analysis.R contains R code that summarizes activity tracking data for 30 volunteers who performed 6 activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYINNG) wearing a smartphone (Samsung Galaxy S II) on the waist.

The input files to the code are:

x_train.txt -contains the training values corresponding to all activity tracking variables (see CodeBoo.md for the variables)

y_train.txt -contains the activity codes for each row in the training data x_train.txt

subject_train.txt -contains the subject codes for each row in the training data x_train.txt

features.txt -contains the column names (names of the variables) in the training data x_train.txt

activity_labels.txt -contains the names of the 6 activities

x_test.txt -contains the testing values corresponding to all activity tracking variables 

y-test.txt -contains the activity codes for each row in the testing data x_test.txt

subject_test.txt -contains the subject codes for each row in the testing data x_test.txt

The code in run_analysis.R performs the following work:
1.	It reads each of the above files int R
2.	It assigns variable names as column names from file features.txt to files x_train.txt and x_test.txt
3.	It assigns subject and activity names to both x_train.txt and x_test.txt using files subject_train.txt and sibject_test.txt
4.	It assigns activity names to the train and test data using the activity codes from y_train.txt and y_test.txt and actvity labels from activity_labels.txt
5.	It adds subject and activity columns to the training and test data
6.	It merges the train and test data sets modified as described above
7.	It subsets the columns containing means and standard deviations of the variables/signals
8.	It calculates the average of each variable for each activity and each subject
9.	It sorts the file by subject
10. It saves the output as text with two methods, one using sink() and the other using write.table()
