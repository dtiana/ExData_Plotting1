
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

png(filename = "plot2.png", width = 504, height = 504)

 plot(dataok$DateTime, dataok$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()
