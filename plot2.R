#Unzipping file
path_dataset <- "C:/Users/20020253/Documents/datasciencecoursera/exdata_data_household_power_consumption.zip"
unzip(path_dataset)

#Reading file
power_consumption_data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

#Converting dates to date variable
power_consumption_data$Time <- paste(power_consumption_data$Date, power_consumption_data$Time)
power_consumption_data$Date <- strptime(power_consumption_data$Date, format = "%d/%m/%Y")
power_consumption_data$Time <- strptime(power_consumption_data$Time, format = "%d/%m/%Y %H:%M:%S")

#Subset data
date_search_logical_vector <- power_consumption_data$Date >= as.Date("2007-02-01") & power_consumption_data$Date <= as.Date("2007-02-02")
power_consumption_data_subset <-power_consumption_data[date_search_logical_vector,]
rm(power_consumption_data)

#Converting data to numeric
power_consumption_data_subset[, 3:ncol(power_consumption_data_subset)] <- lapply(3:ncol(power_consumption_data_subset), function(x) {as.numeric(power_consumption_data_subset[[x]])})

#Plotting graph 2
plot(power_consumption_data_subset$Time, power_consumption_data_subset$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

#Saving plot2 in PNG file
png(file = "plot2.png")
plot(power_consumption_data_subset$Time, power_consumption_data_subset$Global_active_power, type = "l", xaxt = "n", xlab = "", ylab = "Global Active Power (kilowatts)")
axis.POSIXct(1, power_consumption_data_subset$Time, format = "%a")
dev.off()
