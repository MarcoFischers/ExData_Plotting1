##############################################################
#
# This R script creates plot 1
# the plot shows a histogram of Active Power average per minute
#
# Input: file "household_power_consumption.txt" in working directory
#
# Output: file "plot1.png" in working directory
#
# Remark: needs utility function in "readData.R" in working directory
#
##############################################################

# include custom function for reading and subsetting data file
source("readData.R")

# read subset of data provided in the original data file
data<-readDataSubset()

# open graphics device to create a PNG file
png(file="plot1.png")

# set font size
par(ps=12)

# draw histogram
hist(data$Global_active_power,
     col="red",
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)",
     ylab="Frequency")

# close graphics device
dev.off()

