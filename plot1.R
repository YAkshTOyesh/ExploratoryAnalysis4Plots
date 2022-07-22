#Unzipping file
path_dataset <- "C:/Users/20020253/Documents/datasciencecoursera/exdata_data_household_power_consumption.zip"
unzip(path_dataset)

#Reading file
power_consumption_data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

#Converting dates to date variable
library(lubridate)
power_consumption_data$Date <- dmy(power_consumption_data$Date)
power_consumption_data$Time <- hms(power_consumption_data$Time)

#Subset data
date_search_logical_vector <- power_consumption_data$Date >= as.Date("2007-02-01") & power_consumption_data$Date <= as.Date("2007-02-02")
power_consumption_data_subset <-power_consumption_data[date_search_logical_vector,]
rm(power_consumption_data)

#Converting data to numeric
power_consumption_data_subset[, 3:ncol(power_consumption_data_subset)] <- lapply(3:ncol(power_consumption_data_subset), function(x) {as.numeric(power_consumption_data_subset[[x]])})

#Plotting graph 1
hist(power_consumption_data_subset$Global_active_power, main = "Global active power", xlab = "Global active power (kilowatts)", ylab = "Frequency", col = "red")

#Saving plot1 in PNG file
png(file = "plot1.png")
hist(power_consumption_data_subset$Global_active_power, main = "Global active power", xlab = "Global active power (kilowatts)", ylab = "Frequency", col = "red")
dev.off()
