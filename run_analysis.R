library(stringr)
library(dplyr)

#==============================
#Peer Assessment
#==============================
#I have included the download process although unnecessary.
#Each part of the Peer Assessment will be numbered with the corresponding part of the assignment.
#Note: Part 1. is divided into two parts for clarity. All other parts are chronological as stated
#in the assignment description.
#==============================

#url <-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#download.file(url, tmp<-tempfile())
#unzip(tmp)

#reads the first two files in the folder UCI HAR Dataset (activity_labels and features)
datName<-list.files(path="UCI HAR Dataset/")
dat<-lapply(datName[1:2], function(x){read.table(paste("UCI HAR Dataset/",x,sep=""))})
names(dat)<-datName[1:2]

#reads all .txt files in the train folder into a list named train
trainName<-list.files(path="UCI HAR Dataset/train",pattern =".txt")
train<-lapply(trainName, function(x){read.table(paste("UCI HAR Dataset/train/",x,sep=""))})
names(train)<-trainName

#reads all .txt files in the test folder into a list named test
testName<-list.files(path="UCI HAR Dataset/test",pattern =".txt")
test<-lapply(testName, function(x){read.table(paste("UCI HAR Dataset/test/",x,sep=""))})
names(test)<-testName

#Part 1.1======================
#row binds each element of the test and train list to one list named data
data<-mapply(rbind, train, test)

#Part 2========================
#dat[[2]][[2]] contains all the feature names of x, data[[2]] contains all of x
#grep returns the indicies that include the pattern mean( or std( in the string
meanAndStd<-grep("mean[(]|std[(]", dat[[2]][[2]])
data[[2]]<-data[[2]][meanAndStd]

#Part 3========================
#dat[[1]][[2]] contains activity_label for y, data[[3]] contains y
data[[3]]<-factor(data[[3]][[1]], labels=dat[[1]][[2]])

#Part 4.1========================
#dat[[2]][[2]][meanAndStd] is all the feature names containing mean() and std()
names(data[[1]])<-"Subject"
names(data[[2]])<-dat[[2]][[2]][meanAndStd]

#Part 4.2 and Part 1.2===========
#column binds the three elements of the list, also naming the factor, Activity
data<-cbind(data[[1]],data[[2]],Activity = data[[3]])

#Part 5==========================
#data is grouped by Subject and Activity and each other column is summarized by their mean
avgSubData<-data%>%group_by(Subject,Activity)%>%summarise_each(funs(mean))

write.table(avgSubData, file="independent tidy data set.txt",row.name=FALSE)
