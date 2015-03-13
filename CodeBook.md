## Original Data Source
The original dataset used for this project was derived from the [UCI Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) dataset.

According to the UCI weblink documentation:

"The experiments were carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, researchers captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments were video-recorded to label the data manually. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain."

## Raw Data 
Access to raw data used in run_analysis.R script: [Course Project Data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

The following files are used for the project:

- 'features.txt': Links the main dataset columns with their associated variable label.

- 'activity_labels.txt': Links the activity class identifier with their activity name.

Testing (test) and training (train) data were collected under the same conditions. Researchers randomly partitioned data into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. The following files are available for both the train and test datasets.

- 'X_train.txt', 'X_test.txt': Main datasets.

- 'y_train.txt', 'y_test.txt': Acitivity class identifier. Values range from 1 to 6.

- 'subject_train.txt', 'subject_test.txt': Volunteer subject identifier.  Values range from 1 to 30.

## Data Processing Procedure
The run_analysis.R script performs the following steps to clean the data:   
 1. Read in the X_train.txt, y_train.txt and subject_train.txt files and store them in *data1*, *label1* and *subject1* dataframes, respectively.       
 2. Read in the X_test.txt, y_test.txt and subject_test.txt files and store them in *data2*, *label2* and *subject2* dataframes, respectively.       
 3. Read in the features.txt file and store the data in a dataframe called *features*. 
 4. Read the activity_labels.txt file and store the data in a dataframe called *activity*.  
 5. Concatenate *data1* to *data2* to form a combined dataset called *all_data*. Repeat this same process for the label and subject dataframes.  
 6. Identify row numbers for *features* values associated with mean or standard deviation measurements (66 total). Row indices are then used to identify and extract mean and standard deviation columns in the *all_data* dataframe. All other data from *all_data* are discarded. 
 7. Replace activity identifiers in *all_label* with their respective activity description from *activities* and add the column name "activity".
 8. Add the column name "subject" to the the *all_subject* dataframe.
 9. Combine *all_subject*, *all_label* and *all_data* by column to get a new 10299x68 dataframe, *data*. 
 10. Generate a tidy dataset, *tidy*, with the average of each measurement for each activity and each subject. 
 11. Reformat the *tidy* dataframe column names using the following rules:
        1) remove parentheses and dashes 
        2) replace prefix t with time
        3) replace prefix f with freq (short for frequency)
        4) apply CamelCasing
 12. Write the *tidy* dataframe out to a file called "averaged_data.txt" in current working directory. 
