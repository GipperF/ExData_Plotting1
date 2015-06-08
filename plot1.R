# Module written by Chris Fahey on June 7, 2015
# Class project for Coursera Course provided by Johns Hopkins University entitled "Exploratory Data Analysis"
# Set up variables for moving to appropriate directory, if needed
DIR_mywd <- "/home/gip/Desktop/Exploratory Data Anal/Proj1"
setwd(DIR_mywd)
SaveToFile <- 0
plotfilename <- "plot1.png"
#Bring in necessary libraries
library(stringi)
library(data.table)

FN_pwr_datazip <- "exdata-data-household_power_consumption.zip"
FN_rawdata <- "household_power_consumption.txt"

if(!file.exists(FN_rawdata)){ 
    download.file(url='https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip' , destfile="data.zip", method="curl") 
    unzip(FN_pwr_datazip) 
} 
colcl <- c(date="character", time="character", globalactivepower="numeric", globalreactive="numeric", voltage="numeric", globalintensity="numeric", submetering1="numeric", submetering2="numeric", submetering3="numeric")
colnm <- c("dt","t","ga","gr","v","gint", "sm1", "sm2", "sm3")
raw <- read.table(file=FN_rawdata, sep=";",na.strings="?",colClasses=colcl, col.names = colnm, header=TRUE)

raw$fd <- paste(raw$dt, raw$t, sep=" ")
head(raw)
raw$datetime <- dmy_hms(raw2$fd)
raw$fd <- NULL
sd1 <- raw[(raw$datetime >= "2007-02-01" & raw$datetime < "2007-02-03"),]
cd1 <- raw[raw$datetime >= "2007-02-01",]

cd2 <- cd1[cd1$datetime < "2007-02-03", ]

relevantdays <- arrange(cd2,datetime)
rm(sd1)
rm(cd1)
rm(cd2)
rm(raw)
############## PLOT CHART  #################
xbreaks <- c(0,2,4,6,8)
xtics <- c(0,2,4,6)
ybreaks <- c(0,200,400,600,800,1000,1200 )
ybreaks

plot.new()
hist(rd$ga,ylim=range(ybreaks),col="red",main="Global Active Power", axes = FALSE, xlab="Global Active Power (kilowatts)",xlim=c(0,6))

axis(1,at=xbreaks,labels=NULL, tck=-0.02)
axis(2,at=ybreaks,ylim=range(ybreaks) )

if(SaveToFile == 1 ){
    x11()
    plot.new()
    png(file=plotfilename)        

    hist(rd$ga,ylim=range(ybreaks),col="red",main="Global Active Power", axes = FALSE, xlab="Global Active Power (kilowatts)",xlim=c(0,6))
    
    axis(1,at=xbreaks,labels=NULL, tck=-0.02)
    axis(2,at=ybreaks,ylim=range(ybreaks) )
    dev.off()
}

