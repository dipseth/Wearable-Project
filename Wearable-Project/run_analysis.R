library(dplyr)
#Set Directory with UCI HAR Dataset
project_data_directory<-"C:/Users/srivers/Documents/Cleaning Data R/Wearable Project/UCI HAR Dataset"

#Set Working Directory
setwd("C:/Users/srivers/Documents/Cleaning Data R/Wearable Project")

#Bring in Test Data
features<-read.csv(paste0(project_data_directory,"/features.txt"),header=FALSE,stringsAsFactors = FALSE,sep=" ")
subject_test<-read.csv(paste0(project_data_directory,"/test/subject_test.txt"),header=FALSE)
x_test<-read.csv(paste0(project_data_directory,"/test/X_test.txt"),header=FALSE,stringsAsFactors = FALSE)
y_test<-read.csv(paste0(project_data_directory,"/test/y_test.txt"),header=FALSE,stringsAsFactors = FALSE)

#Create Temporary data Frame
df<-as.data.frame(NULL)

#Iterate through Test Set, Creating Data frame
#of each row seperated into 561 columns
for(i in 1:nrow(x_test)){
        x<- strsplit(x_test[i,]," ")
        x<- x[[1]]
        x<-as.numeric(x[x!=""])
        x<-t(as.data.frame(x))
        df<-rbind(df,as.data.frame(x))
}

#Combine Subject Id, Training_id, and Feature Data Set
testing_df<-cbind(subject_test,y_test,df)

#Name Each column, with the subject_id, training_id, and Feature name
names(testing_df)<-c("subject_id","training_id",features[,2])



#Bring in Training Data
features<-read.csv(paste0(project_data_directory,"/features.txt"),header=FALSE,stringsAsFactors = FALSE,sep=" ")
subject_train<-read.csv(paste0(project_data_directory,"/train/subject_train.txt"),header=FALSE)
x_train<-read.csv(paste0(project_data_directory,"/train/X_train.txt"),header=FALSE,stringsAsFactors = FALSE)
y_train<-read.csv(paste0(project_data_directory,"/train/y_train.txt"),header=FALSE,stringsAsFactors = FALSE)

#Create Temporary data Frame
df<-as.data.frame(NULL)

#Iterate through Training Set, Creating Data frame
#of each row seperated into 561 columns
for(i in 1:nrow(x_train)){
        x<- strsplit(x_train[i,]," ")
        x<- x[[1]]
        x<-as.numeric(x[x!=""])
        x<-t(as.data.frame(x))
        df<-rbind(df,as.data.frame(x))
}

#Combine Subject Id, Training_id, and Feature Data Set
train_df<-cbind(subject_train,y_train,df)
df<-NULL

#Name Each column, with the subject_id, training_id, and Feature name
names(train_df)<-c("subject_id","training_id",features[,2])


#Combine Testing and Training
complete_df<-rbind(train_df,testing_df)

#Brining in activity lables
activity_labels<-read.csv(paste0(project_data_directory,"/activity_labels.txt"),header=FALSE,stringsAsFactors = FALSE,sep=" ")

#Apply Activity labels as levels to training_id factor
complete_df$training_id<-factor(complete_df$training_id)
activity_names<-activity_labels[,2]
levels(complete_df$training_id)<-activity_names

#Keep only Mean and Standard Deviation for Each Measurement
mean_std_df<-complete_df[,c("subject_id","training_id",grep("(mean|std)",names(complete_df),value=TRUE))]
rownames(mean_std_df)<-NULL

#Create new DF with Mean of each Measurement by Subject_id and Training_id
mean_group_by<-group_by(mean_std_df,subject_id,training_id)
mean_df<-summarise_each(mean_group_by,funs(mean))


#write CSV of of Mean_STD_DF and Summarized DF with mean for each measurement
write.table(mean_std_df,file="Mean Standard Deviation.csv",row.names=FALSE)
write.table(mean_df,file="Variable Average.csv",row.names=FALSE)





