###########################################################################################################
#
#  Coursera Exploratory Data Analysis
#  Don Martin 
#  5-20-2016
#
#  Plot3.R 
#
#  Description:
#
#  This script loads the Individual household electric power consumption Data Set and 
#  graphs the relationships between date/time and;
#
#  1. kitchens, containing mainly a dishwasher, an oven and a microwave
#  2. laundry rooms, containing a washing-machine, a tumble-drier, a refrigerator and a light
#  3. electric water-heater and an air-conditioner
#
#  between the dates of 2007-02-01 and 2007-02-02
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
      DTMData <- strptime(paste(EPCData$Date, EPCData$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
      SM1Data <- as.numeric(EPCData$Sub_metering_1)
      SM2Data <- as.numeric(EPCData$Sub_metering_2)
      SM3Data <- as.numeric(EPCData$Sub_metering_3)

#  3. Create a 480 by 480 png of the relationship SubMetering 1,2,3 over time

    # Create plot3.png

      png("plot3.png", width=480, height=480)

    # Plot Sub_metering over Time

    # 1) Plot kitchens, containing mainly a dishwasher, an oven and a microwave

         plot (DTMData, 
               SM1Data,  
               type="l",
               xlab="Date/Time",
               ylab="Energy Submetering")

    # 2) Overlay laundry rooms, w/ washing-machine & drier, a refrigerator and a light

         lines(DTMData, 
               SM2Data, 
               type="l", 
               col="red")

    # 3) Overlay electric water-heater and an air-conditioner
      
         lines(DTMData, 
               SM3Data, 
               type="l", 
               col="blue")

    # 4) Create Legend

         legend("topright", c("Sub_metering_1", 
                              "Sub_metering_2", 
                              "Sub_metering_3"), 
                              lty=1, 
                              lwd=2.5, 
                              col=c("black", "red", "blue"))

    # Close plot3.png

      dev.off()


