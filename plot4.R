#download and unzip file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="data.zip")
unzip ("data.zip", exdir = ".")

#read the data and convert dates
data <- read.csv2("household_power_consumption.txt",na.strings = "?")
d<-data
d$Date <- as.Date(d$Date,"%d/%m/%Y")
d$Time <- paste(as.character(d$Date),d$Time)
d$Time <- as.POSIXct(d$Time)
d <- d[which(d$Date  == as.Date("2007-02-01") | d$Date  == as.Date("2007-02-02")), ]
d$Global_active_power <- as.numeric(as.character(d$Global_active_power))
d$Sub_metering_1 <- as.numeric(as.character(d$Sub_metering_1))
d$Sub_metering_2 <- as.numeric(as.character(d$Sub_metering_2))
d$Sub_metering_3 <- as.numeric(as.character(d$Sub_metering_3))

#plotting
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
plot(d$Time,d$Global_active_power,type='l',ylab="Global Active Power (kilowatts)",xlab="")
plot(d$Time,d$Voltage,type='l',ylab="Voltage",xlab="datetime")
with(d, {
  plot(Sub_metering_1~Time, type="l",
       ylab="Global Active Power (kilowatts)", xlab="", cex=0.8)
  lines(Sub_metering_2~Time, col='Red')
  lines(Sub_metering_3~Time, col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=1, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.8)
plot(d$Time,d$Global_reactive_power,type='l',ylab="Global_reactive_power",xlab="datetime")

#png file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
