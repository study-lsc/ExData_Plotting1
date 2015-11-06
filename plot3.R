# this R script plots out the different sub_metering datasets on the same chart, using different
# colors for each data set.  The graph covers two days, Feb 1-2, 2007.

# read the table.  The data set uses ? as the NA value
# Then convert date field to the date class and extract only the days of interest, shrinking the large data set down in size
mypower<-read.table("household_power_consumption.txt", sep=";", header=TRUE, na.strings="?")
mypower$Date<-as.Date(mypower$Date, "%d/%m/%Y")
myset<-mypower[mypower$Date == "2007-02-01" | mypower$Date == "2007-02-02",]

# create a vector that contains date/time (posix time) for graphing purposes
newdate<-with(myset, paste0(Date, " ", Time))
realdate<-strptime(newdate, "%Y-%m-%d %H:%M:%S")

png(filename="plot3.png")

# make the base plot without puttting any lines on it.
plot(realdate, myset$Sub_metering_1, type="n", ylab="Energy sub metering", xlab="" )
lines(realdate, myset$Sub_metering_1, col="black")
lines(realdate, myset$Sub_metering_2, col="red")
lines(realdate, myset$Sub_metering_3, col="blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#dev.copy(png, file="plot3.png")
dev.off()