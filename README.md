Getting-and-Cleaning-Data-Course-Project
Course project for Cousera class Getting and Cleaning Data Course Project

Columns of the output table
The first column is the subject ID. The second column is the activity name. All subsequent columns are means of all observations of the named variable (i.e., the column name) belonging to the group of (subject ID, activity name).

How the script works
STEP1: Read in X variables, subject ID, and Y variable (the activity code) and combine them into a data frame. STEP2: Get the name for the columns and change the column names of the data frame STEP3: Filter columns based on column names, keeping only columns containing mean(), std(), and the subject ID, activity STEP4: Inner join with activity name STEP5: Get per-group mean with each (activity name, subject ID) combination
