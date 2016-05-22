###########################################################################################################
#
#  Coursera Exploratory Data Analysis
#  Don Martin 
#  5-20-2016
#
#  Plot2.R 
#
#  Description:
#
#  This script loads the Individual household electric power consumption Data Set and 
#  graphs the relationship between date/time and household global minute-averaged active power(in kilowatt)
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

#  2. Graph (plot) the relationship between dates and Global_active_power between 2007-02-01 and 2007-02-02
     
      GAPData <- as.numeric(EPCData$Global_active_power)
      DTMData <- strptime(paste(EPCData$Date, EPCData$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

#  3. Create a 480 by 480 png of the relationship Global_active_power over time

    # Create plot2.png

      png("plot2.png", width=480, height=480)

    # Plot Global_active_power between 2007-02-01 and 2007-02-02

      plot(DTMData, 
           GAPData, 
           type="l", 
           xlab="Date/Time", 
           ylab="Global Active Power (kilowatts)")

    # Close plot2.png
      
      dev.off()


