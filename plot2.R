## Download the file and extract in the current dir:
filename<-"household_power_consumption.zip"
if (!file.exists(filename)){
  url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(url, filename)
}  
if (!file.exists("household_power_consumption.txt")) { 
  unzip(filename)
}

# Read only the subset of data - from 2/1/2207 to 2/2/2007
power <- read.table("household_power_consumption.txt",skip=66637 ,nrows=2880,sep=";",na.strings = "?")

# Since we did not read full file, assign actual column names
names(power) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

# converting data and time  
power$Date <- as.Date(power$Date, format = "%d/%m/%Y")
power$DateTime <- as.POSIXct(paste(power$Date, power$Time))

## Plot the line graph for global active power frequency

with(power, plot(DateTime, Global_active_power, type="line", xlab="", ylab="Global Active Power (kilowatts)"))


## Create png file
dev.copy(png,file="plot2.png",width=480, height=480)
dev.off()