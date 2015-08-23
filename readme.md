## File name "readme.md"
This Readme file should be read in conjuction with the "README.TXT" which comes with the downloaded data from the 
UCI Machine Learning Repository.

The R script used for this analysis is "run_analysis.R".

This R script looks to the"Human Activity Recognition Using Smartphones Data Set" held at the UCI Machine Learning Repository.
The address for the site is 

[https://archive.ics.uci.edu/ml/datasets.html](https://archive.ics.uci.edu/ml/datasets.html)

The data set is found in the UCI site at 

[https://archive.ics.uci.edu/ml/datasets/human+Activity+recognition+Using+smartphones](https://archive.ics.uci.edu/ml/datasets/human+Activity+recognition+Using+smartphones)

The data set names are found at

[https://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.names](https://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.names)

The link address to the data set is 

[https://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip](https://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip)

The data set used has the following attribution and licence - 

==================================================================================================
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones
using a Multiclass Hardware-Friendly Support Vector Machine. 
International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions
for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

===================================================================================================

The data set unzips to a directory called "UCI HAR Dataset".

The "UCI HAR Dataset" directory contains two necessary ".txt" files - "activity\_labels.txt" and "features.txt".

The "UCI HAR Dataset" directory also has two subdirectories, "test" and "train".

In each of the "test" and "train" subdirectories there are a number of ".txt" files required for this analysis.

The ".txt" files necessary for this analysis are:

    in the "UCI HAR Dataset" directory
        activity_labels.txt
        features.txt
    in the "UCI HAR Dataset\train" subdirectory 
        subject_test.txt
        X_test.txt
        y_test.txt
    in the "UCI HAR Dataset\train" subdirectory 
        subject_train.txt
        X_train.txt
        y_train.txt.

The ".txt" files listed above will need to be found in your working directory for this analysis to run.

The 'X\_train.txt" and "X_test.txt" files contain the processed observations of the original recorded observations
of each subject as they performed the activities a number of times.

This R script requires the "dplyr" package to be installed and it has the following citation -

===================================================================================================
Hadley Wickham and Romain Francois (2015). dplyr: A Grammar of Data Manipulation. 
R package version 0.4.2. 

[http://CRAN.R-project.org/package=dplyr](http://CRAN.R-project.org/package=dplyr)

===================================================================================================

The function "run\_analysis()" performs some preparatory actions and then undertakes five (5) actions/steps.
"run_analysis()" outputs a file named "tidy.txt" to the working directory.

The preparatory activities are coded in a function called "prepare_for_analysis()".
"prepare_for_analysis()" loads the "dplyr" package, suppressing any warnings, and checks that the required ".txt" files are in the working directory.

The five (5) actions/steps have been coded as five (5) functions in the body of "run_analaysis()".

The five (5) functions are:

    1. "mergeDataSets()" reads and then merges the training and test data sets of the processed observations as well as
            subject and activity codes to construct a merged data frame with the form 
	    (activities:subjects:processed observations(1:561)) and returns the data frame so constructed.
	    The activity code column is given the name "Activity"and the subject code column the name "Subject".
	    The column names for the processed observations are of the form V1:V561.

    2. "extract_mean_sd(the_merged_df)" extracts any column of measurement which is a mean or standard deviation from the 
            data frame constructed in Step 1 and returns the modified data frame.  
	    The columns extracted retain their names - V1 etc.

    3. "renameActivities(the_merged_df)" reads in the activity code file and modifies the descriptive actvity label to 
	    remove underscores and replce them with a space.  The Activity column is then processed to chnage the activity codes
	    to the more descriptive activity labels.  The function returns the so modified data frame.

    4. "renameColumns(the_merged_df)" appropriately labels the data frame columns of observations with descriptive column names.
	    For example, column name "V1" becomes "tBodyAcc_mean_X".  Refer to the Codebook for an explanation of the column names.
	    The function returns the so modified data frame.

    5. "calculate_df(the_merged_df)" constructs a new independent tidy data frame with the average of each observation for each
	    activity and each subject.  The observation column names are updated to reflect that a mean has been taken.
	    For example, column name "tBodyAcc_mean_X" becomes "MEAN(tBodyAcc_mean_X)"


The data frame constructed at Step 5 is writen to the file "tidy.txt" in the working directory. 
 
The file "tidy.txt" is written using "write.table" with "row.name = FALSE".

**The data frame is tidy** as it has one column for each variable and each row is an observation of the activity undertaken by a subject and the results of specific processing of the data obtained from the smart phone sensors.

Further the data set has each activity and subject combination appearing just once.  The activity/subject combination form a key to the table.  Each of the activity/subject combinations has associated with it a row of observations - together each observational grouping forms a table.

For further information look to the fully commented "run_analysis.R" script.

The file "Codebook.md" gives a more complete description of the table produced by the function "run_analysis()".

This "readme.md" file and the files "Codebook.md", "run_analysis.R" and "tidy.txt" have been prepared for assessment in the Data Science course Getting and Cleaning Data offerred through the Johns Hopkins University.
 











