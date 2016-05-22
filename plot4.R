###########################################################################################################
#
#  Coursera Exploratory Data Analysis
#  Don Martin 
#  5-20-2016
#
#  Plot4.R 
#
#  Description:
#
#  This script loads the Individual household electric power consumption Data Set and 
#  builds a 2 X 2 series of graphs of the following;  
#
#  1. The relationship between household global minute-averaged active power over time
#  2. The relationship between household minute-averaged voltage over time
#  3. The relationship between;
#     - kitchens, containing mainly a dishwasher, an oven and a microwave
#     - laundry rooms, containing a washing-machine, a tumble-drier, a refrigerator and a light
#     - electric water-heater and an air-conditioner
#     over time
#  4. The relationship between household global minute-averaged reactive power over time
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
      GRPData <- as.numeric(EPCData$Global_reactive_power)
      VOLTAGE <- as.numeric(EPCData$Voltage)

#  3. Create a 480 by 480 png of a 2 X 2 series of plots 

   # Set up the 2 X 2 layout in plot4.png

      png("plot4.png", width=480, height=480)
      par(mfrow = c(2, 2))

    # Plot Global Active Power over Time

      plot(DTMData, 
           GAPData, 
           type="l", 
           xlab="Date/Time", 
           ylab="Global Active Power")

    # Plot Voltage over Time

      plot(DTMData, 
           VOLTAGE, 
           type="l", 
           xlab="Date/Time", 
           ylab="Voltage")

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
                              col=c("black", "red", "blue"),
                              bty="n")

    # Plot Global_reactive_power over Time
      
      plot(DTMData, 
           GRPData, 
           type="l", 
           lwd=0.5, 
           xlab="Date/Time", 
           ylab="Global Reactive Power")

    # Close plot4.png

      dev.off()



 


 


