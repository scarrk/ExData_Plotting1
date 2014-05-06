# ----------------------------------------------------------------------------
# Code to build plot4.png as per Peer Assessment details at
# https://class.coursera.org/exdata-002/human_grading/view/courses/972082/assessments/3/submissions
#
# Author:  Kev Scarr
# Date:    May 2014
# Version: 
# ----------------------------------------------------------------------------

#
# ---------------------------  Configuration Section -------------------------
#

#
# ---------------------------  Procedural Section ----------------------------
#
# Read directly from zip file, na.s represented by ?
myData <- read.table(unz("exdata_data_household_power_consumption.zip", "household_power_consumption.txt"), header=TRUE, sep=";", na.strings="?", colClasses=c(rep("character",each=2),rep("numeric",each=7)))

# Subset to dates of interest - 2007-02-01 and 2007-02-02 (data in dd/mm/yyy format, omitting leading zeros)
myData <- myData[ (myData$Date %in% c("1/2/2007","2/2/2007")), ]

# Merge Date & Time columsn into new Column for plots
myData$DateTime <- as.POSIXlt(paste(as.Date(myData$Date , "%d/%m/%Y"),myData$Time,""))

# Create the plot using type="n" in order to add the three data lines and then the legend
png(file="plot4.png",height=480,width=480)
par(mfrow=c(2,2))

## First Plot [Top-Left]
plot(myData$DateTime,myData$Global_active_power,type="n", ylab="Global Active Power", xlab="")
lines(myData$DateTime,myData$Global_active_power)

## Second Plot [Top-Right]
plot(myData$DateTime,myData$Voltage,type="n", ylab="Voltage", xlab="datetime")
lines(myData$DateTime,myData$Voltage)

## Third Plot [Bottom-Left]
plot(myData$DateTime,myData$Sub_metering_1,type="n", ylab="Energy sub metering", xlab="")
lines(myData$DateTime,myData$Sub_metering_1,col="black")
lines(myData$DateTime,myData$Sub_metering_2,col="red")
lines(myData$DateTime,myData$Sub_metering_3,col="blue")
legend("topright", bty="n", lty="solid", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue") )

## Fourth plot [Bottom-right]
plot(myData$DateTime,myData$Global_reactive_power,type="n", ylab="Global_reactive_power", xlab="datetime")
lines(myData$DateTime,myData$Global_reactive_power, lwd=0.1)

dev.off()
