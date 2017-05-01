testing_df:Testing Data merged into a single Dataframe
data from subject_test.txt, X_test.txt, and y_test.txt files in 
"~\Wearable Project\UCI HAR Dataset\test"

train_df:Training Data merged into a single Dataframe
data from subject_train.txt, X_train.txt, and y_train.txt files in 
"~\Wearable Project\UCI HAR Dataset\train"

features:Feature names from "~\Wearable Project\UCI HAR Dataset\features.txt"

complete_df: Combined Data Frame with Testing and Training Data.
Columns include subject_id, training_id, and Feature names from  features[,2]

activity_labels:activity labels from /activity_labels.txt

complete_df$training_id is converted into factor with levels as values from activity_labels[,2]


mean_std_df:Combined Data Frame with Testing and Training Data.   
Only Subject_id, training_id, mean/std variables included

mean_df: A summary version of mean_std_df, showing the mean for all variables grouped by subject_id and Training_id
