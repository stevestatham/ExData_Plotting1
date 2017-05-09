# This R script will create the second Plot

dataFile <- "data.txt"

# If the input text file does not exist, create it.
if(!file.exists(dataFile)) {
  
  textFile <- "household_power_consumption.txt"
  
  # If the input text file does not exist, create it.
  if(!file.exists(textFile)) {
    
    # Read from the zip file, if it exists.
    zipfile <- "exdata-data-household_power_consumption.zip"
    
    # If the zip file does not exist, download it.
    if(!file.exists(zipFile)){
      
      url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
      download.file(url, destfile=zipFile) #Download the zip file from the url
      
    }
    unzip(zipFile, files=textFile) #Unzip the file previously downloaded
  }  
  # Read the full input text file
  full <- read.table(textFile, header=TRUE, na.strings="?", sep=";")
  # Filter the data for February 1, 2007 or February 2, 2007 only
  filter <- full[(full$Date=="1/2/2007" | full$Date=="2/2/2007" ), ]
  
  # Write the filtered data to a file named data.txt
  write.table(filter,dataFile,sep=";",row.names=FALSE)
}

# Read the filtered data from the file named data.txt
data <- read.table(dataFile, header=TRUE, na.strings="?", sep=";")

#Create a formatted datetime column
data$DateTime <- strptime(paste(data$Date,data$Time), "%d/%m/%Y %H:%M")

# Multiple Plots
par(mfrow=c(2,2))

plot(data$DateTime,data$Global_active_power,xlab ="",ylab = "Global Active Power",type ="l")

#"Voltage Plot ( top right )
plot(data$DateTime,data$Voltage,xlab="datetime",ylab="Voltage",type="l")

#Energy Sub Metering Plot ( bottom left )
plot(data$DateTime,data$Sub_metering_1,xlab="",ylab="Energy sub metering",type="l",col='black')
lines(data$DateTime,data$Sub_metering_2,col="red")
lines(data$DateTime,data$Sub_metering_3,col="blue")

legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
  col = c("black","red","blue"),lty=1,lwd=1,bty="n")

#"Global Reactive Power Plot ( bottom right )
plot(data$DateTime,data$Global_reactive_power,xlab ="datetime",ylab = "Global_reactive_power",
  type ="l")

#copy the plot to a .png file
plotFile <- "plot4.png"
dev.copy(png, file=plotFile, height=480, width=480, bg='transparent')
dev.off()