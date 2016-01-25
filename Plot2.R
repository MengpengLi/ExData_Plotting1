DataRaw <- read.table("household_power_consumption.txt",sep = ";",header = TRUE)

#convert the first column as date
DataRaw$Date <- as.Date(DataRaw$Date,"%d/%m/%Y")   

#convert second column as POSIXlt object
DataRaw$Time <- strptime(DataRaw$Time, format = "%H:%M:%S")

#drop the date part and only take the time part 
DataRaw$Time <- strftime(DataRaw$Time, format = "%H:%M:%S")

#subsetting the Data by date 2007-02-01 and 2007-02-02 and NA value
DataCooked <- DataRaw[(DataRaw$Date == as.Date('2007-02-01') | DataRaw$Date == as.Date('2007-02-02')),]
DataCooked <- DataCooked[DataCooked$Global_active_power != "?" , ]
DataCooked$Global_active_power <- as.numeric(as.character(DataCooked$Global_active_power))

#plot and store the second plot
png("Plot2.png", width=480, height= 480)
DateObj<-as.POSIXct(paste(DataCooked$Date,DataCooked$Time), format="%Y-%m-%d %H:%M:%S")
plot(DateObj, DataCooked$Global_active_power, type= "l", lwd=1, ylab= "Global Active Power (kilowatts)", xlab="")
dev.off()