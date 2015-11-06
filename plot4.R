# this R script makes a plot with 4 graphs on it.  The graphs cover two days, Feb 1-2, 2007:
# 1)  Global_active_powerof sub_metering values
# 2) Voltage
# 3) sub_metering values from different parts of the home
# 4) global_reactive power

# read the table.  The data set uses ? as the NA value
mypower<-read.table("household_power_consumption.txt", sep=";", header=TRUE, na.strings="?")

# convert date field to the date class and extract only the days of interest, shrinking the large data set down in size
mypower$Date<-as.Date(mypower$Date, "%d/%m/%Y")
myset<-mypower[mypower$Date == "2007-02-01" | mypower$Date == "2007-02-02",]

# create a vector that contains date/time (posix time) for graphing purposes
newdate<-with(myset, paste0(Date, " ", Time))
realdate<-strptime(newdate, "%Y-%m-%d %H:%M:%S")

# open the graphics device and set the number of plots row x columns.  Note: if you plot to screen and then use dev.copy
# to write to a png file, the legend values get clipped in the sub_metering chart.
png(filename="plot4.png")
par(mfrow=c(2,2))

# plot the 4 charts out
plot(realdate, myset$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="" )

plot(realdate, myset$Voltage, type="l", ylab="Voltage", xlab="datetime" )

plot(realdate, myset$Sub_metering_1, type="n", ylab="Energy sub metering", xlab="" )
lines(realdate, myset$Sub_metering_1, col="black")
lines(realdate, myset$Sub_metering_2, col="red")
lines(realdate, myset$Sub_metering_3, col="blue")
legend("topright", bty="n", lty = c(1,1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(realdate, myset$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime" )

dev.off()