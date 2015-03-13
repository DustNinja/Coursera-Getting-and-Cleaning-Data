#-------------------------------------------------------------------------------
# Set hard-coded directory path for downloaded data
#-------------------------------------------------------------------------------

Dir <- "."

#-------------------------------------------------------------------------------
# Download data (if necessary)
#-------------------------------------------------------------------------------

# Add name of zipped directory to the path
DataDirPath <- paste0(Dir,"/UCI HAR Dataset/")

# Check if data directory exists
if (!file.exists(DataDirPath)) {
    
    # Pull data (if needed)
    tempFile <- tempfile()
    zipFile <- download.file(
        url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
        destfile = tempFile,
        method = "curl"
    )
    
    # Unzip directory
    unzip(zipfile = tempFile, exdir = Dir)

    # Remove temporary files
    rm(tempFile); rm(zipFile)
}

#-------------------------------------------------------------------------------
# Load required libraries
#-------------------------------------------------------------------------------

library(plyr)

#-------------------------------------------------------------------------------
# Read all requried files
#-------------------------------------------------------------------------------

# Read in data
data1 <- read.table(file = paste0(DataDirPath,"train/X_train.txt"))
data2 <- read.table(file = paste0(DataDirPath,"test/X_test.txt"))

# Read in label pointers
label1 <- read.table(file = paste0(DataDirPath,"train/y_train.txt"))
label2 <- read.table(file = paste0(DataDirPath,"test/y_test.txt"))

# Read in subject pointers
subject1 <- read.table(file = paste0(DataDirPath,"train/subject_train.txt"))
subject2 <- read.table(file = paste0(DataDirPath,"test/subject_test.txt")) 

# Read in features
features <- read.table(file = paste0(DataDirPath,"features.txt"))

# Read in activity labels
activities <- read.table(file = paste0(DataDirPath,"activity_labels.txt"))

#-------------------------------------------------------------------------------
# Combine the two datasets together
#-------------------------------------------------------------------------------

all_data  <- rbind(data1, data2) 
all_label <- rbind(label1, label2)
all_subject <- rbind(subject1, subject2)

# Remove old vectors
#rm(data1)
#rm(data2)
#rm(label1)
#rm(label2)
#rm(subject1)
#rm(subject2)
   
#-------------------------------------------------------------------------------
# Extract only the measurements on the mean & std dev for each measurement
#-------------------------------------------------------------------------------

# Identify rows with mean() or std() in the feature name
mean_std_rows <- grep("-(mean|std)\\(\\)", features[,2])

# Use feature rows to extract mean and std dev columns from the main dataset
all_data <- all_data[,mean_std_rows]

# Name the main dataset columns
names(all_data) <- features[mean_std_rows,2]
    
#-------------------------------------------------------------------------------
# Combine activity descriptions with their respective label pointers
#-------------------------------------------------------------------------------

all_label[,1] <- activities[all_label[,1],2]

#-------------------------------------------------------------------------------
# Appropriately label the data set with descriptive variable names
#-------------------------------------------------------------------------------

# Name the activity column
names(all_label) <- "activity"

# Name subject column
names(all_subject) <- "subject"

#-------------------------------------------------------------------------------
# Combine everything into a single dataset
#-------------------------------------------------------------------------------

data <- cbind(all_subject, all_label, all_data)

# Remove old vectors
rm(all_data)
rm(all_label)
rm(all_subject)
rm(features)
rm(activities)

#-------------------------------------------------------------------------------
# Create a second, independent tidy data set with the average of each variable
# for each activity and each subject
#-------------------------------------------------------------------------------

tidy <- ddply(data, .(subject,activity), function(x) colMeans(x[,3:ncol(data)]))

# Clean up the column names
names(tidy) <- gsub("(mean\\(\\))", "Mean", names(tidy))
names(tidy) <- gsub("(std\\(\\))", "Std", names(tidy))
names(tidy) <- gsub("(\\(|\\)|-|,|_)", "", names(tidy))
names(tidy) <- sub("^f", "Freq", names(tidy))
names(tidy) <- sub("^t", "Time", names(tidy))

# Write tidy output file
write.table(tidy, "averaged_data.txt", row.name = FALSE)