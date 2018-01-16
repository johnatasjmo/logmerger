# Set working directory
setwd("~/rProgramming/TLC")
# Set timezone to LAX
Sys.setenv(TZ='America/Los_Angeles')
now <- Sys.time()

# Identify folders for input, stage, output
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
# remove duplicates
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
#setwd(outputdir)
#master <- read.xlsx2("master.xlsx", 
#                     sheetName = "Master", 
#                     startRow=1)
# align names of master
#names(master) <- headers
#master$Seq <- as.numeric(as.character(master$Seq))
# rbind both data.frames
#all<- bind_rows(ldfunique, master)
#all_unique <- unique(all)

## save to ms excel to stage directory
#setwd(outputdir)
# write csv file
#write.xlsx(x = all_unique, file = paste0(format(now, "%Y%m%d_%H%M%S_"), "master.xlsx"),
#           sheetName = "master", row.names = TRUE)

