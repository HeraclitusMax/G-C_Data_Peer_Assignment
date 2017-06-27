##About R script

This repo contains files relating to the peer assessment project for the Getting and Cleaning Data Coursera course. The R script, run_analysis.R, does the following:
        1.	Download the dataset if it does not already exist in the working directory
        2.	Load the activity and feature info
        3.	Loads both the training and test datasets, keeping only those columns which reflect a mean or standard deviation
        4.	Loads the activity and subject data for each dataset, and merges those columns with the dataset
        5.	Merges the two datasets
        6.	Converts the activity and subject columns into factors
        7.	Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.

The end result is shown in the file tidy.txt

##About the source data

This project is centrally concerned with downloading, combining and tidying data sets sourced from the following study:  Human Activity Recognition Using Smartphones Data Set. A full description of this study is available from the project’s website: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
The data collected I this study was taken from wearable devices that recorded participant motion as they performed six physical activities. Links to the data sources used in this analysis can be found here:  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
