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
png("plot2.png")
# Create graph
with(data, plot(Time, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = ""))
dev.off()