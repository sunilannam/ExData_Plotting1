plot4 <- function(){
  # file to read from
  file_name <- "household_power_consumption.txt"
  # first read few rows and find each column type
  fewrows <- read.table("household_power_consumption.txt", header = TRUE, 
                        nrows = 3,sep=";")
  classes <- sapply(fewrows,class)
  
  # read entire file with colClasses found previosly
  power <- read.table("household_power_consumption.txt", header = TRUE, 
                      colClasses = classes,na.strings="?",sep=";")
  
  power$Date <- as.Date(power$Date, format="%d/%m/%Y")
  # subset of data for 2 days
  plot4 <- power[(power$Date=="2007-02-01") | (power$Date=="2007-02-02"),]
  
  plot4 <- transform(plot4,timestamp=as.POSIXct(paste(Date, Time)), 
                     "%d/%m/%Y %H:%M:%S")
  
  # create plot on default device
  
  # 2 rows and 2 cols
  par(mfrow=c(2,2))
  
  #Plot #1 
  plot(plot4$timestamp,plot4$Global_active_power, type="l", xlab="", 
       ylab="Global Active Power")
  #Plot #2
  plot(plot4$timestamp,plot4$Voltage, type="l", xlab="datetime", 
       ylab="Voltage")
  
  #Plot #3
  plot(plot4$timestamp,plot4$Sub_metering_1, type="l", xlab="", 
       ylab="Energy sub metering")
  lines(plot4$timestamp,plot4$Sub_metering_2,col="red")
  lines(plot4$timestamp,plot4$Sub_metering_3,col="blue")
  legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ",
        "Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), bty="n", cex=.5)
  
  #Plot #4
  plot(plot4$timestamp,plot4$Global_reactive_power, type="l", xlab="datetime", 
       ylab="Global_reactive_power")
  
  
  # copy from default device to PNG
  dev.copy(png, file="plot4.png", width=480, height=480)
  dev.off()
    
}