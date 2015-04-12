plot3 <- function(){
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
  plot3 <- power[(power$Date=="2007-02-01") | (power$Date=="2007-02-02"),]
  
  plot3 <- transform(plot3,timestamp=as.POSIXct(paste(Date, Time)), 
                     "%d/%m/%Y %H:%M:%S")
  
  # create plot on default device
  
  plot(plot3$timestamp,plot3$Sub_metering_1,type="l", xlab="", 
       ylab="Energy sub metering")
  lines(plot3$timestamp,plot3$Sub_metering_2,col="red")
  lines(plot3$timestamp,plot3$Sub_metering_3,col="blue")
  legend("topright", col=c("black","red","blue"), 
         c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),
         lty=c(1,1), lwd=c(1,1))
  # copy from default device to PNG
  dev.copy(png, file="plot3.png", width=480, height=480)
  dev.off()
    
}