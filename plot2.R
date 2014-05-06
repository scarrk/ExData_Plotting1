# ----------------------------------------------------------------------------
# Code to build plot2.png as per Peer Assessment details at
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

png(file="plot2.png",height=480,width=480)
plot(myData$DateTime,myData$Global_active_power,type="n", ylab="Global Active Power (kilowatts)", xlab="")
lines(myData$DateTime,myData$Global_active_power)
dev.off()

