plot2 <- function(){
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
  plot2 <- power[(power$Date=="2007-02-01") | (power$Date=="2007-02-02"),]
  
  plot2 <- transform(plot2,timestamp=as.POSIXct(paste(Date, Time)), 
                     "%d/%m/%Y %H:%M:%S")
  
  # create plot on default device
  
  plot(plot2$timestamp,plot2$Global_active_power,type="l", xlab="", 
       ylab="Global Active Power (kilowatts)")
  # copy from default device to PNG
  dev.copy(png, file="plot2.png", width=480, height=480)
  dev.off()
  
  cat("Plot2.png saved in", getwd())
}