# Code to create Plot4: create a grid of four plots:
# Up-left is Plot2 (without units on y-axis)
# Up-right is datetime vs Voltage
# Down-left is Plot3 (without bounding box in legend)
# Down-right is dateime vs Global Reactive Power

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
png(file = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))

# Up-left plot:
plot(data$DateTime, data$Global_active_power, type = "l", xlab = "",
     ylab = "Global Active Power")

# Up-right plot:
plot(data$DateTime, data$Voltage, type = "l", xlab = "datetime",
     ylab = "Voltage")

# Down-left plot
plot(data$DateTime, data$Sub_metering_1, type = "n", xlab = "",
     ylab = "Energy sub metering")
lines(data$DateTime, data$Sub_metering_1, col = "black")
lines(data$DateTime, data$Sub_metering_2, col = "red")
lines(data$DateTime, data$Sub_metering_3, col = "blue")
legend("topright", lty = rep("solid",3), col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty = "n")

# Down-right plot
plot(data$DateTime, data$Global_reactive_power, type = "l", xlab = "datetime",
     ylab = "Global_reactive_power")

dev.off()



