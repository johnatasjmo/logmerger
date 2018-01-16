# Description
This code is used to collect csv files into a single csv and output in xlsx format.

# Pre-requisite

Install R studio locally https://www.rstudio.com/products/rstudio/download/

Install R Packages
https://youtu.be/3RWb5U3X-T8?t=76


```{r}
Install R packages
install.packages("plyr")
install.packages("dplyr")
install.packages("readr")
install.packages("xlsx")
```

# Working directories

Create working directory to main folder
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

# Instructions

## Preparation
1. Change the main working directory on `setwd("~/rProgramming/TLC")`
2. Verify that you have all folders created and rename as needed
```
inputdir <- "~/rProgramming/TLC/input"
stagedir <- "~/rProgramming/TLC/stage"
outputdir <- "~/rProgramming/TLC/output"
```

### Execution
3. Save all CSV files to be merged in input
4. Open RStudio and open file merge.R
5. Click Run in RStudio
6. Verify output in folders `stage` and `output`

# Technical note
* input files are saved as separated by comma only. Therefore, inporting these files in MS Excel must be imported as separated by `;` only
* output files are separated by comma `,` for easy reading in MS Excel
* All files can be viewed and verified using a text editor
* Regardless of duplication, the script will only keep one unique record of each batch

# To Do
add more files from previous batches saved in xlxs format
