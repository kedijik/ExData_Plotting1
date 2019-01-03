
## Check if necessary libraries exist and load
if(!("sqldf" %in% installed.packages()[,"Package"])){
  install.packages("sqldf")
  library(sqldf)}

##Download the file, unzip to the working directory
download.file(url='https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip', destfile='Assignment.zip')
unzip("Assignment.zip","household_power_consumption.txt", overwrite=TRUE)

## Read filtered using read.csv.sql
ReadData<-read.csv.sql("household_power_consumption.txt",sql="select * from file where Date in ('1/2/2007','2/2/2007')", header = TRUE, sep=";")

## Above will read the Date and Time columns as char. To fix that
ReadData$DateTime <- as.POSIXct( strptime(paste(ReadData$Date,ReadData$Time),"%d/%m/%Y %H:%M:%S"))
ReadData$Date <- strptime(ReadData$Date,"%d/%m/%Y")
ReadData$Time <- strptime(ReadData$Time,"%H:%M:%S")

## Create png graphic device. Default height and width matches the requirement so no need to fiddle. 
## Generate the normal line plot which due to date format will print weekdays and close off with dev.off()
png(filename = "plot3.png")
with(ReadData,plot(DateTime,Sub_metering_1, xlab = NA, ylab = 'Energy sub metering', type='n'))
lines(x=ReadData$DateTime,y=ReadData$Sub_metering_1, col="black", lwd=1)
lines(x=ReadData$DateTime,y=ReadData$Sub_metering_2, col="red", lwd=1)
lines(x=ReadData$DateTime,y=ReadData$Sub_metering_3, col="blue", lwd=1)
legend("topright",lwd=c(1,1,1), col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3") )
dev.off()