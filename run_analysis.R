### File name "run_analysis.R"
### This code looks to the"Human Activity Recognition Using Smartphones Data Set" 
###     held at the UCI Machine Learning Repository
### The address for the site is "https://archive.ics.uci.edu/ml/datasets.html"
###
### The data set is found in the UCI site at 
###     "https://archive.ics.uci.edu/ml/datasets/human+Activity+recognition+Using+smartphones"
### The data set names are found at 
###     "https://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.names"
### The link address to the data set is 
###     "https://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip"
###
### The data set unzips to a directory called "UCI HAR Dataset"
### The "UCI HAR Dataset" directory contains two ".txt" files necessary for this analysis - see below
### The "UCI HAR Dataset" directory also has two subdirectories, "test" and "train"
### The "test" and "train" subdirectories contain a number of ".txt" files required for this analysis
### The ".txt" files necessary for this analysis are:
###     in the "UCI HAR Dataset" directory
###         activity_labels.txt
###         features.txt
###     in the "UCI HAR Dataset\train" subdirectory 
###         subject_train.txt
###         X_train.txt
###         y_train.txt
###     in the "UCI HAR Dataset\test" subdirectory
###         subject_test.txt
###         X_test.txt
###         y_test.txt
###
### The ".txt" files listed above will need to be found in your working directory
###
### The function "run_analysis()" performs some preparatory actions and then five (5) actions/steps
### "run_analysis()" outputs a file named "tidy.txt"
### The five (5) actions/steps have been coded as five (5) functions in the body of "run_analaysis()"
### The five (5) steps are:
###     1. "mergeDataSets" reads and then merges the training and test data sets and of variables and
###             processed observations and returns the data frame so constructed
###     2. "extract_mean_sd" extracts any measurement which is a mean or standard deviation from the 
###             constructed data frame and returns the modified data frame
###     3. "renameActivities" renames the activities more descriptively and 
###             returns the so modified data frame
###     4. "renameColumns" appropriately labels the data frame columns with descriptive column names and
###             returns the so modified data frame
###     5. "calculate_df" constructs a new independent tidy data frame 
###             with the average of each observation for each activity and each subject
###
### The data frame constructed at Step 5 is writen to the file "tidy.txt" in the working directory 
### The "tidy.txt" file is written using "write.table" with "row.name = FALSE"
###
### This R script requires the "dplyr" package to be installed 
### "dplyr" citation is - Hadley Wickham and Romain Francois (2015). dplyr: A Grammar of Data Manipulation. 
### R package version 0.4.2. http://CRAN.R-project.org/package=dplyr
################################################################################################

