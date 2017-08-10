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

#plotting
plot(d$Time,d$Global_active_power,type='l',ylab="Global Active Power (kilowatts)",xlab="")

#png file
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()