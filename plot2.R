# Module written by Chris Fahey on June 7, 2015
# Class project for Coursera Course provided by Johns Hopkins University entitled "Exploratory Data Analysis"
# Set up variables for moving to appropriate directory, if needed
rm(list=ls())
DIR_mywd <- "/home/gip/Desktop/Exploratory Data Anal/Proj1"
setwd(DIR_mywd)

#Bring in necessary libraries
library(stringi)
library(data.table)

FN_pwr_datazip <- "exdata-data-household_power_consumption.zip"
FN_rawdata <- "household_power_consumption.txt"

SaveToFile <- 0
plotfilename <- "plot2.png"

if(!file.exists(FN_rawdata)){ 
    download.file(url='https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip' , destfile="data.zip", method="curl") 
    unzip(FN_pwr_datazip) 
} 
colcl <- c(date="character", time="character", globalactivepower="numeric", globalreactive="numeric", voltage="numeric", globalintensity="numeric", submetering1="numeric", submetering2="numeric", submetering3="numeric")
colnm <- c("dt","t","ga","gr","v","gint", "sm1", "sm2", "sm3")
raw <- read.table(file=FN_rawdata, sep=";",na.strings="?",colClasses=colcl, col.names = colnm, header=TRUE)

raw$fd <- paste(raw$dt, raw$t, sep=" ")
head(raw)
raw$datetime <- dmy_hms(raw$fd)
raw$fd <- NULL

cd1 <- raw[raw$datetime >= "2007-02-01",]

cd2 <- cd1[cd1$datetime < "2007-02-03", ]

relevantdays <- arrange(cd2,datetime)

rm(cd1)
rm(cd2)
rm(raw)
#####################  NOW PLOT CHART ###########################
plot.new()
#arrange(rd,t)
xbreaks=c("Thu","Fri","Sat")
ybreaks=c(0,2,4,6)
plot(relevantdays$ga, type="l",axes = FALSE, ylab="Global Active Power (kilowatts)", ylim=c(0,7), sub="")
axis(1,at= c(1,1400,2880),labels=xbreaks,tck=-0.02)
axis(2,at= ybreaks,labels=ybreaks,tck=-0.02)
box(which="plot")

if(SaveToFile == 1 ){
    x11()
    plot.new()
    png(file=plotfilename)        
    plot(relevantdays$ga, type="l",axes = FALSE, ylab="Global Active Power (kilowatts)", ylim=c(0,7), sub="")
    axis(1,at= c(1,1400,2880),labels=xbreaks,tck=-0.02)
    axis(2,at= ybreaks,labels=ybreaks,tck=-0.02)
    box(which="plot")

    dev.off()
}

