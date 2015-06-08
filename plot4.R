# Module written by Chris Fahey on June 7, 2015
# Class project for Coursera Course provided by Johns Hopkins University entitled "Exploratory Data Analysis"
# Set up variables for moving to appropriate directory, if needed
DIR_mywd <- "/home/gip/Desktop/Exploratory Data Anal/Proj1"
setwd(DIR_mywd)

#Bring in necessary libraries
library(stringi)
library(data.table)

# Save initial plot parameters

# old.par <- par()
SaveToFile <- 0
plotfilename <- "plot4.png"

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
# head(raw)
raw$datetime <- dmy_hms(raw$fd)
raw$fd <- NULL
# sd1 <- raw[(raw$datetime >= "2007-02-01" & raw$datetime < "2007-02-03"),]
cd1 <- raw[raw$datetime >= "2007-02-01",]

cd2 <- cd1[cd1$datetime < "2007-02-03", ]

relevantdays <- arrange(cd2,datetime)

rm(cd1)
rm(cd2)
rm(raw)

#####################  NOW PLOT CHART ###########################
plot.new()
par(mfrow=c(2,2)) #Prep for 4 charts in space of 2 charts, Left, Right, then down, Left Right
# par(mfrow=c(1,1))
#############  CHART 1  - GLOBAL ACTIVE POWER #####################
xbreaks=c("Thu","Fri","Sat")
ybreaks=c(0,2,4,6)
plot(relevantdays$ga, type="l",axes = FALSE, ylab="Global Active Power (kilowatts)", ylim=c(0,7), sub="")
axis(1,at= c(1,1400,2880),labels=xbreaks,tck=-0.02)
axis(2,at= ybreaks,labels=ybreaks,tck=-0.02)
box(which="plot")

#############  CHART 2 - VOLTAGE  #####################
ybreaks=c(234,238,242,246)
ytics=c(234,236,238,240,242,244,246)
xbreaks=c("Thu","Fri","Sat")
plot(relevantdays$v,type="l", axes = FALSE, ylab="Voltage", col="black",  sub="") 
axis(1,at= c(1,1400,2880),labels=xbreaks,tck=-0.02)
axis(2,at= ybreaks,labels=ybreaks,tck=-0.02)
box(which="plot")

#############  CHART 3 - ENERGY SUB METERING #####################
xbreaks=c("Thu","Fri","Sat")
ybreaks=c(0,10,20,30)
plot(c(relevantdays$sm1), type="n",axes=FALSE, ylab="Energy sub metering",xlab=" ", ylim=c(0,40))

axis(1,at= c(1,1400,2880),labels=xbreaks,tck=-0.02)
axis(2,at= ybreaks,labels=ybreaks,tck=-0.02)

y <- relevantdays$sm1
points(y,type="l", col="black")

y <- relevantdays$sm2
points(y,col="red", type="l")

y <- relevantdays$sm3
points(y,col="blue", type="l")

box(which="plot")
ltext <- c("Sub_metering_1", "Sub_metering_2","Sub_metering_3")
linecols <- c("black", "red", "blue")
legend("topright",ltext,lwd=3,col=linecols)

#############  CHART 4 - GLOBAL REACTIVE POWER #####################
xbreaks=c("Thu","Fri","Sat")
ybreaks=c(0,0.1, 0.2,0.3,0.4,0.5)
#par(mar=c(2,4,2,2))
plot(relevantdays$gr,type="l",axes=FALSE, ylab="Global_reactive_power", ylim=c(0,0.5), sub="datetime",xlab="")
axis(1,at= c(1,1400,2880),labels=xbreaks,tck=-0.02)
axis(2,at= ybreaks,labels=ybreaks,tck=-0.02)
box(which="plot")

#####################  NOW POSSIBLY SAVE FILE  ##################
if(SaveToFile == 1 ){
    x11()
    plot.new()
    png(file=plotfilename)        

    #####################  NOW PLOT CHART ###########################
    plot.new()
    par(mfrow=c(2,2)) #Prep for 4 charts in space of 2 charts, Left, Right, then down, Left Right
    
    #############  CHART 1  - GLOBAL ACTIVE POWER #####################
    xbreaks=c("Thu","Fri","Sat")
    ybreaks=c(0,2,4,6)
    plot(relevantdays$ga, type="l",axes = FALSE, ylab="Global Active Power (kilowatts)", ylim=c(0,7), sub="")
    axis(1,at= c(1,1400,2880),labels=xbreaks,tck=-0.02)
    axis(2,at= ybreaks,labels=ybreaks,tck=-0.02)
    box(which="plot")
    
    #############  CHART 2 - VOLTAGE  #####################
    ybreaks=c(234,238,242,246)
    ytics=c(234,236,238,240,242,244,246)
    xbreaks=c("Thu","Fri","Sat")
    plot(relevantdays$v,type="l", axes = FALSE, ylab="Voltage", col="black",  sub="") 
    
    axis(1,at= c(1,1400,2880),labels=xbreaks,tck=-0.02)
    axis(2,at= ybreaks,labels=ybreaks,tck=-0.02)
    box(which="plot")
    
    #############  CHART 3 - ENERGY SUB METERING #####################
    xbreaks=c("Thu","Fri","Sat")
    ybreaks=c(0,10,20,30)
    plot(c(relevantdays$sm1), type="n",axes=FALSE, ylab="Energy sub metering",xlab=" ", ylim=c(0,40))
    
    axis(1,at= c(1,1400,2880),labels=xbreaks,tck=-0.02)
    axis(2,at= ybreaks,labels=ybreaks,tck=-0.02)
    
    y <- relevantdays$sm1
    points(y,type="l", col="black")
    
    y <- relevantdays$sm2
    points(y,col="red", type="l")
    
    y <- relevantdays$sm3
    points(y,col="blue", type="l")
    
    box(which="plot")
    ltext <- c("Sub_metering_1", "Sub_metering_2","Sub_metering_3")
    linecols <- c("black", "red", "blue")
    legend("topright",ltext,lwd=3,col=linecols)
    
    #############  CHART 4 - GLOBAL REACTIVE POWER #####################
    xbreaks=c("Thu","Fri","Sat")
    ybreaks=c(0,0.1, 0.2,0.3,0.4,0.5)

    plot(relevantdays$gr,type="l",axes=FALSE, ylab="Global_reactive_power", ylim=c(0,0.5), sub="datetime",xlab="")
    axis(1,at= c(1,1400,2880),labels=xbreaks,tck=-0.02)
    axis(2,at= ybreaks,labels=ybreaks,tck=-0.02)
    box(which="plot")
    
    dev.off()
}

