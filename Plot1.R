# This R script will create the first Plot

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

#plot the data
xlab="Global Active Power (kilowatts)"
main="Global Active Power"
hist(data$Global_active_power, main=main, xlab=xlab, 
     ylab="Frequency", col="Red", cex.sub=0.8)

#copy the plot to a .png file
plotFile <- "plot1.png"
dev.copy(png, file=plotFile, height=480, width=480, bg='transparent')
dev.off()