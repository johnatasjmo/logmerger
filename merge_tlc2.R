# Set working directory
setwd("~/rProgramming/TLC")
# Set timezone to LAX
Sys.setenv(TZ='America/Los_Angeles')
now <- Sys.time()

# Identify folders for inpit, stage, output
inputdir <- "~/rProgramming/TLC/input"
stagedir <- "~/rProgramming/TLC/stage"
outputdir <- "~/rProgramming/TLC/output"

# load libraries
library(plyr)
library(dplyr)
library(readr)
library(xlsx)

# create an stage file
setwd(stagedir)
stagefile <- file.create("stage.csv")

# Get file list
setwd(inputdir)
filelist <- list.files(full.names = TRUE)

# set headers with batchID at the end
headers <- c("Seq", "Date/Time", "T5", "T4", "T3", "T2", "T1", "Ref mark", "O2 vol%", "Mode", "Blower time", "Blower cycles", "batchID")

# list of batches
list_batchID <- c(list.files(full.names = FALSE) %>%
                     substr( 0, 6))

# Read all csv files in the folder and create a list of dataframes
ldf <- lapply(filelist, read.csv, skip = 9, header = F, sep = ";") %>%
        # add the names
        lapply(setNames, headers )
# add batch to each list based on list_batchID
ldf <- mapply(`[<-`, ldf, 'batchID', value = list_batchID, SIMPLIFY = FALSE)
# merge all rows
ldf <- bind_rows(ldf) 
ldfunique <- unique(ldf)

# save ldf as csv on stage directory
setwd(stagedir)
write.csv(ldf, file = "stage.csv")
# save ldf as xlsx
write.xlsx(x = ldfunique, file = paste0(format(now, "%Y%m%d_%H%M%S_"), "unique.xlsx"),
           sheetName = "Master", row.names = TRUE)

# create a master.xlsx file in output if doesnt exist (first time)
setwd(outputdir)
if(!file.exists("master.xlsx")) {
write.xlsx(x = ldfunique, file = "master.xlsx",
           sheetName = "Master", row.names = TRUE)
}


# read master as csv, without headers, all rows
# (make sure a file named master.xlsx exists in output directory)
setwd(outputdir)
master <- read.xlsx("master.xlsx", 
                     sheetName = "Master", 
                     startRow=1)
# align names of master
names(master) <- headers
master$Seq <- as.numeric(as.character(master$Seq))
# rbind both data.frames
all<- bind_rows(ldfunique, master)
all_unique <- unique(all)

## save to ms excel to stage directory
setwd(outputdir)
# write csv file
write.xlsx(x = all_unique, file = paste0(format(now, "%Y%m%d_%H%M%S_"), "master.xlsx"),
           sheetName = "master", row.names = TRUE)



***********************
        
# to merge two frames
https://stackoverflow.com/questions/27969968/is-there-an-efficient-way-to-append-to-an-existing-csv-file-without-duplicates-i

# merge and save only non-duplicated
# initial data.frame
df1<-data.frame(name=c('a','b','c'), a=c(1,2,2))
write.csv(df1, "export.csv", row.names=FALSE, na="NA")
# a new data.frame with a couple of duplicate rows
df2<-data.frame(name=c('a','b','c'), a=c(1,2,3))
dfRead<-read.csv("export.csv") # read the file
all<-rbind(dfRead, df2) # rbind both data.frames
# get only the non duplicate rows from the new data.frame
nonDuplicate <- all[!duplicated(all)&c(rep(FALSE, dim(dfRead)[1]), rep(TRUE, dim(df2)[1])), ]
# append the file with the non duplicate rows
write.table(nonDuplicate,"export.csv", row.names=F,na="NA",append=T, quote= FALSE, sep=",", col.names=F)



# Read all csv files in the folder and create a list of dataframes
ldf <- lapply(filelist, read.csv, skip = 9, header = F, sep = ";")
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

# name headers
headers <- c("Seq", "Date/Time", "T5", "T4", "T3", "T2", "T1", "Ref mark", "O2 vol%", "Mode", "Blower time", "Blower cycles")






# example of merged
merged <- 
        # list all files
        list.files(full.names = TRUE) %>% 
        # read each file without first 9 lines, without headers only ; as separator
        lapply(read.csv, skip = 9, header = F, sep = ";") %>%

mapply(function(x, y) "[<-"(x, "SampleID", value = y) ,
               batch_list, ID, SIMPLIFY = FALSE)

mapply(function(x, y) "[<-"(x, "SampleID", value = y) ,
       filelist, ID, SIMPLIFY = FALSE)
        
        # put all rows together
        cbind(NewColumn = "batchID")
        bind_rows %>%
        # save merged as csv
        write.csv(merged, file = "outputtest.csv")


filenames <- list.files(path = "./input", pattern = "*", full.names=TRUE)
import.list <- ldply(filenames, read.csv, skip = 9, header = F, sep = ";" )
write.csv(import.list, file = "importlist.csv")




## save to ms excel 
library(xlsx) #load the package
write.xlsx(x = sample.dataframe, file = "test.excelfile.xlsx",
           sheetName = "TestSheet", row.names = FALSE)



