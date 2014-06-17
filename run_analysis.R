# Merge the training and the test sets to create one data set
dat1 <- read.csv("UCI HAR Dataset/test/X_test.txt",sep="",header=FALSE)
dat2 <- read.csv("UCI HAR Dataset/train/X_train.txt",sep="",header=FALSE)
dat <- rbind(dat1,dat2)

# Extract only the measurements on the mean and standard deviation
cols <- read.table("UCI HAR Dataset/features.txt",sep=" ")
colnames(cols) <- c("ID","Measurement")
mean_cols <- cols[grep("mean()",cols$Measurement,fixed=TRUE),2]
std_cols <- cols[grep("std()",cols$Measurement,fixed=TRUE),2]
ii <- which(cols$Measurement %in% mean_cols | cols$Measurement %in% std_cols)
dat <- dat[,ii]

# Appropriately label the data set with descriptive variable names
colnames(dat) <- cols[ii,2]
remove(dat1,dat2,cols,mean_cols,std_cols,ii)

# Use descriptive activity names to name the activities in the data set
acts1 <- read.csv("UCI HAR Dataset/test/y_test.txt",sep="",header=FALSE)
acts2 <- read.csv("UCI HAR Dataset/train/y_train.txt",sep="",header=FALSE)
acts <- rbind(acts1,acts2)
colnames(acts) <- "Activity"
dat <- cbind(acts,dat)
act_names <- read.csv("UCI HAR Dataset//activity_labels.txt",sep="",header=FALSE)
colnames(act_names) <- c("ID","Activity")
dat$Activity <- act_names$Activity[match(dat$Activity,act_names$ID)]
remove(acts1,acts2,acts,act_names)

# Add subject IDs to data set
subs1 <- read.csv("UCI HAR Dataset/test/subject_test.txt",sep="",header=FALSE)
subs2 <- read.csv("UCI HAR Dataset/train/subject_train.txt",sep="",header=FALSE)
subs <- rbind(subs1,subs2)
colnames(subs) <- "Subject"
dat <- cbind(subs,dat)
remove(subs1,subs2,subs)

# Create a second, independent tidy data set 
# with the average of each variable for each activity and subject
fout <- aggregate(dat[,3:ncol(dat)],list(subjectID=dat$Subject,activity=dat$Activity),mean)
write.csv(fout,"UCI HAR Dataset/TidyDataOutput.txt",row.names=FALSE)
remove(dat,fout)
