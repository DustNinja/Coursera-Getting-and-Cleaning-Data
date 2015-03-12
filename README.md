# Getting and Cleaning Data - Course Project

## Purpose
This repository contains a script and supporting documentation for creating a tidy dataset using data originally sampled from the [UCI Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) data. 

## Files
CodeBook.md - describes the variables, data, and any alterations that were performed to clean up the data

averaged_data.txt - the output file created by the run_analysis.R script

run_analysis.R - contains all code required for data processing and analysis.

## Details
The script does the following:

1. Downloads the UCI Human Activity Recognition Using Smartphones dataset (if necessary)
2. Combines the subjects, features and labels for both the training and test datasets into a single dataset
3. Extracts the mean and standard deviations associated with each measurement
4. Replaces activity identifiers with descriptive activity names
5. Removes extraneous characters from column names
5. Calculates the average of each variable for each activity and each subject
6. Writes out a tidy dataset called "averaged_data.txt"

## Usage
In an RStudio or R console:

source("run_analysis.R")

The script will produce a file called "averaged_data.txt" containing measurement averages for 66 variables, 6 activities, and 30 volunteer subjects.

To view the output in an RStudio or R console:

output_data <- read.table("averaged_data.txt", header=TRUE)
View(output_data)

By default, the run_analysis.R script will locate the initial UCI data directory in the current working directory. To change the data directory location, update the parameter "Dir" to the desired path before running.
