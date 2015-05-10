##############################################################
#
# This R script creates plot 3
# Shows the Sub Metering 1 to 3 average per minute on the timeline
#
# Input: file "household_power_consumption.txt" in working directory
#
# Output: file "plot3.png" in working directory
#
# Remark: needs utility function in "readData.R" in working directory
#
##############################################################

# include custom function for reading and subsetting data file
source("readData.R")

# read subset of data provided in the original data file
data<-readDataSubset()

# make sure that data is sorted by date and time
data<-data[order(data$Date,data$Time),]

# open graphics device to create a PNG file
png(file="plot3.png")

# set font size
par(ps=12)

# draw line plot of variable "sub metering 1"
with(data,
     plot(Sub_metering_1,
          type="l",
          xaxt="n",     # don't draw X axis labels
          xlab="",
          ylab="Energy sub metering")
)

# add red line with variable "sub metering 2"
with(data,
     lines(Sub_metering_2,
           type="l",
           col="red")
)

# add blue line with variable "sub metering 3"
with(data,
     lines(Sub_metering_3,
           type="l",
           col="blue")
)

# draw legend in upper right corner
legend("topright",
       lty=1,
       lwd=1,
       col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# build vector with index value of every new date in the data frame
date.idx<-which(data$Time=="00:00:00")

# extract dates into vector
date.date<-data$Date[date.idx]

# extend both vectors by next day
date.date<-c(date.date, data$Date[max(date.idx)]+1)
date.idx<-c(date.idx, nrow(data)+1)

# build vector with English day abbreviations
Sys.setlocale("LC_TIME", "us")
date.day<-format(date.date, "%a")

# draw X axis label for every new day
axis(1, at=date.idx, labels=date.day)

# close graphics device
dev.off()

