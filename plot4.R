library(sqldf)

# Download dataset
dataZip <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = dataZip)
dataFolder <- tempdir()
unzip(dataZip, exdir = dataFolder)

# Load data
dataFilePath <- file.path(dataFolder, "household_power_consumption.txt")
data <- read.csv2.sql(dataFilePath, sql = "SELECT * FROM file WHERE Date = '1/2/2007' OR Date = '2/2/2007'")

# Convert time object
data <- transform(data, Time = strptime(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S"))

# Save graphic device to png
png("plot4.png")
# Create graphs
par(mfrow=c(2,2))
# Global Active Power
with(data, plot(Time, Global_active_power, type = "l", ylab = "Global Active Power", xlab = ""))
# Voltage
with(data, plot(Time, Voltage, type = "l", ylab = "Voltage", xlab = "datetime"))
# Energy metering
with(data, {
  plot(Time, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
  lines(Time, Sub_metering_2, col = "red")
  lines(Time, Sub_metering_3, col = "blue")
  legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty=1, bty="n")
})
# Global reactive power
with(data, plot(Time, Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime"))
dev.off()