#The purpose of this script is to:
# 1. Merge the training and test data sets to create one data set
# 2. Extract only the measurements on the mean and standard deviation for each measurement
# 3. Use descriptive activity names to name the activities in the data set
# 4. Appropriately label the data set with descriptive activity names
# 5. Create a second, independent tidy data set with the average of each variable for 
#     each activity and each subject.

x <- read.table("./UCI HAR Dataset/train/X_train.txt")
y <- read.table("./UCI HAR Dataset/train/y_train.txt")
s <- read.table("./UCI HAR Dataset/train/subject_train.txt")
f <- read.table("./UCI HAR Dataset/features.txt")
a <- read.table("./UCI HAR Dataset/activity_labels.txt")

x1 <- read.table("./UCI HAR Dataset/test/X_test.txt")
y1 <- read.table("./UCI HAR Dataset/test/y_test.txt")
s1 <- read.table("./UCI HAR Dataset/test/subject_test.txt")


#assign variable names as column names
n <- f[,2]
sn <- setNames(x, n)
sn1 <- setNames(x1, n)
 
#assign subject and activity column names
s <- setNames(s, c("subject"))
s1 <- setNames(s1, c("subject"))

#change activity numbers to activity names, change column names
library(plyr)
a1 <- arrange(join(y, a), V1)
a1 <- setNames(a1, c("activity Number", "activity"))

a2 <- arrange(join(y1, a), V1)
a2 <- setNames(a2, c("activity Number", "activity"))

#add subject and activity columns
xx <- cbind(a1, sn)
xxx <- cbind(s, xx)
xx1 <- cbind(a2, sn1)
xxx1 <- cbind(s1, xx1)

#merge train and test data sets
data <- join(xxx, xxx1, type = "full")


#subset columns containing mean and std
library(sqldf)
cn <- colnames(data)
has_mean <- grep("mean", cn, value=TRUE)
has_std <- grep("std", cn, value=TRUE)
front <- c("subject", "activity Number", "activity")
has_all <- c(front, has_mean, has_std)
sdata <- data[,colnames(data) %in% has_all]

#calculate average of each variable for each activity and each subject
gg <- aggregate(sdata, by = list(subject2=sdata$subject, activity2=sdata$activity), mean)
gg1 <-aggregate(sdata, by = list(subject2=sdata$subject), mean)
gg2 <- aggregate(sdata, by = list(activity2=sdata$activity), mean)
gg3 <- aggregate(sdata, by = list(activity2=sdata$activity, subject2=sdata$subject), mean)

#sort the file by subject
ggg <- gg[order(gg$subject2),]

#save output as text
sink("ggg.txt")
ggg
sink()

#alternative method for generating txt file
write.table(ggg, file="output_mlee.txt", row.names=FALSE)


