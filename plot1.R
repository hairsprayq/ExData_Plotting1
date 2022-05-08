library(chron)

# Download data set.

filename <- "exdata_data_household_power_consumption.zip"
path <- getwd()

# Checking if file already exists.
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, filename, method="curl")
}  

# Checking if folder exists
if (!file.exists("exdata_data_household_power_consumption")) { 
  unzip(filename) 
}

# Read data set.

df <- read.table("exdata_data_household_power_consumption/household_power_consumption.txt", header = TRUE, sep = ";", )
df <- df[!apply(df == "?", 1, all),]
df$Date <- as.Date(df$Date, format = "%d/%m/%Y")
df$Time <- times(df$Time)
df[3:8] <- as.numeric(unlist(df[3:8]))
df_subset <- subset(df, Date == "2007-02-01" | Date == "2007-02-02")
png(file = "plot1.png")
hist(df_subset$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)",
col = "red", xlim = c(0,7.5), ylim = c(0,1200))
dev.off()
  