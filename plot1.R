
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
ReadData$Date <- strptime(ReadData$Date,"%d/%m/%Y")
ReadData$Time <- strptime(ReadData$Time,"%H:%M:%S")

## Create png graphic device. Default height and width matches the requirement so no need to fiddle. 
## Generate the histogram and close off with dev.off()
png(filename = "plot1.png")
hist(ReadData$Global_active_power, col="Red", xlab="Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()