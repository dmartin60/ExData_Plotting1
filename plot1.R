###########################################################################################################
#
#  Coursera Exploratory Data Analysis 
#  5-20-2016
#
#  plot1.R 
#
#  Description:
#
#  This script loads the Individual household electric power consumption Data Set and 
#  creates a histogram of the distribution of household global minute-averaged active power (in kilowatt)
#  between 2007-02-01 and 2007-02-02
#
###########################################################################################################
#  1. Ensure Electric Power Consumption data is available & loaded 
    
      rm(list=ls())

      dataUrl <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
      txtFile <- "./household_power_consumption.txt"
      zipFile <- "./household_power_consumption.zip"

    # Get household_power_consumption.txt

      if (!file.exists(txtFile)){

           if(!file.exists(zipFile)){
               download.file(dataUrl, zipFile)
           }
           unzip(zipFile)
      }

    # Load household_power_consumption between 2007-02-01 and 2007-02-02

      EPCData <- read.table( text = grep("^[1,2]/2/2007",readLines(txtFile),value=TRUE),
                             sep = ';', 
                             col.names = c("Date", 
                                           "Time", 
                                           "Global_active_power", 
                                           "Global_reactive_power", 
                                           "Voltage", 
                                           "Global_intensity", 
                                           "Sub_metering_1", 
                                           "Sub_metering_2", 
                                           "Sub_metering_3"), 
                              na.strings = '?')

#  2. Prepare data sample to be graphed/plotted
     
      GAPData <- as.numeric(EPCData$Global_active_power)

#  3. Create a 480 by 480 png of the histogram of Global Active Power between 2007-02-01 and 2007-02-02

    # Create plot1.png

      png("plot1.png", width=480, height=480)

    # Create histogram of Global Active Power sample

      hist(GAPData, 
           col="red", 
           main="Global Active Power", 
           xlab="Global Active Power (kilowatts)")

    # close plot1.png
      
      dev.off()


