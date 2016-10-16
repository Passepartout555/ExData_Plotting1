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

# Plot 4 is a 2 x 2 arrangement comprising of 
#  |------------------------------------------------------|
#  |                    |                                 |
#  |                    |                                 |
#  |  PLOT 1            | See Plot 2, but voltage         |
#  |                    |                                 |
#  |                    |                                 |
#  |------------------------------------------------------|
#  |                    |                                 |
#  |                    |                                 |
#  | PLOT 3             | See Plot 2, but reactive power  |
#  |                    |                                 |
#  |                    |                                 |
#  |------------------------------------------------------|
# Ready for Plot 4
png(file = "plot4.png", bg = "transparent", width = 480, height = 480)
par(mfrow=c(2,2))
#--------------------------------------------------------------------------
# First part (see Plot 2) on Position 1
with(PowerFrame, plot(Global_active_power ~ datetime, type = "l", ylab = "Global Active Power (kilowatts)", xlab = ""))
#--------------------------------------------------------------------------
# Second part on Position 2
with(PowerFrame, plot(Voltage ~ datetime, type = "l", ylab = "Voltage"))
#--------------------------------------------------------------------------
# Third part (see Plot 3) on Position 3
with(PowerFrame, plot(Sub_metering_1 ~ datetime, type = "l", ylab = "Energy submetering", xlab = ""))
with(PowerFrame, lines(Sub_metering_2 ~ datetime, col = “red”))
with(PowerFrame, lines(Sub_metering_3 ~ datetime, col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = c(1,1,1), lwd = c(2.5, 2.5, 2.5))
#--------------------------------------------------------------------------
# Forth part on Position 4
with(PowerFrame, plot(Global_reactive_power ~ datetime, type = "l"))
#--------------------------------------------------------------------------
