# Code to create Plot1: red histogram of Global Active Power vs Frequency

library(dplyr)

# download data if not already in folder
if (!file.exists("household_power_consumption.zip")) {
    fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileURL,
                  dest = "household_power_consumption.zip",
                  method = "curl")
    unzip("household_power_consumption.zip")
    rm(fileURL)
}

# read in the desired data - starts on line 66638, ends on 69517, total 2880 lines
data <- read.table("household_power_consumption.txt", sep = ";",
                   skip = 66637, nrows = 2880,
                   col.names = c("Date", "Time", "Global_active_power",
                                 "Global_reactive_power", "Voltage",
                                 "Global_intensity", "Sub_metering_1",
                                 "Sub_metering_2", "Sub_metering_3"))


# Create a red histogram of Global_active_power, 12 or 16 bars
png(file = "plot1.png", width = 480, height = 480)
hist(data$Global_active_power, col = "red",
     xlab = "Global Active Power (kilowatt)",
     main = "Global Active Power")
dev.off()