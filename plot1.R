# This R script makes a histogram of global_active_power.  The graph covers two days, Feb 1-2, 2007.

# read the table.  The data set uses ? as the NA value
# Then convert date field to the date class and extract only the days of interest, shrinking the large data set down in size

mypower<-read.table("household_power_consumption.txt", sep=";", header=TRUE, na.strings="?")
mypower$Date<-as.Date(mypower$Date, "%d/%m/%Y")
myset<-mypower[mypower$Date == "2007-02-01" | mypower$Date == "2007-02-02",]

# open the graphics device.
png(filename="plot1.png")
hist(myset$Global_active_power, xlab="Global Active Power (kilowatts)", col="red", main="Global Active Power")
#dev.copy(png, file="plot1.png")
dev.off()

