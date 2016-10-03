## This script reads in a txt file from a URL and creates "plot 4" (four panes).

# fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2F
# data%2Fhousehold_power_consumption.zip"
# download.file(fileURL, destfile = "./household_power_consumption.txt",
#               method = "curl")
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

par(mfrow = c(2, 2))

# Draw the first plot
# Make plot of global active power vs time for two days of data
plot(febdata$Global_active_power ~ febdata$datetime, febdata, 
     col = "black", xlab = "", ylab = "Global Active Power", 
     type = "l", cex.lab = 0.75, cex.axis = 0.75)

# Draw the second plot
# Make plot of voltage vs time for two days of data
plot(febdata$Voltage ~ febdata$datetime, 
     col = "black", xlab = "datetime", ylab = "Voltage", 
     type = "l", cex.lab = 0.75, cex.axis = 0.75)

# Draw the third plot
# Make a plot of sub metering values vs datetime.
plot(febdata$Sub_metering_1 ~ febdata$datetime, col = "black", xlab = "", 
     ylab = "Energy sub metering", type = "l", cex.lab = 0.75, cex.axis = 0.75)
lines(febdata$Sub_metering_2 ~ febdata$datetime, type = "l", col = "red")
lines(febdata$Sub_metering_3 ~ febdata$datetime, type = "l", col = "blue")
legend("topright", lty = c(1, 1, 1), lwd = c(2.5, 2.5, 2.5), 
       col = c("black", "red", "blue"), 
       c("sub_metering_1", "sub_metering_2", "sub_metering_3"))

# Draw the fourth plot
# Make plot of reactive power vs time for two days of data
plot(febdata$Global_reactive_power ~ febdata$datetime, 
     col = "black", xlab = "datetime", ylab = "Global_reactive_power", 
     type = "l", cex.lab = 0.75, cex.axis = 0.75)

dev.copy(png,'plot4.png')
dev.off()
