## I set my Working directory
# setwd("C:\Collaborateur\BigData\Coursera\Exploratory_Data_Analysis\Week01\Project")           ## My Working directory

## I create my Data Frame and transform it to get the appropriate values and formats
ElectPwrConsumption <- read.table(file.path(getwd(), "./Dataset/household_power_consumption.txt"), 
                                  sep = ";", header= TRUE, na.strings="?")                      ## I load the dataset into a Data Frame
ElectPwrConsumption$Date <- as.Date(ElectPwrConsumption$Date, format="%d/%m/%Y")                ## In my Data Frame, Date is in Factor format and I set it into Date format
DS_From_Dates <- subset(ElectPwrConsumption, Date >= "2007/2/1" & Date <= "2007/2/2")           ## I select my date range
DS_From_Dates$DateTime <- paste(DS_From_Dates$Date, DS_From_Dates$Time)                         ## Add column DateTime into Dataset and convert automaticaly Factor format into character
DS_From_Dates$DateTime <- strptime(paste(DS_From_Dates$Date, DS_From_Dates$Time),
                                   format = "%Y-%m-%d %H:%M:%S")                                ## I merge Date and Time into my new column 
DS_From_Dates$DateTime <- as.POSIXct(DS_From_Dates$DateTime)                                    ## I convert the default value POSIXlt in POSIXct

##Plot4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))                                               ## I customize my Graphic Device : marging, and number of column & row
with(DS_From_Dates, {
        plot(Global_active_power~DateTime, type="l", ylab="Global Active Power", xlab="")       ## First plot
        plot(Voltage~DateTime, type="l", ylab="Voltage", xlab="datetime")                       ## Second plot
        plot(Sub_metering_1~DateTime, type="l", ylab="Energy sub metering", xlab="")            ## Third plot
        lines(Sub_metering_2~DateTime,col='Red')
        lines(Sub_metering_3~DateTime,col='Blue')
        legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
               legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))                  ## I customize my third plot with legends, titles and colors
        plot(Global_reactive_power~DateTime, type="l", 
             ylab="Global_reactive_power",xlab="datetime")                                      ## Last plot
})
dev.copy(png, file ="plot4.png", width = 480, height = 480)                                     ## I copy my Graphic device into PNG file
dev.off()                                                                                       ## I close Graphic device and I allow register "plot4.png" file into my workspace
