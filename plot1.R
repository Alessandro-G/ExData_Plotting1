## This script reads in a txt file from a URL and creates "plot 1".

#    fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2F
#                    data%2Fhousehold_power_consumption.zip"
#    download.file(fileURL, destfile = "./household_power_consumption.txt",
#                      method = "curl")
#   dateDownloaded <- date()

    library(dplyr)
    library(lubridate)
    
# Read the file into R
rawdata <- read.table("household_power_consumption.txt", header = TRUE, 
                      sep = ";", na.strings = "?")

# change the date column from a factor to a date object
rawdata$Date <- dmy(rawdata$Date)

# filter on date for data from 1-2 Feb 2007 for project analysis.
febdata <- filter(rawdata, Date == "2007-02-01" | Date == "2007-02-02")

# Plot a histogram of global active power
hist(febdata$Global_active_power, col = "red", 
     xlab = "Global Active Power 
     (kilowatts)", main = "Global Active Power")
dev.copy(png,'plot1.png')
dev.off()
