# This R script plots out global_reactive_power.  The graph covers two days, Feb 1-2, 2007.

# read the table.  The data set uses ? as the NA value
# Then convert date field to the date class and extract only the days of interest, shrinking the large data set down in size

mypower<-read.table("household_power_consumption.txt", sep=";", header=TRUE, na.strings="?")
mypower$Date<-as.Date(mypower$Date, "%d/%m/%Y")
myset<-mypower[mypower$Date == "2007-02-01" | mypower$Date == "2007-02-02",]

# create a vector that contains date/time (posix time) for graphing purposes
newdate<-with(myset, paste0(Date, " ", Time))
realdate<-strptime(newdate, "%Y-%m-%d %H:%M:%S")

png(filename="plot2.png")
plot(realdate, myset$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="" )
#dev.copy(png, file="plot2.png")
dev.off()

