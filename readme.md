# Description
This code is used to collect csv files into a single csv and output in xlsx format.

# Pre-requisite

Install R locally
```{r}
Install R packages
install.packages("plyr")
install.packages("dplyr")
install.packages("readr")
install.packages("xlsx")
```

# Working directories

Set working directory to main folder
Inside main directory, this folders must be created
/input
/output
/stage

`input` folder is where all CSV files to merge must be located (i.e. R37B19_2016-07-12.CSV)
`stage` folder will save CSV files before saving to xlsx format
`output` folder will contain xlxs file compiled

# Process
The script executes below process:
* reads all csv files and creates a list to be processed
* reads all batches from csv files
* creates data tables for each csv file and adds the batch
* creates a single csv file
* removes duplicate lines
* saves all merged files as CSV
* saves all files as xlsx format

# To Do
add more files from previous batches saved in xlxs format
