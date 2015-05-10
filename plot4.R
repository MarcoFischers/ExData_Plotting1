##############################################################
#
# This R script creates plot 4
# the plot shows4 plots
# 1 Active Power average per minute on the timeline
# 2 Voltage average per minute on the timeline
# 3 Sub Metering 1 to 3 average per minute on the timeline
# 4 Reactive Power average per minute on the timeline
#
# Input: file "household_power_consumption.txt" in working directory
#
# Output: file "plot4.png" in working directory
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

# open graphics device to create a PNG file
png(file="plot4.png")

# set 4 plotting areas
par(mfrow=c(2,2), ps=12)

######## first plot ########################################

# draw line plot of variable "global active power"
with(data,
     plot(Global_active_power,
          type="l",
          xaxt="n",     # don't draw X axis labels
          xlab="",
          ylab="Global Active Power (kilowatts)")
)

# draw X axis label for every new day
axis(1, at=date.idx, labels=date.day)

######## second plot ########################################

# draw line plot of variable "voltage"
with(data,
     plot(Voltage,
          type="l",
          xaxt="n",     # don't draw X axis labels
          xlab="datetime",
          ylab="Voltage")
)

# draw X axis label for every new day
axis(1, at=date.idx, labels=date.day)

######## third plot ########################################

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

# draw X axis label for every new day
axis(1, at=date.idx, labels=date.day)

# draw legend in upper right corner
legend("topright",
       lty=1,
       lwd=1,
       col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       bty="n"     # no box around legend           
      )

######## fourth plot ########################################

# draw line plot of variable "global reactive power"
with(data,
     plot(Global_reactive_power,
          type="l",
          xaxt="n",     # don't draw X axis labels
          xlab="datetime")
)

# draw X axis label for every new day
axis(1, at=date.idx, labels=date.day)

# close graphics device
dev.off()
