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

# Ready for Plot 1
png(file = "plot1.png", bg = "transparent", width = 480, height = 480)
hist(PowerFrame$Global_active_power, 
col = "red", 
xlab = "Global Active Power (kilowatts)", 
ylab = "Frequency"
main = "Global Active Power")
dev.off()