### Run the analysis
run_analysis <- function ()   {

    ## THE FUNCTIONS BELOW ARE CALLED FROM THE BODY OF THIS FUNCTION
    ##
    ## Preparatory actions
    ## Loads the "dplyr" package and checks that all the needed files are present
    ## in the working directory
    ## Returns empty
    prepare_for_analysis <- function()   {
        # need to load the package "dplyr" with warnings suppressed
        library("dplyr", warn.conflicts = FALSE)
        # check to see all needed files exist in the working directory
        if (!file.exists("X_train.txt")) 
            stop("This script reqires 'X_train.txt' to exist in the working directory")
        if (!file.exists("X_test.txt")) 
            stop("This script reqires 'X_test.txt' to exist in the working directory")
        if (!file.exists("features.txt")) 
            stop("This script reqires 'features.txt' to exist in the working directory")
        if (!file.exists("activity_labels.txt")) 
            stop("This script requires 'activity_labels.txt' to exist in the working directory")
        if (!file.exists("y_train.txt")) 
            stop("This script requires 'y_train.txt' to exist in the working directory")
        if (!file.exists("y_test.txt")) 
            stop("This script requires 'y_test.txt' to exist in the working directory")
        if (!file.exists("subject_train.txt")) 
            stop("This script reqires 'subject_train.txt' to exist in the working directory")
        if (!file.exists("subject_test.txt")) 
            stop("This script reqires 'subject_test.txt' to exist in the working directory")
    }
    
    ## Step 1
    ## Read in and merge the training and test data sets to create a merged data frame 
    ## The data frame will have the form of (activities:subjects:processed observations(1:561))
    ## Returns the merged data frame
    mergeDataSets <- function() {
        # read in the activities column for the training and test groups and merge them
        # that is, read "y_train.txt" and "y_test.txt" files and row bind them such that
        # input from "y_train.txt" is above that from "y_test.txt"
        ydfTrain <- read.delim("y_train.txt", sep = "", header = FALSE)
        ydfTest <- read.delim("y_test.txt", sep = "", header = FALSE)
        activities_df <- rbind(ydfTrain, ydfTest, make.row.names = FALSE)
        colnames(activities_df) <- "Activity"
        
        # read in the subjects column for the training and test groups and merge them
        # that is, read "subject_train.txt" and "subject_test.txt" files and row bind them such that
        # input from "subjet_train.txt" is above that from "subject_test.txt"
        subjectdfTrain <- read.delim("subject_train.txt", sep = "", header = FALSE)
        subjectdfTest <- read.delim("subject_test.txt", sep = "", header = FALSE)
        subjects_df <- rbind(subjectdfTrain, subjectdfTest, make.row.names = FALSE)
        colnames(subjects_df) <- "Subject"
        
        # read in the observation columns for the training and test groups and merge them
        # that is, read "X_train.txt" and "X_test.txt" files and row bind them such that
        # input from "X_train.txt" is above that from "X_test.txt"
        XdfTrain <- read.delim("X_train.txt", sep = "", header = FALSE)
        XdfTest <- read.delim("X_test.txt", sep = "", header = FALSE)
        observations_df <- rbind(XdfTrain, XdfTest, make.row.names = FALSE)
        # sort out the column names in Step 3 - leave the header as V1:V561

        # need to column bind so as to form a data frame as -
        # (activities:subjects:processed observations(1:561))
        # first column bind subjects to the observation data frame
        the_merged_df <- cbind(subjects_df, observations_df)
        # then column bind activities and return with the result
        cbind(activities_df, the_merged_df)
    }
    
    ## Step 2
    ## Extract from the merged data frame the columns holding the means and standard deviations
    ## that is, extract those columns holding the processed pbservations which are the 
    ## means and standard deviations ofthe original data - see the Codebook
    ## Returns a smaller data frame holding the extracted columns
    ## as well as the Activity and Subject columns
    extract_mean_sd <- function(the_merged_df)  {
        # get the column names of the processed observations from "feature.txt"
        variable_df <- read.delim("features.txt", header = FALSE, sep = "", stringsAsFactors=FALSE)
        # build a list of columns to keep
        columns_to_keep <- (filter(variable_df, grepl("mean", V2) | grepl("std", V2)))
        #add 2 to the values in column V1 of columns_to_keep (the merged data frame has two leading columns)
        keep_these <- c(1, 2, (columns_to_keep$V1 + 2))
        # select out the columns to be kept and return the resultant data frame
        select(the_merged_df, keep_these)
    } 
    
    ## Step 3
    ## Rename the labels used for the activities being undertaken in a more descriptive way
    ## Returns a data frame with activity label codes replace by descriptions
    renameActivities <- function(the_merged_df)  {
        # read in activity labels from the "activity_labels.txt"
        activities_df <- read.delim("activity_labels.txt", header=FALSE, sep = "", stringsAsFactors=FALSE)
        # look through elements of the second column and replace underscores with a space
        activities_df$V2 <- gsub("_", " ", activities_df[ , "V2"])
        # look through the elements of the first column ("Activity") of the passed data frame and 
        # replace activity label code numbers with the corresponding descriptive label
        for (i in 1:nrow(activities_df)) 
            the_merged_df$Activity <- gsub(i, activities_df[i, 2], the_merged_df[ , "Activity"] )
        # return the resultant data frame
        the_merged_df
    }    
    
    ## Step 4
    ## Rename the retained columns of the data frame more descriptively
    ## See the "Codebook.md" file for more information on the meaning of the column names
    ## Returns the data frame with tidier column names
    renameColumns <- function(the_merged_df)  {
        # get the column names of the processed observations from "feature.txt"
        # NOTE !!! this is not efficient as have done this read in already - fix anon
        variable_df <- read.delim("features.txt", header = FALSE, sep = "", stringsAsFactors=FALSE)
        # build a list of columns to keep
        columns_to_keep <- (filter(variable_df, grepl("mean", V2) | grepl("std", V2)))
        # look through the names of the columns kept and tidy up a little
        columns_to_keep$V2 <- gsub("\\(\\)", "", columns_to_keep$V2)
        columns_to_keep$V2 <- gsub("-", "_", columns_to_keep$V2)
        columns_to_keep$V2 <- gsub("BodyBody", "Body", columns_to_keep$V2)
        # rename the processed observation columns of the data frame
        colnames(the_merged_df)[3:ncol(the_merged_df)] <- columns_to_keep$V2
        # return the data frame with its tidier and more descriptive column names
        # refer to the Codebook for interpretation of the brief column names
        the_merged_df
    }
    
    ## Step 5
    ## Build an independent tidy data frame and average each variable for each activity and each subject
    ## Returns the newly built tidy data frame
    calculate_df <- function(the_merged_df)  {
        # calculate the mean of each observation/column for each activity and each subject
        a_tidy_df <- the_merged_df %>% group_by(Activity, Subject) %>% summarise_each(funs(mean))
        # modify the names of the processed observation columns to reflect that a meanhas been taken 
        colnames(a_tidy_df)[3:ncol(a_tidy_df)] <- paste("MEAN(", colnames(a_tidy_df[3:ncol(a_tidy_df)]), sep = "")
        colnames(a_tidy_df)[3:ncol(a_tidy_df)] <- paste(colnames(a_tidy_df[3:ncol(a_tidy_df)]), ")", sep ="")
        a_tidy_df
    }
    
################################################################################################    
    
    ## BODY OF THE FUNCTION
    ##
    ## Preparatory actions
    prepare_for_analysis()
    
    # Do Step 1 - merge training and test data
    merged_df <- mergeDataSets()

    # Do Step 2 - extract columns of means and standard deviations 
    merged_df <- extract_mean_sd(merged_df)

    # Do Step 3 - rebuild the activities undertaken by subjects with descriptive names 
    merged_df <- renameActivities(merged_df)

    # Do Step 4 - tidy up and rename the column names
    merged_df <- renameColumns(merged_df)
    
    # Do Step 5 - calculate means of each variable/observation for each activity and each subject and
    tidy_df <- calculate_df(merged_df)
   
    # Before we go - write out the tidy data frame from Step 5 as the file "tidy.txt"
    write.table(tidy_df, file = "tidy.txt", row.names = FALSE)
    
################################################################################################
}