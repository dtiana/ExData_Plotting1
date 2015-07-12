
## loading data in usefull formats and subsetting on the date of 2007-02-01 & 2007-02-02

data = read.table("household_power_consumption.txt", na.strings="?", sep=";", as.is=T, header=T, colClasses= c("character", "character", "double", "double", "double", "double", "double", "double", "double"))

subdata = data[data$Date=="1/2/2007" | data$Date=="2/2/2007",]; rm(data)

## convert date and time in a single POSIXlt variable DateTime 

temp = paste(subdata$Date[1], subdata$Time[1])

for(i in 2:length(subdata$Date)){
                                   temp = c(temp, paste(subdata$Date[i], subdata$Time[i]))
                                 }
                
temp = strptime(temp, format="%d/%m/%Y %H:%M:%S")

dataok=data.frame(DateTime=temp, subdata) ; rm(temp, i) 
                
## PLOTTING histogram of Global Active Power and saving as png

png(filename = "plot4.png", width = 504, height = 504);

par(mfrow = c(2, 2))

plot(dataok$DateTime, dataok$Global_active_power, type="l", xlab="", ylab="Global Active Power")

plot(dataok$DateTime, dataok$Voltage, type="l", xlab="datetime", ylab="Voltage")


## START:just a marker for code of third panel plot

xmin = dataok$DateTime[1]; xmax = dataok$DateTime[2880]

plot(dataok$DateTime, dataok$Sub_metering_1, type = "n", ann = F, xlim = c(xmin, xmax), ylim = c(0.0, 38.0))

par(new=T)

plot(dataok$DateTime, dataok$Sub_metering_1, type = "l", ann = F)

par(new=T)

plot(dataok$DateTime, dataok$Sub_metering_2, type = "l", ann = F, col="red", xlim = c(xmin, xmax), ylim = c(0.0, 38.0))

par(new=T)

plot(dataok$DateTime, dataok$Sub_metering_3, type = "l", ann = F, col="blue", xlim = c(xmin, xmax), ylim = c(0.0, 38.0))

par(new=T)

title(ylab="Energy sub metering")

par(new=T)

legend(x="topright",legend= c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=1, col= c("black", "red", "blue"))

## END:just a marker for code of third panel plot

 
 plot(dataok$DateTime, dataok$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()
