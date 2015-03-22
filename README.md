# How the script works
## Step1-4, Tidy data1
  Read data sets and combine them.
  Read subjects and combine them.
  Read data labels and combine them.
  Read features.
  Subset only measurements on the mean and standard deviation for each measurement.
  Rename features to make it human readable.
  Read activity list.
  Rename activities to make it human readable.
  Rename data labels with activity name.
  Merge data, subjects, and labels to a single tiny data set.
  Write first tiny data set to file.
  
## Step 5, Tidy data2
Prepare empty data set.
Loop through subjects, then subloop through activities.
Get the full list of measurements of each activity in a subject.
Calculate the mean of each activities.
Place the means in the columns next to subject/activity row.
Write second tiny data set to file.

