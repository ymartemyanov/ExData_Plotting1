library(readr)

## Set locale from Russian to English
Sys.setlocale(category = "LC_ALL", locale = "english")

## Read data from zip file
df1 = read_csv2("exdata_data_household_power_consumption.zip")
## The dataset has 2,075,259 rows and 9 columns
summary(df1)

## We will only be using data from the dates 2007-02-01 and 2007-02-02
sub_df <- df1[df1$Date %in% c("1/2/2007","2/2/2007"),]

## No incomplete observation
sub_df <- sub_df[complete.cases(sub_df),]

## Combine Date and Time and add column to dataset
Date_time <- paste(sub_df$Date, sub_df$Time)
sub_df <- cbind(Date_time, sub_df)

## Convert the Date and Time variables to Date/Time classes
sub_df$Date_time <- strptime(sub_df$Date_time, format="%d/%m/%Y %H:%M:%S")

## Convert Global_active_power to numeric
sub_df$Global_active_power <- as.numeric(sub_df$Global_active_power)
#str(sub_df)

## Create plot
plot(sub_df$Date_time, sub_df$Global_active_power, xlab="", ylab="Global Active Power (kilowatts)", type="l")
dev.copy(png,"plot2.png")
dev.off()
