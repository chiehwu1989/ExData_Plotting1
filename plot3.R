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
png("plot3.png")
# Create graph
with(data, plot(Time, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = ""))
with(data, lines(Time, Sub_metering_2, col = "red"))
with(data, lines(Time, Sub_metering_3, col = "blue"))
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty=1)
dev.off()