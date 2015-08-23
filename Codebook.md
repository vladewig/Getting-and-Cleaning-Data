## File name "Codebook.md"

**Title:** Further Processing of Data Obtained from Samsung Galaxy S Smartphone Sensors

**Description:**  A tidy data set of summary data is built from previously processed data collected 
from a Samsung S smartphone's sensors for activities undertaken by wearers. 

**Citation of sources:** The source data set used for this analysis has the following attribution and licence
 
==================================================================================================
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. 
Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. 
International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors 
or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

===================================================================================================

**Data Disclaimer:** The data being described and this document are offerred for the purpose of meeting the 
assessment requiremnts in the Data Science course Getting and Cleaning Data offerred by Johns Hopkins 
University and for no other purpose.  

To be clear, it is offerred as is and no responsibility is accepted for the uses of this data and 
documentation or for any and all interpretation or inferences made based upon any such uses.

**Data Collection Description:** The data was collected as follows from the "Human Activity Recognition Using 
Smartphones Data Set" held at the UCI Machine Learning Repository.  The address for the site is 
[https://archive.ics.uci.edu/ml/datasets.html](https://archive.ics.uci.edu/ml/datasets.html).

The source data set is found in the UCI site at
 
[https://archive.ics.uci.edu/ml/datasets/human+Activity+recognition+Using+smartphones](http://https://archive.ics.uci.edu/ml/datasets/human+Activity+recognition+Using+smartphones)

The source data set names are found at 

[https://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.names](https://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.names)

The link address to the source data set is 

[https://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip](https://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip)

The source data set unzips to a directory called "UCI HAR Dataset".
The "UCI HAR Dataset" directory contains two necessary ".txt" files - "activity_labels.txt" and "features.txt".
The "UCI HAR Dataset" directory also has two subdirectories, "test" and "train".
In each of the "test" and "train" subdirectories there are a number of ".txt" files required for this analysis.

The ".txt" files necessary for this analysis are

    in the "UCI HAR Dataset" directory
        activity_labels.txt
        features.txt
	in the "UCI HAR Dataset\test" subdirectory
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

The "README.TXT" file downloaded and unzipped into the "UCI HAR Dataset" directory provides further information.

Thirty (30) volunteer subjects performed six (6) activities a number of times while wearing a Samsung 
Galaxy S smartphone.  Subjects were aged 19 to 48 years and were given a unique identifying number from 1 to 30.

The activities involved laying, sitting, standing, walking, walking downstairs and walking upstairs.

The original study retieved data from two inbuilt sensors of the phone - an accelerometer and a gyroscope. 
An accelerometer provides information on the linear acceleration of the phone (wearer) in the X, Y and Z direction.
Linear acceleration is in standard gravity units 9.8 meters/second/second.

A gyroscope provides information on the angular velocity of the phone in the X, Y and Z direction.
Angular velocity is in units of radians/second.
The measurements are processed.  They are normalised and bounded in the range [-1, 1].

The data used from the UCI Machine Learning Repository has already been processed.  The data used for this analysis was provided as train(ing) and test ".txt" files.  The fields are white space delimited.

Once read in the ".txt" files need to be further manipulated.

The train(ing) and test files need to be attached.  The test data sets need to be appended to the bottom of the train(ing) data set.  
The activity data set is constructed from the "y\_train.txt" and "y\_test.txt" files.
The subject data set is constructed from the "Subject\_train.txt" and the "Subject\_test.txt" files.
The pre-processed observation data set is constructed from the "X\_train.txt" and the "X\_test.txt" files.

A data set with 10299 rows is obtained from the original appended data sets.
The primary data set used for this analysis is constructed by column binding the activty, subject and 
observarion data sets.  The form of that data set is (activity:subject:processed observations(1:561)).
There are 10299 rows and 563 columns.  This constructed data set has no row column or header row.

Not all of the observation data is required.  This analysis is concerned with the mean and standard deviation measurements on the original data from the sensors.  

**Note** that this analysis does not include any observations looking at the phase angle between any average measurements.

The data set constructed has 81 columns.  An activity and a subject column and 79 observation columns.
There is no row name column.
The data set has one header row and 180 data rows.  The 180 data rows consist of the summary data of six (6)
actvities undertaken by thirty (30) subjects.  

Subject column data is coded by an integer 1 to 30 inclusive. 

Activity column data is coded as a character phrase as described above - "laying" etc.

Observation data lies between -1 and 1 inclusive and is stored as a real double precision number. 

The data set is summarised by taking the mean of each activity/suject combination.

The summary observation columns have abreviated descriptive column names.

The "feature_info.txt" file downloaded and unzipped into the "UCI HAR Dataset" directory provides further information.

The summary observation column names have the general form - 

**MEAN([t,f][[[Body, Gravity][Acc, Gyro]][["", Jerk]["", Mag]]]-[mean, std, meanFreq]-["", X, Y, Z])**

**Explanation**

**MEAN()** the mean of the measurements within the brackets

**[t, f]**

"t" and "f" refer to the time and frequency domains of the measurements.  The frequency domain is obtained by a
Fast Fourier Transform on the corresponding time signals.

**[[Body, Gravity][Acc, Gyro]]**

The signal from the accelerometer is processed to provide the linear acceleration "Acc" due to gravity and of the body.
The gyroscope measures the angular acceleration "Gyro" of the body.

Combinations are "BodyAcc", "BodyGyro" and "GravityAcc".

**[["", Jerk]["", Mag]]**

"Jerk" refers to the differentiation, with respect to time, of linear acceleration and of angular acceleration
Linear jerk has units of gravity units/second (units of 9.8 meters/second/second/second) and angular jerk has units
of radians/second/second/second.

"Mag" refers to the magnituded of the signal as derived by calculating the Euclidean norm of the X, Y, and Z signals.

Combinations are "", "Jerk", "Mag" and "JerkMag".

**[[[Body, Gravity][Acc, Gyro]][["", Jerk]["", Mag]]]**

Combinations are 

"BodyAcc", "BodyAccJerk", "BodyAccMag", "BodyAccJerkMag";

"BodyGyro", "BodyGyroJerk", "BodyGyroMag", "BodyGyroJerkMag";

"GravityAcc", "GravityAccMag".

There is no "GravityAccJerk" and no "GravityAccJerkMag".

**[mean, std, meanfreq]**

"mean" refers to the meanof the observations.  "std" refers to standard deviation and "meanFreq" is the weighted
average of the frequency components.

**["", X, Y, Z]** 

Either no interest in the direction (eg if observation is of gravity or looking at a magnitude of a signal) or X, Y, or Z.

**Examples - for the time domain**

 **tBodyAcc\_mean_X**       "Time domain mean linear acceleration of the body in the X-axis".

 **tBodyAcc\_std_Y**        "Time domain standard deviation of the linear acceleration of the body in the Y-axis".

 **tBodyAccJerk\_mean_Z**   "Time domain mean linear jerk of the body in the Z-axis".

 **tBodyAccJerk\_std_Y**    "Time domain standard deviation of the linear jerk of the body in the Y-axis".

 **tBodyGyro\_mean_X**     "Time domain mean angular velocity of the body in the X-axis".

 **tBodyGyro\_std_Y**      "Time domain standard deviation of the angular velocity of the body in the Y-axis".

**tBodyGyroJerk\_mean_Z**  "Time domain mean angular jerk of the body in the Z-axis".

 **tBodyGyroJerk\_std_Y**   "Time domain standard deviation of the angular jerk of the body in the Y-axis".

 **tBodyAccMag\_mean**      "Time domain mean Euclidean normalised magnitude of the linear acceleration of the body".

 **tBodyAccMag\_std**       "Time domain standard deviation of the normalised magnitude of the linear acceleration of the body".

 **tGravityAcc\_mean_X**    "Time domain mean linear acceleration of the body due to gravity in the X-axis".

 **tGravityAcc\_std_Z**     "Time domain standard deviation of the linear acceleration of the body due to gravity in the Z-axis ".

 **tGravityAccMag\_mean**   "Time domain mean normalised magnitude of the linear acceleration of the body due to gravity".

 **tgravityAccMa\g_std**    "Time domain standard deviation of the magnitude of the linear acceleration of the body due to gravity".

 **tBodyAccJerkMag\_mean**  "Time domain mean Euclidean normalised magnitude of the linear jerk of the body".

 **tBodyAccJerkMag\_std**   "Time domain standard deviation of the Euclidean normalised magnitude of the linear jerk of the body".

 **tBodyGyroMag\_mean**     "Time domain mean Euclidean normalised magnitude of the angular velocity of the body".

 **tBodyGyroMag\_std**      "Time domain standard deviation of the Euclidean normalised magnitude of the angular velocity of the body".

 **tBodyGyroJerkMag\_mean** "Time domain mean Euclidean normalised magnitude of the angular jerk of the body".

 **tBodyGyroJerkMag\_std**  "Time domain standard deviation of the Euclidean normalised magnitude of the angular jerk of the body".

 **MEAN(tBodyAcc\_mean_X)** "The mean of an activity/subject combination of observations - in this instance the time domain	mean linear acceleration of the body in the X-axis."

The frequency domain is similarly described.