library(readr)

## Set locale from Russian to English
Sys.setlocale(category = "LC_ALL", locale = "english")

## Read data from zip file
df1 = read_csv2("exdata_data_household_power_consumption.zip")
## The dataset has 2,075,259 rows and 9 columns
lapply(df1, class)
summary(df1)

## We will only be using data from the dates 2007-02-01 and 2007-02-02
sub_df <- df1[df1$Date %in% c("1/2/2007","2/2/2007"),]

## No incomplete observation
sub_df <- sub_df[complete.cases(sub_df),]

#convert the Date variable to Date/Time class
sub_df$Date <- as.Date(sub_df$Date, format="%d/%m/%Y")

## Combine Date and Time and add column to dataset, convert to Date/Time classes
Date_time <- paste(sub_df$Date, sub_df$Time)
#Date_time
Date_time <- as.POSIXct(Date_time)

## Convert Submetering to numeric
Sub_metering_1 = as.numeric(sub(',', '.', sub_df$Sub_metering_1))
Sub_metering_2 = as.numeric(sub(',', '.', sub_df$Sub_metering_2))
Sub_metering_3 = as.numeric(sub(',', '.', sub_df$Sub_metering_3))

## Create plot
plot(Date_time, Sub_metering_1, type="l", xlab="", 
     ylab="Energy Submetering")
lines(Date_time, Sub_metering_2, col="red")
lines(Date_time, Sub_metering_3, col="blue")
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png,"plot3.png")
dev.off()

