# Set working directory
setwd("~/rProgramming/TLC")

# Identify folders for inpit, stage, output
inputdir <- "~/rProgramming/TLC/input"
stagedir <- "~/rProgramming/TLC/stage"
outputdir <- "~/rProgramming/TLC/outputdir"

# load libraries
library(plyr)
library(dplyr)
library(readr)

# create an stage file
setwd(stagedir)
stagefile <- file.create("stagefile.csv")

# Get file list
setwd(inputdir)
file_list <- list.files()
n <- length(file_list)

# create a loop
i <- 1
for (i in n ) {
        # extract batch number of files
        batch <- substr(file_list[i], 0, 6),
        df1 = read.csv(file_list[i], skip = 9, header = F, sep = ";"),
        write.csv(df1, file = "./output/df1.csv")
}
***********************

# Read all csv files in the folder and create a list of dataframes
ldf <- lapply(file_list , read.csv, skip = 9, header = F, sep = ";")
# Combine each dataframe in the list into a single dataframe
mergedf <- do.call("rbind", ldf)
colnames(mergedf) = headers
mergedf.clean <- unique(mergedf)
write.csv(mergedf, file = "../output/mergedf.csv")


# example to add header
setwd(inputdir)
file1 <- "R37B19_2016-07-12.CSV"
file2 <- "R38B20_2016-12-23.CSV"
file3 <- "R41B23_2016-08-03.CSV"
df1 = read.csv(file1, skip = 9, header = F, sep = ";")
df2 = read.csv(file2, skip = 9, header = F, sep = ";")
df3 = read.csv(file3, skip = 9, header = F, sep = ";")

headers <- c("Seq", "Date/Time", "T5", "T4", "T3", "T2", "T1", "Ref mark", "O2 vol%", "Mode", "Blower time", "Blower cycles")
df1 = read.csv(file1, skip = 9, header = F, sep = ";")
colnames(df1) = headers
write.csv(df1, file = "./output/df1.csv")
df2 = read.csv(file2, skip = 9, header = headers)
head(df1)
head(df2)

batch = "batchname"

# list of batches
batch_list <- list.files(full.names = FALSE) %>%
        substr( 0, 6)


# example of merged
merged <- 
        # list all files
        list.files(full.names = FALSE) %>% 
        # read each file without first 9 lines, without headers only ; as separator
        lapply(read.csv, skip = 9, header = F, sep = ";") %>% 
        # put all rows together
        bind_rows %>%
        cbind(batch = batch_list) %>%
        # save merged as csv
        write.csv(merged, file = "outputtest.csv")


filenames <- list.files(path = "./input", pattern = "*", full.names=TRUE)
import.list <- ldply(filenames, read.csv, skip = 9, header = F, sep = ";" )
write.csv(import.list, file = "importlist.csv")




## save to ms excel 
library(xlsx) #load the package
write.xlsx(x = sample.dataframe, file = "test.excelfile.xlsx",
           sheetName = "TestSheet", row.names = FALSE)



