library(readr)

## Set locale from Russian to English
Sys.setlocale(category = "LC_ALL", locale = "english")

## Read data from zip file
df1 = read_csv2("exdata_data_household_power_consumption.zip")
##The dataset has 2,075,259 rows and 9 columns
lapply(df1, class)
summary(df1)

## We will only be using data from the dates 2007-02-01 and 2007-02-02
sub_df <- df1[df1$Date %in% c("1/2/2007","2/2/2007"),]

## No incomplete observation
sub_df <- sub_df[complete.cases(sub_df),]

#convert the Date variable to Date/Time class
sub_df$Date <- as.Date(sub_df$Date, format="%d/%m/%Y")

## Convert the Date and Time variables to Date/Time classes
Date_time <- paste(sub_df$Date, sub_df$Time)
Date_time <- as.POSIXct(Date_time)

## Add to dataset
sub_df <- cbind(Date_time, sub_df)


## Convert Global_active_power and Global_reactive_power to numeric
sub_df$Global_active_power <- as.numeric(sub_df$Global_active_power)
sub_df$Global_reactive_power <- as.numeric(sub_df$Global_reactive_power)

## Convert Submetering to numeric
Sub_metering_1 = as.numeric(sub(',', '.', sub_df$Sub_metering_1))
Sub_metering_2 = as.numeric(sub(',', '.', sub_df$Sub_metering_2))
Sub_metering_3 = as.numeric(sub(',', '.', sub_df$Sub_metering_3))

## Convert voltage to numeric
voltage <- as.numeric(sub_df$Voltage)

## Create plots
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

plot(Date_time, sub_df$Global_active_power, xlab="", ylab="Global Active Power (kilowatts)", type="l")
plot(voltage~Date_time, type="l", xlab="datetime", ylab="Voltage")
plot(sub_df$Date_time, Sub_metering_1, type="l", xlab="", 
     ylab="Energy Submetering")
lines(sub_df$Date_time, Sub_metering_2, col="red")
lines(sub_df$Date_time, Sub_metering_3, col="blue")
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=c(1,1,1), bty = "n",
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(Date_time, sub_df$Global_reactive_power, xlab="datetime", ylab="Global_reactive_power", type="l")
dev.copy(png,"plot4.png")
dev.off()

