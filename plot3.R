# Read the data from the website, MacOS here
temp <- tempfile()
download.file(“https://d396qusza40orc.cloudfront.net/exdata/data/household_power_consumption.zip”, temp, “curl”)
Mydata <- read.csv(unz(temp, "powerconsumption.txt"), header = TRUE, sep = ";")
unlink(temp)

# Data Cleaning and preparation - same for all plots
MyData <- read.csv(con, header = TRUE, sep = ";")
# Load relevant data into data frame for displaying later
MyData$Date <- as.Date(MyData$Date, format="%d/%m/%Y")

# Extract just the two days as needed
PowerFrame <- MyData[(MyData$Date=="2007-02-01") | (MyData$Date=="2007-02-02"),]

# Convert the types for numeric processing
PowerFrame$Global_active_power <- as.numeric(as.character(PowerFrame$Global_active_power))
PowerFrame$Global_reactive_power <- as.numeric(as.character(PowerFrame$Global_reactive_power))
PowerFrame$Voltage <- as.numeric(as.character(PowerFrame$Voltage))
PowerFrame$Sub_metering_1 <- as.numeric(as.character(PowerFrame$Sub_metering_1))
PowerFrame$Sub_metering_2 <- as.numeric(as.character(PowerFrame$Sub_metering_2))
PowerFrame$Sub_metering_3 <- as.numeric(as.character(PowerFrame$Sub_metering_3))

# Transform the date and time for next plot
PowerFrame <- transform(PowerFrame, datetime=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")

# Ready for Plot 3:
png(file = "plot3.png", bg = "transparent", width = 480, height = 480)
with(PowerFrame, plot(Sub_metering_1 ~ datetime, type = "l", ylab = "Energy submetering", xlab = ""))
with(PowerFrame, lines(Sub_metering_2 ~ datetime, col = “red”))
with(PowerFrame, lines(Sub_metering_3 ~ datetime, col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = c(1,1,1), lwd = c(2.5, 2.5, 2.5))
dev.off()

