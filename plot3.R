# Code to create Plot3: line graph of Time vs the three sub metering measurements
# Sub_metering_1 should be black
# Sub_metering_2 should be red
# Sub_metering_3 should be blue

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

# add new variable for Date-Time with class POSIXlt
data <- mutate(data, DateTime = paste(Date, Time, sep = " "))
data$DateTime <- strptime(data$DateTime, "%d/%m/%Y %H:%M:%S")

# line plot of Global active power over time
png(file = "plot3.png", width = 480, height = 480)
plot(data$DateTime, data$Sub_metering_1, type = "n", xlab = "",
     ylab = "Energy sub metering")
lines(data$DateTime, data$Sub_metering_1, col = "black")
lines(data$DateTime, data$Sub_metering_2, col = "red")
lines(data$DateTime, data$Sub_metering_3, col = "blue")
legend("topright", lty = rep("solid",3), col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()



