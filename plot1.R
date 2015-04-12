plot1 <- function(){
  # file to read from
  file_name <- "household_power_consumption.txt"
  # first read few rows and find each column type
  fewrows <- read.table("household_power_consumption.txt", header = TRUE, nrows = 3,sep=";")
  classes <- sapply(fewrows,class)
  
  # read entire file with colClasses found previosly
  power <- read.table("household_power_consumption.txt", header = TRUE, colClasses = classes,na.strings="?",sep=";")
  
  # subset of data for 2 days
  plot1 <- power[(power$Date=="1/2/2007") | (power$Date=="2/2/2007"),]
  
  # create histogram on default device
  hist(plot1$Global_active_power, main = paste("Global Active Power"), col="red", xlab="Global Active Power (kilowatts)")
  
  # copy from default device to PNG
  dev.copy(png, file="plot1.png", width=480, height=480)
  dev.off()
  
  cat("Plot1.png saved in", getwd())
}