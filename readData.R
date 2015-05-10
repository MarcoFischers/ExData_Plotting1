##############################################################
#
# This R script defines a function "readDataSubset" for
# reading the data file "household_power_consumption.txt" and
# extracting observations corresponding to 2007 Feb 1 and 2007 Feb 2
#
# Input: file "household_power_consumption.txt" in working directory
#
# Output: data subset
#
##############################################################

readDataSubset <- function() {
    # read file
    # fields separated by ; and first line contains variable names
    # convert any ? to NA 
    # keep first 2 columns as character strings
    filename<-"household_power_consumption.txt"
    df<-read.table(filename, sep=";", header=TRUE, na.strings="?",as.is=c(1,2))
    
    # convert date string into date format: replaces former Date
    df$Date<-as.Date(df$Date,"%d/%m/%Y")
    
    # extract data from dates 2007-02-01 and 2007-02-02
    date.from<-as.Date("2007-02-01","%Y-%m-%d")
    date.until<-as.Date("2007-02-02","%Y-%m-%d")
    df[df$Date >= date.from & df$Date <= date.until, ]
}