## This script reads in a txt file from a URL and creates "plot 3".

# fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2F
# data%2Fhousehold_power_consumption.zip"
# download.file(fileURL, destfile = "./household_power_consumption.txt",
#              method = "curl")
# dateDownloaded <- date()

library(dplyr)
library(lubridate)

# Read the file into R
rawdata <- read.table("household_power_consumption.txt", header = TRUE, 
                      sep = ";", na.strings = "?")

# change the date column from a factor to a date object
rawdata$Date <- dmy(rawdata$Date)

# filter on date for data from 1-2 Feb 2007 for project analysis.
febdata <- filter(rawdata, Date == "2007-02-01" | Date == "2007-02-02")

# Create new variable "datetime" and put in POSXCt format for sorting by hours.
febdata$datetime <- paste(febdata$Date,febdata$Time)
febdata$datetime <- ymd_hms(febdata$datetime)

# Make a plot of sub metering values vs datetime.
plot(febdata$Sub_metering_1 ~ febdata$datetime, col = "black", xlab = "", 
     ylab = "Energy sub metering", type = "l")
lines(febdata$Sub_metering_2 ~ febdata$datetime, type = "l", col = "red")
lines(febdata$Sub_metering_3 ~ febdata$datetime, type = "l", col = "blue")


legend("topright", lty = c(1, 1, 1), lwd = c(2.5, 2.5, 2.5), 
       col = c("black", "red", "blue"), legend = 
       c("sub_metering_1", "sub_metering_2", "sub_metering_3"))

dev.copy(png,'plot3.png')
dev.off()