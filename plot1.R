## Plot a histogram of Global Active Power frequency from 
## "Individual household eletric power consumption" in the
## period beetween 2007-02-01 and 2007-02-02.

# 1. Download and extract file
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, "household_power_consumption.zip")
unzip("household_power_consumption.zip")

# 2. Load the data 
data <- read.table("household_power_consumption.txt", sep=";", header=TRUE, stringsAsFactors=FALSE, na.strings="?")

# 3. Filtering data
data$DateTime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
initDate <- as.POSIXct("2007-02-01 00:00:00")
endDate <- as.POSIXct("2007-02-02 23:59:59")

# 4. Cleaning data (releasing memory)
data <- data[(data$DateTime >= initDate & data$DateTime <= endDate), c(3,4,5,7,8,9,10)]

# 5. Config plot param
par(mfcol = c(1, 1))

# 6. Plot histogram
with(data, hist(Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (killowatts)"))

# 7. Save PNG file
dev.copy(png, file="plot1.png")
dev.off()