DataRaw <- read.table("household_power_consumption.txt",sep = ";",header = TRUE)

#convert the first column as date
DataRaw$Date <- as.Date(DataRaw$Date,"%d/%m/%Y")   

#convert second column as POSIXlt object
DataRaw$Time <- strptime(DataRaw$Time, format = "%H:%M:%S")

#drop the date part and only take the time part 
DataRaw$Time <- strftime(DataRaw$Time, format = "%H:%M:%S")

#subsetting the Data by date 2007-02-01 and 2007-02-02 and NA value
DataCooked <- DataRaw[(DataRaw$Date == as.Date('2007-02-01') | DataRaw$Date == as.Date('2007-02-02')),]
DataCooked <- DataCooked[DataCooked$Sub_metering_1 != "?" , ]
DataCooked <- DataCooked[DataCooked$Sub_metering_2 != "?" , ]
DataCooked <- DataCooked[DataCooked$Sub_metering_3 != "?" , ]
DataCooked$Sub_metering_1 <- as.numeric(as.character(DataCooked$Sub_metering_1))
DataCooked$Sub_metering_2 <- as.numeric(as.character(DataCooked$Sub_metering_2))
DataCooked$Sub_metering_3 <- as.numeric(as.character(DataCooked$Sub_metering_3))

#plot and store the second plot
png("Plot3.png", width=480, height= 480)
DateObj<-as.POSIXct(paste(DataCooked$Date,DataCooked$Time), format="%Y-%m-%d %H:%M:%S")
plot(DateObj, DataCooked$Sub_metering_1, type= "l", lwd=1, ylab= "Energy Sub metering", xlab="",col="black")
lines(DateObj,DataCooked$Sub_metering_2,col="red")
lines(DateObj,DataCooked$Sub_metering_3,col="blue")
legend("topright",legend=c("sub_metering_1","sub_metering_2","sub_metering_3"),lty = c(1,1), col = c("black","red","blue"))
dev.off()