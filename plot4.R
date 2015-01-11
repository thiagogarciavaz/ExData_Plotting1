## Plot a panel chart with variables from 
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
par(mfcol = c(2, 2))

# 6. Plot panel chart
with(data, plot(DateTime, Global_active_power, type="l", ylab="Global Active Power (killowatts)", xlab=""))

with(data, plot(DateTime, Sub_metering_1, col="black", type="l", ylab="Energy sub metering", xlab=""))
with(data, lines(DateTime, Sub_metering_2, col="red"))
with(data, lines(DateTime, Sub_metering_3, col="blue"))
legend("topright", col=c("black", "red", "blue"), lwd=1, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

with(data, plot(DateTime, Voltage, type="l", ylab="Voltage", xlab="datetime"))

with(data, plot(DateTime, Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime"))

# 7. Save PNG file
dev.copy(png, file="plot4.png")
dev.off()