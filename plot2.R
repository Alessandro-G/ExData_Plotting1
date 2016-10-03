## This script reads in a txt file from a URL and creates "plot 2".

# fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2F
#             data%2Fhousehold_power_consumption.zip"
# download.file(fileURL, destfile = "./household_power_consumption.txt",
#              method = "curl")
# dateDownloaded <- date()

library(dplyr)
library(lubridate)

# Read the file into R
rawdata <- read.table("household_power_consumption.txt", header = TRUE, 
                      sep = ";", na.strings = "?")

# change the date column from a factor to a date object so it can filter
rawdata$Date <- dmy(rawdata$Date)

# filter on Date for data from 1-2 Feb 2007 for project analysis.
febdata <- filter(rawdata, Date == "2007-02-01" | Date == "2007-02-02")

# Create new variable "datetime" and put in POSXCt format for sorting by hours.
febdata$datetime <- paste(febdata$Date,febdata$Time)
febdata$datetime <- ymd_hms(febdata$datetime)

# Make plot of global active power vs time for two days of data
plot(febdata$Global_active_power ~ febdata$datetime, febdata, 
     col = "black", xlab = "", ylab = "Global Active Power (kilowatts)", 
     type = "l")

dev.copy(png,'plot2.png')
dev.off()


