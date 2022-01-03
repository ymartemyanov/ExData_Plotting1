library(readr)

#read data from zip file
df1 = read_csv2("exdata_data_household_power_consumption.zip")
#The dataset has 2,075,259 rows and 9 columns
summary(df1)

#We will only be using data from the dates 2007-02-01 and 2007-02-02
sub_df <- df1[df1$Date %in% c("1/2/2007","2/2/2007"),]

#convert the Date variable to Date/Time class
sub_df$Date <- as.Date(sub_df$Date, format="%d/%m/%Y")

#convert Global_active_power to numeric
sub_df$Global_active_power <- as.numeric(sub_df$Global_active_power)

#create histogram
hist(sub_df$Global_active_power, col="red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")

#create png file
dev.copy(png, file = "plot1.png")
dev.off()
